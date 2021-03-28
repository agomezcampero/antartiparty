<template>
  <div class="flex flex-col w-screen p-2 md:p-10 md:flex-row">
    <new-user-modal :game-id="gameId" />
    <join-game-modal :game-id="gameId" />
    <div class="flex-shrink-0 w-full mb-4 md:w-1/2">
      <h1 class="mb-6 text-3xl text-center">
        AntartiParty
      </h1>
      <div class="flex justify-center">
        <button
          v-if="currentRound === 0"
          class="px-8 py-2 mx-auto mb-2 text-xl border-2 rounded text-ap-blue border-ap-blue"
          v-clipboard="() => url"
        >
          Copiar link
        </button>
      </div>
      <div
        class="flex justify-center"
        v-if="currentRound < 15"
      >
        <div class="mr-8 text-xl">
          Jugada {{ currentRound }}
        </div>
        <button
          class="px-8 py-2 mb-2 text-xl text-white rounded bg-ap-blue"
          @click="roll"
          :disabled="rollingDisabled"
          :class="{ 'opacity-50 cursor-not-allowed': rollingDisabled }"
        >
          Tirar dados
        </button>
      </div>
      <div
        v-else
        class="text-xl text-center"
      >
        Fin del juego
      </div>
      <div
        class="mb-8 text-xl text-center"
        v-if="currentRound > 0 && currentRound < 15"
      >
        {{ betsMissing === 1 ? 'Falta 1 apuesta' : `Faltan ${betsMissing} apuestas` }}
      </div>
      <div class="flex justify-center mb-4">
        <dice
          class="flex-shrink-0 w-1/2 px-2 md:px-4"
          :value="diceValues[0]"
          color="white"
          :rolling="!!rolling"
          :results="results[0]"
        />
        <dice
          class="flex-shrink-0 w-1/2 px-2 md:px-4"
          :value="diceValues[1]"
          color="blue"
          :rolling="!!rolling"
          :results="results[1]"
        />
      </div>
      <h2 class="text-2xl text-center">
        Números disponibles
      </h2>
      <div class="flex flex-wrap justify-center">
        <div
          v-for="n in availableNumbers"
          :key="n"
          class="mx-4 md:text-xl"
        >
          {{ n }}
        </div>
      </div>
    </div>
    <standings class="w-screen px-2 md:w-1/2" />
  </div>
</template>

<script>
import { mapState } from 'vuex';
import Dice from './dice';
import Standings from './standings';
import roundsApi from '../api/rounds';
import NewUserModal from './new-user-modal';
import JoinGameModal from './join-game-modal';

const DICE_SIDES = 6;
const ROLL_SECONDS = 3000;

export default {
  components: {
    Dice,
    Standings,
    NewUserModal,
    JoinGameModal,
  },
  data() {
    return {
      diceValues: this.startingRound ? [this.startingRound.white, this.startingRound.blue] : [1, 1],
      rolling: null,
      currentRound: this.startingRound ? this.startingRound.number : 0,
      betsMissing: this.startingBetsMissing,
      results: [[], []],
    };
  },
  props: {
    gameId: { type: Number, required: true },
    startingRound: { type: Object, default: () => ({ number: 0 }) },
    startingBetsMissing: { type: Number, required: true },
    startingAvailableNumbers: { type: Array, required: true },
    startingBetPlaced: { type: Boolean, required: true },
    currentStandings: { type: Array, required: true },
    startingUser: { type: Object, default: null },
  },
  computed: {
    ...mapState(['availableNumbers', 'currentUser', 'standings']),
    rollingDisabled() {
      if (this.currentRound === 0) return false;

      return this.betsMissing > 0 || this.rolling;
    },
    url() {
      return window.location.href;
    },
  },
  methods: {
    roll() {
      roundsApi.create({ gameId: this.gameId });
    },
    random() {
      return Math.floor(Math.random() * DICE_SIDES);
    },
    setRound(round) {
      this.results = [[], []];
      this.currentRound = round.number;
      this.rolling = true;
      setTimeout(() => {
        this.diceValues = [round.white, round.blue];
        this.betsMissing = this.standings.length;
        this.$store.commit('setBetPlaced', false);
        this.rolling = false;
      }, ROLL_SECONDS);
    },
  },
  channels: {
    GameChannel: {
      received(data) {
        if (data.round) this.setRound(data.round);
        if (data.bets) this.betsMissing = data.bets.missing;
        if (data.results) this.results = [data.results.white, data.results.blue];
        if (data.standings) this.$store.commit('setStandings', data.standings);
        if (data.user) this.$store.dispatch('addUser', data.user);
      },
    },
  },
  mounted() {
    this.$cable.subscribe({ channel: 'GameChannel', id: this.gameId });
    this.$store.commit('setGameId', this.gameId);
    this.$store.commit('setAvailableNumbers', this.startingAvailableNumbers);
    this.$store.commit('setStandings', this.currentStandings);
    this.$store.commit('setBetPlaced', this.startingBetPlaced);
    this.$store.commit('setCurrentUser', this.startingUser);

    if (!this.startingUser) {
      this.$modal.show('user-modal');
    } else if (!this.standings.find(user => user.id === this.startingUser.id)) {
      this.$modal.show('join-game-modal');
    }
  },
};
</script>
