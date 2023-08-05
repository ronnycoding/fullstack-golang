-- +goose Up
-- +goose StatementBegin
CREATE TYPE integration_type AS ENUM ('SHOPIFY');

CREATE TABLE "integration"
(
    id         SERIAL PRIMARY KEY ,
    store_id   INTEGER NOT NULL REFERENCES "store" (id),
    type       integration_type NOT NULL,
    extra      JSONB,
    access_token TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);
-- add index for improve performance
CREATE INDEX integration_store_id_idx ON integration (store_id);
CREATE INDEX integration_type_idx ON integration (type);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX integration_store_id_idx;
DROP INDEX integration_type_idx;
DROP TABLE "integration";
DROP TYPE integration_type;
-- +goose StatementEnd
