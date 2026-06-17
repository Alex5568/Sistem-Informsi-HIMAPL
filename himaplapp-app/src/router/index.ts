import { createRouter, createWebHistory } from '@ionic/vue-router';
import { RouteRecordRaw } from 'vue-router';

const routes: Array<RouteRecordRaw> = [
  {
    path: '',
    // redirect: '/folder/Inbox'
    redirect: '/login'
  },
  {
    path: '/folder/:id',
    name: 'Folder',
    component: () => import ('../views/FolderPage.vue')
  },
  {
    path: '/loader',
    name: 'Loader',
    component: () => import ('../views/LoaderPages.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import ('../views/LoginPage.vue')
  },
  {
    path: '/home',
    name: 'Home',
    component: () => import('../views/HomePage2.vue')
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
