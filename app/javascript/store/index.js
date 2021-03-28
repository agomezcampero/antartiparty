import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';

Vue.use(Vuex);

const MAX = 15;

const initialState = {
  availableNumbers: [...Array(MAX).keys()].map(val => val + 1),
  gameId: null,
  betPlaced: false,
  standings: [],
  currentUser: null,
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
  setCurrentUser(state, payload) {
    state.currentUser = payload;
  },
};

const actions = {
  removeNumber({ commit, state }, payload) {
    commit('setAvailableNumbers', state.availableNumbers.filter(val => val !== payload));
  },
  addUser({ commit, state }, payload) {
    if (state.standings.find(user => user.id === payload.id)) return;

    commit('setStandings',
      [...state.standings, { id: payload.id, username: payload.username, points: 0 }]);
  },
};

const vuexStore = new Vuex.Store({
  state: initialState,
  mutations,
  actions,
});

export default vuexStore;
