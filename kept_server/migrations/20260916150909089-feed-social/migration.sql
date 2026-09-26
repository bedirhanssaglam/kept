BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feed_comment" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "displayName" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "body" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "feed_comment_target_idx" ON "feed_comment" USING btree ("targetType", "targetId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feed_like" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "feed_like_unique_idx" ON "feed_like" USING btree ("userId", "targetType", "targetId");
CREATE INDEX "feed_like_target_idx" ON "feed_like" USING btree ("targetType", "targetId");


--
-- MIGRATION VERSION FOR kept
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('kept', '20260916150909089-feed-social', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916150909089-feed-social', "timestamp" = now();

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
