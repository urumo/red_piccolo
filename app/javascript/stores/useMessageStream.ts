import type { Ref } from 'vue';
import { ref } from 'vue';
import { defineStore } from 'pinia';
import { useAuthorizationStore } from './useAuthorization';
import consumer from '@/channels/consumer';

export const useMessageStreamStore = defineStore('messages', () => {
  const { user, userIsSet } = useAuthorizationStore();

  const messages: Ref<string[]> = ref([]);

  if (!userIsSet) return;

  consumer.subscriptions.create(
    {
      channel: `ApplicationCable::Chat::MessagesChannel`,
      user_id: user.id
    },
    {
      connected() {
        console.log('connected');
      },

      disconnected() {},

      received(data: string) {
        const message = JSON.parse(data);
        messages.value.push(message.message);
      }
    }
  );

  return { messages };
});
