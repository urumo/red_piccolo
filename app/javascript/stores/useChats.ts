import { defineStore } from 'pinia';
import { ref } from 'vue';
import fetchWrapper from '@/fetchWrapper';

export type User = {
  id: string;
  full_name: string;
  role: string;
  tag: string;
};

export type Message = {
  id: string;
  content: string;
  user: User;
  is_edited: boolean;
  updated_at: string;
};

export type Chat = {
  id: string;
  title: string;
  description: string;
  messages: {
    messages: Message[];
    next_cursor: string | null;
  };
  users: User[];
};

export type TransmissionType =
  | 'message_added'
  | 'message_edited'
  | 'message_deleted'
  | 'chat_participant_updated'
  | 'chat_updated';

export type WsUser = {
  id: string;
  email: string;
  role: string;
  tag: string;
  created_at: string;
  updated_at: string;
  full_name: string;
};

export type WsMessage = {
  id: string;
  content: string;
  user_id: string;
  chat_id: string;
  created_at: string;
  updated_at: string;
  is_edited: boolean;
};

export type WsChat = {
  id: string;
  title: string;
  description: string;
};

export type WsTransmission = {
  transmission_type: TransmissionType;
  message?: WsMessage;
  user?: WsUser;
  chat?: WsChat;
};

export type Result = {
  chats: Chat[];
};

export enum windowActionTypes {
  NONE,
  CREATE_CHAT,
  EDIT_CHAT,
  DELETE_CHAT,
  ADD_USER_TO_CHAT,
  REMOVE_USER_FROM_CHAT,
  SHOW_CHAT
}

export const useChatStore = defineStore('chat', () => {
  const userChats = ref({} as Result);
  const error = ref('');

  fetchWrapper('chat/')
    .then((data) => data?.json())
    .then((data) => {
      userChats.value = data;
    })
    .catch((err) => {
      error.value = err.message;
    });

  function addMessageToChat(chatId: string, message: Message): void {
    const chat = userChats.value.chats.find((chat) => chat.id === chatId);
    if (!chat) throw new Error(`Chat with id ${chatId} not found`);

    chat.messages.messages.push(message);

    if (chat.messages.messages.length > 100) {
      chat.messages.messages.shift();
    }
  }

  function AddChat(chat: WsChat): void {
    userChats.value.chats.push({
      ...chat,
      messages: {
        messages: [],
        next_cursor: null
      },
      users: []
    });
  }

  return { userChats, error, addMessageToChat, AddChat };
});
