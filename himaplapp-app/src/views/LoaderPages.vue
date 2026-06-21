<template>
  <ion-page>
    <ion-content class="ion-padding">
      <div class="flex-center">
        <ion-spinner name="crescent" color="success"></ion-spinner>
        <p>{{ statusMessage }}</p>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { IonPage, IonContent, IonSpinner } from '@ionic/vue';
import { useRouter } from "vue-router";

const router = useRouter();
const statusMessage = ref("Menyiapkan Data HIMAPL...");

onMounted(() => {
    console.log("Halaman Loader berhasil dimuat!");

    setTimeout(() => {
       statusMessage.value = "Hampir selesai...";
       
       setTimeout(() => {
        router.push("/login");
       }, 1000);
    }, 2000);
});
</script>
