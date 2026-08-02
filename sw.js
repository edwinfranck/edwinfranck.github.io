/* Service worker du portfolio d'Edwin Kouassi.
   Stratégie : on sert depuis le cache si on l'a, on met à jour en arrière-plan.
   Bumper CACHE force le rafraîchissement de tous les visiteurs. */
const CACHE = 'edwin-portfolio-v7';
const CORE = ['./', './index.html', './manifest.webmanifest',
              './assets/css/fonts.css', './assets/js/gsap.min.js',
              './assets/img/edwin.jpg', './assets/img/icon-192.png'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(CORE)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET' || new URL(req.url).origin !== location.origin) return;
  e.respondWith(
    caches.match(req).then(hit => {
      const net = fetch(req).then(res => {
        if (res && res.status === 200) {
          const copy = res.clone();
          caches.open(CACHE).then(c => c.put(req, copy));
        }
        return res;
      }).catch(() => hit);
      return hit || net;
    })
  );
});
