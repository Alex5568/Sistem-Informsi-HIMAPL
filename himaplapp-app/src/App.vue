<template>
  <ion-app>
    <ion-split-pane content-id="main-content" :when="isMenuDisabled ? false : 'md'">
      <ion-menu content-id="main-content" type="overlay" :disabled="isMenuDisabled" :swipe-gesture="!isMenuDisabled">
        <ion-content>
          <ion-list id="inbox-list">
            <ion-list-header class="app-menu-header">
              <div class="user-info">
                <h2>{{ userName }}</h2>
                <p v-if="userEmail">{{ userEmail }}</p>
              </div>
            </ion-list-header>

            <ion-menu-toggle :auto-hide="false" v-for="(p, i) in appPages" :key="i">
              <ion-item @click="selectedIndex = i" router-direction="root" :router-link="p.url" lines="none" :detail="false" class="menu-item" :class="{ selected: selectedIndex === i }">
                <ion-icon aria-hidden="true" slot="start" :ios="p.iosIcon" :md="p.mdIcon"></ion-icon>
                <ion-label>{{ p.title }}</ion-label>
              </ion-item>
            </ion-menu-toggle>
          </ion-list>

          <div class="menu-footer">
            <ion-menu-toggle :auto-hide="false">
              <ion-item @click="handleLogout" lines="none" :detail="false" class="menu-item logout-item">
                <ion-icon aria-hidden="true" slot="start" :ios="logOutOutline" :md="logOutSharp"></ion-icon>
                <ion-label>Log Out</ion-label>
              </ion-item>
            </ion-menu-toggle>
          </div>
        </ion-content>
      </ion-menu>
      
      <ion-router-outlet id="main-content"></ion-router-outlet>
    </ion-split-pane> 
  </ion-app>
</template>

<script setup lang="ts">
import {
  IonApp,
  IonContent,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonMenu,
  IonMenuToggle,
  IonRouterOutlet,
  IonSplitPane,
} from '@ionic/vue';
import { ref, computed, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { supabase } from './supabase';
import {
  homeOutline, homeSharp,
  calendarOutline, calendarSharp,
  personOutline, personSharp,
  settingsOutline, settingsSharp,
  logOutOutline, logOutSharp
} from 'ionicons/icons';

const route = useRoute();
const router = useRouter();

const isMenuDisabled = computed(() => {
  return route.path === '/login' || route.path === '/register';
});

const selectedIndex = ref(0);
const appPages = [
  {
    title: 'Home',
    url: '/tabs/home',
    iosIcon: homeOutline,
    mdIcon: homeSharp,
  },
  {
    title: 'Events & Projects',
    url: '/tabs/projects',
    iosIcon: calendarOutline,
    mdIcon: calendarSharp,
  },
  {
    title: 'My Profile',
    url: '/tabs/profile',
    iosIcon: personOutline,
    mdIcon: personSharp,
  },
  {
    title: 'Settings',
    url: '/settings',
    iosIcon: settingsOutline,
    mdIcon: settingsSharp,
  }
];

const handleLogout = async () => {
  await supabase.auth.signOut();
  router.push('/login');
};

const path = window.location.pathname.split('folder/')[1];
if (path !== undefined) {
  selectedIndex.value = appPages.findIndex((page) => page.title.toLowerCase() === path.toLowerCase());
}

const userName = ref('Guest');
const userEmail = ref('');

const fetchUserProfile = async (user: any) => {
  if (user) {
    userEmail.value = user.email || '';
    const { data } = await supabase
      .from('users')
      .select('nama')
      .eq('id', user.id)
      .single();
    if (data) {
      userName.value = data.nama;
    }
  } else {
    userName.value = 'Guest';
    userEmail.value = '';
  }
};

onMounted(() => {
  supabase.auth.getSession().then(({ data: { session } }) => {
    fetchUserProfile(session?.user);
  });

  supabase.auth.onAuthStateChange((_event, session) => {
    fetchUserProfile(session?.user);
  });
});
</script>

<style scoped>
ion-menu ion-content {
  --background: #f8fafc;
}

.app-menu-header {
  background: linear-gradient(135deg, #184a85 0%, #2b5a9b 100%);
  padding: 32px 16px 24px 16px;
  margin-bottom: 8px;
  min-height: unset;
}

.user-info h2 {
  color: white;
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 20px;
  margin: 0 0 4px 0;
}

.user-info p {
  color: #a5c8fe;
  font-family: "Inter", sans-serif;
  font-size: 14px;
  margin: 0;
}

ion-menu.md ion-list {
  padding: 0;
  background: transparent;
}

.menu-item {
  --background: transparent;
  --color: #475569;
  font-family: "Inter", sans-serif;
  font-weight: 500;
  font-size: 16px;
  margin: 4px 12px;
  border-radius: 12px;
}

.menu-item ion-icon {
  color: #64748b;
  font-size: 24px;
}

.menu-item.selected {
  --background: #eff6ff;
  --color: #184a85;
  font-weight: 600;
}

.menu-item.selected ion-icon {
  color: #184a85;
}

.menu-footer {
  margin-top: auto;
  padding: 16px 0;
  border-top: 1px solid #e2e8f0;
  position: absolute;
  bottom: 0;
  width: 100%;
}

.logout-item {
  --color: #ef4444;
}

.logout-item ion-icon {
  color: #ef4444;
}
</style>
