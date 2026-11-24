-- ============================================================
--  nevera_court / config.lua
--  Customer-editable configuration (escrow_ignore)
-- ============================================================

Config = Config or {}

-- ============================================================
--  GENERAL
-- ============================================================

Config.Debug = false            -- true = print debug messages to console
Config.Locale = 'en'            -- UI + form HTML folder: en→forms_en | hr→forms_hr | de→forms_de | fr→forms_fr | es→forms_es
-- Hours east of UTC for texts the server writes itself (Discord). Player toasts use the PC clock.
-- e.g. 1 = CET (winter), 2 = CEST (summer), -5 = EST. nil = UTC on the server side only.
Config.TimeZoneOffset = 0
                                -- Form templates live in web/dist/forms_<lang>/ (edit the HTML, restart the resource)
                                -- Missing file falls back to forms_en
Config.Currency = '€'           -- Money symbol shown everywhere (UI, fines, fees, notifications): '€', '$', '£', ...
Config.PageSize = 20            -- Records per page (pagination)

-- Chat commands. Change the name here; the script reads these keys.
-- legacyAliases = true also keeps the old names: jpdezurni, doj_jury_odjava, refreshnkz.
Config.Commands = {
    juryJoin      = 'doj_jury',
    juryLeave     = 'doj_jury_leave',
    refreshLaws   = 'refreshlaws',
    help          = 'doj_help',
    legacyAliases = false,
}

-- Your server / court name. Used in UI titles, the official seal, Discord logs and the A4 forms
-- (the form templates say "Nevera" — it is replaced at runtime with ServerName).
-- ============================================================
--  EDITION — Full or Lite court
--  'full' = everything · 'lite' = core court only:
--      cases, forms, warrants, verdicts, bail, hearings, fines, penal code, gavel,
--      arraignment, bench warrants, contempt, penal code editor
--  Any single module can be forced on/off below (true / false). nil = follow the Edition.
-- ============================================================
Config.Edition = 'full'   -- 'full' | 'lite'

Config.Modules = {
    -- core extras
    bail            = nil,
    db_editor       = nil,  -- full only: laptop Database editor (Lite stays off)
    hearings        = nil,
    jury            = nil,
    judicial_police = nil,
    archive         = nil,
    projector       = nil,
    gavel           = nil,
    -- court services
    exams           = nil,  -- bar exam / licences
    appointments    = nil,  -- attorney appointments
    treasury        = nil,  -- DOJ treasury ledger
    appeals         = nil,
    expungement     = nil,
    plea_deals      = nil,
    evidence        = nil,
    court_session   = nil,  -- all rise / minutes
    court_board     = nil,
    -- court procedure
    arraignment       = nil,  -- plea entry + public defender
    bench_warrants    = nil,  -- failure to appear → arrest warrant
    alt_sentences     = nil,  -- probation / community service
    restraining_orders = nil,
    detention_limits  = nil,  -- HUT time limits
    house_arrest      = nil,  -- house arrest + ankle monitor
    contempt          = nil,  -- contempt of court
    law_editor        = nil,  -- in-game penal code editor
}

Config.Branding = {
    ServerName = 'Los Santos',  -- e.g. 'Nevera' → "DISTRICT COURT NEVERA", "Nevera criminal code"
    PenalCode  = 'PC',          -- short name of your penal code shown in titles (e.g. 'PC', 'NKZ')
}

-- Court filing fees charged from the player's bank (Config.Fees.Account).
-- Adjust amounts to your server economy before go-live.
Config.Fees = {
    Enabled = true,
    Account = 'bank',
    CurrencyLabel = nil,        -- nil = use Config.Currency
    request_certificate_no_criminal = 500,
    name_change_request = 2000,
}

-- Framework bridge: 'auto' | 'qb' | 'qbox' | 'esx' | 'standalone'
-- auto = detect Qbox > QBCore > ESX > OX; use standalone only when set explicitly
Config.Framework = 'auto'

-- ESX-only options (ignored on QB / Qbox / OX)
Config.ESX = {
    -- ESX jobs usually have no job.onDuty. false = treat nil as on-duty (default).
    -- true  = require job.onDuty == true (only if your ESX duty script sets it).
    RequireDuty = false,
    -- Groups allowed for Bridge.AddCommand(..., restricted = true, ...)
    AdminGroups = { 'admin', 'superadmin' },
}

-- Inventory bridge: 'auto' | 'ox' | 'qs-inventory' | 'qb-inventory' | 'ps-inventory' | 'codem-inventory' | 'tgiann-inventory' | 'origen_inventory' | 'ak47_inventory'
-- auto: ox_inventory wins if both ox and qb-inventory are started.
-- Pure QB (no ox_inventory): leave 'auto' or set 'qb-inventory'.
-- Mixed servers switching to QB-only: set provider = 'qb-inventory' so ox is ignored.
Config.Inventory = {
    provider = 'auto',
}

-- ============================================================
--  TIMERS (seconds)
-- ============================================================

