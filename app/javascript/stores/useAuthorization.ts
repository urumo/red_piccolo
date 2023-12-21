import type { Ref } from 'vue';
import { inject, ref, watch } from 'vue';
import { defineStore } from 'pinia';
import type { User } from '@/types/graphql';
import { GetCurrentUserDocument } from '@/types/graphql';
import type { UseQueryResponse } from '@urql/vue';
import { useClientHandle } from '@urql/vue';
import type { VueCookies } from 'vue-cookies';
import ErrorHandler from '@/errorHandler';

export const useAuthorizationStore = defineStore('auth', () => {
  const cookies: VueCookies = inject('$cookies') as VueCookies;
  const userFromLocalStorage = () => {
    const user = localStorage.getItem('currentUser');
    if (!user) return {};
    return JSON.parse(user);
  };
  const user: Ref<User> = ref(userFromLocalStorage() as User);
  const tokenId: Ref<string> = ref(cookies.get('session') || '');
  const userIsSet: Ref<boolean> = ref(tokenId.value !== '');
  if (!tokenId.value) login();

  const handle = useClientHandle();

  const currentUserQuery = handle.useQuery({
    query: GetCurrentUserDocument,
    requestPolicy: 'network-only',
    pause: true
  });

  function login() {
    window.location.href = '/identity/auth';
  }

  function setToken(id: string) {
    if (!id) return;
    cookies.set('session', id);
    authorize();
  }

  function authorize(): void {
    if (!tokenId.value) return;
    const {
      data,
      fetching,
      error
    }: UseQueryResponse<{
      me: User;
    }> = currentUserQuery.executeQuery();
    watch(fetching, (fetching: boolean) => {
      if (error.value) {
        ErrorHandler(error.value, 'currentUserQuery', 'Authorization');
        logout();
        return;
      }
      if (!fetching && data?.value) {
        user.value = data?.value?.me;
        localStorage.setItem('currentUser', JSON.stringify(user.value));
      }
    });
  }

  function logout(): void {
    cookies.remove('session');
    localStorage.removeItem('currentUser');
    user.value = {} as User;
    tokenId.value = '';
  }

  return { user, userIsSet, tokenId, login, authorize, setToken, logout };
});
