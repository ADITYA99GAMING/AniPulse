ANIPULSE - GITHUB PAGES + SUPABASE SHARED CONTENT SETUP
========================================================

The website is configured with your Supabase project and publishable key.
Project reference: khprmojdrqpuxtqpeinc
Project URL: https://khprmojdrqpuxtqpeinc.supabase.co

IMPORTANT
- Never put a Supabase service_role/secret key in this website.
- The publishable key in index.html is intended for browser use.
- Database security is enforced by Row Level Security (RLS), not by hiding the key.
- GitHub Pages hosts the static website; Supabase stores the shared content.

STEP 1 - CREATE THE DATABASE TABLE AND POLICIES
1. Open https://supabase.com/dashboard/project/khprmojdrqpuxtqpeinc/sql/new
2. Open SUPABASE-SETUP.sql from this project.
3. Copy all SQL statements except the final commented UPDATE example, then run them.
   (The UPDATE example is run separately after your admin user exists.)

STEP 2 - CREATE YOUR ADMIN LOGIN
1. In Supabase, open Authentication -> Users.
2. Click Add user and create your own admin email/password.
3. Open SQL Editor and run this statement, replacing the email with the exact admin email:

   UPDATE auth.users
   SET raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) || '{"role":"admin"}'::jsonb
   WHERE email = 'YOUR_ADMIN_EMAIL';

4. Sign out and sign back in to AniPulse so the refreshed session contains the admin role.
5. In AniPulse, open Admin Panel and use that email/password.

STEP 3 - PUBLISH ON GITHUB PAGES
1. Upload the contents of the AniPulse-main folder to the root of your GitHub repository.
2. In GitHub, open Settings -> Pages.
3. Choose Deploy from a branch, branch main, folder /(root), then Save.
4. Wait for GitHub Pages to deploy the website.

HOW IT WORKS
- Every visitor reads anime catalogue, memes, and news from the same Supabase row.
- Admin changes are written to Supabase and become visible to all visitors.
- The hero slider is driven by the shared anime catalogue's featuredInSlider values.
- Admin writes require a signed-in account whose app_metadata role is admin.
- Existing localStorage data is used only as a fallback before the first shared database row exists.

LIMITATIONS
- Supabase Free quotas and inactivity-pause rules apply; check https://supabase.com/pricing.
- This database stores catalogue/content metadata and episode URLs, not video files.
- Actual video hosting/streaming must be provided by a separate legal video host.
- The existing project does not gain a public user registration/profile system from this content integration.

UPDATE NOTE - SHARED CONTENT SYNC FIX
The updated index.html now:
- checks the active Supabase user and admin app_metadata role before every publish;
- loads the shared database row before rendering the homepage;
- refreshes catalogue, memes, news and hero slider for visitors when Supabase Realtime sends an update;
- refreshes shared content again when a visitor returns to the browser tab;
- shows database errors instead of reporting a false successful publish.

After replacing the files on GitHub, run the complete SUPABASE-SETUP.sql again as postgres, then sign out/in to the admin account. In Supabase, confirm Realtime is enabled for public.anipulse_content if live updates do not arrive.

IMPORTANT SCOPE NOTE
The separate season/episode HTML pages now sync their internal trailer, related-page and episode-link editor data through the additional public.anipulse_page_content table. The migration is included in SUPABASE-SETUP.sql. The admin must first sign in on the homepage using the Supabase admin account; Supabase Row Level Security then blocks non-admin writes even if someone opens a legacy page editor.