Config.Timers = {
    prefilingDeadline       = 86400,    -- 24h to file Criminal Complaint after arrest
    civilAppearanceDeadline = 172800,   -- 48h for civil Appearance after service
    searchWarrantExpiry     = 1209600,  -- 14 days search warrant validity
    failToAppearBailBan     = 14,       -- days without bail after Fail to Appear
    cronInterval            = 60000,    -- cron check interval (ms)
}

-- Target eye (courthouse / archive / projector / gavel)
-- 'auto' = ox_target if started, otherwise qb-target
Config.Target = {
    provider = 'auto', -- 'auto' | 'ox_target' | 'qb-target'
}

-- ============================================================
--  COURTHOUSE — target zones (ox_target or qb-target)
-- ============================================================

Config.Courthouse = {
    mainZone = {
        coords = vector3(234.89, -1314.04, 29.22),
        size   = vector3(8.0, 12.0, 3.0),
        rotation = 0.0,
        heading  = 0.0,
    },
    terminalZone = {
        coords = vector3(234.89, -1309.04, 29.22),
        size   = vector3(2.0, 2.0, 2.0),
        rotation = 0.0,
    },
    bailZone = {
        coords = vector3(240.50, -1314.04, 29.22),
        size   = vector3(2.0, 2.0, 2.0),
        rotation = 0.0,
    },
}

-- Projector + gavel (move coords to your courtroom MLO)
-- The .gfx is NOT included. Download the free tool by thers and start it before this resource:
--   https://forum.cfx.re/t/release-generic-dui-2d-3d-renderer/131208
-- Unzip generic_texture_renderer_gfx into resources, then in server.cfg:
--   ensure generic_texture_renderer_gfx
--   ensure Nevera_Court
-- coords = centre of the screen on the wall (Z about 1.3 above the floor).
-- rot    = direction the picture faces. If it is mirrored, add 180 to rot.z.
Config.Courtroom = {
    projector = {
        enabled      = true,
        coords       = vector3(234.89, -1318.20, 31.55),
        rot          = vector3(0.0, 0.0, 180.0),
        scale        = 0.085,
        viewDistance = 18.0,
        width        = 1550,
        height       = 870,
    },
    gavel = {
        enabled   = true,
        -- Target point + optional desk prop. The STRIKE itself plays from the judge's
        -- real position, so it works even if these coords are not exact.
        coords    = vector3(234.89, -1314.04, 29.35),
        heading   = 0.0,
        spawnProp = true,          -- static gavel on the judge's desk at coords
        prop      = `prop_cs_gavel`, -- desk prop only; a missing model spawns nothing (no claw hammer)
        -- No strike animation. amb@world_human_hammering is a worker nailing wood
        -- (claw hammer in hand + three loud hits). The strike is the gavel sound only.
        range     = 22.0,          -- hearing distance (m)
        command   = 'gavel',       -- /gavel for judges ('' = disabled). Also: target eye + NUI button
        -- Sound: 'nui' = real gavel sound (web/dist/gavel.wav) with distance fall-off
        --        'native' = GTA sound (soundName / soundSet below)
        sound     = 'nui',
        volume    = 0.9,           -- 0.0 - 1.0 (nui only)
        knocks    = 3,             -- strikes per use (1-5)
        gapMs     = 330,           -- ms between strikes
        soundName = 'PICK_UP',
        soundSet  = 'HUD_FRONTEND_DEFAULT_SOUNDSET',
    },
    projectorRoles = {
        'judge', 'supreme_court', 'prosecutor',
        'defense_attorney', 'public_defender', 'police',
    },
    -- Projector only loads these hosts (youtube/slides/discord/img). Add your CCTV/camera host or IP.
    allowedHosts = {
        'youtube.com',
        'youtu.be',
        'docs.google.com',
        'drive.google.com',
        'imgur.com',
        'i.imgur.com',
        'discord.com',
        'cdn.discordapp.com',
        'media.discordapp.net',
        'ibb.co',
        'i.ibb.co',
    },
}

-- ============================================================
--  PERMISSIONS
-- ============================================================

Config.Permissions = {
    supreme_court     = 'group.supreme_court',
    judge             = 'group.judge',
    district_attorney = 'group.da',
    defense_attorney  = 'group.defense',
    public_defender   = 'group.pubdef',
    policeJob         = 'police',
    policeMinGrade    = 2,
}

-- ============================================================
--  BILLING — peleg-billing (optional)
--  Filing amounts live in Config.Fees above. This block is only
--  for the optional peleg-billing invoice issuer, not a second price list.
-- ============================================================

Config.Billing = {
    useBank = true,
    issuerJob = 'police',
}

-- ============================================================
--  PHONE — multi-phone bridge (optional)
-- ============================================================

Config.Phone = {
    -- auto | lb-phone | qs-smartphone | yseries | 17mov | gksphone | npwd | qb-phone
    provider = 'auto',
    dojNumber = 'DOJ-SYSTEM',
    senderName = 'Department of Justice',
    appIcon = nil,                -- nil = built-in DOJ icon (works with any resource folder name)
    appColor = '#1a1a2e',
    enableSMS = true,
    enableNotify = true,
}

