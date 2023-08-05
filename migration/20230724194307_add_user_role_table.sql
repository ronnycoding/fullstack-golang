-- +goose Up
-- +goose StatementBegin
CREATE TABLE "user_role"
(
    id         SERIAL PRIMARY KEY ,
    user_id    INTEGER NOT NULL REFERENCES "user" (id),
    role_id    INTEGER NOT NULL REFERENCES "role" (id),
    store_id   INTEGER NOT NULL REFERENCES "store" (id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP
);
-- add index for improve performance
CREATE INDEX user_role_user_id_idx ON user_role (user_id);
CREATE INDEX user_role_role_id_idx ON user_role (role_id);
CREATE INDEX user_role_store_id_idx ON user_role (store_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX user_role_user_id_idx;
DROP INDEX user_role_role_id_idx;
DROP INDEX user_role_store_id_idx;
DROP TABLE "user_role";
-- +goose StatementEnd
