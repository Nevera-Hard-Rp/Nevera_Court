-- ============================================================
--  Install/sql/04_first_supreme_court.sql
--  Give yourself Supreme Court (chief judge) — run ONCE
--  Replace CITIZENID and NAME with your character values.
-- ============================================================

INSERT INTO `doj_roles`
  (`citizenid`, `player_name`, `role`, `bar_number`, `office`, `discord`, `active`, `assigned_by`)
VALUES
  ('CITIZENID', 'Your Name', 'supreme_court', NULL, NULL, NULL, 1, 'OWNER')
ON DUPLICATE KEY UPDATE
  `role` = 'supreme_court',
  `active` = 1,
  `player_name` = VALUES(`player_name`);

-- Verify:
-- SELECT * FROM doj_roles WHERE role = 'supreme_court';
