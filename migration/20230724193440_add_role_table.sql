-- +goose Up
-- +goose StatementBegin
CREATE TABLE "role"
(
    id         SERIAL PRIMARY KEY ,
    name       TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);
-- add index for improve performance
CREATE INDEX role_name_idx ON role (name);

-- add seed data
INSERT INTO "role" (name) VALUES 
    -- system roles
    ('admin'),
    ('support'),
    -- store roles
    ('store_owner'),
    ('store_manager'),
    ('store_clerk'),
    -- delivery roles
    ('delivery_driver'),
    ('delivery_analyst'),
    ('delivery_manager');

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX role_name_idx;
DROP TABLE "role";
-- +goose StatementEnd
