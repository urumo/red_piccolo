<script setup lang="ts">
import { windowActionTypes } from '@/stores/useChats';
import { ref } from 'vue';
import fetchWrapper from '@/fetchWrapper';

const emit = defineEmits(['choose-action']);
const closeWindow = () => {
  emit('choose-action', windowActionTypes.NONE, []);
};

const titleField = ref('');
const descriptionField = ref('');

const submit = (event: MouseEvent) => {
  event.preventDefault();
  const title = titleField.value.value;
  const description = descriptionField.value.value;
  fetchWrapper('/chat', {
    method: 'POST',
    body: JSON.stringify({
      title,
      description
    })
  }).then((response) => {
    if (response?.ok) {
      closeWindow();
    }
  });
};
</script>

<template>
  <div class="tui-window">
    <fieldset class="tui-fieldset tui-border-double create-chat-field">
      <legend>Create a chat</legend>

      <button @click="closeWindow" class="tui-fieldset-button right">
        <span class="green-255-text">x</span>
      </button>
      <div>
        <label class="label">Title........</label>
        <input class="tui-input" type="text" placeholder="Title" ref="titleField" />
      </div>
      <div>
        <label class="label">Description..</label>
        <input class="tui-input" type="text" placeholder="Description" ref="descriptionField" />
      </div>
      <button @click="submit" class="tui-button">Create</button>
    </fieldset>
  </div>
</template>

<style scoped>
.create-chat-field {
  max-height: 80vh;
  overflow-y: auto;
}

.tui-window {
  width: 50vw;
  height: 80vh;
}
</style>
