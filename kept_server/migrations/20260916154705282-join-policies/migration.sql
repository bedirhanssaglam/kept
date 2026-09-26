BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "join_request" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "userId" text NOT NULL,
    "displayName" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "join_request_room_user_idx" ON "join_request" USING btree ("roomId", "userId");
CREATE INDEX "join_request_room_status_idx" ON "join_request" USING btree ("roomId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "vow_invite" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "code" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "maxUses" bigint NOT NULL DEFAULT 0,
    "useCount" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "vow_invite_code_idx" ON "vow_invite" USING btree ("code");
CREATE INDEX "vow_invite_room_idx" ON "vow_invite" USING btree ("roomId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "vow_membership" ADD COLUMN "role" text NOT NULL DEFAULT 'member'::text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "vow_room" ADD COLUMN "joinPolicy" text NOT NULL DEFAULT 'open'::text;
ALTER TABLE "vow_room" ADD COLUMN "isOfficial" boolean NOT NULL DEFAULT false;

--
-- MIGRATION VERSION FOR kept
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('kept', '20260916154705282-join-policies', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916154705282-join-policies', "timestamp" = now();

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
