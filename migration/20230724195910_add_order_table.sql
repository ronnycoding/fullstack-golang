-- https://shopify.dev/docs/api/storefront/2023-07/objects/Order
-- +goose Up
-- +goose StatementBegin
CREATE TYPE order_cancel_reason_type AS ENUM ('CUSTOMER', 'DECLINED', 'FRAUD', 'INVENTORY', 'OTHER');
CREATE TYPE order_financial_status AS ENUM ('AUTHORIZED', 'PAID', 'PARTIALLY_PAID', 'PARTIALLY_REFUNDED', 'PENDING', 'REFUNDED', 'VOIDED');
CREATE TYPE order_fulfillment_status AS ENUM ('FULFILLED', 'IN_PROGRESS', 'ON_HOLD', 'OPEN', 'PARTIALLY_FULFILLED', 'PENDING_FULFILLMENT', 'RESTOCKED', 'SCHEDULED', 'UNFULFILLED');
CREATE TABLE "order" (
    id SERIAL PRIMARY KEY,
    platform_id INTEGER NOT NULL,
    billing_address_id INTEGER NOT NULL REFERENCES mailing_address(id),
    cancel_reason order_cancel_reason_type,
    cancelled_at TIMESTAMP,
    currency_code VARCHAR(3) NOT NULL,
    currency_subtotal_price INTEGER NOT NULL,
    currency_total_duties INTEGER,
    currency_total_price INTEGER NOT NULL,
    currency_total_tax INTEGER NOT NULL,
    customer_locale VARCHAR(255),
    customer_url VARCHAR(255),
    edited BOOLEAN NOT NULL DEFAULT FALSE,
    email VARCHAR(255),
    financial_status order_financial_status,
    fulfillment_status order_fulfillment_status NOT NULL,
    name VARCHAR(255) NOT NULL,
    order_number INTEGER NOT NULL,
    original_total_duties INTEGER,
    original_total_price INTEGER NOT NULL,
    phone VARCHAR(255),
    processed_at TIMESTAMP NOT NULL,
    shipping_address_id INTEGER NOT NULL REFERENCES mailing_address(id),
    discount_allocated_amount INTEGER,
    status_url VARCHAR(255),
    subtotal_price INTEGER NOT NULL,
    total_refunded INTEGER,
    total_shipping_price INTEGER NOT NULL,
    currency_total_shipping_price VARCHAR(3) NOT NULL,
    total_tax INTEGER NOT NULL,
);
-- add index for improve performance
CREATE INDEX order_platform_id_idx ON "order" (platform_id);
CREATE INDEX order_billing_address_id_idx ON "order" (billing_address_id);
CREATE INDEX order_shipping_address_id_idx ON "order" (shipping_address_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX order_platform_id_idx;
DROP INDEX order_billing_address_id_idx;
DROP INDEX order_shipping_address_id_idx;
DROP TABLE "order";
-- +goose StatementEnd