-- ============================================================
--  MDT — police MDT bridge (optional)
--  auto | ps-mdt | tk_mdt | advanced | none
--  See Install/MDT.md for exports + hook examples
-- ============================================================

Config.MDT = {
    enabled  = true,
    -- auto priority: tk_mdt → ps-mdt
    -- 'advanced' is NEVER auto-detected — set provider = 'advanced' + resourceName
    provider = 'auto',  -- 'auto' | 'tk_mdt' | 'ps-mdt' | 'advanced' | 'none'
    -- Required when provider = 'advanced' (exact folder name from Keymaster)
    resourceName = nil,  -- e.g. 'p_mdt'
    -- Resources allowed to call IssueFine / CreateFormProgrammatically (SUD-004)
    -- Do NOT add a generic 'mdt' name — anyone can name a resource that.
    trustedInvokers = {
        'ps-mdt',
        'tk_mdt',
    },
    -- Push court events into the linked MDT
    syncWarrants    = true,
    syncCases       = true,
    syncVerdicts    = true,
    syncCommitments = true,
}

-- ============================================================
--  DISCORD WEBHOOKS (panel / system event logs — TEXT embeds)
--
--  Prefer server.secrets.cfg / server.cfg convars (see Install/server_cfg_discord.cfg):
--    set nevera_court_log_cases    "https://discord.com/api/webhooks/..."
--    set nevera_court_log_warrants "..."
--    … same for bail, fines, verdicts, admin, audit
--
--  Leave these empty for buyers. Convars override Config.Webhooks when set.
--  A4 form screenshots (transcripts) use NEVERA_COURT_WH_* — separate layer.
-- ============================================================

Config.Webhooks = {
    cases    = '',   -- new / closed cases          → nevera_court_log_cases
    forms    = '',   -- printed / filed forms (text) → nevera_court_log_forms
    warrants = '',   -- arrest & search warrants   → nevera_court_log_warrants
    bail     = '',   -- bail events
    fines    = '',   -- monetary fines
    verdicts = '',   -- judgments
    admin    = '',   -- admin actions
    audit    = '',   -- audit log
    judicial = '',   -- judicial police: transport + protection requests → nevera_court_log_judicial
}

-- ============================================================
--  PRISON — hard-RP commitment order + jail handoff
-- ============================================================
-- Flow when commitmentOrder = true (recommended for hard RP):
--   1) Judge enters Guilty + prison minutes
--   2) Court creates a Commitment Order (pending) — NO instant jail
--   3) Custody / judicial police / DOC jobs get notified
--   4) They escort the inmate (RP), then Execute the order
--   5) Only then Config.Prison.provider jails the player
-- Set commitmentOrder = false to restore instant jail on verdict.

Config.Prison = {
    -- auto | qb-prison | rcore_prison | pickle_prisons | custom | none
    provider = 'auto',
    -- Used by UI when converting NKZ months → suggested prison minutes
    minutesPerMonth = 60,

    -- Hard RP: create commitment order instead of teleporting on verdict
    commitmentOrder = true,

    -- Framework jobs allowed to EXECUTE a commitment order (intake → prison)
    -- Add your judicial police / DOC / corrections job names here.
    executeJobs = {
        'police',
        'sheriff',
        'bcso',
        'sasp',
        'lspd',
        'correctional',
        'doc',
        'judicial_police',
    },
    executeMinGrade = 0,

    -- Also allow anyone with DOJ police role in doj_roles
    allowPoliceRole = true,

    -- Executor must be near the defendant to execute (anti-remote jail)
    requireNearby = true,
    nearbyDistance = 5.0,

    -- Optional intake zone at the state prison gate (ox_target or qb-target)
    intakeZone = {
        enabled  = true,
        coords   = vector3(1845.0, 2585.0, 45.0), -- Bolingbroke / adjust to your MLO
        size     = vector3(4.0, 4.0, 3.0),
        rotation = 0.0,
        label    = 'Execute Commitment Order',
    },

    -- How custody / police get the order when it is issued
    notify = {
        oxLib    = true,   -- red ox_lib popup for online executeJobs
        phoneSMS = true,   -- phone notification via Config.Phone bridge
        -- Dispatch alert (soft): auto | ps-dispatch | cd_dispatch | qs-dispatch | custom | none
        dispatch = 'auto',
        -- Jobs shown on dispatch (defaults to executeJobs if empty)
        dispatchJobs = {},
        -- custom dispatch: TriggerEvent(serverEvent, payload)
        customDispatchEvent = '',
    },

    -- custom: set event names if provider = 'custom'
    custom = {
        -- TriggerClientEvent(event, src, minutes)
        clientEvent = 'prison:client:Enter',
        -- TriggerEvent / TriggerServerEvent (server-side) — leave empty to skip
        serverEvent = '',
    },
}

