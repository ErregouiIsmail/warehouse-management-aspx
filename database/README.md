## Database

using [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) as a database system from microsoft

- ER Diagram

```txt
roles (id, codename, created_at, updated_at)
addresses (id, line, city, country, created_at, updated_at)

categories (id, name, slug, parent_id, created_at, updated_at)

users (id, username, password, full_name, is_active, role_id, created_at, updated_at)

brands (id, name, description, address_id, created_at, updated_at)

products (id, name, slug, qtyStock, price, category_id, brand_id, created_at, updated_at)
medias (id, type, name, source, description, created_at, updated_at)

product_medias (id, product_id, media_id, created_at, updated_at)

suppliers (id, name, description, address_id, created_at, updated_at)

invoices (id, state, supplier_id, issued_at, updated_at)
invoices_items (id, invoice_id, product_id, qty, price)
```
