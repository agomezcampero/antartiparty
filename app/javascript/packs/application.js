import Vue from 'vue/dist/vue.esm';
import 'vue-multiselect/dist/vue-multiselect.min.css';
import Multiselect from 'vue-multiselect';
import ActionCableVue from 'actioncable-vue';
import App from '../app.vue';
import '../css/application.css';
import Game from '../components/game';
import GameForm from '../components/game-form';
import store from '../store';

Vue.component('Multiselect', Multiselect);
Vue.use(ActionCableVue, {
  connectionUrl: '/cable',
  connectImmediately: true,
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-app',
    components: { App, Game, GameForm },
    store,
  });

  return app;
});
