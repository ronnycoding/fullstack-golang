-- +goose Up
-- +goose StatementBegin
CREATE TABLE customer_platform_address (
    id SERIAL PRIMARY KEY,
    customer_platform_id INTEGER NOT NULL REFERENCES customer_platform(id),
    address_id INTEGER NOT NULL REFERENCES mailing_address(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP
);
-- add index for improve performance
CREATE INDEX customer_platform_address_customer_platform_id_idx ON customer_platform_address (customer_platform_id);
CREATE INDEX customer_platform_address_address_id_idx ON customer_platform_address (address_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX customer_platform_address_customer_platform_id_idx;
DROP INDEX customer_platform_address_address_id_idx;
DROP TABLE customer_platform_address;
-- +goose StatementEnd
