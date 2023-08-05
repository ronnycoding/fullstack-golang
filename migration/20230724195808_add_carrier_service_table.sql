-- +goose Up
-- +goose StatementBegin
-- https://shopify.dev/docs/api/admin-graphql/2023-07/objects/FulfillmentService
CREATE TABLE "carrier_service"
(
    id         SERIAL PRIMARY KEY ,
    store_id   INTEGER NOT NULL REFERENCES "store" (id),
    platform_id INTEGER NOT NULL,
    inventory_management BOOLEAN NOT NULL DEFAULT FALSE,
    location  INTEGER REFERENCES "location" (id),
    permits_sku_sharing BOOLEAN NOT NULL DEFAULT FALSE,
    product_based BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);
-- add index for improve performance
CREATE INDEX "carrier_service_store_id_idx" ON "carrier_service" (store_id);
CREATE INDEX "carrier_service_platform_id_idx" ON "carrier_service" (platform_id);
CREATE INDEX "carrier_service_location_idx" ON "carrier_service" (location);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX "carrier_service_store_id_idx";
DROP INDEX "carrier_service_platform_id_idx";
DROP INDEX "carrier_service_location_idx";
DROP TABLE "carrier_service";
-- +goose StatementEnd
