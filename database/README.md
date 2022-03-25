## Database

using [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) as a database system from microsoft

- ER Diagram

```txt
countries (id, name, iso3, flag, created_at, updated_at)
cities (id, name, country_id, created_at, updated_at)

roles (id, codename, created_at, updated_at)
addresses (id, line, city_id, created_at, updated_at)

categories (id, name, slug, description, parent_id, created_at, updated_at)

users (id, username, password, full_name, is_active, role_id, created_at, updated_at)

brands (id, name, description, address_id, created_at, updated_at)

products (id, name, slug, qty, price, category_id, brand_id, created_at, updated_at)
medias (id, type, name, source, description, product_id, created_at, updated_at)

suppliers (id, name, description, address_id, created_at, updated_at)

invoices (id, state, description, supplier_id, issued_at, updated_at)
invoices_items (id, invoice_id, product_id, qty, price)
```

- Roles

predefined in 3 roles that the superuser can add more accordingly

- Permissions

  the following are the permissions that the app supports

  - Superuser
    - counties: Full Access
    - cities: Full Access
    - roles: Full Access
    - addresses: Full Access
    - categories: Full Access
    - users: Full Access
    - brands: Full Access
    - products & medias: Full Access
    - suppliers: Full Access
    - invoices & invoices_items: Read Only
  - Manager / Supervisor
    - counties: Read Only
    - cities: Read Only
    - roles: Read Only
    - addresses: Read Only
    - categories: Read Only
    - users: Read Only for non Superusers
    - brands: Full Access
    - products & medias: Full Access
    - suppliers: Full Access
    - invoices & invoices_items: Read Only
  - Sales Ops
    - counties: Read Only
    - cities: Read Only
    - roles: Read Only
    - addresses: Read Only
    - categories: Read Only
    - users: Read Only for himself and Sales Ops
    - brands: Read Only
    - products & medias: Read Only
    - suppliers: Read Only
    - invoices & invoices_items: Full Access
