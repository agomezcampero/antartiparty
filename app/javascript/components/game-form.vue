<template>
  <div class="mx-4">
    <h1 class="mb-4 text-3xl">
      Crear nuevo AntartiParty
    </h1>
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
      gamesApi.create().then(({ data }) => {
        window.location.href = `/games/${data.id}`;
      });
    },
  },
};
</script>
