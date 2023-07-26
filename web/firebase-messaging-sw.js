importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyB6qCy9IgV23l07r0sv_eh-oRsG4qJlxOI",
  appId: "1:502920115519:web:d74a884e3d778dfa624f8a",
  messagingSenderId: "502920115519",
  projectId: "my-storage-ces",
  authDomain: "my-storage-ces.firebaseapp.com",
  storageBucket: "my-storage-ces.appspot.com",
  measurementId: "G-FVNFRS9WHD",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
