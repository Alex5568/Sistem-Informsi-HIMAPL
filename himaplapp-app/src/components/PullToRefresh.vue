<template>
  <ion-refresher slot="fixed" @ionRefresh="handleRefresh">
    <ion-refresher-content
      pulling-icon="lines"
      pulling-text="Pull to refresh..."
      refreshing-spinner="circles"
      refreshing-text="Refreshing...">
    </ion-refresher-content>
  </ion-refresher>
</template>

<script setup lang="ts">
import { IonRefresher, IonRefresherContent } from '@ionic/vue';

const emit = defineEmits(['refresh']);

const handleRefresh = (event: any) => {
  // Emit event ke komponen induk (parent)
  // Meneruskan object event agar induk bisa memanggil event.target.complete()
  emit('refresh', event);
};
</script>
