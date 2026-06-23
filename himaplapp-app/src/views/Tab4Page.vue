<template>
  <ion-page>
    <CustomHeader title="HIMAPL Profil" />

    <ion-content :fullscreen="true" class="app-background">
      <div class="profile-header-section">
        <ion-avatar class="profile-avatar">
          <img :src="userData?.avatar_url || 'https://ionicframework.com/docs/img/demos/avatar.svg'" alt="Profile Avatar" />
        </ion-avatar>
        <h2 class="profile-name" v-if="!isLoading">{{ userData?.nama || 'Guest' }}</h2>
        <h2 class="profile-name" v-else>Loading...</h2>
        <p class="profile-role" v-if="!isLoading">{{ userData?.nim || userData?.email }}</p>
        <ion-badge class="profile-badge" v-if="!isLoading">{{ userData?.user_role || 'No Role' }}</ion-badge>
      </div>

      <div class="profile-content-section">
        <div class="menu-group">
          <h3 class="menu-group-title">Account</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item button class="profile-item" :detail="false">
              <div class="item-icon-box bg-blue" slot="start">
                <ion-icon :icon="personOutline" class="color-blue"></ion-icon>
              </div>
              <ion-label>Edit Profile</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
            <ion-item button class="profile-item" :detail="false">
              <div class="item-icon-box bg-orange" slot="start">
                <ion-icon :icon="lockClosedOutline" class="color-orange"></ion-icon>
              </div>
              <ion-label>Change Password</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
          </ion-list>
        </div>

        <div class="menu-group">
          <h3 class="menu-group-title">General</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item button class="profile-item" :detail="false">
              <div class="item-icon-box bg-gray" slot="start">
                <ion-icon :icon="settingsOutline" class="color-gray"></ion-icon>
              </div>
              <ion-label>Settings</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
            <ion-item button class="profile-item" :detail="false">
              <div class="item-icon-box bg-gray" slot="start">
                <ion-icon :icon="helpCircleOutline" class="color-gray"></ion-icon>
              </div>
              <ion-label>Help & Support</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
          </ion-list>
        </div>

        <ion-button expand="block" class="logout-btn" fill="clear">
          <ion-icon :icon="logOutOutline" slot="start"></ion-icon>
          Log Out
        </ion-button>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import {
  IonPage, IonContent, IonAvatar, IonList, IonItem,
  IonIcon, IonLabel, IonBadge, IonButton
} from '@ionic/vue';
import {
  personOutline, lockClosedOutline, settingsOutline,
  helpCircleOutline, logOutOutline, chevronForwardOutline
} from 'ionicons/icons';
import CustomHeader from "@/components/CustomHeader.vue";
import { supabase } from "../supabase";

const userData = ref<any>(null);
const isLoading = ref(true);

const fetchUserProfile = async () => {
    isLoading.value = true;
    try {
        const { data: authData, error: authError } = await supabase.auth.getUser();
        if (authError || !authData.user) {
            console.error("Auth Error:", authError);
            return;
        }
        
        const { data: publicUser, error: publicError } = await supabase
            .from('users')
            .select('*')
            .eq('id', authData.user.id)
            .single();
            
        if (publicError) {
            console.error("Public User Fetch Error:", publicError);
        } else {
            userData.value = publicUser;
        }
    } catch (e) {
        console.error("Unexpected Error:", e);
    } finally {
        isLoading.value = false;
    }
};

onMounted(() => {
    fetchUserProfile();
});
</script>

<style scoped>
.profile-header-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 32px 16px 24px;
  background: white;
  border-bottom-left-radius: 24px;
  border-bottom-right-radius: 24px;
  box-shadow: 0px 12px 24px -12px rgba(0, 0, 0, 0.05);
}

.profile-avatar {
  width: 96px;
  height: 96px;
  border: 4px solid #ebeff5;
  margin-bottom: 16px;
  box-shadow: 0px 8px 16px rgba(0,0,0,0.1);
}

.profile-name {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 22px;
  color: #191c1e;
  margin: 0 0 4px 0;
}

.profile-role {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  color: #424750;
  margin: 0 0 12px 0;
}

.profile-badge {
  --background: #184a85;
  --color: #ffffff;
  padding: 6px 12px;
  font-size: 10px;
  letter-spacing: 0.5px;
  border-radius: 12px;
  font-weight: 600;
}

.profile-content-section {
  padding: 24px 16px;
}

.menu-group {
  margin-bottom: 24px;
}

.menu-group-title {
  font-family: "Inter", sans-serif;
  font-size: 13px;
  font-weight: 600;
  color: #718096;
  text-transform: uppercase;
  letter-spacing: 1px;
  margin: 0 0 12px 8px;
}

.profile-list {
  background: white;
  border-radius: 16px;
  padding: 8px 0;
  box-shadow: 0px 8px 16px -8px rgba(0, 0, 0, 0.05);
}

.profile-item {
  --padding-start: 16px;
  --inner-padding-end: 16px;
  --min-height: 60px;
  font-family: "Inter", sans-serif;
  font-weight: 500;
  font-size: 15px;
  color: #191c1e;
}

.item-icon-box {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 16px;
}

.bg-blue { background: #dbe8fe; }
.color-blue { color: #2b5a9b; }

.bg-orange { background: #fde2ba; }
.color-orange { color: #624000; }

.bg-gray { background: #f3f4f6; }
.color-gray { color: #4a5568; }

.chevron-icon {
  color: #a0aec0;
  font-size: 20px;
}

.logout-btn {
  margin-top: 32px;
  --color: #e53e3e;
  font-family: "Inter", sans-serif;
  font-weight: 600;
  font-size: 16px;
}
</style>
