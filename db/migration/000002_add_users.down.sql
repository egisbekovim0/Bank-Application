alter table if exists "accounts" drop CONSTRAINT if EXISTS "accounts_owner_fkey";

DROP INDEX IF EXISTS "accounts_owner_currency_idx";

drop TABLE if EXISTS "users";