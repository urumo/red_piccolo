<script setup lang="ts">
import { onMounted, onUpdated, watch, type PropType, ref } from 'vue';
import { type Chat, windowActionTypes } from "@/stores/useChats";

const props = defineProps({
  selectedChat: {
    type: Object as PropType<Chat>,
    required: true
  }
});
const messageField = ref(null as HTMLFieldSetElement | null);

const emit = defineEmits(['choose-action']);
const closeChat = () => {
  emit('choose-action', windowActionTypes.NONE, []);
};

const scrollToBottom = () => {
  if (messageField.value) {
    messageField.value.scrollTop = messageField.value.scrollHeight;
  }
};

onMounted(scrollToBottom);
onUpdated(scrollToBottom);

watch(props.selectedChat, scrollToBottom, { immediate: true });
</script>

<template>
  <div v-if="props.selectedChat.id" class="tui-window">
    <fieldset class="tui-fieldset tui-border-double messages-field" ref="messageField">
      <legend>{{ props.selectedChat.title }} : {{ props.selectedChat.description }}</legend>

      <button @click="closeChat" class="tui-fieldset-button right">
        <span class="green-255-text">x</span>
      </button>
      <div
        v-for="message in props.selectedChat.messages.messages"
        :key="message.id"
        :id="message.id"
      >
        <div class="tui-window">
          <fieldset class="tui-fieldset tui-border-dashed">
            <legend>{{ message.user.full_name }}</legend>
            <button class="tui-fieldset-button right">
              <span class="green-255-text">reply</span>
            </button>
            <p>{{ message.content }}</p>
            <p>{{ message.updated_at }}</p>
            <label class="tui-checkbox"
              >edited
              <input v-if="message.is_edited" type="checkbox" checked />
              <input v-else type="checkbox" />
              <span></span>
            </label>
          </fieldset>
        </div>
      </div>
    </fieldset>
  </div>
</template>

<style scoped>
.messages-field {
  max-height: 80vh;
  overflow-y: auto;
}

.tui-window {
  width: 50vw;
  height: 80vh;
}
</style>
