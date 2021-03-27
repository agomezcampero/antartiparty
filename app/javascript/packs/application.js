import Vue from 'vue/dist/vue.esm';
import App from '../app.vue';
import '../css/application.css';
import Home from '../components/home';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-app',
    components: { App, Home },
  });

  return app;
});
