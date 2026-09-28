BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "vow_room" ADD COLUMN "durationDays" bigint NOT NULL DEFAULT 0;
ALTER TABLE "vow_room" ADD COLUMN "startsOn" text NOT NULL DEFAULT ''::text;

--
-- MIGRATION VERSION FOR kept
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('kept', '20260926172955694-vow-span', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926172955694-vow-span', "timestamp" = now();

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
