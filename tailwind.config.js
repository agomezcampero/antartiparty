/* eslint-disable no-undef */
module.exports = {
  theme: {
    extend: {
      colors: {
        'ap-blue': '#4788C7',
      },
    },
  },
  variants: {},
  plugins: [],
  purge: {
    enabled: process.env.NODE_ENV === 'production',
    content: [
      './app/**/*.html',
      './app/**/*.vue',
      './app/**/*.js',
      './app/**/*.erb',
    ],
  },
};
