-- AniPulse shared content database (run this in Supabase SQL Editor)
-- Public visitors can read content. Only a Supabase user with app_metadata.role = 'admin' can write.

create table if not exists public.anipulse_content (
  id integer primary key check (id = 1),
  catalog jsonb not null default '[]'::jsonb,
  memes jsonb not null default '[]'::jsonb,
  news jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.anipulse_content enable row level security;

grant select on public.anipulse_content to anon, authenticated;
grant insert, update on public.anipulse_content to authenticated;

drop policy if exists "Anyone can read AniPulse content" on public.anipulse_content;
create policy "Anyone can read AniPulse content"
  on public.anipulse_content for select
  using (true);

drop policy if exists "Only AniPulse admins can insert content" on public.anipulse_content;
create policy "Only AniPulse admins can insert content"
  on public.anipulse_content for insert to authenticated
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

drop policy if exists "Only AniPulse admins can update content" on public.anipulse_content;
create policy "Only AniPulse admins can update content"
  on public.anipulse_content for update to authenticated
  using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

-- After creating your admin user in Authentication > Users, replace the email below
-- with that exact email and run this statement to grant the admin role.
-- UPDATE auth.users
-- SET raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) || '{"role":"admin"}'::jsonb
-- WHERE email = 'YOUR_ADMIN_EMAIL';
