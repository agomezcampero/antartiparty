<template>
  <div class="m-10">
    <h1 class="mb-6 text-3xl text-center">
      AntartiParty
    </h1>
    <div class="flex justify-center">
      <button
        class="px-8 py-2 mb-12 text-xl text-white rounded bg-ap-blue"
        @click="roll"
      >
        Tirar dados
      </button>
    </div>
    <div class="flex justify-center">
      <dice
        class="mr-24"
        :value="diceValues[0]"
        color="white"
        :rolling="!!rolling"
      />
      <dice
        :value="diceValues[1]"
        color="blue"
        :rolling="!!rolling"
      />
    </div>
  </div>
</template>

<script>
import Dice from './dice';

const DICE_SIDES = 6;
const ROLL_SECONDS = 3000;
const PIC_CHANGE_SECONDS = 100;

export default {
  components: {
    Dice,
  },
  data() {
    return {
      diceValues: [0, 0],
      rolling: null,
    };
  },
  methods: {
    roll() {
      this.rolling = setInterval(() => {
        this.diceValues = [this.random(), this.random()];
      }, PIC_CHANGE_SECONDS);
      setTimeout(() => {
        clearInterval(this.rolling);
        this.rolling = null;
      }, ROLL_SECONDS);
    },
    random() {
      return Math.floor(Math.random() * DICE_SIDES);
    },
  },
};
</script>
