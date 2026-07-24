-- ============================================================
--  nevera_court | seed_laws_english.sql
--  Fill EMPTY doj_laws + doj_law_categories with English text.
--
--  Prerequisites:
--    - Tables exist (from nevera_court.sql)
--    - Prefer empty tables; ON DUPLICATE KEY UPDATE is safe
--
--  Do NOT use seed_laws_from_hr_dump.sql (removed — was HR titles).
-- ============================================================

SET NAMES utf8mb4;

-- ------------------------------------------------------------
-- Categories (9) — English
-- ------------------------------------------------------------
INSERT INTO `doj_law_categories` (`id`, `title`, `description`, `color`, `icon`) VALUES
(1, 'Traffic Offenses', 'Traffic and vehicle violations', '#3b82f6', 'car'),
(2, 'Assault & Violence', 'Physical attacks and threats', '#ef4444', 'alert-triangle'),
(3, 'Theft & Robbery', 'Property theft and robbery', '#f59e0b', 'shopping-bag'),
(4, 'Weapons & Explosives', 'Illegal weapons and explosives', '#dc2626', 'target'),
(5, 'Drug Offenses', 'Controlled substances', '#10b981', 'pill'),
(6, 'Public Order', 'Disturbing the peace', '#6366f1', 'users'),
(7, 'Property Crimes', 'Vandalism, fraud, arson', '#8b5cf6', 'home'),
(8, 'Official Misconduct', 'Contempt, resisting arrest, bribery', '#0ea5e9', 'shield'),
(9, 'Serious Felonies', 'Murder, kidnapping, extortion', '#be123c', 'skull')
ON DUPLICATE KEY UPDATE
  `title` = VALUES(`title`),
  `description` = VALUES(`description`),
  `color` = VALUES(`color`),
  `icon` = VALUES(`icon`);

-- ------------------------------------------------------------
-- Laws — English titles; same codes / fines / jail as NKZ dump
-- ------------------------------------------------------------
INSERT INTO `doj_laws`
  (`id`, `code`, `title`, `description`, `category_id`, `severity`,
   `min_fine`, `max_fine`, `min_jail`, `max_jail`, `points`, `active`)
