import { ref, inject } from 'vue'
import type { Ref } from 'vue'
import { defineStore } from 'pinia'
import type { Jwt, User } from '@/types/graphql'
import { useClientHandle } from '@urql/vue'
import type { UseQueryResponse, UseMutationResponse } from '@urql/vue'
import { GetCurrentUserDocument, useLoginMutation, useRegisterMutation } from '@/types/graphql'
import { watch } from 'vue'
import type { VueCookies } from 'vue-cookies'
import ErrorHandler from "@/errorHandler";

export const useAuthorizationStore = defineStore('auth', () => {
  const cookies: VueCookies = inject('$cookies') as VueCookies
  const user: Ref<User> = ref((cookies.get('currentUser') || {}) as User)
  const userIsSet = ref(!!Object.keys(user.value).length)
  const tokenId: Ref<string> = ref(cookies.get('session') || '')
  const handle = useClientHandle()

  const currentUserQuery = handle.useQuery({
    query: GetCurrentUserDocument,
    requestPolicy: 'network-only',
    pause: true
  })

  function setToken(id: string) {
    if (!id) return
    cookies.set('session', id)
    authorize()
  }

  function authorize(): void {
    if (!tokenId.value) return
    const {
      data,
      fetching,
      error
    }: UseQueryResponse<{
      me: User
    }> = currentUserQuery.executeQuery()
    watch(fetching, (fetching: boolean) => {
      if (error.value) {
        ErrorHandler(error.value, currentUserQuery, 'Authorization')
        return
      }
      if (!fetching && data?.value) {
        user.value = data?.value?.me
        cookies.set('currentUser', user.value, '1D')
      }
    })
  }

  function authenticate(email: string, password: string): UseMutationResponse<Jwt> {
    return handle.useMutation({
      query: useLoginMutation,
      variables: { email, password },
      requestPolicy: 'network-only',
      pause: true
    })
  }

  function signUp(
    email: string,
    password: string,
    passwordConfirmation: string
  ): UseMutationResponse<Jwt> {
    return handle.useMutation({
      query: useRegisterMutation,
      variables: { email, password, passwordConfirmation },
      requestPolicy: 'network-only',
      pause: true
    })
  }

  function logout(): void {
    cookies.remove('session')
    cookies.remove('currentUser')
    user.value = {} as User
    tokenId.value = ''
  }

  return { user, userIsSet, tokenId, authorize, authenticate, signUp, setToken, logout }
})
