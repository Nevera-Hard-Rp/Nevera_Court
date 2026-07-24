-- ============================================================
--  Install/items/esx_document_a4.sql
--  ONLY for legacy ESX inventories that use the `items` SQL table.
--
--  If you use ESX + ox_inventory → use ox_inventory_document_a4.lua instead.
--  If you use ESX + qs-inventory → add item in qs-inventory shared items
--  (same name: document_a4) and copy the PNG.
--
--  Image: copy Install/items/document_a4.png into your inventory images folder.
-- ============================================================

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`)
VALUES
  ('document_a4', 'Court Document', 50, 0, 1)
ON DUPLICATE KEY UPDATE
  `label` = VALUES(`label`),
  `weight` = VALUES(`weight`);
