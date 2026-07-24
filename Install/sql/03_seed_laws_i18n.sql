-- ============================================================
--  nevera_court | 03_seed_laws_i18n.sql
--  Populate HR/DE/FR titles + descriptions for law categories
--  and all NKZ laws from 02_seed_laws_english.sql.
--
--  Prerequisites (fresh install):
--    - 01_nevera_court.sql (tables + i18n columns already exist)
--    - 02_seed_laws_english.sql (English base data)
-- ============================================================

SET NAMES utf8mb4;

-- ------------------------------------------------------------
-- Categories (9) — HR / DE / FR
-- ------------------------------------------------------------
UPDATE `doj_law_categories` SET
  `title_hr` = 'Prometni prekršaji',
  `title_de` = 'Verkehrsdelikte',
  `title_fr` = 'Infractions routières',
  `description_hr` = 'Prometni prekršaji i kršenja propisa o vozilima',
  `description_de` = 'Verkehrs- und Fahrzeugverstöße',
  `description_fr` = 'Infractions au code de la route et aux véhicules'
WHERE `id` = 1;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Napad i nasilje',
  `title_de` = 'Körperverletzung und Gewalt',
  `title_fr` = 'Agression et violence',
  `description_hr` = 'Fizički napadi i prijetnje',
  `description_de` = 'Körperliche Angriffe und Drohungen',
  `description_fr` = 'Agressions physiques et menaces'
WHERE `id` = 2;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Krađa i pljačka',
  `title_de` = 'Diebstahl und Raub',
  `title_fr` = 'Vol et brigandage',
  `description_hr` = 'Krađa i pljačka tuđe imovine',
  `description_de` = 'Diebstahl und Raub von Eigentum',
  `description_fr` = 'Vol et brigandage de biens'
WHERE `id` = 3;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Oružje i eksplozivi',
  `title_de` = 'Waffen und Sprengstoffe',
  `title_fr` = 'Armes et explosifs',
  `description_hr` = 'Nezakonito posjedovanje oružja i eksplozivnih sredstava',
  `description_de` = 'Illegale Waffen und Sprengstoffe',
  `description_fr` = 'Armes et explosifs illégaux'
WHERE `id` = 4;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Prekršaji vezani uz droge',
  `title_de` = 'Drogendelikte',
  `title_fr` = 'Infractions liées aux stupéfiants',
  `description_hr` = 'Kontrolirane opojne tvari',
  `description_de` = 'Betäubungsmittel',
  `description_fr` = 'Substances contrôlées'
WHERE `id` = 5;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Javni red i mir',
  `title_de` = 'Öffentliche Ordnung',
  `title_fr` = 'Ordre public',
  `description_hr` = 'Narušavanje javnog reda i mira',
  `description_de` = 'Störung der öffentlichen Ordnung',
  `description_fr` = 'Atteinte à l''ordre public'
WHERE `id` = 6;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Imovinskopravni prekršaji',
  `title_de` = 'Eigentumsdelikte',
  `title_fr` = 'Atteintes aux biens',
  `description_hr` = 'Vandalizam, prijevara i podmetanje požara',
  `description_de` = 'Vandalismus, Betrug und Brandstiftung',
  `description_fr` = 'Vandalisme, fraude et incendie criminel'
WHERE `id` = 7;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Službena zloporaba',
  `title_de` = 'Amtsmissbrauch',
  `title_fr` = 'Fautes fonctionnelles',
  `description_hr` = 'Nepoštovanje suda, otpor pri uhićenju i podmićivanje',
  `description_de` = 'Missachtung des Gerichts, Widerstand gegen die Festnahme und Bestechung',
  `description_fr` = 'Outrage, résistance à l''arrestation et corruption'
WHERE `id` = 8;

UPDATE `doj_law_categories` SET
  `title_hr` = 'Teška kaznena djela',
  `title_de` = 'Schwere Straftaten',
  `title_fr` = 'Crimes graves',
  `description_hr` = 'Ubojstvo, otmica i ucjena',
  `description_de` = 'Mord, Entführung und Erpressung',
  `description_fr` = 'Meurtre, enlèvement et extorsion'
WHERE `id` = 9;

