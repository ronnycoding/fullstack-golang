-- +goose Up
-- +goose StatementBegin
CREATE TABLE "user"
(
    id         SERIAL PRIMARY KEY ,
    email      VARCHAR(255) NOT NULL UNIQUE,
    uid        VARCHAR(28) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

ALTER SEQUENCE "user_id_seq" RESTART WITH 1000000;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE "user";
-- +goose StatementEnd
