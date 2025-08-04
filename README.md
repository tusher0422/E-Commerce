# Flutter E-Commerce Web App

A beginner-friendly Flutter web e-commerce app with Firebase, Stripe integration, and product listing via API.

## Setup

- Run `flutter pub get`
- Connect Firebase: `flutterfire configure`
- Deploy `functions/index.js` or run it locally
- Add your Stripe secret key in `.env` (do NOT commit)
- Run app: `flutter run -d chrome`

## Packages Used

- firebase_core, firebase_auth, google_sign_in
- cloud_firestore, flutter_stripe
- http, get, flutter_easyloading

## Features

- Google Sign-In with Firebase
- Product list from Fake Store API
- Stripe payments using Firebase Functions
- Basic product detail view
- Simple GetX state management

## Limitations

- Stripe works only in test mode
- Public API, no real product database
- Only Google Sign-In supported