-- ============================================================
--  JUDICIAL POLICE — court protection (optional, high-risk only)
--  + prisoner transport orders (prison -> hearing)
-- ============================================================
-- Real-world split (not "judge calls PP for every trial"):
--   A) Standing duty (24/7 court security + entrance control) = the
--      judicial_police job itself, on duty near the court. No request here.
--   B) prisoner_transport — judge requests an inmate be escorted from
--      prison to a hearing at a set time. Main feature of this block.
--   C) court_protection — OPTIONAL reinforcement request for a
--      high-risk trial. NOT created automatically per hearing.
-- Flow: request -> alarm to COMMAND roles -> command "Acknowledges" ->
--       command "Assigns" one or more officers -> officer "Completes".

Config.JudicialPolice = {
    enabled = true,

    -- ⚠ SET YOUR OWN POLICE JOB NAMES. `job` must match the job name in your framework
    -- exactly (QBCore shared/jobs.lua, Qbox qbx_core/shared/jobs.lua, ESX `jobs` table).
    -- commandMinGrade = from this grade up a player gets the alarm and can claim / assign;
    --                   lower grades can only be assigned to a request.
    -- highRiskOnly    = only alerted when the judge ticks "High risk" (e.g. SWAT).
    -- Remove the ones your server doesn't have, add as many as you need.
    units = {
        { job = 'police',  label = 'LSPD', commandMinGrade = 3 },
        { job = 'sheriff', label = 'BCSO', commandMinGrade = 3 },
        -- { job = 'judicial', label = 'Judicial Police', commandMinGrade = 3 },
        -- { job = 'swat',     label = 'SWAT',            commandMinGrade = 3, highRiskOnly = true },
    },

    -- Who gets which request type. `first` = alarmed immediately.
    -- `fallback` = alarmed if nobody from `first` is online/on duty, or nobody
    -- claimed within fallbackAfterSec. The judge can still change the ticks in the form.
    -- Tip: with a dedicated judicial police job put it in `first` for the court / transport types
    --      and your regular police in `fallback`.
    routing = {
        court_protection       = { first = { 'police' }, fallback = { 'sheriff' }, fallbackAfterSec = 120 },
        transport_to_court     = { first = { 'police' }, fallback = { 'sheriff' }, fallbackAfterSec = 120 },
        transport_to_jail      = { first = { 'police' }, fallback = { 'sheriff' }, fallbackAfterSec = 120 },
        arrest                 = { first = { 'police', 'sheriff' } },
        house_arrest_violation = { first = { 'police', 'sheriff' } },
    },

    onlyOnDuty = true,  -- alarm only players whose framework duty is on (same duty as the job / F6)

    -- Legacy (only used when `units` above is missing or empty):
    -- commandJobs = { 'police', 'sheriff' }, commandMinGrade = 3,
    -- assignableJobs = { 'police', 'sheriff' },

    -- Repeating alarm (sound/banner) until a command role claims the request
    alarmIntervalMs  = 15000,
    alarmMaxRepeats  = 0,    -- 0 = forever until claimed
    -- `repeat` is a Lua keyword, so the key is written in brackets.
    alarmSound = { set = 'HUD_MINI_GAME_SOUNDSET', name = 'TIMER_STOP', ['repeat'] = 3 },

    -- Named places the court can pick in the request form ("My current location" is always offered too).
    -- Transport routes use `court` and `prison`. ⚠ Set your own coords (stand at the entrance, copy x/y/z).
    -- You can add more, e.g. court2 = { label = 'Courtroom 2', coords = vector3(...) }.
    locations = {
        court  = { label = 'Courtroom 1',        coords = vector3(234.89, -1309.04, 29.22) },
        prison = { label = 'Bolingbroke Prison', coords = vector3(1856.12, 2608.04, 45.19) },
    },

    -- Blip + GPS line for the officer who claims or is assigned.
    route = { enabled = true, sprite = 526, colour = 47, arriveDistance = 30.0 },

    -- Pending or acknowledged requests older than this become expired.
    -- 0 = leave them. Assigned requests are not expired.
    expireAfterHours = 6,

    -- When the request must be scheduled. immediate types hide the time field
    -- and are stored as "now". required types must be at least minHoursAhead.
    schedule = {
        court_protection       = { required = true,  minHoursAhead = 2 },
        transport_to_court     = { required = true,  minHoursAhead = 2 },
        transport_to_jail      = { required = false, immediate = true, label = 'after_verdict' },
        arrest                 = { required = false, immediate = true },
        house_arrest_violation = { required = false, immediate = true },
    },

    -- /command to toggle "on duty" (standing duty, part A above) — phone app can call the same export
    dutyToggleCommand = 'jpduty',

    -- Optional target point at the court entrance to toggle duty in-world
    -- (same ox_target/qb-target bridge as the rest of Court).
    dutyZone = {
        enabled = true,
        coords  = vector3(234.89, -1309.04, 29.22), -- move to your court entrance
        radius  = 1.5,
    },

    -- Walk-through metal detectors (needs detector arches in your MLO or your own props).
    -- Stand in the middle of each arch and copy the coords into `gates`.
    -- On-duty jobs in exemptJobs pass silently. Anyone else carrying a weapon sets off the
    -- beep (heard within hearDistance) and on-duty exemptJobs players get a notification.
    gate = {
        enabled = false,
        radius = 1.15,
        hearDistance = 25.0,
        cooldownSec = 8,
        exemptOnDuty = true,
        exemptJobs = { 'police', 'sheriff' },
        sound = { name = 'Beep_Red', set = 'DLC_HEIST_HACKING_SNAKE_SOUNDS', repeats = 5 },
        gates = {
            -- { coords = vector3(0.0, 0.0, 0.0), label = 'Main entrance' },
        },
    },

    -- Completion note is NEVER hard-required (matches existing warrant/commitment notes) —
    -- only soft-recommended in the UI for the type(s) below.
    noteRecommended = {
        transport_to_court = true,
        transport_to_jail  = true,
        court_protection   = false,
    },

    -- Same notify bridge pattern as Config.Prison.notify
    notify = {
        oxLib    = true,
        phoneSMS = true,
        dispatch = 'auto',  -- auto | ps-dispatch | cd_dispatch | qs-dispatch | custom | none
        dispatchJobs = {},
        customDispatchEvent = '',
    },
}

