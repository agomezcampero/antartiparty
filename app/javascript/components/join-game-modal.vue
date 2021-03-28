<template>
  <modal
    name="join-game-modal"
    :width="300"
  >
    <div class="flex flex-col justify-center h-full px-4 space-y-4">
      <div class="text-xl text-center">
        Hola {{ currentUser && currentUser.username }}, haz click para unirte al juego
      </div>
      <button
        class="py-2 text-white rounded bg-ap-blue"
        @click="createGameUser"
      >
        Ir a jugar
      </button>
    </div>
  </modal>
</template>

<script>
import { mapState } from 'vuex';
import gameUsersApi from '../api/game-users';

export default {
  props: {
    gameId: { type: Number, default: null },
  },
  computed: {
    ...mapState(['currentUser']),
  },
  methods: {
    createGameUser() {
      gameUsersApi.create({ gameId: this.gameId }).then(() => {
        this.$modal.hide('join-game-modal');
      });
    },
  },
};
</script>
