-- ============================================================
--  Install/sql/upgrade/migrate_law_i18n.sql
--  Add title_hr / title_de / title_fr if missing
--  ONLY for older English installs that predate i18n columns.
--  Fresh 01_nevera_court.sql already has these columns — skip.
-- ============================================================
--  Add HR/DE/FR title + description columns to law tables.
--
--  Prerequisites:
--    - Tables doj_law_categories, doj_laws exist (nevera_court.sql)
--
--  Run once. Ignore errors if columns already exist.
-- ============================================================

SET NAMES utf8mb4;

-- Run once. Ignore errors if columns already exist.
ALTER TABLE `doj_law_categories`
  ADD COLUMN `title_hr` VARCHAR(100) NULL AFTER `title`,
  ADD COLUMN `title_de` VARCHAR(100) NULL AFTER `title_hr`,
  ADD COLUMN `title_fr` VARCHAR(100) NULL AFTER `title_de`,
  ADD COLUMN `description_hr` TEXT NULL AFTER `description`,
  ADD COLUMN `description_de` TEXT NULL AFTER `description_hr`,
  ADD COLUMN `description_fr` TEXT NULL AFTER `description_de`;

-- Run once. Ignore errors if columns already exist.
ALTER TABLE `doj_laws`
  ADD COLUMN `title_hr` VARCHAR(200) NULL AFTER `title`,
  ADD COLUMN `title_de` VARCHAR(200) NULL AFTER `title_hr`,
  ADD COLUMN `title_fr` VARCHAR(200) NULL AFTER `title_de`,
  ADD COLUMN `description_hr` TEXT NULL AFTER `description`,
  ADD COLUMN `description_de` TEXT NULL AFTER `description_hr`,
  ADD COLUMN `description_fr` TEXT NULL AFTER `description_de`;
