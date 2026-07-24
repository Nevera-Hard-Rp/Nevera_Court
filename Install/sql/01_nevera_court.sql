-- ============================================================
--  nevera_court / sql / nevera_court.sql
--  Run ONCE on installation
--  v3 — full English schema (tables + columns renamed from Croatian)
-- ============================================================

-- ============================================================
--  1. ROLES (doj_roles)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_roles` (
  `id`              INT AUTO_INCREMENT PRIMARY KEY,
  `citizenid`       VARCHAR(100)  NOT NULL,
  `player_name`     VARCHAR(100) NOT NULL,
  `role`            ENUM(
                      'supreme_court',
                      'judge',
                      'prosecutor',
                      'defense_attorney',
                      'public_defender',
                      'police'
                    ) NOT NULL,
  `bar_number`      VARCHAR(20)  DEFAULT NULL,
  `office`          VARCHAR(100) DEFAULT NULL,
  `discord`         VARCHAR(100) DEFAULT NULL,
  `active`          TINYINT(1)   DEFAULT 1,
  `assigned_by`     VARCHAR(100)  DEFAULT NULL,
  `assigned_at`     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_citizen_role` (`citizenid`, `role`),
  -- Fast lookup: all active roles for citizenid
  INDEX `idx_citizen_active` (`citizenid`, `active`),
  INDEX `idx_role_active`    (`role`, `active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  2. CASES (doj_cases)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_cases` (
  `id`                        INT AUTO_INCREMENT PRIMARY KEY,
  `case_number`               VARCHAR(30)  UNIQUE NOT NULL,
  `vrsta`                     ENUM('criminal','civil') NOT NULL,
  `status`                    ENUM(
                                'open',
                                'investigation',
                                'pending_indictment',
                                'probable_cause',
                                'pre_hearing',
                                'pre_trial',
                                'trial',
                                'awaiting_verdict',
                                'dismissed',
                                'closed',
                                'pending'
                              ) DEFAULT 'open',
  -- Parties
  `plaintiff_citizenid`       VARCHAR(100)  DEFAULT NULL,
  `plaintiff_name`            VARCHAR(100) DEFAULT NULL,
  `defendant_citizenid`       VARCHAR(100)  DEFAULT NULL,
  `defendant_name`            VARCHAR(100) DEFAULT NULL,
  -- Legal representatives
  `prosecutor_citizenid`      VARCHAR(100)  DEFAULT NULL,
  `defense_attorney_citizenid` VARCHAR(100) DEFAULT NULL,
  `judge_citizenid`           VARCHAR(100)  DEFAULT NULL,
  -- Details
  `mdt_incident_id`           VARCHAR(50)  DEFAULT NULL,
  `charges`                   JSON         DEFAULT NULL,
  `facts`                     TEXT         DEFAULT NULL,
  `porota`                    TINYINT(1)   DEFAULT 0,
  `verdict`                   ENUM('guilty','not_guilty','mistrial') DEFAULT NULL,
  `kazna`                     TEXT         DEFAULT NULL,
  `fine_amount`               INT          DEFAULT 0,
  `fine_paid`                 TINYINT(1)   DEFAULT 0,
  -- Dates
  `incident_date`             DATE         DEFAULT NULL,
  `filed_at`                  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `indictment_deadline`       TIMESTAMP    DEFAULT NULL,
  `updated_at`                TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `closed_at`                 TIMESTAMP    DEFAULT NULL,

  -- ── Single-column (fast lookup on one field) ──────────
  INDEX `idx_status`      (`status`),
  INDEX `idx_vrsta`       (`vrsta`),
  INDEX `idx_deadline`    (`indictment_deadline`),

  -- ── Composite (most common queries in code) ────────────────────
  -- "Get all open cases, sorted by date"
  INDEX `idx_status_date` (`status`, `filed_at`),

  -- "Get all cases for defendant where status is not closed"
  INDEX `idx_defendant_status` (`defendant_citizenid`, `status`),

  -- "Get all cases for prosecutor/attorney"
  INDEX `idx_prosecutor`  (`prosecutor_citizenid`, `status`),
  INDEX `idx_defense`     (`defense_attorney_citizenid`, `status`),

  -- "Get all cases for judge"
  INDEX `idx_judge`       (`judge_citizenid`, `status`),

  -- "Criminal vs civil — active"
  INDEX `idx_vrsta_status` (`vrsta`, `status`),

  -- Archive job: closed + older than 30 days
  INDEX `idx_closed_at` (`closed_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  3. FORMS (doj_forms)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_forms` (
  `id`                INT AUTO_INCREMENT PRIMARY KEY,
  `case_number`       VARCHAR(30)  DEFAULT NULL,
  `form_type`         VARCHAR(60)  NOT NULL,  -- English key: criminal_complaint, civil_complaint, etc.
  `status`            ENUM('draft','filed','approved','denied','signed') DEFAULT 'draft',
  `filed_by_citizenid` VARCHAR(100) NOT NULL,
  `filed_by_name`     VARCHAR(100) NOT NULL,
  `filed_by_role`     VARCHAR(50)  NOT NULL,
  `form_data`         JSON         NOT NULL,
  `signatories`       JSON         DEFAULT NULL,
  `filed_at`          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `updated_at`        TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Single
  INDEX `idx_form_type` (`form_type`),
  INDEX `idx_status`    (`status`),

  -- Composite
  -- "Get all forms for case X with given status"
  INDEX `idx_case_status`   (`case_number`, `status`),
  -- "Get all forms submitted by that citizen"
  INDEX `idx_filed_by_status` (`filed_by_citizenid`, `status`),
  -- Form queue: pending by date
  INDEX `idx_type_date`     (`form_type`, `filed_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  4. WARRANTS (doj_warrants)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_warrants` (
  `id`                    INT AUTO_INCREMENT PRIMARY KEY,
  `warrant_number`        VARCHAR(30)  UNIQUE NOT NULL,
  `warrant_type`          ENUM('arrest','search') NOT NULL,
  `case_number`           VARCHAR(30)  DEFAULT NULL,
  `status`                ENUM('pending','active','executed','denied','expired','revoked') DEFAULT 'pending',
  `target_citizenid`      VARCHAR(100)  DEFAULT NULL,
  `target_name`           VARCHAR(100) DEFAULT NULL,
  `target_description`    TEXT         DEFAULT NULL,
  `offense_description`   TEXT         DEFAULT NULL,
  `charges`               JSON         DEFAULT NULL,
  `search_location`       TEXT         DEFAULT NULL,
  `items_to_seize`        TEXT         DEFAULT NULL,
  `legal_basis`           TEXT         DEFAULT NULL,
  `judge_citizenid`       VARCHAR(100)  DEFAULT NULL,
  `judge_name`            VARCHAR(100) DEFAULT NULL,
  `denial_reason`         TEXT         DEFAULT NULL,
  `issued_at`             TIMESTAMP    DEFAULT NULL,
  `expires_at`            TIMESTAMP    DEFAULT NULL,
  `executed_at`           TIMESTAMP    DEFAULT NULL,
  `requested_at`          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `requested_by`          VARCHAR(100)  NOT NULL,

  -- Single
  INDEX `idx_status`    (`status`),

  -- Composite
  -- "All active arrest warrants for citizenid"
  INDEX `idx_target_status`  (`target_citizenid`, `status`),
  -- "Cron job: active + expired"
  INDEX `idx_status_expires` (`status`, `expires_at`),
  -- "All warrants for case"
  INDEX `idx_case`           (`case_number`),
  -- "All warrants requested by judge"
  INDEX `idx_judge_status`   (`judge_citizenid`, `status`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  5. BAIL (doj_bail)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_bail` (
  `id`                    INT AUTO_INCREMENT PRIMARY KEY,
  `case_number`           VARCHAR(30)  NOT NULL,
  `defendant_citizenid`   VARCHAR(100)  NOT NULL,
  `defendant_name`        VARCHAR(100) NOT NULL,
  `status`                ENUM(
                            'pending',
                            'set',
                            'paid',
                            'forfeited',
                            'denied',
                            'revoked',
                            'returned'
                          ) DEFAULT 'pending',
  `bail_type`             ENUM('cash','personal_surety','property') DEFAULT 'cash',
  `amount`                INT          DEFAULT 0,
  `fine_amount`           INT          DEFAULT 0,
  `paid_by_citizenid`     VARCHAR(100)  DEFAULT NULL,
  `approved_by_citizenid` VARCHAR(100)  DEFAULT NULL,
  `approved_by_role`      VARCHAR(50)  DEFAULT NULL,
  `billing_id`            VARCHAR(50)  DEFAULT NULL,
  `agreement_signed`      TINYINT(1)   DEFAULT 0,
  `forfeiture_reason`     TEXT         DEFAULT NULL,
  `strike_count`          TINYINT      DEFAULT 0,
  `missed_hearing`        TINYINT(1)   DEFAULT 0,
  `bail_ban_until`        TIMESTAMP    DEFAULT NULL,
  `set_at`                TIMESTAMP    DEFAULT NULL,
  `paid_at`               TIMESTAMP    DEFAULT NULL,
  `created_at`            TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,

  -- Composite
  INDEX `idx_defendant_status` (`defendant_citizenid`, `status`),
  INDEX `idx_case_status`      (`case_number`, `status`),
  -- 3-Strike cron: citizen + strike_count
  INDEX `idx_citizen_strikes`  (`defendant_citizenid`, `strike_count`),
  -- Ban check: citizen + date
  INDEX `idx_ban`              (`defendant_citizenid`, `bail_ban_until`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  6. HEARINGS (doj_hearings)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_hearings` (
  `id`                INT AUTO_INCREMENT PRIMARY KEY,
  `case_number`       VARCHAR(30)  NOT NULL,
  `hearing_type`      ENUM(
                        'bail_hearing',
                        'probable_cause',
                        'motion_hearing',
                        'pre_trial',
                        'trial_jury',
                        'trial_bench',
                        'sentencing',
                        'civil_pre_trial',
                        'civil_trial'
                      ) NOT NULL,
  `status`            ENUM('scheduled','in_progress','completed','cancelled','postponed') DEFAULT 'scheduled',
  `judge_citizenid`   VARCHAR(100)  DEFAULT NULL,
  `hearing_date`      DATETIME     NOT NULL,
  `location`          VARCHAR(100) DEFAULT 'Courtroom 1',
  `discord_link`      VARCHAR(200) DEFAULT NULL,
  `notes`             TEXT         DEFAULT NULL,
  `notification_sent` TINYINT(1)   DEFAULT 0,
  `created_by`        VARCHAR(100)  NOT NULL,
  `created_at`        TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,

  -- Composite
  -- "Judge schedule: all scheduled hearings from today"
  INDEX `idx_judge_date`   (`judge_citizenid`, `hearing_date`, `status`),
  -- "Hearings for case — chronological"
  INDEX `idx_case_date`    (`case_number`, `hearing_date`),
  -- "Upcoming hearings (dashboard)"
  INDEX `idx_status_date`  (`status`, `hearing_date`),
  -- Notification cron: notification_sent = 0
  INDEX `idx_notification` (`notification_sent`, `hearing_date`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  7. JURY POOL (doj_jury)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_jury` (
  `id`            INT AUTO_INCREMENT PRIMARY KEY,
  `citizenid`     VARCHAR(100)  NOT NULL,
  `player_name`   VARCHAR(100) NOT NULL,
  `discord`       VARCHAR(100) DEFAULT NULL,
  `status`        ENUM('available','selected','dismissed','excused') DEFAULT 'available',
  `case_number`   VARCHAR(30)  DEFAULT NULL,
  `registered_at` TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_citizen` (`citizenid`),
  -- "Available jurors for selection"
  INDEX `idx_status_date`  (`status`, `registered_at`),
  INDEX `idx_case_status`  (`case_number`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  8. PENDING FINES (doj_pending_fines)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_pending_fines` (
  `id`           INT AUTO_INCREMENT PRIMARY KEY,
  `citizenid`    VARCHAR(100)  NOT NULL,
  `amount`       INT          NOT NULL,
  `reason`       TEXT         NOT NULL,
  `case_number`  VARCHAR(30)  DEFAULT NULL,
  `issued_by`    VARCHAR(100)  NOT NULL,
  `issued_at`    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `paid`         TINYINT(1)   DEFAULT 0,

  -- "Unpaid fines for citizenid (login check)"
  INDEX `idx_citizen_paid` (`citizenid`, `paid`),
  INDEX `idx_paid_date`    (`paid`, `issued_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  9. AUDIT LOG (doj_audit_log)
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_audit_log` (
  `id`           INT AUTO_INCREMENT PRIMARY KEY,
  `citizenid`    VARCHAR(100)  NOT NULL,
  `player_name`  VARCHAR(100) DEFAULT NULL,
  `action`       VARCHAR(100) NOT NULL,
  `details`      TEXT         DEFAULT NULL,
  `case_number`  VARCHAR(30)  DEFAULT NULL,
  `created_at`   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,

  -- "Audit for case — chronological (most common query)"
  INDEX `idx_case_date`     (`case_number`, `created_at`),
  -- "All actions by citizen"
  INDEX `idx_citizen_date`  (`citizenid`, `created_at`),
  -- "Filter by action (admin view)"
  INDEX `idx_action_date`   (`action`, `created_at`),
  -- Old audit log cleanup (cron)
  INDEX `idx_date`          (`created_at`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  10. ARCHIVE (doj_archive)
--  Same structure + indexes as doj_cases (copied via LIKE).
--  Do NOT re-ADD indexes here — LIKE already includes them
--  (would cause #1061 Duplicate key name).
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_archive`
  LIKE `doj_cases`;

-- ============================================================
--  AUTO-ARCHIVING — MySQL Event
--  NOTE: event_scheduler must be enabled on the server:
--    SET GLOBAL event_scheduler = ON;
-- ============================================================

DELIMITER $$

DROP EVENT IF EXISTS `nevera_doj_archiving`$$

CREATE EVENT `nevera_doj_archiving`
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
DO
BEGIN
  -- Move closed cases older than 30 days to the archive
  INSERT IGNORE INTO `doj_archive`
    SELECT * FROM `doj_cases`
    WHERE `status` IN ('closed','dismissed')
    AND `closed_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);

  -- Optional: delete archived rows from the main table
  -- DELETE FROM `doj_cases`
  -- WHERE `status` IN ('closed','dismissed')
  -- AND `closed_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);
END$$

DELIMITER ;

-- ============================================================
--  AUDIT LOG CLEANUP EVENT (optional)
--  Deletes audit log entries older than 90 days — saves space
-- ============================================================

DELIMITER $$

DROP EVENT IF EXISTS `nevera_doj_audit_cleanup`$$

CREATE EVENT `nevera_doj_audit_cleanup`
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
DO
BEGIN
  DELETE FROM `doj_audit_log`
  WHERE `created_at` < DATE_SUB(NOW(), INTERVAL 90 DAY);
END$$

DELIMITER ;

-- ============================================================
--  11. FORM COUNTERS (doj_counters) — English form_type keys
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_counters` (
  `id`           INT AUTO_INCREMENT PRIMARY KEY,
  `form_type`    VARCHAR(60) NOT NULL UNIQUE,
  `prefix`       VARCHAR(10) NOT NULL,
  `year`         INT         NOT NULL DEFAULT 2026,
  `last_number`  INT         NOT NULL DEFAULT 0,
  INDEX `idx_form_type` (`form_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `doj_counters` (`form_type`, `prefix`, `year`, `last_number`) VALUES
  ('affidavit', 'AFF', YEAR(CURDATE()), 0),
  ('answer_to_complaint', 'ATC', YEAR(CURDATE()), 0),
  ('appearance_of_counsel', 'AOC', YEAR(CURDATE()), 0),
  ('appointment_of_counsel', 'APC', YEAR(CURDATE()), 0),
  ('arrest_warrant', 'AW', YEAR(CURDATE()), 0),
  ('arrest_warrant_denied', 'AWD', YEAR(CURDATE()), 0),
  ('bail_agreement', 'BA', YEAR(CURDATE()), 0),
  ('bond_order', 'BO', YEAR(CURDATE()), 0),
  ('civil_complaint', 'CV', YEAR(CURDATE()), 0),
  ('criminal_complaint', 'CC', YEAR(CURDATE()), 0),
  ('criminal_pre_filing', 'CPF', YEAR(CURDATE()), 0),
  ('judgment_civil', 'JC', YEAR(CURDATE()), 0),
  ('motion_contempt', 'MC', YEAR(CURDATE()), 0),
  ('motion_default_judgment', 'MDJ', YEAR(CURDATE()), 0),
  ('motion_enlargement_time', 'MET', YEAR(CURDATE()), 0),
  ('motion_pre_trial_conference', 'MPT', YEAR(CURDATE()), 0),
  ('motion_stipulated_dismissal', 'MSD', YEAR(CURDATE()), 0),
  ('motion_to_dismiss', 'MTD', YEAR(CURDATE()), 0),
  ('motion_to_reconsider', 'MTR', YEAR(CURDATE()), 0),
  ('name_change_request', 'NCR', YEAR(CURDATE()), 0),
  ('notice_of_hearing', 'NOH', YEAR(CURDATE()), 0),
  ('notice_of_suit', 'NOS', YEAR(CURDATE()), 0),
  ('order_denying_motion', 'ODM', YEAR(CURDATE()), 0),
  ('order_granting_motion', 'OGM', YEAR(CURDATE()), 0),
  ('order_of_dismissal', 'OOD', YEAR(CURDATE()), 0),
  ('proof_of_service', 'POS', YEAR(CURDATE()), 0),
  ('request_arrest_warrant', 'RAW', YEAR(CURDATE()), 0),
  ('request_search_seizure', 'RSS', YEAR(CURDATE()), 0),
  ('response_to_motion', 'RTM', YEAR(CURDATE()), 0),
  ('search_warrant', 'SW', YEAR(CURDATE()), 0),
  ('subpoena_duces_tecum', 'SDT', YEAR(CURDATE()), 0),
  ('subpoena_testify_civil', 'STC', YEAR(CURDATE()), 0),
  ('subpoena_testify_criminal', 'STK', YEAR(CURDATE()), 0),
  ('substitution_of_attorney', 'SOA', YEAR(CURDATE()), 0),
  ('supreme_court_order', 'SCO', YEAR(CURDATE()), 0)
ON DUPLICATE KEY UPDATE `prefix` = VALUES(`prefix`);

-- ============================================================
--  12. PENAL CODE — CATEGORIES (doj_law_categories)
--  Lookup table for NKZ penal code categories (1xx-9xx).
--  Used by server/sv_laws.lua.
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_law_categories` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `title`       VARCHAR(100) NOT NULL,
  `title_hr`    VARCHAR(100) DEFAULT NULL,
  `title_de`    VARCHAR(100) DEFAULT NULL,
  `title_fr`    VARCHAR(100) DEFAULT NULL,
  `description` TEXT         DEFAULT NULL,
  `description_hr` TEXT      DEFAULT NULL,
  `description_de` TEXT      DEFAULT NULL,
  `description_fr` TEXT      DEFAULT NULL,
  `color`       VARCHAR(20)  DEFAULT NULL,
  `icon`        VARCHAR(50)  DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  13. PENAL CODE — LAWS (doj_laws)
--  NKZ penal code articles. Used by server/sv_laws.lua.
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_laws` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `code`        VARCHAR(20)  NOT NULL,
  `title`       VARCHAR(200) NOT NULL,
  `title_hr`    VARCHAR(200) DEFAULT NULL,
  `title_de`    VARCHAR(200) DEFAULT NULL,
  `title_fr`    VARCHAR(200) DEFAULT NULL,
  `description` TEXT         DEFAULT NULL,
  `description_hr` TEXT      DEFAULT NULL,
  `description_de` TEXT      DEFAULT NULL,
  `description_fr` TEXT      DEFAULT NULL,
  `category_id` INT          DEFAULT NULL,
  `severity`    VARCHAR(30)  DEFAULT NULL,
  `min_fine`    INT          DEFAULT 0,
  `max_fine`    INT          DEFAULT 0,
  `min_jail`    INT          DEFAULT 0,
  `max_jail`    INT          DEFAULT 0,
  `points`      INT          DEFAULT 0,
  `active`      TINYINT(1)   DEFAULT 1,
  INDEX `idx_code`     (`code`),
  INDEX `idx_category` (`category_id`),
  CONSTRAINT `fk_laws_category` FOREIGN KEY (`category_id`)
    REFERENCES `doj_law_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  14. CHARGES / PENAL CODE LINK (doj_charges)
--  Links charges on a case to a penal code article (doj_laws).
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_charges` (
  `id`              INT AUTO_INCREMENT PRIMARY KEY,
  `case_id`         INT NOT NULL,
  `law_id`          INT NOT NULL,
  `fine_imposed`    INT DEFAULT 0,
  `jail_imposed`    INT DEFAULT 0,
  `status`          VARCHAR(30) DEFAULT 'charge',
  `note`            TEXT DEFAULT NULL,
  `created_by`      VARCHAR(100) DEFAULT NULL,
  `created_at`      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_case` (`case_id`),
  INDEX `idx_law`  (`law_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
--  15. COMMITMENT ORDERS (doj_commitment_orders)
--  Hard-RP: judge issues order on Guilty; custody executes → prison
-- ============================================================

CREATE TABLE IF NOT EXISTS `doj_commitment_orders` (
  `id`                    INT AUTO_INCREMENT PRIMARY KEY,
  `order_number`          VARCHAR(30)  UNIQUE NOT NULL,
  `case_number`           VARCHAR(30)  NOT NULL,
  `defendant_citizenid`   VARCHAR(100)  NOT NULL,
  `defendant_name`        VARCHAR(100) DEFAULT NULL,
  `minutes`               INT          NOT NULL DEFAULT 0,
  `status`                ENUM('pending','executed','cancelled') DEFAULT 'pending',
  `issued_by_citizenid`   VARCHAR(100)  NOT NULL,
  `issued_by_name`        VARCHAR(100) DEFAULT NULL,
  `executed_by_citizenid` VARCHAR(100)  DEFAULT NULL,
  `executed_by_name`      VARCHAR(100) DEFAULT NULL,
  `notes`                 TEXT         DEFAULT NULL,
  `issued_at`             TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `executed_at`           TIMESTAMP    DEFAULT NULL,
  INDEX `idx_status`            (`status`),
  INDEX `idx_defendant_status`  (`defendant_citizenid`, `status`),
  INDEX `idx_case`              (`case_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
