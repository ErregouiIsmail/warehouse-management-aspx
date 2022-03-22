-- Connect to the 'WarehouseManagementSystem' database 
USE WarehouseManagementSystem
GO

-- Insert rows into table 'dbo.roles'
INSERT INTO dbo.roles
  ([codename])
VALUES
  ('Superuser'),
  ('Manager / Supervisor'),
  ('Sales Ops')
GO