-- ============================================================
--  JURY
-- ============================================================

Config.Jury = {
    minJurors = 6,
    maxJurors = 12,
    selectionMethod = 'random',  -- 'random' | 'manual'
}

-- ============================================================
--  UI — NUI PANEL
-- ============================================================

Config.UI = {
    openKey        = 'F5',
    closeKeys      = { 'Escape', 'F5' },
    notifyDuration = 6000,
    blink          = true, -- taskbar badge pulse; set false to keep a steady badge
    tablePageSize  = 15,
    pageSize       = 20,

    -- Everyone picks their own look by default (theme/density/language);
    -- admin can lock it server-wide. Same pattern as a theme.locked option
    -- in off-the-shelf inventory NUIs.
    theme = {
        default = '',      -- '' = built-in default look
        locked  = false,    -- true = players can't change it themselves
    },
}

-- ============================================================
--  FORMS — anti-fraud: require a Discord transcript on print
--  (sv_printer.lua rejects the save if the screenshot never
--  reached Discord — no more "original" lost to lag/bug/closed window)
-- ============================================================
Config.Forms = {
    -- true = printing is REJECTED unless the A4 screenshot reached Discord
    --        (needs nevera_court_imgbb_key + nevera_court_wh_* convars, see Install/server_cfg_discord.cfg)
    -- false = screenshots are optional (recommended until Discord/ImgBB is set up)
    requireTranscript = false,
    -- Form types exempt from the requirement (e.g. internal drafts you add here)
    transcriptExempt = {},
}

-- ============================================================
--  OFFICIAL COURT SEAL (2D on printed A4 — baked into html_content)
--  Only court staff roles. Citizens cannot add/edit the seal.
-- ============================================================
Config.Seal = {
    Enabled = true,
    -- Roles that imprint the official seal when printing
    Roles = {
        judge = true,
        clerk = true,
        supreme_court = true,
    },
    -- Show VALJAN/LAŽAN notify when opening a sealed document (Use)
    NotifyOnOpen = true,
}

-- ============================================================
--  ECONOMY
-- ============================================================

Config.Economy = {
    referenceHourlyRate = 950,
    misdemeanorMaxHours = 4,
    felonyMaxHours = 20,
    rookiePlaytimeThreshold = 35,
    rookieFineMultiplier    = 0.7,
    civilDamagesMin = 1000,
    civilDamagesMax = 500000,
}

-- ============================================================
--  ARCHIVE
-- ============================================================

