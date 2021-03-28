<template>
  <div>
    <table class="mx-auto text-sm text-white rounded-t-lg bg-ap-blue">
      <tr class="text-left border-b-2 border-gray-300">
        <th class="px-2 py-3">
          Lugar
        </th>
        <th class="px-2 py-3">
          Email
        </th>
        <th class="px-2 py-3">
          Puntos
        </th>
      </tr>
      <tr
        class="text-black bg-gray-100 border-b border-gray-200"
        v-for="(user, idx) in standings"
        :key="user.email"
      >
        <td class="px-2 py-3">
          {{ idx + 1 }}
        </td>
        <td class="px-2 py-3 break-all">
          {{ user.email }}
        </td>
        <td class="px-2 py-3">
          {{ user.points }}
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  computed: {
    ...mapState(['standings']),
  },
};
</script>
