CREATE extension if not exists citext;
create extension if not exists "uuid-ossp";
CREATE table users (
    id uuid DEFAULT uuid_generate_v4() PRIMARY key,
    username citext UNIQUE not null,
    password text,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);
CREATE table notes (
    id uuid default uuid`_generate_v4() PRIMARY key,
    parent_id uuid references notes (id),
    user_id uuid not null references users (id),
    title text,
    content text,
    is_published boolean not null default false,
    cerated_at timestamp default now(),
    updated_at timestamp default now()
);