<script setup lang="ts">
import {
  type Chat,
  type Message,
  useChatStore,
  type User,
  windowActionTypes,
  type WsMessage,
  type WsTransmission,
  type WsUser
} from '@/stores/useChats';
import { computed, ref } from 'vue';
import ChatsWindow from '@/components/ChatsWindow.vue';
import MessagesWindow from '@/components/MessagesWindow.vue';
import fetchWrapper from '@/fetchWrapper';
import consumer from '@/channels/consumer';
import SearchBar from '@/components/SearchBar.vue';
import MessageInputBar from '@/components/MessageInputBar.vue';
import CreateChatWindow from '@/components/CreateChatWindow.vue';

const windowActionFunctions = {
  [windowActionTypes.NONE]: (args: unknown[]) => {
    selectedChat.value = {} as Chat;
    windowAction.value = windowActionTypes.NONE;
  },
  [windowActionTypes.CREATE_CHAT]: (args: unknown[]) => {
    windowAction.value = windowActionTypes.CREATE_CHAT;
  },
  [windowActionTypes.EDIT_CHAT]: (args: unknown[]) => {
    windowAction.value = windowActionTypes.EDIT_CHAT;
  },
  [windowActionTypes.DELETE_CHAT]: (args: unknown[]) => {
    windowAction.value = windowActionTypes.DELETE_CHAT;
  },
  [windowActionTypes.ADD_USER_TO_CHAT]: (args: unknown[]) => {
    windowAction.value = windowActionTypes.ADD_USER_TO_CHAT;
  },
  [windowActionTypes.REMOVE_USER_FROM_CHAT]: (args: unknown[]) => {
    windowAction.value = windowActionTypes.REMOVE_USER_FROM_CHAT;
  },
  [windowActionTypes.SHOW_CHAT]: (args: unknown[]) => {
    windowAction.value = windowActionTypes.SHOW_CHAT;
    const chatId: string = args[0] as string;
    selectedChat.value = chats.value.find((chat) => chat.id === chatId) as Chat;
  }
};

const windowAction = ref(windowActionTypes.NONE);
const user = ref({} as User);
const selectedChat = ref({} as Chat);
const chats = computed(() => useChats.userChats.chats);
const useChats = useChatStore();

function serializedMessage(message: WsMessage, user: WsUser): Message {
  return {
    id: message.id,
    content: message.content,
    user: {
      id: user.id,
      full_name: user.full_name,
      tag: user.tag,
      role: user.role
    },
    is_edited: message.is_edited,
    updated_at: message.updated_at
  };
}

const connectToWebSocket = (userId: string) => {
  consumer.subscriptions.create(
    {
      channel: `ApplicationCable::Chat::MessagesChannel`,
      user_id: userId
    },
    {
      connected() {},
      disconnected() {},
      received(data: string) {
        const messageDto: WsTransmission = JSON.parse(data);
        const { transmission_type } = messageDto;
        switch (transmission_type) {
          case 'message_added':
            const { message, user } = messageDto;
            useChats.addMessageToChat(message?.chat_id!, serializedMessage(message!, user!));
            break;
          case 'message_edited':
            break;
          case 'message_deleted':
            break;
          case 'chat_participant_updated':
            break;
          case 'chat_updated':
            useChats.AddChat(messageDto.chat!);
            break;
          default:
            console.error(`Unknown transmission type ${transmission_type}`);
        }
      }
    }
  );
};

fetchWrapper('/identity')
  .then((response) => response?.json())
  .then((data) => {
    user.value.id = data.id;
    connectToWebSocket(data.id);
  })
  .catch((e) => {
    console.log(e);
  });

const chooseWindowAction = (action: windowActionTypes, args: unknown[]) => {
  windowActionFunctions[action](args);
};
</script>

<template class="tui-scroll-white">
  <p v-if="useChats.error">{{ useChats.error }}</p>
  <table class="tui-table-grid">
    <tbody>
      <tr>
        <td rowspan="2" height="90%">
          <div v-if="windowAction == windowActionTypes.NONE"></div>
          <MessagesWindow
            v-else-if="windowAction == windowActionTypes.SHOW_CHAT"
            :chats="chats"
            :selected-chat="selectedChat"
            @choose-action="chooseWindowAction"
          />
          <CreateChatWindow
            v-if="windowAction == windowActionTypes.CREATE_CHAT"
            @choose-action="chooseWindowAction"
          />
        </td>
        <td width="30%" height="3%" class="center">
          <SearchBar />
        </td>
      </tr>
      <tr>
        <td width="25" height="60%">
          <ChatsWindow
            :chats="chats"
            :selected-chat="selectedChat"
            @choose-action="chooseWindowAction"
          />
        </td>
      </tr>
      <tr>
        <td height="3%" colspan="2">
          <MessageInputBar v-if="selectedChat.id && windowAction == windowActionTypes.SHOW_CHAT" />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<style scoped>
table {
  width: 100%;
  height: 80vh;
  margin-top: 0.5%;
}
</style>
