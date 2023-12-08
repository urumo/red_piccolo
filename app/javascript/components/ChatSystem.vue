<script setup lang="ts"></script>

<template>
  <div class="messenger">
    <aside class="sidebar">
      <div class="input-group">
        <input type="search" placeholder="Search contacts..." />
      </div>
      <ul class="contact-list">
        <li>Contact 1</li>
        <li>Contact 2</li>
        <li>Contact 3</li>
        <!-- Add more contacts here -->
      </ul>
    </aside>
    <section class="chat-window">
      <ul class="chat-messages">
        <li>Message 1 from User</li>
        <li>Message 2 from Contact</li>
        <!-- Add more messages here -->
      </ul>
      <div class="input-group">
        <input type="text" class="message-input" placeholder="Type a message..." />
      </div>
    </section>
  </div>
</template>

<style scoped>
.messenger {
  display: flex;
  width: 90%;
  max-width: 1000px;
  height: 80%;
  margin-top: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.sidebar {
  width: 30%;
  background: #fff;
  border-right: 1px solid #ddd;
  padding: 20px;
  overflow: auto;
}

.chat-window {
  width: 70%;
  padding: 20px;
  overflow: auto;
  display: flex;
  flex-direction: column;
}

.contact-list {
  list-style: none;
  padding: 0;
  margin-top: 20px;
}

.contact-list li {
  padding: 10px;
  border-bottom: 1px solid #ddd;
}

.chat-messages {
  list-style: none;
  padding: 0;
  flex-grow: 1;
}

.chat-messages li {
  margin-bottom: 15px;
  padding: 10px;
  background: #f1f1f1;
  border-radius: 5px;
  width: fit-content;
}

.input-group {
  margin-top: 20px;
}

input[type='text'],
input[type='search'],
.message-input {
  width: calc(100% - 40px); /* Adjust width based on padding */
  padding: 10px;
  margin-bottom: 20px;
  border: 1px solid #ddd;
  border-radius: 5px;
}

.message-input {
  margin-bottom: 0;
  flex-shrink: 0;
}

/* Responsive styles */
@media (max-width: 768px) {
  .messenger {
    flex-direction: column;
  }

  .sidebar,
  .chat-window {
    width: 100%;
  }
}
</style>
