-- https://shopify.dev/docs/api/admin-graphql/2023-07/objects/MailingAddress
-- +goose Up
-- +goose StatementBegin
CREATE TABLE "mailing_address"
(
    id          SERIAL PRIMARY KEY ,
    platform_id INTEGER NOT NULL,
    address1    VARCHAR(255),
    address2    VARCHAR(255),
    city        VARCHAR(255),
    company     VARCHAR(255),
    country     VARCHAR(255),
    country_code VARCHAR(2),
    first_name  VARCHAR(255),
    formatted_area VARCHAR(255),
    last_name   VARCHAR(255),
    location GEOGRAPHY(POINT, 4326) NOT NULL,
    name       VARCHAR(255),
    phone      VARCHAR(255),
    province   VARCHAR(255),
    province_code VARCHAR(2),
    time_zone  VARCHAR(255),
    zip        VARCHAR(255),
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at  TIMESTAMP,
    deleted_at  TIMESTAMP
);
-- add index for improve performance
CREATE INDEX "mailing_address_platform_id_idx" ON "mailing_address" (platform_id);
CREATE INDEX "mailing_address_location_idx" ON "mailing_address" USING GIST (location);
CREATE INDEX "mailing_address_country_idx" ON "mailing_address" (country);
CREATE INDEX "mailing_address_country_code_idx" ON "mailing_address" (country_code);
CREATE INDEX "mailing_address_province_idx" ON "mailing_address" (province);
CREATE INDEX "mailing_address_province_code_idx" ON "mailing_address" (province_code);
CREATE INDEX "mailing_address_zip_idx" ON "mailing_address" (zip);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- drop index
DROP INDEX "mailing_address_platform_id_idx";
DROP INDEX "mailing_address_location_idx";
DROP INDEX "mailing_address_country_idx";
DROP INDEX "mailing_address_country_code_idx";
DROP INDEX "mailing_address_province_idx";
DROP INDEX "mailing_address_province_code_idx";
DROP INDEX "mailing_address_zip_idx";
DROP TABLE "mailing_address";
-- +goose StatementEnd
