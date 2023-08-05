-- +goose Up
-- +goose StatementBegin
CREATE TABLE "location_address"
(
    id         SERIAL PRIMARY KEY ,
    location_id INTEGER NOT NULL REFERENCES "location" (id),
    platform_id INTEGER NOT NULL,
    address1   TEXT NOT NULL,
    address2   TEXT,
    city       TEXT NOT NULL,
    country    TEXT NOT NULL,
    country_code TEXT NOT NULL,
    country_name TEXT NOT NULL,
    location GEOGRAPHY(POINT, 4326) NOT NULL,
    phone TEXT,
    province TEXT,
    province_code TEXT,
    zip TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);
-- add index for improve performance
CREATE INDEX location_address_location_id_idx ON location_address (location_id);
CREATE INDEX location_address_country_idx ON location_address (country);
CREATE INDEX location_address_country_code_idx ON location_address (country_code);
CREATE INDEX location_address_location_idx ON location_address USING GIST (location);
CREATE INDEX location_address_province_idx ON location_address (province);
CREATE INDEX location_address_province_code_idx ON location_address (province_code);
CREATE INDEX location_address_zip_idx ON location_address (zip);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX location_address_location_id_idx;
DROP INDEX location_address_country_idx;
DROP INDEX location_address_country_code_idx;
DROP INDEX location_address_location_idx;
DROP INDEX location_address_province_idx;
DROP INDEX location_address_province_code_idx;
DROP INDEX location_address_zip_idx;
DROP TABLE "location_address";
-- +goose StatementEnd
