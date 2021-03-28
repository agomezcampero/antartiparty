<template>
  <div>
    <img
      :src="require(`assets/images/${color}/${value}.png`)"
      class="mb-2 border-2 border-ap-blue"
      :class="{ 'animate-spin': rolling }"
    >
    <div
      v-for="(result, idx) in results"
      :key="idx"
    >
      <div
        class="overflow-hidden overflow-ellipsis"
        :class="result.winner ? 'text-green-500' : 'text-red-500'"
      >
        {{ result.value }} - {{ result.user.username }}
      </div>
    </div>
    <multiselect
      class="mb-2"
      v-model="betValue"
      :options="availableNumbers"
      :disabled="betPlaced"
    />
    <button
      class="w-full p-2 mb-2 text-lg text-white rounded bg-ap-blue"
      @click="bet"
      :disabled="betDisabled"
      :class="{ 'opacity-50 cursor-not-allowed': betDisabled }"
    >
      Apostar
    </button>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import betsApi from '../api/bets';

export default {
  data() {
    return {
      betValue: null,
    };
  },
  props: {
    value: { type: Number, required: true },
    color: { type: String, required: true },
    rolling: { type: Boolean, required: true },
    results: { type: Array, required: true },
  },
  computed: {
    ...mapState(['availableNumbers', 'gameId', 'betPlaced']),
    betDisabled() {
      return this.betPlaced || !this.betValue;
    },
  },
  methods: {
    bet() {
      betsApi.create({ value: this.betValue, gameId: this.gameId, color: this.color }).then(() => {
        this.$store.commit('setBetPlaced', true);
        this.$store.dispatch('removeNumber', this.betValue);
        this.betValue = null;
      });
    },
  },
};
</script>
