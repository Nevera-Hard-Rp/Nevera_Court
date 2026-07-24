-- ============================================================
--  Install/sql/upgrade/esx_identifier_length.sql
--  Widen all player-id columns for ESX identifiers
--  (char1:… / license:… often 40–60+ chars; QB citizenid is ~8)
--
--  Run once on EXISTING databases created before VARCHAR(100).
--  Fresh installs already use VARCHAR(100) via 01_nevera_court.sql.
--  Do NOT run on a brand-new install after 01.
-- ============================================================

ALTER TABLE `doj_roles`
  MODIFY COLUMN `citizenid`   VARCHAR(100) NOT NULL,
  MODIFY COLUMN `assigned_by` VARCHAR(100) DEFAULT NULL;

ALTER TABLE `doj_cases`
  MODIFY COLUMN `plaintiff_citizenid`        VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `defendant_citizenid`        VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `prosecutor_citizenid`       VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `defense_attorney_citizenid` VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `judge_citizenid`            VARCHAR(100) DEFAULT NULL;

ALTER TABLE `doj_forms`
  MODIFY COLUMN `filed_by_citizenid` VARCHAR(100) NOT NULL;

ALTER TABLE `doj_warrants`
  MODIFY COLUMN `target_citizenid` VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `judge_citizenid`  VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `requested_by`     VARCHAR(100) NOT NULL;

ALTER TABLE `doj_bail`
  MODIFY COLUMN `defendant_citizenid`   VARCHAR(100) NOT NULL,
  MODIFY COLUMN `paid_by_citizenid`     VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `approved_by_citizenid` VARCHAR(100) DEFAULT NULL;

ALTER TABLE `doj_hearings`
  MODIFY COLUMN `judge_citizenid` VARCHAR(100) DEFAULT NULL,
  MODIFY COLUMN `created_by`      VARCHAR(100) NOT NULL;

ALTER TABLE `doj_jury`
  MODIFY COLUMN `citizenid` VARCHAR(100) NOT NULL;

ALTER TABLE `doj_pending_fines`
  MODIFY COLUMN `citizenid` VARCHAR(100) NOT NULL,
  MODIFY COLUMN `issued_by` VARCHAR(100) NOT NULL;

ALTER TABLE `doj_audit_log`
  MODIFY COLUMN `citizenid` VARCHAR(100) NOT NULL;

ALTER TABLE `doj_case_charges`
  MODIFY COLUMN `created_by` VARCHAR(100) DEFAULT NULL;

ALTER TABLE `doj_commitment_orders`
  MODIFY COLUMN `defendant_citizenid`   VARCHAR(100) NOT NULL,
  MODIFY COLUMN `issued_by_citizenid`   VARCHAR(100) NOT NULL,
  MODIFY COLUMN `executed_by_citizenid` VARCHAR(100) DEFAULT NULL;