-- HOW THE ARCHIVE WORKS (server owners — set this up before going live):
--   1) Locations = the physical spots on YOUR map where players open the archive
--      (City Hall, police station, hospital, law office …). Stand there in-game,
--      copy the coords and add one row per spot. Rows left at 0,0,0 are ignored.
--   2) Passwords = one password per DOJ role. CHANGE ALL DEFAULTS and give each
--      organisation only its own password (police → police, judges → judge …).
--   3) Every role has its own shared stash (doj_archive_police, doj_archive_judge …).
--      Citizens all use the same `citizen` password, but each citizen opens a
--      PERSONAL stash (doj_archive_<citizenid>) — nobody sees anyone else's papers.
--   4) Any player can use ANY archive point with their own role password.
Config.Archive = {
    -- Password per role (keys must match Enums.Roles). CHANGE THESE before going live.
    Passwords = {
        citizen            = 'citizen123',
        police             = 'police123',
        defense_attorney   = 'defense123',
        public_defender    = 'defender123',
        prosecutor         = 'prosecutor123',
        clerk              = 'clerk123',
        judge              = 'judge123',
        supreme_court      = 'supreme123',
    },
    -- true  = each role opens doj_archive_<role> (citizen = personal doj_archive_<citizenid>)
    -- false = all staff share StashId; citizen still gets a personal stash
    UseRoleStashes = true,
    AllowedItems = { 'document_a4' },
    StashSize = { slots = 50, weight = 100000 },
    StashId = 'doj_archive_main',
    Locations = {
        -- Physical ox_target points only (not separate stash DBs).
        -- Example: 2× City Hall, 1× police, 1× hospital — any player uses THEIR role password at ANY point.
        { label = 'Location 1', coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
        { label = 'Location 2', coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
        { label = 'Location 3', coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
        { label = 'Location 4', coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
        { label = 'Location 5', coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
    },
}

-- ============================================================
--  COURT SERVICES — ox_lib menus
--  Open: /court (Config.Extras.command), DOJ main menu → "Court services",
--        or the eye on Config.Courthouse.mainZone. SQL: Install/sql/nevera_court.sql
-- ============================================================

Config.Extras = {
    command = 'court',      -- '' = no command
    target  = true,         -- "Court services" eye option at Config.Courthouse.mainZone
}

-- Bar exam / professional licences
Config.Exams = {
    enabled       = true,
    cooldownHours = 24,     -- wait time after a failed attempt
    types = {
        attorney = {
            label           = 'Bar Exam — Attorney at Law',
            fee             = 2500,             -- charged from bank when the exam starts (0 = free) → DOJ treasury
            passScore       = 80,               -- % of correct answers needed
            requireApproval = true,             -- judge / Supreme Court approves before the licence is active
            grantRole       = 'defense_attorney', -- DOJ role given on approval (nil = licence only)
            questions = {
                { q = 'Who carries the burden of proof in a criminal trial?', options = { 'The defendant', 'The prosecution', 'The judge', 'The jury' }, answer = 2 },
                { q = 'What is the standard of proof in a criminal case?', options = { 'Preponderance of the evidence', 'Probable cause', 'Beyond a reasonable doubt', 'Reasonable suspicion' }, answer = 3 },
                { q = 'What must a judge find before issuing a search warrant?', options = { 'Probable cause', 'A confession', 'A prior conviction', 'Reasonable doubt' }, answer = 1 },
                { q = 'What does "habeas corpus" protect against?', options = { 'Double taxation', 'Unlawful detention', 'Defamation', 'Breach of contract' }, answer = 2 },
                { q = 'A defendant may not be tried twice for the same offence. This is called…', options = { 'Contempt', 'Double jeopardy', 'Discovery', 'Voir dire' }, answer = 2 },
                { q = 'What is "voir dire"?', options = { 'Closing argument', 'Jury selection questioning', 'An appeal', 'A plea deal' }, answer = 2 },
                { q = 'A plea deal must finally be approved by…', options = { 'The police', 'The defense attorney', 'The judge', 'The jury' }, answer = 3 },
                { q = 'What is the standard of proof in a civil case?', options = { 'Beyond a reasonable doubt', 'Preponderance of the evidence', 'Probable cause', 'Clear suspicion' }, answer = 2 },
                { q = 'Attorney–client communications are generally…', options = { 'Public record', 'Privileged', 'Sent to the court', 'Recorded by police' }, answer = 2 },
                { q = 'Which court decides an appeal of a district court verdict here?', options = { 'Traffic court', 'The Supreme Court', 'The police', 'City hall' }, answer = 2 },
            },
        },
        -- Add more: judge = { label = 'Judicial Exam', grantRole = 'judge', ... }
    },
}

-- Citizens request appointments with attorneys
Config.Appointments = {
    enabled     = true,
    lawyerRoles = { 'defense_attorney', 'public_defender' },
}

-- DOJ treasury: fines, filing fees, exam fees, expungement fees and forfeited bail
Config.Treasury = {
    enabled  = true,
    -- Also push money into a society / business account:
    -- 'none' | 'auto' | 'qb-banking' | 'qb-management' | 'Renewed-Banking' | 'okokBanking' | 'esx_addonaccount'
    provider = 'none',
    account  = 'doj',                 -- society / job account name (ESX: 'society_doj')
    viewRoles     = { 'judge', 'supreme_court', 'clerk' },
    withdrawRoles = { 'supreme_court' },  -- withdraw → own bank, always logged
}

-- Appeals to the Supreme Court
Config.Appeals = {
    enabled      = true,
    windowHours  = 72,          -- how long after the verdict an appeal can be filed
    reopenStatus = 'pre_trial', -- case status when an appeal is GRANTED (verdict is cleared)
}

-- Expungement — clear a conviction from the record (certificates, GetCriminalRecord export)
Config.Expungement = {
    enabled  = true,
    waitDays = 7,       -- days after the verdict before a request is allowed
    fee      = 1000,    -- 0 = free → DOJ treasury
}

-- Plea deals: prosecutor offers → defendant / defense accepts → judge approves (= guilty verdict with the agreed terms)
Config.PleaDeals = { enabled = true }

-- Evidence attached to a case (images / video / links / notes). URLs must match Config.Courtroom.allowedHosts.
Config.Evidence = {
    enabled  = true,
    addRoles = { 'judge', 'supreme_court', 'clerk', 'prosecutor', 'defense_attorney', 'public_defender', 'police' },
}

-- Courtroom session: "All rise", order, minutes (transcript)
Config.CourtSession = {
    enabled     = true,
    radius      = 25.0,         -- players inside this radius of the judge get "All rise" etc.
    captureChat = true,         -- log chat messages said inside the radius into the minutes (default chat resource)
    webhook     = 'verdicts',   -- Config.Webhooks channel that receives the transcript when the session ends ('' = none)
    staffRoles  = { 'judge', 'supreme_court', 'clerk' },  -- who can run the session / add minutes
}

-- Public court board (hearing schedule + recent public verdicts)
-- Shows at an eye point (and /courtboard). Put the point on a TV / notice board in your MLO.
Config.CourtBoard = {
    enabled   = true,
    command   = 'courtboard',   -- '' = no command
    locations = {
        { coords = vector3(234.89, -1311.00, 29.22), label = 'Court board' },
    },
    hearings  = 10,             -- upcoming hearings shown
    verdicts  = 10,             -- recent verdicts shown (expunged cases are hidden)
}

-- In-game penal code editor (/court → Penal code editor): change prices, prison time, texts,
-- add / deactivate articles. Saved to the database and active immediately.
Config.LawEditor = {
    enabled = true,
    roles   = { 'supreme_court' },        -- DOJ roles allowed
    ace     = 'nevera.sudstvo.admin',     -- or anyone with this ACE (txAdmin admins)
    command = 'courtlaws',                -- direct command ('' = only via /court menu)
}

-- ⚠ DATABASE EDITOR (laptop → Tools → Database) — direct access to court tables.
-- NOBODY has it by default — not even Supreme Court. YOU decide who gets it, in server.cfg:
--     add_ace qbcore.god nevera.court.db allow                 -- e.g. only server owners
--     add_ace identifier.license:xxxxxxxx nevera.court.db allow -- or one specific person
-- Give it only to people you fully trust. Every change goes to doj_db_history (Restore) and Discord.
-- The client sends a table, a column and a value — never SQL. The server allows a change only when
-- the table and the column are listed below. Anything not listed is hidden
-- (doj_counters, doj_audit_log, doj_archive, doj_laws → use Law Code → Edit).
Config.DbEditor = {
    enabled  = true,
    ace      = 'nevera.court.db',
    pageSize = 50,
    locked   = { 'id', 'case_number', 'citizenid', 'created_at', 'filed_at' },
    tables   = {
        doj_hearings       = { mode = 'edit', edit = { 'hearing_type', 'status', 'hearing_date', 'location', 'notes' }, delete = true },
        doj_bail           = { mode = 'edit', edit = { 'status', 'amount', 'bail_type', 'strike_count', 'bail_ban_until', 'forfeiture_reason' } },
        doj_warrants       = { mode = 'edit', edit = { 'status', 'expires_at', 'denial_reason', 'target_description', 'search_location' } },
        doj_roles          = { mode = 'edit', edit = { 'role', 'office', 'bar_number', 'active' }, insert = true, delete = true },
        doj_jury           = { mode = 'edit', edit = { 'status', 'case_number' }, delete = true },
        doj_pending_fines  = { mode = 'edit', edit = { 'amount', 'reason', 'paid' } },
        doj_licenses       = { mode = 'edit', edit = { 'status', 'decision_note' } },
        doj_appointments   = { mode = 'edit', edit = { 'status', 'lawyer_note', 'requested_time' } },
        doj_law_categories = { mode = 'edit', edit = { 'title', 'title_hr', 'title_de', 'title_fr', 'title_es', 'color', 'icon' } },
        doj_house_arrest   = { mode = 'edit', edit = { 'radius', 'ends_at', 'conditions' } },
        doj_cases          = { mode = 'edit', edit = { 'status', 'facts', 'prosecutor_citizenid', 'defense_attorney_citizenid', 'judge_citizenid' } },
        doj_forms = { mode = 'read' }, doj_commitment_orders = { mode = 'read' }, doj_charges = { mode = 'read' },
        doj_appeals = { mode = 'read' }, doj_expungements = { mode = 'read' }, doj_plea_deals = { mode = 'read' },
        doj_case_evidence = { mode = 'read' }, doj_court_sessions = { mode = 'read' }, doj_court_minutes = { mode = 'read' },
        doj_alt_sentences = { mode = 'read' }, doj_restraining_orders = { mode = 'read' }, doj_detention = { mode = 'read' },
        doj_judicial_requests = { mode = 'read' }, doj_exam_attempts = { mode = 'read' }, doj_treasury = { mode = 'read' },
    },
}

-- ============================================================
--  COURT PROCEDURE (Install/sql/nevera_court.sql)
-- ============================================================

-- Arraignment: judge enters the plea (guilty / not guilty / no contest).
-- Guilty / no contest → case goes straight to sentencing.
Config.Arraignment = {
    enabled = true,
    -- Public defender is assigned automatically when the defendant asks for one
    -- (or the judge / clerk assigns it). Online public defenders are preferred.
    publicDefenderRoles = { 'public_defender' },
}

-- Bench warrant: judge marks "failed to appear" → active arrest warrant, police + MDT notified
Config.BenchWarrant = {
    enabled     = true,
    forfeitBail = true,    -- paid bail of that case is forfeited to the DOJ treasury
}

-- Probation & community service (alternative sentences)
Config.AltSentences = {
    enabled = true,
    -- Probation: a new GUILTY verdict during probation revokes it automatically
    -- and the suspended prison time becomes a commitment order.
    autoRevokeOnNewConviction = true,
    -- Community service: player walks to a spot and works (progress bar) — one task each time
    community = {
        taskSeconds = 12,
        scenario    = 'WORLD_HUMAN_JANITOR',
        locations   = {   -- put these in a park / street of your map
            vector3(195.07, -933.86, 30.69),
            vector3(176.25, -950.73, 30.09),
            vector3(160.52, -985.43, 30.09),
            vector3(213.47, -952.20, 30.09),
        },
        blip = { sprite = 365, colour = 2, label = 'Community service' },
    },
}

-- Restraining orders: the restrained person is warned when inside the radius,
-- police are alerted after `graceSeconds`.
Config.RestrainingOrders = {
    enabled       = true,
    checkInterval = 5000,   -- ms (server loop, only for orders where both people are online)
    graceSeconds  = 15,     -- time to leave before it counts as a violation
    alertCooldown = 120,    -- seconds between two police alerts for the same order
    autoWarrant   = false,  -- true = every violation also creates an arrest warrant
    policeJobs    = { 'police', 'sheriff', 'bcso', 'sasp', 'lspd' },
}

-- Pre-trial detention (HUT) limits
Config.Detention = {
    enabled        = true,
    hours          = 72,    -- real hours a HUT detention lasts
    extensionHours = 72,    -- each extension
    maxExtensions  = 2,
    warnBeforeHours = 12,   -- warn judge + prosecutor before it expires
}

-- House arrest + ankle monitor (Install/sql/nevera_court.sql)
-- Judge sets the home address (his own position or the defendant's) and a radius.
-- Leaving the radius → warning → police alert (+ optional warrant / revoke).
Config.HouseArrest = {
    enabled          = true,
    defaultRadius    = 100,     -- metres around the home address
    maxDays          = 90,      -- real days
    checkInterval    = 5000,    -- ms between position checks
    graceSeconds     = 20,      -- time to get back inside before police are alerted
    alertCooldown    = 120,     -- seconds between two police alerts for the same person
    autoRevokeAfter  = 3,       -- violations before house arrest is revoked (0 = never)
    warrantOnRevoke  = true,    -- revoke / cut bracelet → active arrest warrant (HA-YYYY-####)
    policeJobs       = { 'police', 'sheriff', 'bcso', 'sasp', 'lspd' },
    onDutyOnly       = true,    -- only on-duty officers get alerts / tracking
    -- Live tracking: police see a moving blip of every person on house arrest
    liveTracking     = true,
    trackInterval    = 10000,   -- ms between tracking updates
    trackBlip        = { sprite = 280, colour = 5, outsideColour = 1, scale = 0.8 },
    command          = 'bracelets', -- police / judges: list of everyone on house arrest ('' = only via /court)
    -- Ankle monitor prop (GTA has no ankle monitor model — any small prop works, or stream your own)
    bracelet = {
        model    = `prop_ld_hdd_01`,
        fallback = `prop_cs_walkie_talkie`,
        bone     = 14201,                        -- SKEL_L_Foot
        offset   = vector3(0.02, 0.05, 0.0),
        rotation = vector3(0.0, 90.0, 0.0),
    },
    -- Cutting the bracelet (the person needs this item; it is consumed)
    cutterItem       = 'bolt_cutter',
    consumeCutter    = true,
    cutSeconds       = 8,
    homeBlip         = { sprite = 40, colour = 2, label = 'House arrest' },
    -- Circle on the live map when a sentence has no radius of its own.
    radius           = 100,
    -- Live map in the laptop. Empty = built-in radar (no map images ship with this resource).
    -- Same CRS as tk_mdt: {z}/{x}/{y}.png, no TMS flip. Zoom 2–5.
    -- Optional: URL of map tiles you are allowed to use. Examples (same layout, no calibration needed):
    --   'https://cfx-nui-tk_mdt/web/build/tiles/{z}/{x}/{y}.png'                                  -- if you own tk_mdt
    --   'https://raw.githubusercontent.com/meesvrh/GTAV-Map-Tiles/main/tiles/atlas/{z}/{x}/{y}.jpg'      -- free (atlas)
    --   'https://raw.githubusercontent.com/meesvrh/GTAV-Map-Tiles/main/tiles/satellite/{z}/{x}/{y}.jpg'  -- free (satellite)
    --   'https://viruxe.github.io/gtav-map-tiles/atlas/{z}/{x}-{y}.webp'        -- free (atlas, also satelite / grid)
    -- Third-party images, use at your own discretion. For many players, download them into your own resource.
    -- No map images ship with this resource.
    mapTiles = '',
    map              = {
        minZoom = 2,
        maxZoom = 5,
        ax = 0.02072, bx = 117.3, ay = -0.0205, by = 172.8,
    },
}

-- Contempt of court: judge punishes a person in the courtroom on the spot
Config.Contempt = {
    enabled     = true,
    radius      = 25.0,     -- players near the judge that can be selected
    maxFine     = 5000,
    maxMinutes  = 30,       -- prison minutes (direct to prison provider, no commitment order)
}
