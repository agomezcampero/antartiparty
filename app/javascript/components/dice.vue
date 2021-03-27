<template>
  <img
    :src="require(`assets/images/${color}/${value}.png`)"
    class="border-2 border-ap-blue"
    :class="{ 'animate-spin': rolling }"
  >
</template>

<script>

export default {
  props: {
    value: { type: Number, required: true },
    color: { type: String, required: true },
    rolling: { type: Boolean, required: true },
  },
};
</script>