VALUES
(1,  'NKZ-101', 'Speeding up to 10 mph over the limit', NULL, 1, 'infraction', 30, 60, 0, 0, 0, 1),
(2,  'NKZ-102', 'Speeding 10–20 mph over the limit', NULL, 1, 'infraction', 60, 130, 0, 0, 1, 1),
(3,  'NKZ-103', 'Speeding 20–30 mph over the limit', NULL, 1, 'infraction', 130, 390, 0, 0, 2, 1),
(4,  'NKZ-104', 'Speeding 30–50 mph over the limit', NULL, 1, 'infraction', 390, 920, 0, 0, 3, 1),
(5,  'NKZ-105', 'Speeding 50+ mph over the limit', NULL, 1, 'moderate', 1320, 2650, 0, 3, 5, 1),
(6,  'NKZ-111', 'DUI — BAC below 0.05%', NULL, 1, 'infraction', 90, 400, 0, 0, 2, 1),
(7,  'NKZ-112', 'DUI — BAC 0.05–0.10%', NULL, 1, 'infraction', 400, 660, 0, 0, 4, 1),
(8,  'NKZ-113', 'DUI — BAC 0.10–0.15%', NULL, 1, 'moderate', 660, 1320, 0, 1, 6, 1),
(9,  'NKZ-114', 'DUI — BAC above 0.15%', NULL, 1, 'moderate', 1320, 2650, 1, 6, 8, 1),
(10, 'NKZ-115', 'Refusal of breathalyzer', NULL, 1, 'moderate', 2650, 2650, 1, 6, 8, 1),
(11, 'NKZ-116', 'Driving under the influence of drugs', NULL, 1, 'moderate', 1320, 2650, 1, 6, 8, 1),
(12, 'NKZ-121', 'Failure to wear a seatbelt', NULL, 1, 'infraction', 130, 130, 0, 0, 1, 1),
(13, 'NKZ-122', 'Using a mobile phone while driving', NULL, 1, 'infraction', 130, 130, 0, 0, 1, 1),
(14, 'NKZ-123', 'Failure to wear a helmet', NULL, 1, 'infraction', 130, 130, 0, 0, 1, 1),
(15, 'NKZ-124', 'Improper child restraint in vehicle', NULL, 1, 'infraction', 260, 260, 0, 0, 2, 1),
(16, 'NKZ-131', 'Running a red light', NULL, 1, 'moderate', 390, 1320, 0, 0, 3, 1),
(17, 'NKZ-132', 'Running a red light — dangerous', NULL, 1, 'moderate', 1320, 2650, 0, 1, 5, 1),
(18, 'NKZ-133', 'Failure to stop at a stop sign', NULL, 1, 'infraction', 390, 390, 0, 0, 2, 1),
(19, 'NKZ-134', 'Failure to obey a traffic sign', NULL, 1, 'infraction', 260, 260, 0, 0, 1, 1),
(20, 'NKZ-135', 'Illegal parking', NULL, 1, 'infraction', 130, 130, 0, 0, 0, 1),
(21, 'NKZ-141', 'Wrong-way driving on freeway', NULL, 1, 'felony', 2650, 2650, 1, 12, 10, 1),
(22, 'NKZ-142', 'Driving the wrong direction', NULL, 1, 'moderate', 1320, 1320, 0, 3, 5, 1),
(23, 'NKZ-143', 'Stopping on the freeway', NULL, 1, 'infraction', 660, 660, 0, 0, 3, 1),
(24, 'NKZ-144', 'Improper passing on the freeway', NULL, 1, 'infraction', 390, 390, 0, 0, 2, 1),
(25, 'NKZ-151', 'Driving without a license', NULL, 1, 'moderate', 800, 800, 0, 0, 0, 1),
(26, 'NKZ-152', 'Driving with a suspended license', NULL, 1, 'moderate', 2650, 2650, 1, 6, 0, 1),
(27, 'NKZ-153', 'Improper passing', NULL, 1, 'infraction', 660, 660, 0, 0, 3, 1),
(28, 'NKZ-154', 'Reckless driving', NULL, 1, 'infraction', 390, 660, 0, 0, 3, 1),
(29, 'NKZ-155', 'Unregistered vehicle', NULL, 1, 'infraction', 260, 260, 0, 0, 0, 1),
(30, 'NKZ-156', 'Expired driver license', NULL, 1, 'infraction', 130, 130, 0, 0, 0, 1),
(31, 'NKZ-201', 'Threats', NULL, 2, 'moderate', 1500, 1500, 0, 12, 0, 1),
(32, 'NKZ-202', 'Battery / bodily injury', NULL, 2, 'moderate', 3000, 3000, 0, 12, 0, 1),
(33, 'NKZ-203', 'Aggravated battery', NULL, 2, 'felony', 6000, 10000, 6, 60, 0, 1),
(34, 'NKZ-204', 'Assault on a public official', NULL, 2, 'felony', 10000, 15000, 12, 60, 0, 1),
(35, 'NKZ-205', 'Assault on a public official with a weapon', NULL, 2, 'severe', 15000, 20000, 24, 120, 0, 1),
(36, 'NKZ-301', 'Petty theft (under $200)', NULL, 3, 'misdemeanor', 500, 500, 0, 6, 0, 1),
(37, 'NKZ-302', 'Theft ($200–$2000)', NULL, 3, 'moderate', 2000, 2000, 0, 12, 0, 1),
(38, 'NKZ-303', 'Grand theft', NULL, 3, 'moderate', 5000, 6000, 6, 36, 0, 1),
(39, 'NKZ-304', 'Vehicle theft', NULL, 3, 'moderate', 6000, 6000, 6, 36, 0, 1),
(40, 'NKZ-305', 'Store robbery', NULL, 3, 'felony', 10000, 10000, 12, 48, 0, 1),
(41, 'NKZ-306', 'Armed robbery', NULL, 3, 'felony', 18000, 18000, 24, 60, 0, 1),
(42, 'NKZ-307', 'Jewelry store robbery', NULL, 3, 'severe', 25000, 25000, 36, 84, 0, 1),
(43, 'NKZ-308', 'Bank robbery', NULL, 3, 'severe', 35000, 50000, 48, 120, 0, 1),
(44, 'NKZ-311', 'Trespassing', NULL, 3, 'misdemeanor', 3000, 3000, 0, 12, 0, 1),
(45, 'NKZ-312', 'Burglary', NULL, 3, 'moderate', 6000, 6000, 6, 36, 0, 1),
(46, 'NKZ-313', 'Residential burglary', NULL, 3, 'moderate', 10000, 10000, 12, 48, 0, 1),
(47, 'NKZ-314', 'Armed burglary', NULL, 3, 'felony', 15000, 15000, 24, 60, 0, 1),
(48, 'NKZ-401', 'Possession of a melee weapon', NULL, 4, 'moderate', 3000, 3000, 0, 12, 0, 1),
(49, 'NKZ-402', 'Possession of an illegal firearm', NULL, 4, 'felony', 7000, 12000, 6, 36, 0, 1),
(50, 'NKZ-403', 'Carrying an illegal firearm', NULL, 4, 'felony', 12000, 20000, 12, 60, 0, 1),
(51, 'NKZ-404', 'Possession of an automatic weapon', NULL, 4, 'severe', 20000, 30000, 24, 120, 0, 1),
(52, 'NKZ-405', 'Weapons trafficking', NULL, 4, 'severe', 30000, 50000, 36, 180, 0, 1),
(53, 'NKZ-406', 'Possession of explosives', NULL, 4, 'severe', 15000, 25000, 24, 120, 0, 1),
(54, 'NKZ-501', 'Possession of marijuana (under 5g)', NULL, 5, 'misdemeanor', 500, 500, 0, 0, 0, 1),
(55, 'NKZ-502', 'Drug possession — small amount', NULL, 5, 'moderate', 2000, 2000, 0, 12, 0, 1),
(56, 'NKZ-503', 'Drug possession — medium amount', NULL, 5, 'moderate', 5000, 5000, 0, 24, 0, 1),
(57, 'NKZ-504', 'Drug possession — large amount', NULL, 5, 'felony', 10000, 10000, 6, 36, 0, 1),
(58, 'NKZ-511', 'Marijuana cultivation', NULL, 5, 'felony', 12000, 12000, 12, 60, 0, 1),
(59, 'NKZ-512', 'Drug manufacturing', NULL, 5, 'severe', 18000, 18000, 24, 120, 0, 1),
(60, 'NKZ-513', 'Drug trafficking', NULL, 5, 'severe', 25000, 25000, 36, 180, 0, 1),
(61, 'NKZ-514', 'Organized drug trafficking', NULL, 5, 'severe', 40000, 60000, 60, 240, 0, 1),
(62, 'NKZ-601', 'Public swearing / disorderly language', NULL, 6, 'infraction', 200, 200, 0, 0, 0, 1),
(63, 'NKZ-602', 'Verbal assault', NULL, 6, 'infraction', 300, 300, 0, 0, 0, 1),
(64, 'NKZ-603', 'Disturbing the peace', NULL, 6, 'misdemeanor', 500, 500, 0, 3, 0, 1),
(65, 'NKZ-604', 'Public fight / affray', NULL, 6, 'moderate', 1000, 1000, 0, 12, 0, 1),
(66, 'NKZ-605', 'False report', NULL, 6, 'moderate', 2000, 2000, 0, 12, 0, 1),
(67, 'NKZ-701', 'Graffiti', NULL, 7, 'infraction', 500, 500, 0, 0, 0, 1),
(68, 'NKZ-702', 'Minor property damage', NULL, 7, 'misdemeanor', 1500, 1500, 0, 6, 0, 1),
(69, 'NKZ-703', 'Major property damage', NULL, 7, 'moderate', 4000, 4000, 0, 12, 0, 1),
(70, 'NKZ-704', 'Damage to public property', NULL, 7, 'moderate', 7000, 7000, 0, 24, 0, 1),
(71, 'NKZ-705', 'Arson', NULL, 7, 'felony', 12000, 20000, 12, 60, 0, 1),
(72, 'NKZ-711', 'Fraud', NULL, 7, 'moderate', 10000, 15000, 6, 48, 0, 1),
(73, 'NKZ-712', 'Forgery', NULL, 7, 'moderate', 7000, 7000, 6, 36, 0, 1),
(74, 'NKZ-801', 'Evading police in a vehicle', NULL, 8, 'felony', 5000, 5000, 6, 24, 0, 1),
(75, 'NKZ-802', 'Evading on foot', NULL, 8, 'moderate', 2000, 2000, 0, 6, 0, 1),
(76, 'NKZ-803', 'Failure to obey a lawful order', NULL, 8, 'misdemeanor', 500, 500, 0, 3, 0, 1),
(77, 'NKZ-804', 'Obstruction of justice', NULL, 8, 'misdemeanor', 300, 500, 0, 3, 0, 1),
(78, 'NKZ-805', 'Resisting arrest', NULL, 8, 'moderate', 3000, 3000, 0, 12, 0, 1),
(79, 'NKZ-811', 'Contempt of court — verbal', NULL, 8, 'misdemeanor', 500, 1000, 0, 3, 0, 1),
(80, 'NKZ-812', 'Disruption of court proceedings', NULL, 8, 'moderate', 1000, 2000, 0, 6, 0, 1),
(81, 'NKZ-813', 'Failure to appear in court', NULL, 8, 'moderate', 2000, 3000, 0, 6, 0, 1),
(82, 'NKZ-814', 'Contempt of court — aggravated', NULL, 8, 'felony', 3000, 5000, 0, 12, 0, 1),
(83, 'NKZ-815', 'Threat against a judge or attorney', NULL, 8, 'felony', 5000, 10000, 6, 36, 0, 1),
(84, 'NKZ-901', 'Attempted murder', NULL, 9, 'severe', 20000, 35000, 60, 180, 0, 1),
(85, 'NKZ-902', 'Murder (second degree)', NULL, 9, 'severe', 35000, 50000, 60, 240, 0, 1),
(86, 'NKZ-903', 'Murder (first degree)', NULL, 9, 'severe', 50000, 60000, 120, 480, 0, 1),
(87, 'NKZ-911', 'Extortion', NULL, 9, 'felony', 15000, 25000, 12, 60, 0, 1),
(88, 'NKZ-912', 'Kidnapping', NULL, 9, 'severe', 25000, 50000, 36, 180, 0, 1),
(89, 'NKZ-913', 'False imprisonment', NULL, 9, 'felony', 12000, 20000, 12, 60, 0, 1),
(90, 'NKZ-904', 'Attempted murder', 'Attempt to murder another person', 9, 'felony', 25000, 35000, 24, 48, 50, 1),
(101,'NKZ-806', 'Abuse of authority', 'Abuse of official position for personal gain', 8, 'felony', 25000, 40000, 12, 48, 35, 1),
(104,'NKZ-807', 'Bribery of a public official', 'Offering a bribe to a public official', 8, 'felony', 15000, 25000, 6, 24, 25, 1),
(105,'NKZ-808', 'Accepting a bribe', 'Acceptance of a bribe by a public official', 8, 'felony', 20000, 30000, 12, 36, 30, 1)
ON DUPLICATE KEY UPDATE
  `code` = VALUES(`code`),
  `title` = VALUES(`title`),
  `description` = VALUES(`description`),
  `category_id` = VALUES(`category_id`),
  `severity` = VALUES(`severity`),
  `min_fine` = VALUES(`min_fine`),
  `max_fine` = VALUES(`max_fine`),
  `min_jail` = VALUES(`min_jail`),
  `max_jail` = VALUES(`max_jail`),
  `points` = VALUES(`points`),
  `active` = VALUES(`active`);

-- Verify
SELECT COUNT(*) AS categories FROM doj_law_categories;
SELECT COUNT(*) AS laws FROM doj_laws;
