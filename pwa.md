# PWA Quickstart

PWAs basically require 2 things:
- manifest.json
- service-worker.js

## manifest.json

This should be in the root directory of the site.

The icons of various sizes are to support various mobile platforms.

You also need to link this and the icons in the index.html page:

```html
<link rel="manifest" href="manifest.json">
<!-- ios support -->
<link rel="apple-touch-icon" href="images/icons/icon-72x72.png" />
<link rel="apple-touch-icon" href="images/icons/icon-96x96.png" />
<link rel="apple-touch-icon" href="images/icons/icon-128x128.png" />
<link rel="apple-touch-icon" href="images/icons/icon-144x144.png" />
<link rel="apple-touch-icon" href="images/icons/icon-152x152.png" />
<link rel="apple-touch-icon" href="images/icons/icon-192x192.png" />
<link rel="apple-touch-icon" href="images/icons/icon-384x384.png" />
<link rel="apple-touch-icon" href="images/icons/icon-512x512.png" />
<meta name="apple-mobile-web-app-status-bar" content="#db4938" />
<meta name="theme-color" content="#db4938" />
```

Example manifest:

```json
{
    "name": "PWA Test",
    "short_name": "PWATest",
    "start_url": "/index.html",
    "display": "standalone",
    "background_color": "#fdfdfd",
    "theme_color": "#db4938",
    "orientation": "portrait-primary",
    "icons": [
      {
        "src": "/images/icons/icon-72x72.png",
        "type": "image/png", "sizes": "72x72"
      },
      {
        "src": "/images/icons/icon-96x96.png",
        "type": "image/png", "sizes": "96x96"
      },
      {
        "src": "/images/icons/icon-128x128.png",
        "type": "image/png","sizes": "128x128"
      },
      {
        "src": "/images/icons/icon-144x144.png",
        "type": "image/png", "sizes": "144x144"
      },
      {
        "src": "/images/icons/icon-152x152.png",
        "type": "image/png", "sizes": "152x152"
      },
      {
        "src": "/images/icons/icon-192x192.png",
        "type": "image/png", "sizes": "192x192",
        "purpose": "any maskable"
      },
      {
        "src": "/images/icons/icon-384x384.png",
        "type": "image/png", "sizes": "384x384"
      },
      {
        "src": "/images/icons/icon-512x512.png",
        "type": "image/png", "sizes": "512x512"
      }
    ]
  }
}
```

## service-worker.js

You should start it in the index.html file in the onload event.

```html
<script>
    window.onload = () => {  
        'use strict';     
        if ('serviceWorker' in navigator) {     
            navigator.serviceWorker.register('/serviceWorker.js'); 
        } 
    }
</script>
```

An example service worker:

```js
const staticPWA = "pwa-test-v1";

// These are all the things that should be cached for offline use.
const assets = [
    "/",
    "/images/icons/icon-512x512.png",
    "/images/icons/icon-384x384.png",
    "/images/icons/icon-192x192.png",
    "/images/icons/icon-152x152.png",
    "/images/icons/icon-144x144.png",
    "/images/icons/icon-128x128.png",
    "/images/icons/icon-96x96.png",
    "/images/icons/icon-72x72.png",
];

self.addEventListener("install", installEvent => {
    installEvent.waitUntil(
        caches.open(staticPWA).then(cache => cache.addAll(assets))
    );
});

self.addEventListener("fetch", fetchEvent => {
    fetchEvent.respondWith(
        caches.match(fetchEvent.request).then(res => {
            return res || fetch(fetchEvent.request)
        })
    )
});
```