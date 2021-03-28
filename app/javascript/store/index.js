import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';

Vue.use(Vuex);

const MAX = 15;

const initialState = {
  availableNumbers: [...Array(MAX).keys()].map(val => val + 1),
  gameId: null,
  betPlaced: false,
  standings: [],
};

const mutations = {
  setGameId(state, payload) {
    state.gameId = payload;
  },
  setAvailableNumbers(state, payload) {
    state.availableNumbers = payload;
  },
  setBetPlaced(state, payload) {
    state.betPlaced = payload;
  },
  setStandings(state, payload) {
    state.standings = payload;
  },
};

const actions = {
  removeNumber({ commit, state }, payload) {
    commit('setAvailableNumbers', state.availableNumbers.filter(val => val !== payload));
  },
};

const vuexStore = new Vuex.Store({
  state: initialState,
  mutations,
  actions,
});

export default vuexStore;
