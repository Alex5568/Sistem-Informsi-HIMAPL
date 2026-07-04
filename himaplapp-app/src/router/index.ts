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
  },
  {
    path: '/settings',
    name: 'Settings',
    component: () => import('../views/SettingsPage.vue')
  },
  {
    path: '/event/:id',
    name: 'EventDetail',
    component: () => import('../views/EventDetailPage.vue')
  },
  {
    path: '/news/:id',
    name: 'NewsDetail',
    component: () => import('../views/NewsDetailPage.vue')
  },
  {
    path: '/notification/:id',
    name: 'NotificationDetail',
    component: () => import('../views/NotificationDetailPage.vue')
  },
  {
    path: '/manage/events',
    name: 'ManageEvents',
    component: () => import('../views/ManageEventsPage.vue')
  },
  {
    path: '/manage/news',
    name: 'ManageNews',
    component: () => import('../views/ManageNewsPage.vue')
  },
  {
    path: '/manage/notifications',
    name: 'ManageNotifications',
    component: () => import('../views/ManageNotificationsPage.vue')
  },
  {
    path: '/manage/roles',
    name: 'ManageRoles',
    component: () => import('../views/ManageRolesPage.vue')
  },
  {
    path: '/reports',
    name: 'Reports',
    component: () => import('../views/ReportsPage.vue')
  },
  {
    path: '/organization',
    name: 'Organization',
    component: () => import('../views/OrganizationPage.vue')
  }
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
});

// Add global route guard
router.beforeEach(async (to, from, next) => {
  // Check if we are handling an OAuth redirect error
  const hashParams = new URLSearchParams(to.hash.substring(1) || window.location.hash.substring(1));
  if (hashParams.has('error_description')) {
    const errorMsg = hashParams.get('error_description');
    console.error('OAuth Error:', errorMsg);
  }

  // Jika ada token dari Supabase di URL hash, izinkan routing berjalan 
  // agar Supabase dapat memproses token tersebut.
  if (to.hash && (to.hash.includes('access_token') || to.hash.includes('refresh_token'))) {
    return next();
  }

  // Import supabase inside the guard to avoid circular dependencies if any
  const { supabase } = await import('../supabase');
  
  // Get current session (this automatically parses the OAuth hash if present)
  const { data: { session } } = await supabase.auth.getSession();

  // If going to tabs and not authenticated, redirect to login
  if (to.path.startsWith('/tabs') && !session) {
    next('/login');
  } 
  // If going to login/register and already authenticated, redirect to tabs/home
  else if ((to.path === '/login' || to.path === '/register') && session) {
    next('/tabs/home');
  }
  else {
    next();
  }
});

export default router;