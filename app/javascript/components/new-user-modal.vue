<template>
  <modal
    name="user-modal"
    :width="300"
  >
    <div class="flex flex-col justify-center h-full px-4 space-y-4">
      <label
        for="username"
        class="text-xl text-center"
      >
        Ingresa un nombre
      </label>
      <input
        type="text"
        id="username"
        name="username"
        class="p-2 text-xl border rounded border-ap-blue"
        v-model="username"
      >
      <button
        class="py-2 text-white rounded bg-ap-blue"
        @click="createUser"
      >
        Ir a jugar
      </button>
    </div>
  </modal>
</template>

<script>
import usersApi from '../api/users';

export default {
  data() {
    return {
      username: '',
    };
  },
  props: {
    gameId: { type: Number, default: null },
  },
  methods: {
    createUser() {
      usersApi.create({ username: this.username, gameId: this.gameId }).then(() => {
        this.$modal.hide('user-modal');
      });
    },
  },
};
</script>