-- ------------------------------------------------------------
-- Laws (93) — HR / DE / FR titles (+ descriptions where set)
-- ------------------------------------------------------------
UPDATE `doj_laws` SET `title_hr` = 'Prekoračenje brzine do 16 km/h iznad dopuštenog', `title_de` = 'Geschwindigkeitsüberschreitung bis zu 16 km/h über dem Limit', `title_fr` = 'Excès de vitesse jusqu''à 16 km/h au-dessus de la limite' WHERE `code` = 'NKZ-101';
UPDATE `doj_laws` SET `title_hr` = 'Prekoračenje brzine 16–32 km/h iznad dopuštenog', `title_de` = 'Geschwindigkeitsüberschreitung 16–32 km/h über dem Limit', `title_fr` = 'Excès de vitesse de 16 à 32 km/h au-dessus de la limite' WHERE `code` = 'NKZ-102';
UPDATE `doj_laws` SET `title_hr` = 'Prekoračenje brzine 32–48 km/h iznad dopuštenog', `title_de` = 'Geschwindigkeitsüberschreitung 32–48 km/h über dem Limit', `title_fr` = 'Excès de vitesse de 32 à 48 km/h au-dessus de la limite' WHERE `code` = 'NKZ-103';
UPDATE `doj_laws` SET `title_hr` = 'Prekoračenje brzine 48–80 km/h iznad dopuštenog', `title_de` = 'Geschwindigkeitsüberschreitung 48–80 km/h über dem Limit', `title_fr` = 'Excès de vitesse de 48 à 80 km/h au-dessus de la limite' WHERE `code` = 'NKZ-104';
UPDATE `doj_laws` SET `title_hr` = 'Prekoračenje brzine više od 80 km/h iznad dopuštenog', `title_de` = 'Geschwindigkeitsüberschreitung um mehr als 80 km/h über dem Limit', `title_fr` = 'Excès de vitesse de plus de 80 km/h au-dessus de la limite' WHERE `code` = 'NKZ-105';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja pod utjecajem alkohola — koncentracija ispod 0,05 %', `title_de` = 'Fahren unter Alkoholeinfluss — Blutalkohol unter 0,05 %', `title_fr` = 'Conduite sous l''empire d''alcool — taux d''alcoolémie inférieur à 0,05 %' WHERE `code` = 'NKZ-111';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja pod utjecajem alkohola — koncentracija 0,05–0,10 %', `title_de` = 'Fahren unter Alkoholeinfluss — Blutalkohol 0,05–0,10 %', `title_fr` = 'Conduite sous l''empire d''alcool — taux d''alcoolémie de 0,05 à 0,10 %' WHERE `code` = 'NKZ-112';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja pod utjecajem alkohola — koncentracija 0,10–0,15 %', `title_de` = 'Fahren unter Alkoholeinfluss — Blutalkohol 0,10–0,15 %', `title_fr` = 'Conduite sous l''empire d''alcool — taux d''alcoolémie de 0,10 à 0,15 %' WHERE `code` = 'NKZ-113';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja pod utjecajem alkohola — koncentracija iznad 0,15 %', `title_de` = 'Fahren unter Alkoholeinfluss — Blutalkohol über 0,15 %', `title_fr` = 'Conduite sous l''empire d''alcool — taux d''alcoolémie supérieur à 0,15 %' WHERE `code` = 'NKZ-114';
UPDATE `doj_laws` SET `title_hr` = 'Odbijanje alkotesta', `title_de` = 'Verweigerung des Alkoholtests', `title_fr` = 'Refus de souffler dans l''éthylomètre' WHERE `code` = 'NKZ-115';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja pod utjecajem opojnih droga', `title_de` = 'Fahren unter Drogeneinfluss', `title_fr` = 'Conduite sous l''empire de stupéfiants' WHERE `code` = 'NKZ-116';
UPDATE `doj_laws` SET `title_hr` = 'Nevožnja sa sigurnosnim pojasom', `title_de` = 'Nichttragen des Sicherheitsgurts', `title_fr` = 'Non-port de la ceinture de sécurité' WHERE `code` = 'NKZ-121';
UPDATE `doj_laws` SET `title_hr` = 'Korištenje mobilnog telefona tijekom vožnje', `title_de` = 'Handybenutzung während der Fahrt', `title_fr` = 'Utilisation du téléphone mobile en conduisant' WHERE `code` = 'NKZ-122';
UPDATE `doj_laws` SET `title_hr` = 'Nevožnja sa zaštitnom kacigom', `title_de` = 'Nichttragen eines Schutzhelms', `title_fr` = 'Non-port du casque de protection' WHERE `code` = 'NKZ-123';
UPDATE `doj_laws` SET `title_hr` = 'Neispravno prilagodljivo sjedalo za dijete u vozilu', `title_de` = 'Unsachgemäße Kindersicherung im Fahrzeug', `title_fr` = 'Dispositif de retenue pour enfant non conforme dans le véhicule' WHERE `code` = 'NKZ-124';
UPDATE `doj_laws` SET `title_hr` = 'Prolazak kroz crveno svjetlo', `title_de` = 'Überfahren einer roten Ampel', `title_fr` = 'Franchissement d''un feu rouge' WHERE `code` = 'NKZ-131';
UPDATE `doj_laws` SET `title_hr` = 'Prolazak kroz crveno svjetlo — opasno', `title_de` = 'Überfahren einer roten Ampel — gefährlich', `title_fr` = 'Franchissement d''un feu rouge — circonstances dangereuses' WHERE `code` = 'NKZ-132';
UPDATE `doj_laws` SET `title_hr` = 'Nepridržavanje obveze zaustavljanja na znak stop', `title_de` = 'Missachtung des Stoppschilds', `title_fr` = 'Non-respect du panneau stop' WHERE `code` = 'NKZ-133';
UPDATE `doj_laws` SET `title_hr` = 'Nepridržavanje prometnog znaka', `title_de` = 'Missachtung eines Verkehrszeichens', `title_fr` = 'Non-respect d''un panneau de signalisation' WHERE `code` = 'NKZ-134';
UPDATE `doj_laws` SET `title_hr` = 'Nedopušteno parkiranje', `title_de` = 'Unzulässiges Parken', `title_fr` = 'Stationnement illicite' WHERE `code` = 'NKZ-135';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja u suprotnom smjeru na autocesti', `title_de` = 'Fahren in falscher Richtung auf der Autobahn', `title_fr` = 'Circulation en sens inverse sur autoroute' WHERE `code` = 'NKZ-141';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja u suprotnom smjeru', `title_de` = 'Fahren in falscher Richtung', `title_fr` = 'Circulation en sens interdit' WHERE `code` = 'NKZ-142';
UPDATE `doj_laws` SET `title_hr` = 'Zaustavljanje na autocesti', `title_de` = 'Anhalten auf der Autobahn', `title_fr` = 'Arrêt sur autoroute' WHERE `code` = 'NKZ-143';
UPDATE `doj_laws` SET `title_hr` = 'Nepropisno pretjecanje na autocesti', `title_de` = 'Unzulässiges Überholen auf der Autobahn', `title_fr` = 'Dépassement irrégulier sur autoroute' WHERE `code` = 'NKZ-144';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja bez vozačke dozvole', `title_de` = 'Fahren ohne Führerschein', `title_fr` = 'Conduite sans permis de conduire' WHERE `code` = 'NKZ-151';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja s privremeno oduzetom vozačkom dozvolom', `title_de` = 'Fahren mit entzogenem Führerschein', `title_fr` = 'Conduite avec permis suspendu' WHERE `code` = 'NKZ-152';
UPDATE `doj_laws` SET `title_hr` = 'Nepropisno pretjecanje', `title_de` = 'Unzulässiges Überholen', `title_fr` = 'Dépassement irrégulier' WHERE `code` = 'NKZ-153';
UPDATE `doj_laws` SET `title_hr` = 'Nepravilna i opasna vožnja', `title_de` = 'Rücksichtslose Fahrweise', `title_fr` = 'Conduite imprudente' WHERE `code` = 'NKZ-154';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja neregistriranog vozila', `title_de` = 'Fahren mit nicht zugelassenem Fahrzeug', `title_fr` = 'Conduite d''un véhicule non immatriculé' WHERE `code` = 'NKZ-155';
UPDATE `doj_laws` SET `title_hr` = 'Vožnja s isteklom vozačkom dozvolom', `title_de` = 'Fahren mit abgelaufenem Führerschein', `title_fr` = 'Conduite avec permis de conduire expiré' WHERE `code` = 'NKZ-156';
UPDATE `doj_laws` SET `title_hr` = 'Prijetnja', `title_de` = 'Bedrohung', `title_fr` = 'Menaces' WHERE `code` = 'NKZ-201';
UPDATE `doj_laws` SET `title_hr` = 'Tjelesna ozljeda', `title_de` = 'Körperverletzung', `title_fr` = 'Blessures corporelles' WHERE `code` = 'NKZ-202';
UPDATE `doj_laws` SET `title_hr` = 'Teška tjelesna ozljeda', `title_de` = 'Schwere Körperverletzung', `title_fr` = 'Coups et blessures aggravés' WHERE `code` = 'NKZ-203';
UPDATE `doj_laws` SET `title_hr` = 'Napad na službenu osobu', `title_de` = 'Angriff auf eine Amtsperson', `title_fr` = 'Agression sur agent public' WHERE `code` = 'NKZ-204';
UPDATE `doj_laws` SET `title_hr` = 'Napad na službenu osobu oružjem', `title_de` = 'Angriff auf eine Amtsperson mit Waffe', `title_fr` = 'Agression sur agent public avec arme' WHERE `code` = 'NKZ-205';
UPDATE `doj_laws` SET `title_hr` = 'Sitna krađa (ispod 200 USD)', `title_de` = 'Diebstahl geringen Werts (unter 200 USD)', `title_fr` = 'Vol simple (moins de 200 USD)' WHERE `code` = 'NKZ-301';
UPDATE `doj_laws` SET `title_hr` = 'Krađa (200–2000 USD)', `title_de` = 'Diebstahl (200–2000 USD)', `title_fr` = 'Vol (200 à 2000 USD)' WHERE `code` = 'NKZ-302';
UPDATE `doj_laws` SET `title_hr` = 'Teška krađa', `title_de` = 'Schwerer Diebstahl', `title_fr` = 'Vol qualifié' WHERE `code` = 'NKZ-303';
UPDATE `doj_laws` SET `title_hr` = 'Krađa vozila', `title_de` = 'Fahrzeugdiebstahl', `title_fr` = 'Vol de véhicule' WHERE `code` = 'NKZ-304';
UPDATE `doj_laws` SET `title_hr` = 'Pljačka trgovine', `title_de` = 'Raubüberfall auf ein Geschäft', `title_fr` = 'Braquage de commerce' WHERE `code` = 'NKZ-305';
UPDATE `doj_laws` SET `title_hr` = 'Pljačka s oružjem', `title_de` = 'Bewaffneter Raubüberfall', `title_fr` = 'Braquage à main armée' WHERE `code` = 'NKZ-306';
UPDATE `doj_laws` SET `title_hr` = 'Pljačka zlatarnice', `title_de` = 'Raubüberfall auf Juweliergeschäft', `title_fr` = 'Braquage de bijouterie' WHERE `code` = 'NKZ-307';
UPDATE `doj_laws` SET `title_hr` = 'Pljačka banke', `title_de` = 'Banküberfall', `title_fr` = 'Braquage de banque' WHERE `code` = 'NKZ-308';
UPDATE `doj_laws` SET `title_hr` = 'Neovlašteni ulaz na tuđi posjed', `title_de` = 'Unbefugtes Betreten fremden Besitzes', `title_fr` = 'Violation de domicile' WHERE `code` = 'NKZ-311';
UPDATE `doj_laws` SET `title_hr` = 'Provala', `title_de` = 'Einbruch', `title_fr` = 'Cambriolage' WHERE `code` = 'NKZ-312';
UPDATE `doj_laws` SET `title_hr` = 'Provala u stambeni objekt', `title_de` = 'Wohnungseinbruch', `title_fr` = 'Cambriolage de domicile' WHERE `code` = 'NKZ-313';
UPDATE `doj_laws` SET `title_hr` = 'Provala s oružjem', `title_de` = 'Bewaffneter Einbruch', `title_fr` = 'Cambriolage avec arme' WHERE `code` = 'NKZ-314';
UPDATE `doj_laws` SET `title_hr` = 'Posjed hladnog oružja', `title_de` = 'Besitz einer Hieb- und Stichwaffe', `title_fr` = 'Détention d''une arme blanche' WHERE `code` = 'NKZ-401';
UPDATE `doj_laws` SET `title_hr` = 'Posjed nedopuštene vatrene oružja', `title_de` = 'Besitz einer illegalen Schusswaffe', `title_fr` = 'Détention d''une arme à feu illégale' WHERE `code` = 'NKZ-402';
UPDATE `doj_laws` SET `title_hr` = 'Nošenje nedopuštene vatrene oružja', `title_de` = 'Führen einer illegalen Schusswaffe', `title_fr` = 'Port d''une arme à feu illégale' WHERE `code` = 'NKZ-403';
UPDATE `doj_laws` SET `title_hr` = 'Posjed automatskog oružja', `title_de` = 'Besitz einer automatischen Waffe', `title_fr` = 'Détention d''une arme automatique' WHERE `code` = 'NKZ-404';
UPDATE `doj_laws` SET `title_hr` = 'Trgovina oružjem', `title_de` = 'Waffenhandel', `title_fr` = 'Trafic d''armes' WHERE `code` = 'NKZ-405';
UPDATE `doj_laws` SET `title_hr` = 'Posjed eksplozivnih sredstava', `title_de` = 'Besitz von Sprengstoffen', `title_fr` = 'Détention d''explosifs' WHERE `code` = 'NKZ-406';
UPDATE `doj_laws` SET `title_hr` = 'Posjed marihuane (ispod 5 g)', `title_de` = 'Besitz von Marihuana (unter 5 g)', `title_fr` = 'Détention de marijuana (moins de 5 g)' WHERE `code` = 'NKZ-501';
UPDATE `doj_laws` SET `title_hr` = 'Posjed droga — mala količina', `title_de` = 'Drogenbesitz — geringe Menge', `title_fr` = 'Détention de stupéfiants — petite quantité' WHERE `code` = 'NKZ-502';
UPDATE `doj_laws` SET `title_hr` = 'Posjed droga — srednja količina', `title_de` = 'Drogenbesitz — mittlere Menge', `title_fr` = 'Détention de stupéfiants — quantité moyenne' WHERE `code` = 'NKZ-503';
UPDATE `doj_laws` SET `title_hr` = 'Posjed droga — velika količina', `title_de` = 'Drogenbesitz — große Menge', `title_fr` = 'Détention de stupéfiants — grande quantité' WHERE `code` = 'NKZ-504';
UPDATE `doj_laws` SET `title_hr` = 'Uzgoj marihuane', `title_de` = 'Marihuanazucht', `title_fr` = 'Culture de marijuana' WHERE `code` = 'NKZ-511';
UPDATE `doj_laws` SET `title_hr` = 'Proizvodnja opojnih droga', `title_de` = 'Drogenherstellung', `title_fr` = 'Fabrication de stupéfiants' WHERE `code` = 'NKZ-512';
UPDATE `doj_laws` SET `title_hr` = 'Promet opojnih droga', `title_de` = 'Drogenhandel', `title_fr` = 'Trafic de stupéfiants' WHERE `code` = 'NKZ-513';
UPDATE `doj_laws` SET `title_hr` = 'Organizirani promet opojnih droga', `title_de` = 'Organisierter Drogenhandel', `title_fr` = 'Trafic organisé de stupéfiants' WHERE `code` = 'NKZ-514';
UPDATE `doj_laws` SET `title_hr` = 'Javno vrijeđanje / neprimjereni govor', `title_de` = 'Öffentliches Schimpfen / ungebührliche Äußerungen', `title_fr` = 'Injures publiques / propos injurieux' WHERE `code` = 'NKZ-601';
UPDATE `doj_laws` SET `title_hr` = 'Ustna napast', `title_de` = 'Verbale Beleidigung', `title_fr` = 'Outrage verbal' WHERE `code` = 'NKZ-602';
UPDATE `doj_laws` SET `title_hr` = 'Narušavanje javnog reda i mira', `title_de` = 'Störung der öffentlichen Ordnung', `title_fr` = 'Atteinte à l''ordre public' WHERE `code` = 'NKZ-603';
UPDATE `doj_laws` SET `title_hr` = 'Javna tučnjava', `title_de` = 'Öffentliche Schlägerei', `title_fr` = 'Rixe en public' WHERE `code` = 'NKZ-604';
UPDATE `doj_laws` SET `title_hr` = 'Lažna prijava', `title_de` = 'Falsche Anzeige', `title_fr` = 'Dénonciation mensongère' WHERE `code` = 'NKZ-605';
UPDATE `doj_laws` SET `title_hr` = 'Crtanje grafita', `title_de` = 'Graffiti / Sachbeschädigung durch Besprühen', `title_fr` = 'Graffiti' WHERE `code` = 'NKZ-701';
UPDATE `doj_laws` SET `title_hr` = 'Manja šteta na imovini', `title_de` = 'Geringfügige Sachbeschädigung', `title_fr` = 'Dégradation mineure de biens' WHERE `code` = 'NKZ-702';
UPDATE `doj_laws` SET `title_hr` = 'Veća šteta na imovini', `title_de` = 'Erhebliche Sachbeschädigung', `title_fr` = 'Dégradation importante de biens' WHERE `code` = 'NKZ-703';
UPDATE `doj_laws` SET `title_hr` = 'Oštećenje javne imovine', `title_de` = 'Beschädigung öffentlichen Eigentums', `title_fr` = 'Dégradation de biens publics' WHERE `code` = 'NKZ-704';
UPDATE `doj_laws` SET `title_hr` = 'Podmetanje požara', `title_de` = 'Brandstiftung', `title_fr` = 'Incendie criminel' WHERE `code` = 'NKZ-705';
UPDATE `doj_laws` SET `title_hr` = 'Prijevara', `title_de` = 'Betrug', `title_fr` = 'Escroquerie' WHERE `code` = 'NKZ-711';
UPDATE `doj_laws` SET `title_hr` = 'Krivotvorenje', `title_de` = 'Urkundenfälschung', `title_fr` = 'Falsification' WHERE `code` = 'NKZ-712';
UPDATE `doj_laws` SET `title_hr` = 'Bijeg policiji vozilom', `title_de` = 'Flucht vor der Polizei mit Fahrzeug', `title_fr` = 'Fuite devant la police en véhicule' WHERE `code` = 'NKZ-801';
UPDATE `doj_laws` SET `title_hr` = 'Bijeg policiji pješice', `title_de` = 'Flucht vor der Polizei zu Fuß', `title_fr` = 'Fuite devant la police à pied' WHERE `code` = 'NKZ-802';
UPDATE `doj_laws` SET `title_hr` = 'Nepridržavanje zakonite službene naredbe', `title_de` = 'Missachtung einer rechtmäßigen Anordnung', `title_fr` = 'Non-respect d''un ordre légitime' WHERE `code` = 'NKZ-803';
UPDATE `doj_laws` SET `title_hr` = 'Sprječavanje provođenja pravde', `title_de` = 'Behinderung der Rechtspflege', `title_fr` = 'Entrave à l''action de la justice' WHERE `code` = 'NKZ-804';
UPDATE `doj_laws` SET `title_hr` = 'Otpor pri uhićenju', `title_de` = 'Widerstand gegen die Festnahme', `title_fr` = 'Résistance à l''arrestation' WHERE `code` = 'NKZ-805';
UPDATE `doj_laws` SET `title_hr` = 'Nepoštovanje suda — usmeno', `title_de` = 'Gerichtsbeleidigung — verbal', `title_fr` = 'Outrage à la cour — verbal' WHERE `code` = 'NKZ-811';
UPDATE `doj_laws` SET `title_hr` = 'Ometanje sudskog postupka', `title_de` = 'Störung der Gerichtsverhandlung', `title_fr` = 'Trouble à l''audience' WHERE `code` = 'NKZ-812';
UPDATE `doj_laws` SET `title_hr` = 'Nepojavljivanje na sudu', `title_de` = 'Versäumnis der Gerichtsvorladung', `title_fr` = 'Défaut de comparution' WHERE `code` = 'NKZ-813';
UPDATE `doj_laws` SET `title_hr` = 'Nepoštovanje suda — teško', `title_de` = 'Schwere Gerichtsbeleidigung', `title_fr` = 'Outrage à la cour — aggravé' WHERE `code` = 'NKZ-814';
UPDATE `doj_laws` SET `title_hr` = 'Prijetnja sucu ili odvjetniku', `title_de` = 'Bedrohung eines Richters oder Anwalts', `title_fr` = 'Menaces contre un juge ou un avocat' WHERE `code` = 'NKZ-815';
UPDATE `doj_laws` SET `title_hr` = 'Pokušaj ubojstva', `title_de` = 'Versuchter Mord', `title_fr` = 'Tentative de meurtre' WHERE `code` = 'NKZ-901';
UPDATE `doj_laws` SET `title_hr` = 'Ubojstvo (drugi stupanj)', `title_de` = 'Mord (zweiten Grades)', `title_fr` = 'Meurtre (deuxième degré)' WHERE `code` = 'NKZ-902';
UPDATE `doj_laws` SET `title_hr` = 'Ubojstvo (prvi stupanj)', `title_de` = 'Mord (ersten Grades)', `title_fr` = 'Meurtre (premier degré)' WHERE `code` = 'NKZ-903';
UPDATE `doj_laws` SET `title_hr` = 'Ucjena', `title_de` = 'Erpressung', `title_fr` = 'Extorsion' WHERE `code` = 'NKZ-911';
UPDATE `doj_laws` SET `title_hr` = 'Otmica', `title_de` = 'Entführung', `title_fr` = 'Enlèvement' WHERE `code` = 'NKZ-912';
UPDATE `doj_laws` SET `title_hr` = 'Nezakonito lišavanje slobode', `title_de` = 'Freiheitsberaubung', `title_fr` = 'Séquestration' WHERE `code` = 'NKZ-913';
UPDATE `doj_laws` SET `title_hr` = 'Pokušaj ubojstva', `title_de` = 'Versuchter Mord', `title_fr` = 'Tentative de meurtre', `description_hr` = 'Pokušaj usmrtiti drugu osobu', `description_de` = 'Versuch, eine andere Person zu töten', `description_fr` = 'Tentative de tuer une autre personne' WHERE `code` = 'NKZ-904';
UPDATE `doj_laws` SET `title_hr` = 'Zloporaba službenog položaja', `title_de` = 'Amtsmissbrauch', `title_fr` = 'Abus d''autorité', `description_hr` = 'Zloporaba službenog položaja u osobnu korist', `description_de` = 'Missbrauch der Amtsstellung zum persönlichen Vorteil', `description_fr` = 'Abus de fonction pour gain personnel' WHERE `code` = 'NKZ-806';
UPDATE `doj_laws` SET `title_hr` = 'Podmićivanje službene osobe', `title_de` = 'Bestechung einer Amtsperson', `title_fr` = 'Corruption d''un agent public', `description_hr` = 'Ponuda mita službenoj osobi', `description_de` = 'Anbieten eines Bestechungsgeldes an eine Amtsperson', `description_fr` = 'Offre de pot-de-vin à un agent public' WHERE `code` = 'NKZ-807';
UPDATE `doj_laws` SET `title_hr` = 'Primanje mita', `title_de` = 'Annahme eines Bestechungsgeldes', `title_fr` = 'Acceptation de pot-de-vin', `description_hr` = 'Primanje mita od strane službene osobe', `description_de` = 'Annahme eines Bestechungsgeldes durch eine Amtsperson', `description_fr` = 'Acceptation d''un pot-de-vin par un agent public' WHERE `code` = 'NKZ-808';


-- Verify
SELECT COUNT(*) AS categories_i18n FROM doj_law_categories WHERE title_hr IS NOT NULL;
SELECT COUNT(*) AS laws_i18n FROM doj_laws WHERE title_hr IS NOT NULL;
