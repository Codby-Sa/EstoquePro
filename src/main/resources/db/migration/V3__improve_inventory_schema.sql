ALTER TABLE stores
ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT TRUE;

ALTER TABLE products
ADD COLUMN cost_price NUMERIC(10, 2) NOT NULL DEFAULT 0;

ALTER TABLE products
ADD COLUMN unit_type VARCHAR(20) NOT NULL DEFAULT 'UN';

ALTER TABLE products
ADD CONSTRAINT chk_products_cost_price_non_negative
CHECK (cost_price >= 0);

ALTER TABLE products
ADD CONSTRAINT chk_products_unit_type
CHECK (unit_type IN ('UN', 'KG', 'G', 'L', 'ML', 'PACOTE', 'CAIXA'));

CREATE UNIQUE INDEX idx_products_store_barcode_unique
ON products(store_id, barcode)
WHERE barcode IS NOT NULL AND deleted_at IS NULL;

ALTER TABLE stock_movements
ADD COLUMN quantity_before INTEGER NOT NULL DEFAULT 0;

ALTER TABLE stock_movements
ADD COLUMN quantity_after INTEGER NOT NULL DEFAULT 0;

ALTER TABLE stock_movements
ADD COLUMN price_sold NUMERIC(10, 2);

ALTER TABLE stock_movements
ADD CONSTRAINT chk_stock_movements_quantity_before_non_negative
CHECK (quantity_before >= 0);

ALTER TABLE stock_movements
ADD CONSTRAINT chk_stock_movements_quantity_after_non_negative
CHECK (quantity_after >= 0);

ALTER TABLE stock_movements
ADD CONSTRAINT chk_stock_movements_price_sold_non_negative
CHECK (price_sold IS NULL OR price_sold >= 0);

ALTER TABLE stock_movements
DROP CONSTRAINT chk_stock_movements_type;

ALTER TABLE stock_movements
ADD CONSTRAINT chk_stock_movements_type
CHECK (type IN ('IN', 'SALE', 'LOSS', 'INTERNAL_CONSUMPTION'));