-- +goose Up
-- +goose StatementBegin
CREATE TABLE fulfillment_order (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    info JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES "order" (id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE fulfillment_order;
-- +goose StatementEnd
