-- +goose Up
-- +goose StatementBegin
create table fulfillment (
    id  SERIAL PRIMARY KEY,
    fulfillment_order_id INTEGER NOT NULL,
    info JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    CONSTRAINT fk_fulfillment_order_id FOREIGN KEY (fulfillment_order_id) REFERENCES "fulfillment_order" (id)
)
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table fulfillment
-- +goose StatementEnd
