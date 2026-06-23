import { createRouter, createWebHistory } from '@ionic/vue-router';
import { RouteRecordRaw } from 'vue-router';
import TabsPage from '../views/TabsPage.vue';

const routes: Array<RouteRecordRaw> = [
  // 1. Base Route (Mengarahkan ke Login saat aplikasi pertama kali dibuka)
  {
    path: '',
    redirect: '/login'
  },

  // 2. Rute Standar (Standalone Pages)
  {
    path: '/folder/:id',
    name: 'Folder',
    component: () => import('../views/FolderPage.vue')
  },

  // 3. Rute Tabs (Nested Routes)
  {
    path: '/tabs/',
    component: TabsPage,
    children: [
      {
        path: '',
        redirect: '/tabs/home'
      },
      {
        path: 'home',
        component: () => import('@/views/Tab1Page.vue')
      },
      {
        path: 'projects',
        component: () => import('@/views/Tab2Page.vue')
      },
      {
        path: 'notifications',
        component: () => import('@/views/Tab3Page.vue')
      },
      {
        path: 'profile',
        component: () => import('@/views/Tab4Page.vue')
      }
    ]
  },
  {
    path: '/loader',
    name: 'Loader',
    component: () => import('../views/LoaderPages.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/LoginPage.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/RegisterPage.vue')
  }
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
});

export default router;