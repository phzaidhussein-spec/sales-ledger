-- شغّل هذا الملف كاملاً داخل Supabase: SQL Editor > New query > الصق ثم Run

create table if not exists employees (
  id text primary key,
  name text not null,
  goals jsonb not null default '[]'::jsonb,
  created_at timestamp with time zone default now()
);

create table if not exists sales (
  id text primary key,
  employee_id text references employees(id) on delete cascade,
  date date not null,
  product text,
  category text,
  price numeric not null default 0,
  qty numeric not null default 1,
  created_at timestamp with time zone default now()
);

-- تفعيل الوصول العام (مناسب لأداة داخلية بسيطة بدون تسجيل دخول).
-- إذا أردت لاحقاً حماية أقوى (تسجيل دخول للموظفين)، يمكن استبدال هذه السياسات بسياسات مبنية على auth.uid().
alter table employees enable row level security;
alter table sales enable row level security;

create policy "allow all on employees" on employees
  for all using (true) with check (true);

create policy "allow all on sales" on sales
  for all using (true) with check (true);
