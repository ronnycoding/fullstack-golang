-- +goose Up
-- +goose StatementBegin
-- https://shopify.dev/docs/api/admin-graphql/2023-07/objects/Location
CREATE TABLE "location"
(
    id          SERIAL PRIMARY KEY ,
    store_id    INTEGER NOT NULL REFERENCES "store" (id),
    platform_id INTEGER NOT NULL,
    activatable BOOLEAN NOT NULL,
    address_verified  BOOLEAN NOT NULL,
    deactivatable BOOLEAN NOT NULL,
    deactivated_at TIMESTAMP,
    deletable BOOLEAN NOT NULL,
    fulfills_online_orders BOOLEAN NOT NULL,
    has_active_inventory BOOLEAN NOT NULL,
    has_unfulfilled_orders BOOLEAN NOT NULL,
    is_active BOOLEAN NOT NULL,
    metafields JSONB,
    ships_inventory BOOLEAN NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at  TIMESTAMP,
    deleted_at  TIMESTAMP
);
-- add index for improve performance
CREATE INDEX location_store_id_idx ON location (store_id);
CREATE INDEX location_address_verified_idx ON location (address_verified);
CREATE INDEX location_deactivatable_idx ON location (deactivatable);
CREATE INDEX location_deactivated_at_idx ON location (deactivated_at);
CREATE INDEX location_fulfills_online_orders_idx ON location (fulfills_online_orders);
CREATE INDEX location_has_active_inventory_idx ON location (has_active_inventory);
CREATE INDEX location_has_unfulfilled_orders_idx ON location (has_unfulfilled_orders);
CREATE INDEX location_is_active_idx ON location (is_active);
CREATE INDEX location_ships_inventory_idx ON location (ships_inventory);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX location_store_id_idx;
DROP INDEX location_address_verified_idx;
DROP INDEX location_deactivatable_idx;
DROP INDEX location_deactivated_at_idx;
DROP INDEX location_fulfills_online_orders_idx;
DROP INDEX location_has_active_inventory_idx;
DROP INDEX location_has_unfulfilled_orders_idx;
DROP INDEX location_is_active_idx;
DROP INDEX location_ships_inventory_idx;
DROP TABLE "location";
-- +goose StatementEnd
