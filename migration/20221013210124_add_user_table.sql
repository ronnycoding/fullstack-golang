-- +goose Up
-- +goose StatementBegin
CREATE TABLE "user"
(
    id         SERIAL PRIMARY KEY ,
    email      TEXT NOT NULL UNIQUE,
    uid        TEXT NOT NULL UNIQUE,
    session    TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    last_login TIMESTAMP
);

ALTER SEQUENCE "user_id_seq" RESTART WITH 1000000;
-- add index for improve performance
CREATE INDEX user_email_idx ON "user" (email);
CREATE INDEX user_uid_idx ON "user" (uid);
CREATE INDEX user_session_idx ON "user" (session);
CREATE INDEX user_last_login_idx ON "user" (last_login);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX user_email_idx;
DROP INDEX user_uid_idx;
DROP INDEX user_session_idx;
DROP INDEX user_last_login_idx;
DROP TABLE "user";
-- +goose StatementEnd
