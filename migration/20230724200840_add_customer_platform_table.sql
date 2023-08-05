-- https://shopify.dev/docs/api/admin-graphql/2023-07/objects/Customer
-- +goose Up
-- +goose StatementBegin
CREATE TYPE customer_platform_state_type AS ENUM ('DECLINED', 'DISABLED', 'ENABLED', 'INVITED');
CREATE TABLE customer_platform (
    id  SERIAL PRIMARY KEY,
    platform_id INTEGER NOT NULL,
    amount_spent INTEGER NOT NULL,
    currency_spent VARCHAR(3) NOT NULL,
    average_order_amount INTEGER,
    average_order_currency VARCHAR(3),
    can_delete BOOLEAN NOT NULL,
    platform_created_at TIMESTAMP NOT NULL,
    default_address_id INTEGER NOT NULL REFERENCES mailing_address(id),
    display_name VARCHAR(255),
    email VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    last_order_id INTEGER REFERENCES "order"(id),
    locale VARCHAR(255),
    note VARCHAR(255),
    number_of_orders INTEGER NOT NULL,
    phone VARCHAR(255),
    state customer_platform_state_type NOT NULL,
    tags VARCHAR(255),
    tax_exempt BOOLEAN NOT NULL,
    updated_at TIMESTAMP,
    valid_email_address BOOLEAN NOT NULL,
    verified_email BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP
  )
-- add index for improve performance
CREATE INDEX customer_platform_platform_id_idx ON customer_platform (platform_id);
CREATE INDEX customer_platform_amount_spent_idx ON customer_platform (amount_spent);
CREATE INDEX customer_platform_currency_spent_idx ON customer_platform (currency_spent);
CREATE INDEX customer_platform_average_order_amount_idx ON customer_platform (average_order_amount);
CREATE INDEX customer_platform_average_order_currency_idx ON customer_platform (average_order_currency);
CREATE INDEX customer_platform_can_delete_idx ON customer_platform (can_delete);
CREATE INDEX customer_platform_platform_created_at_idx ON customer_platform (platform_created_at);
CREATE INDEX customer_platform_default_address_id_idx ON customer_platform (default_address_id);
CREATE INDEX customer_platform_display_name_idx ON customer_platform (display_name);
CREATE INDEX customer_platform_email_idx ON customer_platform (email);
CREATE INDEX customer_platform_first_name_idx ON customer_platform (first_name);
CREATE INDEX customer_platform_last_name_idx ON customer_platform (last_name);
CREATE INDEX customer_platform_last_order_id_idx ON customer_platform (last_order_id);
CREATE INDEX customer_platform_locale_idx ON customer_platform (locale);
CREATE INDEX customer_platform_note_idx ON customer_platform (note);
CREATE INDEX customer_platform_number_of_orders_idx ON customer_platform (number_of_orders);
CREATE INDEX customer_platform_phone_idx ON customer_platform (phone);
CREATE INDEX customer_platform_state_idx ON customer_platform (state);
CREATE INDEX customer_platform_tags_idx ON customer_platform (tags);
CREATE INDEX customer_platform_tax_exempt_idx ON customer_platform (tax_exempt);
CREATE INDEX customer_platform_updated_at_idx ON customer_platform (updated_at);
CREATE INDEX customer_platform_valid_email_address_idx ON customer_platform (valid_email_address);
CREATE INDEX customer_platform_verified_email_idx ON customer_platform (verified_email);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX customer_platform_platform_id_idx;
DROP INDEX customer_platform_amount_spent_idx;
DROP INDEX customer_platform_currency_spent_idx;
DROP INDEX customer_platform_average_order_amount_idx;
DROP INDEX customer_platform_average_order_currency_idx;
DROP INDEX customer_platform_can_delete_idx;
DROP INDEX customer_platform_platform_created_at_idx;
DROP INDEX customer_platform_default_address_id_idx;
DROP INDEX customer_platform_display_name_idx;
DROP INDEX customer_platform_email_idx;
DROP INDEX customer_platform_first_name_idx;
DROP INDEX customer_platform_last_name_idx;
DROP INDEX customer_platform_last_order_id_idx;
DROP INDEX customer_platform_locale_idx;
DROP INDEX customer_platform_note_idx;
DROP INDEX customer_platform_number_of_orders_idx;
DROP INDEX customer_platform_phone_idx;
DROP INDEX customer_platform_state_idx;
DROP INDEX customer_platform_tags_idx;
DROP INDEX customer_platform_tax_exempt_idx;
DROP INDEX customer_platform_updated_at_idx;
DROP INDEX customer_platform_valid_email_address_idx;
DROP INDEX customer_platform_verified_email_idx;
DROP TABLE customer;
-- +goose StatementEnd
