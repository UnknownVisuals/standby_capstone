<div align="center">
    <img src="assets/logo/logo.png" alt="Logo StandBy" width="360" align="center">
</div>

## 🏃 - How to run the App

1. clone this repository

   ```bash
   git clone https://github.com/UnknownVisuals/standby_capstone.git
   ```

2. create .env and provide SUPABASE_URL, SUPABASE_ANON_KEY, and SUPABASE_SERVICE_ROLE_KEY

   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
   ```

3. provide your firebase service-account.json to `supabase/functions/iot-warning/HERE!`

4. configure firebase_options

   ```bash
   flutterfire configure
   ```

5. get the dependencies

   ```bash
   flutter pub get
   ```

6. run the app

   ```bash
   flutter run -d DEVICENAME
   ```
