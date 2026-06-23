<template>
  <ion-header class="ion-no-border custom-header-solid">
    <ion-toolbar>
      <ion-buttons slot="start">
        <ion-button class="menu-btn">
          <ion-menu-button></ion-menu-button>
        </ion-button>
      </ion-buttons>
      <ion-title class="header-title">{{ title }}</ion-title>
      <ion-avatar slot="end" class="header-avatar">
        <img alt="Profile" :src="avatarUrl" />
      </ion-avatar>
    </ion-toolbar>
  </ion-header>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { 
  IonHeader, IonToolbar, IonButtons, IonButton, 
  IonMenuButton, IonTitle, IonAvatar 
} from "@ionic/vue";
import { supabase } from "../supabase";

// Mengatur properti judul agar bisa diubah di tiap halaman
defineProps({
  title: {
    type: String,
    default: "HIMAPL",
  },
});

const avatarUrl = ref('https://ionicframework.com/docs/img/demos/avatar.svg');

const fetchAvatar = async () => {
    try {
        const { data: authData, error: authError } = await supabase.auth.getUser();
        if (authError || !authData.user) {
            return;
        }
        
        const { data: publicUser, error: publicError } = await supabase
            .from('users')
            .select('avatar_url')
            .eq('id', authData.user.id)
            .single();
            
        if (!publicError && publicUser?.avatar_url) {
            avatarUrl.value = publicUser.avatar_url;
        }
    } catch (e) {
        console.error("Unexpected Error retrieving user avatar:", e);
    }
};

onMounted(() => {
    fetchAvatar();
});
</script>