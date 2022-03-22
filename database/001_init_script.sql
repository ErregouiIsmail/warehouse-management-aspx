-- Create a new database called 'WarehouseManagementSystem'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
  SELECT name
FROM sys.databases
WHERE name = N'WarehouseManagementSystem'
)
CREATE DATABASE WarehouseManagementSystem
GO

-- Connect to the 'WarehouseManagementSystem' database 
USE WarehouseManagementSystem
GO

-- TABLES

-- Create a new table called 'countries' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.countries', 'U') IS NOT NULL
DROP TABLE dbo.countries
GO
-- Create the table in the specified schema
CREATE TABLE dbo.countries
(
  id INT IDENTITY PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  iso3 NCHAR(3) NOT NULL UNIQUE,
  flag NVARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'cities' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.cities', 'U') IS NOT NULL
DROP TABLE dbo.cities
GO
-- Create the table in the specified schema
CREATE TABLE dbo.cities
(
  id INT IDENTITY PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  country_id INT NOT NULL FOREIGN KEY REFERENCES dbo.countries(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'roles' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.roles', 'U') IS NOT NULL
DROP TABLE dbo.roles
GO
-- Create the table in the specified schema
CREATE TABLE dbo.roles
(
  id INT IDENTITY PRIMARY KEY,
  codename NVARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'addresses' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.addresses', 'U') IS NOT NULL
DROP TABLE dbo.addresses
GO
-- Create the table in the specified schema
CREATE TABLE dbo.addresses
(
  id INT IDENTITY PRIMARY KEY,
  [line] NVARCHAR(255) NOT NULL UNIQUE,
  city_id INT NOT NULL FOREIGN KEY REFERENCES dbo.cities(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'categories' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.categories', 'U') IS NOT NULL
DROP TABLE dbo.categories
GO
-- Create the table in the specified schema
CREATE TABLE dbo.categories
(
  id INT IDENTITY PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  slug NVARCHAR(255) NOT NULL UNIQUE,
  [description] NTEXT,
  parent_id INT FOREIGN KEY REFERENCES dbo.categories(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'users' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.users', 'U') IS NOT NULL
DROP TABLE dbo.users
GO
-- Create the table in the specified schema
CREATE TABLE dbo.users
(
  id INT IDENTITY PRIMARY KEY,
  username NVARCHAR(255) NOT NULL UNIQUE,
  [password] NVARCHAR(255) NOT NULL,
  full_name NVARCHAR(255) NOT NULL,
  is_active BIT DEFAULT 0,
  role_id INT NOT NULL FOREIGN KEY REFERENCES dbo.roles(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'brands' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.brands', 'U') IS NOT NULL
DROP TABLE dbo.brands
GO
-- Create the table in the specified schema
CREATE TABLE dbo.brands
(
  id INT IDENTITY PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL UNIQUE,
  [description] NTEXT,
  address_id INT NOT NULL FOREIGN KEY REFERENCES dbo.addresses(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'products' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.products', 'U') IS NOT NULL
DROP TABLE dbo.products
GO
-- Create the table in the specified schema
CREATE TABLE dbo.products
(
  id INT IDENTITY PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  slug NVARCHAR(255) NOT NULL UNIQUE,
  [description] NTEXT,
  qty INT NOT NULL,
  price FLOAT NOT NULL,
  category_id INT NOT NULL FOREIGN KEY REFERENCES dbo.categories(id),
  brand_id INT NOT NULL FOREIGN KEY REFERENCES dbo.brands(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'medias' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.medias', 'U') IS NOT NULL
DROP TABLE dbo.medias
GO
-- Create the table in the specified schema
CREATE TABLE dbo.medias
(
  id INT IDENTITY PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  [type] NVARCHAR(255) NOT NULL,
  source NVARCHAR(255) NOT NULL,
  [description] NTEXT NOT NULL,
  product_id INT NOT NULL FOREIGN KEY REFERENCES dbo.products(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'suppliers' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.suppliers', 'U') IS NOT NULL
DROP TABLE dbo.suppliers
GO
-- Create the table in the specified schema
CREATE TABLE dbo.suppliers
(
  id INT IDENTITY PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  [description] NTEXT NOT NULL,
  address_id INT NOT NULL FOREIGN KEY REFERENCES dbo.addresses(id),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'invoices' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.invoices', 'U') IS NOT NULL
DROP TABLE dbo.invoices
GO
-- Create the table in the specified schema
CREATE TABLE dbo.invoices
(
  id INT IDENTITY PRIMARY KEY,
  [state] NVARCHAR(255) NOT NULL,
  [type] NVARCHAR(255) NOT NULL,
  [description] NTEXT NOT NULL,
  supplier_id INT NOT NULL FOREIGN KEY REFERENCES dbo.suppliers(id),
  issued_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME,
);
GO

-- Create a new table called 'invoices_items' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.invoices_items', 'U') IS NOT NULL
DROP TABLE dbo.invoices_items
GO
-- Create the table in the specified schema
CREATE TABLE dbo.invoices_items
(
  id INT IDENTITY PRIMARY KEY,
  qty INT NOT NULL,
  price FLOAT NOT NULL,
  invoice_id INT NOT NULL FOREIGN KEY REFERENCES dbo.invoices(id),
  product_id INT NOT NULL FOREIGN KEY REFERENCES dbo.products(id),
  updated_at DATETIME,
);
GO

-- TRIGGERS

-- Create a new trigger called 'tg_update_at_countries' on table 'dbo.countries'
CREATE TRIGGER tg_update_at_countries ON dbo.countries
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.countries'
  UPDATE dbo.countries
  SET
    [updated_at] = GETDATE()
  FROM dbo.countries cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_cities' on table 'dbo.cities'
CREATE TRIGGER tg_update_at_cities ON dbo.cities
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.cities'
  UPDATE dbo.cities
  SET
    [updated_at] = GETDATE()
  FROM dbo.cities cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_roles' on table 'dbo.roles'
CREATE TRIGGER tg_update_at_roles ON dbo.roles
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.roles'
  UPDATE dbo.roles
  SET
    [updated_at] = GETDATE()
  FROM dbo.roles cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_addresses' on table 'dbo.addresses'
CREATE TRIGGER tg_update_at_addresses ON dbo.addresses
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.addresses'
  UPDATE dbo.addresses
  SET
    [updated_at] = GETDATE()
  FROM dbo.addresses cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_categories' on table 'dbo.categories'
CREATE TRIGGER tg_update_at_categories ON dbo.categories
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.categories'
  UPDATE dbo.categories
  SET
    [updated_at] = GETDATE()
  FROM dbo.categories cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_users' on table 'dbo.users'
CREATE TRIGGER tg_update_at_users ON dbo.users
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.users'
  UPDATE dbo.users
  SET
    [updated_at] = GETDATE()
  FROM dbo.users cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_brands' on table 'dbo.brands'
CREATE TRIGGER tg_update_at_brands ON dbo.brands
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.brands'
  UPDATE dbo.brands
  SET
    [updated_at] = GETDATE()
  FROM dbo.brands cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_products' on table 'dbo.products'
CREATE TRIGGER tg_update_at_products ON dbo.products
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.products'
  UPDATE dbo.products
  SET
    [updated_at] = GETDATE()
  FROM dbo.products cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_medias' on table 'dbo.medias'
CREATE TRIGGER tg_update_at_medias ON dbo.medias
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.medias'
  UPDATE dbo.medias
  SET
    [updated_at] = GETDATE()
  FROM dbo.medias cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_suppliers' on table 'dbo.suppliers'
CREATE TRIGGER tg_update_at_suppliers ON dbo.suppliers
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.suppliers'
  UPDATE dbo.suppliers
  SET
    [updated_at] = GETDATE()
  FROM dbo.suppliers cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_invoices' on table 'dbo.invoices'
CREATE TRIGGER tg_update_at_invoices ON dbo.invoices
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.invoices'
  UPDATE dbo.invoices
  SET
    [updated_at] = GETDATE()
  FROM dbo.invoices cs INNER JOIN inserted i ON cs.id = i.id
END
GO

-- Create a new trigger called 'tg_update_at_invoices_items' on table 'dbo.invoices_items'
CREATE TRIGGER tg_update_at_invoices_items ON dbo.invoices_items
AFTER UPDATE
AS
BEGIN
  -- Update rows in table 'dbo.invoices_items'
  UPDATE dbo.invoices_items
  SET
    [updated_at] = GETDATE()
  FROM dbo.invoices_items cs INNER JOIN inserted i ON cs.id = i.id
END
GO
