-- +goose Up
-- +goose StatementBegin
CREATE TABLE "store"
(
    id         SERIAL PRIMARY KEY ,
    name       TEXT NOT NULL UNIQUE,
    platform_id INTEGER NOT NULL,
    currency_code TEXT NOT NULL,
    checkout_supported BOOLEAN NOT NULL,
    taxes_included BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP
);
-- add index for improve performance
CREATE INDEX store_name_idx ON "store" (name);
CREATE INDEX store_platform_id_idx ON "store" (platform_id);
CREATE INDEX store_currency_code_idx ON "store" (currency_code);
CREATE INDEX store_checkout_supported_idx ON "store" (checkout_supported);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX store_name_idx;
DROP INDEX store_platform_id_idx;
DROP INDEX store_currency_code_idx;
DROP INDEX store_checkout_supported_idx;
DROP TABLE "store";
-- +goose StatementEnd
