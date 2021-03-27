const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const vue = require('./loaders/vue');
const path = require('path');

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('vue', vue);
module.exports = environment;

environment.config.merge({
  resolve: {
    alias: {
      assets: path.resolve('./app/assets'),
    },
  },
});
