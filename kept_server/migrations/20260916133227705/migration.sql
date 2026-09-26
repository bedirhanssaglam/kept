BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "vow_check_in" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "userId" text NOT NULL,
    "dayKey" text NOT NULL,
    "kept" boolean NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "vow_membership" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "userId" text NOT NULL,
    "displayName" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "vow_room" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "rule" text NOT NULL,
    "category" text NOT NULL,
    "isPublic" boolean NOT NULL,
    "creatorId" text NOT NULL,
    "memberCount" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR kept
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('kept', '20260916133227705', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916133227705', "timestamp" = now();

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
