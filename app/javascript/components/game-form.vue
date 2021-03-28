<template>
  <div class="mx-4">
    <h1 class="mb-4 text-3xl">
      Crear nueva partida
    </h1>
    <multiselect
      class="mb-4"
      :options="users"
      v-model="selectedUsers"
      :multiple="true"
      :close-on-select="false"
      :clear-on-select="false"
      :preserve-search="true"
      :searchable="true"
      track-by="id"
      label="email"
    />
    <button
      class="px-8 py-2 text-xl text-white bg-ap-blue"
      @click="createGame"
    >
      Crear
    </button>
  </div>
</template>

<script>
import gamesApi from '../api/games';

export default {
  data() {
    return {
      selectedUsers: [],
    };
  },
  props: {
    users: { type: Array, required: true },
  },
  methods: {
    createGame() {
      gamesApi.create({ userIds: this.selectedUsers.map(user => user.id) }).then(({ data }) => {
        window.location.href = `/games/${data.id}`;
      });
    },
  },
};
</script>
