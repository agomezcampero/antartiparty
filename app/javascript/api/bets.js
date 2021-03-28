import api from './index';

export default {
  create(data) {
    return api({
      method: 'post',
      url: '/api/v1/bets',
      data,
    });
  },
};
