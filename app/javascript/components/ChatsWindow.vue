<script setup lang="ts">
import { computed, type PropType } from 'vue';
import { type Chat, windowActionTypes } from '@/stores/useChats';

const props = defineProps({
  chats: {
    type: Array as PropType<Chat[]>,
    required: true
  },
  selectedChat: {
    type: Object as PropType<Chat>,
    required: true
  }
});

const emit = defineEmits(['choose-action']);

const selectChat = (chatId: string) => {
  emit('choose-action', windowActionTypes.SHOW_CHAT, [chatId]);
};

const lastMessage = computed(() => {
  return props.chats.map((chat) => {
    const lastMessage = chat.messages.messages[chat.messages.messages.length - 1];
    return {
      ...lastMessage,
      userFullName: lastMessage?.user.full_name.slice(0, 5),
      contentPreview: lastMessage?.content.slice(0, 15)
    };
  });
});

const openCreateChatWindow = () => {
  emit('choose-action', windowActionTypes.CREATE_CHAT, []);
};
</script>

<template>
  <div class="tui-window">
    <fieldset class="tui-fieldset tui-border-double chats-field">
      <legend>Chats</legend>
      <button @click="openCreateChatWindow" class="tui-fieldset-button right"><span class="green-168-text">C</span>reate</button>
      <div v-for="(chat, index) in props.chats" :key="chat.id" :id="chat.id">
        <fieldset @click="selectChat(chat.id)" class="tui-fieldset tui-border-dotted">
          <legend>{{ chat.title }}</legend>
          <div v-if="chat.messages.messages.length">
            <p>
              {{ lastMessage[index]?.userFullName }} : {{ lastMessage[index]?.contentPreview }}...
            </p>
            <p>{{ lastMessage[index].updated_at }}</p>
          </div>
        </fieldset>
      </div>
    </fieldset>
  </div>
</template>

<style scoped>
.chats-field {
  height: 73vh;
  width: 50vh;
  max-height: 80vh;
  overflow-y: auto;
}
</style>
