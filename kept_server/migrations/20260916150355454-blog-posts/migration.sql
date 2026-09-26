BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "blog_post" (
    "id" bigserial PRIMARY KEY,
    "slug" text NOT NULL,
    "title" text NOT NULL,
    "excerpt" text NOT NULL,
    "body" text NOT NULL,
    "topic" text NOT NULL,
    "publishedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "blog_post_slug_idx" ON "blog_post" USING btree ("slug");


--
-- MIGRATION VERSION FOR kept
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('kept', '20260916150355454-blog-posts', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916150355454-blog-posts', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
