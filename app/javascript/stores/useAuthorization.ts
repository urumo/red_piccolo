import { ref } from 'vue'
import type { Ref } from 'vue'
import { defineStore } from 'pinia'
import type { Jwt, User } from '@/types/graphql'
import { useClientHandle } from '@urql/vue'
import type { UseQueryResponse, UseMutationResponse } from '@urql/vue'
import { GetCurrentUserDocument, useLoginMutation, useRegisterMutation } from '@/types/graphql'
import { watch } from 'vue'

export const useAuthorizationStore = defineStore('auth', () => {
  const user: Ref<User> = ref(JSON.parse(localStorage.getItem('currentUser') || '{}') as User)
  const tokenId: Ref<string> = ref(localStorage.getItem('session') || '')
  const handle = useClientHandle()

  function setToken(id: string) {
    if (!id) return
    localStorage.setItem('session', id)
    authorize()
  }

  function authorize(): void {
    const {
      data,
      fetching,
      error
    }: UseQueryResponse<{
      me: User
    }> = handle.useQuery({
      query: GetCurrentUserDocument,
      requestPolicy: 'network-only'
    })
    watch(fetching, (fetching: boolean) => {
      if (error.value) {
        logout()
      }
      if (!fetching && !error.value && data?.value) {
        user.value = data?.value?.me
        localStorage.setItem('currentUser', JSON.stringify(data?.value?.me))
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

  function logout() {
    localStorage.removeItem('session')
    localStorage.removeItem('currentUser')
    user.value = {} as User
    tokenId.value = ''
  }

  return { user, tokenId, authorize, authenticate, signUp, setToken, logout }
})
