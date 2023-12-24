import { createApp } from 'vue';
import ErrorHandler from '@/errorHandler';
import Chat from '@/layouts/ChatSystem.vue';
import { createPinia } from 'pinia';

const app = createApp(Chat);
app.use(createPinia());
app.config.errorHandler = ErrorHandler;

app.mount('#chat');
