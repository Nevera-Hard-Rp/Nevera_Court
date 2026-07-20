<div align="center">

<img src="https://nevera-rp.com/tebex/assets/nevera-court-github-banner.png" alt="Nevera Court — FiveM DOJ / Court System" width="100%">

# Nevera Court

### Department of Justice — Court & Legal Roleplay System for FiveM

[![FiveM](https://img.shields.io/badge/FiveM-cerulean-orange?style=for-the-badge)](https://fivem.net/)
[![Lua](https://img.shields.io/badge/Lua-5.4-blue?style=for-the-badge&logo=lua)](https://www.lua.org/)
[![ox_lib](https://img.shields.io/badge/ox__lib-required-2ECC71?style=for-the-badge)](https://overextended.dev/)
[![Version](https://img.shields.io/badge/version-1.0.0-informational?style=for-the-badge)](#)
[![Locale](https://img.shields.io/badge/locale-EN%20%7C%20HR%20%7C%20DE%20%7C%20FR-purple?style=for-the-badge)](#localization)
[![License](https://img.shields.io/badge/license-Proprietary-red?style=for-the-badge)](#license--support)

**Cases · Forms · Warrants · Bail · Hearings · Jury · Fines · Penal Code · Archive · MDT · Discord**

[Overview](#overview) ·
[Features](#features) ·
[Requirements](#requirements) ·
[Installation](#installation) ·
[Configuration](#configuration) ·
[Localization](#localization) ·
[Discord & webhooks](#discord--webhooks) ·
[Roles](#roles--permissions) ·
[In-game usage](#in-game-usage) ·
[Legal forms](#legal-forms) ·
[Development](#development--rebuild-nui) ·
[Exports](#exports--integration) ·
[Troubleshooting](#troubleshooting) ·
[Support](#support--community)

</div>

---

## Overview

**Nevera Court** is a full **Department of Justice (DOJ)** system for serious legal roleplay on FiveM. Police, prosecutors, defense counsel, judges, clerks, and citizens run criminal and civil procedure end-to-end inside one resource:

- Open and manage cases with auto docket numbers  
- Fill, sign, print, and archive official A4 court forms  
- Request and execute arrest / search warrants  
- Set bail, schedule hearings, run jury selection  
- Enter verdicts and issue **commitment orders** (hard RP prison handoff)  
- Calculate fines, browse the penal code (NKZ), and log actions to Discord  

Designed for **Tebex / Cfx.re Asset Escrow**: buyers edit configs, locales, bridges, SQL, and the full React NUI source while core gameplay logic can be encrypted.

| | |
|---|---|
| **Version** | `1.0.0` (`fxmanifest.lua`) |
| **Frameworks** | ESX · QBCore · Qbox · OX_Core · Standalone (`Config.Framework = 'auto'`) |
| **Inventory** | ox · qs · qb · ps · codem · tgiann · origen · ak47 (`auto`) |
| **Phone** | LB · Quasar · YSeries · 17mov · GKS · NPWD · qb-phone (`auto`) |
| **MDT** | Bridge for tk_mdt (full) · Advanced (manual) · ps-mdt (patch) · ox_mdt (events) — see `Install/MDT.md` |
| **UI** | React NUI + ox_lib menus / alerts / targets |
| **Languages** | `en` · `hr` · `de` · `fr` — **UI translation only** (`Config.Locale`) |

> **Croatian install guide:** `Install/README_HR.md`  
> **English install pack:** `Install/README.md`

---

## Features

### Case management
- Criminal & civil cases with a full status pipeline:  
  `open` → `investigation` → `pending_indictment` → `probable_cause` → `pre_hearing` → `pre_trial` → `trial` → `awaiting_verdict` → `closed` / `dismissed`
- Auto docket numbers (e.g. `CR-2026-00001`, `CV-2026-00042`)
- Parties, charges linked to the penal code, timeline & audit trail
- Verdicts: Guilty / Not Guilty / Mistrial

### Legal forms (37 A4 HTML templates)
- Fillable US-style court forms in-game (affidavits, complaints, warrants, motions, orders, subpoenas, civil filings, …)
- Role-based form access
- Legal misuse warning before print
- Print → `document_a4` inventory item (+ optional Discord screenshot via imgbb)
- Judge approve / deny / sign workflow
- Form chrome i18n: `web/dist/i18n/forms_{en,hr,de,fr}.json`

### Warrants
- Arrest (AW) & search (SW): request → judge approve / deny → police execute
- Auto-expiry timers and login warrant alerts

### Bail / bond
- Cash / surety / property · HUT (hold until trial)
- Fail-to-appear rules & bail bans
- Courthouse bail desk (`ox_target`) · forfeiture & refund

### Hearings & jury
- Bail, probable cause, pre-trial, jury / bench trial, sentencing, civil
- Hearing reminders · Discord event webhooks
- Jury pool registration · selection · voir dire (`Config.Jury`: 6–12)

### Fines & economy
- Editable `config_fines.lua` · rookie fine multiplier
- Civil damages range · pending fines on login
- Optional `peleg-billing` integration (pcall-safe)

### Penal code (NKZ)
- ~93 articles · 9 categories · LawPicker on criminal forms
- Localized display titles (`title_hr` / `title_de` / `title_fr`)
- Server exports for MDT / third-party scripts

### Prison / commitment (hard RP)
- When `Config.Prison.commitmentOrder = true`, a guilty verdict does **not** auto-jail
- Custody / DOC executes the commitment order near the inmate → prison provider handoff
- Bridges: `qb-prison` · `rcore_prison` · `pickle_prisons` · `custom` · `none`

### Document archive
- Password-protected stashes per role (`Config.Archive.Passwords`)
- Optional per-role stashes (`UseRoleStashes = true`): citizen personal stash → police / DA / defense / judge / Supreme Court stacks
- Allowed item: `document_a4` · configurable archive locations

### Admin & audit
- Role assignment (Supreme Court admin panel)
- Audit log for key DOJ actions
- Discord: system event webhooks + separate form-screenshot channels

### Framework & MDT bridges (new)
- **ESX** + QBCore + Qbox + OX_Core + Standalone (`Config.Framework = 'auto'`)
- MDT push: warrants / cases / verdicts / commitments → `Install/MDT.md`
- Honest sync levels: tk_mdt full · Advanced manual · ps-mdt patch · ox_mdt events
- `Config.MDT.trustedInvokers` for safe `IssueFine` / programmatic forms

### Localization
- One switch: `Config.Locale = 'en' | 'hr' | 'de' | 'fr'`
- Covers ox_lib UI, React panel, print warning, form chrome, and NKZ titles  
- Does **not** rename exports / API (always English)

---

## Requirements

| Resource | Required |
|----------|----------|
| [oxmysql](https://github.com/overextended/oxmysql) | **Yes** |
| [ox_lib](https://github.com/overextended/ox_lib) | **Yes** |
| Framework (**ESX** / QB / Qbox / OX) or `standalone` | **Yes** |
| Inventory (ox recommended) | **Yes** (print / archive) |
| MDT (ps-mdt / tk_mdt / ox_mdt / Advanced) | Optional — `Install/MDT.md` |
| [ox_target](https://github.com/overextended/ox_target) / qb-target | Recommended |
| Phone script | Optional |
| Prison script | Optional |
| peleg-billing | Optional |

> **OneSync** is recommended for production servers.

---

## Installation

Use the buyer pack under **`Install/`** (SQL, item snippet, Discord convars, guides).

### 1. Place the resource

```text
resources/[nevera]/Nevera_Court/
```

Use the **exact folder name** in `ensure`. Printer / NUI paths resolve with `GetCurrentResourceName()`.

### 2. Database

#### A) Brand-new install (most buyers)

```text
01 → 02 → 03 → 04
```

| Order | File | Purpose |
|-------|------|---------|
| 1 | `Install/sql/01_nevera_court.sql` | Create all tables (includes `title_hr/de/fr`) |
| 2 | `Install/sql/02_seed_laws_english.sql` | Seed NKZ (English canonical titles) |
| 3 | `Install/sql/03_seed_laws_i18n.sql` | Fill HR / DE / FR law titles |
| 4 | `Install/sql/04_first_supreme_court.sql` | First Supreme Court admin |

**Skip `sql/upgrade/`** on a fresh install.

#### B) Existing Nevera Court DB (missing `title_hr` / `title_de` / `title_fr`)

```text
upgrade/migrate_law_i18n.sql → 03_seed_laws_i18n.sql
```

If migrate errors with “column already exists”, ignore it and run **`03` only**.

#### C) Upgrade from old `nevera_sudstvo` (HR table names)

```text
upgrade/upgrade_hr_to_en.sql
→ 02 (only if doj_laws empty)
→ 03_seed_laws_i18n.sql
→ 04_first_supreme_court.sql
```

Do **not** run `01` on an old HR database.

**Verify:**

```sql
SELECT COUNT(*) AS categories FROM doj_law_categories;  -- expect 9
SELECT COUNT(*) AS laws FROM doj_laws;                  -- expect ~93
```

### 3. Inventory item (`document_a4`)

| Inventory | File |
|-----------|------|
| **ox_inventory** (QB / Qbox / ESX) | `Install/items/ox_inventory_document_a4.lua` → `ox_inventory/data/items.lua` |
| **qb-core** + qb/ps inventory | `Install/items/qbcore_document_a4.lua` → `qb-core/shared/items.lua` |
| **Legacy ESX** (`items` SQL table) | `Install/items/esx_document_a4.sql` |

**ESX + ox_inventory:** use the **ox** file only — do **not** need the ESX SQL.

Copy `Install/items/document_a4.png` → your inventory images folder  
(ox: `ox_inventory/web/images/` · qb: `qb-inventory/html/images/`).

### 4. `server.cfg`

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_target          # or your target resource
ensure ox_inventory       # or your inventory
ensure [your-framework]
ensure Nevera_Court       # exact folder name
```

Optional Discord screenshot convars — see [Discord & webhooks](#discord--webhooks) and `Install/server_cfg_discord.cfg`.

### 5. First-boot checklist

- [ ] Console shows NKZ categories **9**, laws **~93**
- [ ] `Config.Locale` set to your language
- [ ] Courthouse coords match your MLO (`Config.Courthouse`)
- [ ] Archive passwords changed (`Config.Archive.Passwords`)
- [ ] Supreme Court role assigned (`04_…sql` or Admin tab)
- [ ] Save / Print form → legal warning → `document_a4` in inventory
- [ ] Webhooks / convars filled (optional but recommended)

---

## Configuration

Primary editable file: [`config.lua`](config.lua) (escrow-open). Fine table: [`config_fines.lua`](config_fines.lua).

### Essentials

```lua
Config.Debug     = false
Config.Locale    = 'en'       -- 'en' | 'hr' | 'de' | 'fr'
Config.Currency  = '$'
Config.Framework = 'auto'     -- 'esx' | 'qb' | 'qbox' | 'ox' | 'standalone'
Config.MDT = {
    provider = 'auto',        -- tk_mdt → ps-mdt → ox_mdt (advanced = manual + resourceName)
    trustedInvokers = { 'ps-mdt', 'tk_mdt' },
}
-- MDT sync levels + ps-mdt patch: Install/MDT.md
Config.ESX = { RequireDuty = false, AdminGroups = { 'admin', 'superadmin' } }
Config.Inventory = { provider = 'auto' }
Config.Phone     = { provider = 'auto' }
```

### MDT sync levels (before you market “4 MDTs”)

| Provider | Level |
|----------|--------|
| `tk_mdt` | Full sync (exports) |
| `advanced` | Partial/Full — set `provider` + `resourceName` (no auto-guess) |
| `ps-mdt` | Events + optional patch (`Install/patches/ps-mdt_nevera_warrant.lua`) |
| `ox_mdt` | Events only (API WIP) |

### Courthouse zones

Edit `Config.Courthouse.mainZone` / `terminalZone` / `bailZone` to your map MLO.

### Prison / commitment

```lua
Config.Prison = {
    provider = 'auto',
    commitmentOrder = true,   -- hard RP (recommended)
    executeJobs = { 'police', 'doc', 'correctional', --[[ … ]] },
    requireNearby = true,
}
```

### UI

```lua
Config.UI = {
    openKey = 'F5',
    closeKeys = { 'Escape', 'F5' },
}
```

### Archive (passwords & stashes)

```lua
Config.Archive = {
    Passwords = {
        citizen          = 'citizen123',
        police           = 'police123',
        defense_attorney = 'defense123',
        public_defender  = 'defender123',
        prosecutor       = 'prosecutor123',
        clerk            = 'clerk123',
        judge            = 'judge123',
        supreme_court    = 'supreme123',
    },
    UseRoleStashes = true,   -- doj_archive_<role> for staff; personal stash for citizens
    AllowedItems   = { 'document_a4' },
    StashSize      = { slots = 50, weight = 100000 },
    StashId        = 'doj_archive_main',
    Locations      = { --[[ ox_target archive points ]] },
}
```

**Change default passwords before going live.** Wrong password = stash will not open.

### System Discord webhooks

```lua
Config.Webhooks = {
    cases = '', warrants = '', bail = '', fines = '',
    verdicts = '', admin = '', audit = '',
}
```

Form **screenshot** channels use `server.cfg` convars (below), not this table.

---

## Localization

| Code | Language | Locale file | Form strings |
|------|----------|-------------|--------------|
| `en` | English (default) | `locales/en.lua` | `forms_en.json` |
| `hr` | Croatian / Balkan | `locales/hr.lua` | `forms_hr.json` |
| `de` | German | `locales/de.lua` | `forms_de.json` |
| `fr` | French | `locales/fr.lua` | `forms_fr.json` |

### What `Config.Locale` controls

`Config.Locale` (including `hr`) is **UI translation only** — panel labels, notifies, form chrome, NKZ display titles. Public API / export names stay **English**.

| Area | Localized |
|------|-----------|
| ox_lib notifies, alerts, menus, targets | Yes |
| React panel (`OPEN_PANEL` strings) | Yes |
| Print legal warning | Yes |
| HTML form chrome (`data-i18n` + `forms_*.json`) | Yes |
| NKZ titles in DB (`title_*`) | Yes (after SQL `03`) |
| Export / event names | No (always English) |

**Add a language:** copy `locales/en.lua` → `locales/xx.lua`, register it in `fxmanifest.lua` `shared_scripts`, add `forms_xx.json`, set `Config.Locale = 'xx'`.

---

## Discord & webhooks

Two separate Discord layers:

> **New to Discord webhooks?** Official guide: [Intro to Webhooks (Discord Support)](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks)

### How to create a webhook (quick steps)

1. Open your Discord server → **Server Settings** → **Integrations** → **Webhooks** → **New Webhook** (or **Create Webhook**).
2. Name it (e.g. `Nevera Court — Cases`), pick the target **text channel**, optionally set an avatar.
3. Click **Copy Webhook URL** — it looks like `https://discord.com/api/webhooks/ID/TOKEN`.
4. Paste that URL into `Config.Webhooks` **or** the matching `set nevera_court_wh_…` line in `server.cfg` (see below).
5. Repeat for each channel you want (cases, warrants, criminal forms, etc.).

**Tips**

- You need **Manage Webhooks** permission on the server.
- Treat the URL like a password — anyone with it can post to that channel.
- Create **one webhook per channel** (or one shared channel) so logs stay organized.
- After editing `server.cfg`, restart the server (or at least `ensure Nevera_Court`).

**Form screenshots also need an imgbb API key**

1. Create a free account at [imgbb.com](https://imgbb.com/) → API → copy your key.  
2. Set `set nevera_court_imgbb_key "YOUR_KEY"` in `server.cfg`.  
   Without this key, Discord screenshot uploads for printed forms will fail.

### 1) System event webhooks — `config.lua`

Used for case / warrant / bail / fine / verdict / admin / audit logs (`Config.Webhooks`).

### 2) Form screenshot channels — `server.cfg` convars

Printed forms upload via **imgbb**, then post as Discord embeds. English-only convar names. Reference: [`Install/server_cfg_discord.cfg`](Install/server_cfg_discord.cfg).

```cfg
set nevera_court_imgbb_key "YOUR_IMGBB_API_KEY"

set nevera_court_wh_criminal "https://discord.com/api/webhooks/..."
set nevera_court_wh_verdict  "https://discord.com/api/webhooks/..."
set nevera_court_wh_fines    "https://discord.com/api/webhooks/..."
set nevera_court_wh_bail     "https://discord.com/api/webhooks/..."
set nevera_court_wh_citizen  "https://discord.com/api/webhooks/..."
set nevera_court_wh_admin    "https://discord.com/api/webhooks/..."
set nevera_court_wh_audit    "https://discord.com/api/webhooks/..."
```

| Convar | Use |
|--------|-----|
| `nevera_court_imgbb_key` | imgbb API key (required for screenshot upload) |
| `nevera_court_wh_criminal` | Criminal form screenshots |
| `nevera_court_wh_verdict` | Verdict / judgment screenshots |
| `nevera_court_wh_fines` | Fine-related screenshots |
| `nevera_court_wh_bail` | Bail / bond screenshots |
| `nevera_court_wh_citizen` | Citizen form screenshots |
| `nevera_court_wh_admin` | Admin form screenshots |
| `nevera_court_wh_audit` | Audit / general document shots |

---

## Roles & permissions

| Role | Key | Typical access |
|------|-----|----------------|
| Supreme Court | `supreme_court` | Full admin + all panels + role management |
| Judge | `judge` | Cases, warrants, bail, hearings, jury, fines, archive |
| Prosecutor / DA | `prosecutor` | Cases, forms, warrants, hearings |
| Defense attorney | `defense_attorney` | Cases, defense forms, hearings |
| Public defender | `public_defender` | Same as defense |
| Police | `police` | Affidavit, warrant requests, pre-filing |
| Clerk | `clerk` | Forms / hearings support |
| Citizen | `citizen` | Limited forms, jury register, personal archive (default) |

Assignable DB roles (new install): `supreme_court`, `judge`, `prosecutor`, `defense_attorney`, `public_defender`, `police`.

**First admin:** edit and run `Install/sql/04_first_supreme_court.sql` with your **citizenid**, or assign via the Admin tab in-game.

Optional ACE / group mappings: `Config.Permissions`.

Archive access also requires the correct password for that role in `Config.Archive.Passwords`.

---

## In-game usage

### Opening the panel

| Method | Description |
|--------|-------------|
| Keybind | `Config.UI.openKey` (default **F5**) |
| Courthouse | `ox_target` on `Config.Courthouse` zones |
| Menus | ox_lib context / radial (where enabled) |

### Typical criminal flow

```text
Arrest / Affidavit
  → Criminal Pre-Filing / Complaint
  → Case opened (docket number)
  → Warrant request (optional) → Judge approve → Execute
  → Bail hearing / HUT
  → Motions & hearings
  → Trial / jury
  → Verdict
  → Commitment order (if Guilty + prison) → DOC / custody executes
  → Print forms → archive stacks
```

### Commands

| Command / bind | Description |
|----------------|-------------|
| **F5** (default) | Open / close DOJ panel |
| `/doj_help` | List DOJ commands |
| `/doj_jury` | Register for jury pool |
| `/doj_jury_odjava` | Unregister from jury pool |
| `/doj_commitment` | Commitment orders (custody / DOC / judges) |
| `/refreshnkz` | Reload penal code from DB (console or admin) |

### Print flow

```text
Save/Print → legal warning → Accept → copy count
  → Discord screenshot (if imgbb + webhooks set)
  → document_a4 item(s) in inventory
  → Hand to counsel / judge or place in archive stash
```

### Archive flow

1. Approach an archive location (`Config.Archive.Locations`).  
2. Enter the **password for your DOJ role**.  
3. Citizen → personal stash `doj_archive_<citizenid>`.  
4. Staff (with `UseRoleStashes = true`) → `doj_archive_<role>` (e.g. `doj_archive_judge`, `doj_archive_supreme_court`).

---

## Legal forms

Templates live in `web/dist/forms/` (source: `web/public/forms/`). Form labels / chrome use `web/dist/i18n/forms_*.json`.

### Included templates (37)

| Category | Examples |
|----------|----------|
| Criminal intake | Affidavit, Criminal Complaint, Criminal Pre-Filing |
| Warrants | Request Arrest Warrant, Arrest Warrant, Request Search & Seizure, Search Warrant |
| Bail / bond | Bail Agreement, Bond Order |
| Motions | Motion to Dismiss, Contempt, Pre-Trial Conference, Reconsider, Enlargement of Time, Response to Motion |
| Orders / notices | Notice of Hearing, Supreme Court Order, various court orders |
| Process | Subpoena (testify / duces tecum), Proof of Service, Appearance of Counsel, Substitution of Attorney |
| Civil / citizen | Civil Complaint, Civil Judgment, Answer to Complaint, Name Change Request |

Exact filenames are under `web/public/forms/`. Access is gated by `Enums.FormsByRole` (role → allowed form types).

---

## Project structure

```text
Nevera_Court/
├── Install/                      # Buyer pack
│   ├── README.md / README_HR.md
│   ├── MDT.md
│   ├── patches/ps-mdt_nevera_warrant.lua
│   ├── server_cfg_discord.cfg
│   ├── items/                    # ox + qb-core + legacy ESX item
│   └── sql/
│       ├── 01 … 04               # fresh install
│       └── upgrade/              # HR→EN, i18n migrate, ESX ID length
├── bridge/
│   ├── framework/                # qb · qbox · esx · ox · standalone
│   ├── mdt/                      # ps · tk · ox · advanced
│   ├── inventory/ · phone/
│   └── registry.lua · resolve.lua
├── client/ · server/ · shared/ · locales/
├── web/src · web/public · web/dist
├── config.lua · config_fines.lua
└── fxmanifest.lua
```

### Escrow — editable files

Typically open (`escrow_ignore`):

- `config.lua` · `config_fines.lua`
- `locales/**`
- `bridge/**`
- `sql/**` · `Install/**`
- `web/**` (full NUI source + rebuild)

Encrypted on release: core `server/` + `client/` logic (except files left open by the author).

---

## Development — rebuild NUI

If you change React UI or forms source:

```bash
cd web
npm install
npm run build
```

Requirements: **Node.js** (LTS) on the machine that builds. Upload the new `web/dist/` to the server and `ensure` the resource.

Form HTML / i18n can also be edited under `web/public/` then rebuilt so `web/dist/` stays in sync.

---

## Exports & integration

Useful for MDT and other resources. **Resource name in `exports['…']` must match the folder name.**

Primary export names are **English**. Croatian names are legacy aliases. `Config.Locale` does not rename exports.

| Export | Module |
|--------|--------|
| `MDT_GetProvider` / `MDT_IsFelon` / `MDT_HasWarrant` / `MDT_NotifyWarrant` / `MDT_NotifyCase` / `MDT_NotifyVerdict` / `MDT_CreateIncident` | MDT bridge (`Install/MDT.md`) |
| `GetLaws` / `GetLaw` / `GetCategories` | Laws |
| `GetCase` / `GetActiveCasesForCitizen` | Cases |
| `HasActiveWarrant` / `GetActiveWarrants` | Warrants |
| `HasActiveBail` / `GetBailForCase` | Bail |
| `IssueFine` / `GetPendingFines` | Fines |
| `GetPlayerRoles` / `HasRole` | Roles |
| `CreateCommitmentOrder` / `CanExecuteCommitment` | Prison |
| `GetJury` / `CountAvailableJurors` | Jury |
| `GetHearingsForCase` / `GetNextHearing` | Hearings |
| `GetFormById` / `GetFormsForCase` / `CreateFormProgrammatically` | Forms |

**Legacy HR aliases** (same functions): `GetZakoni` → `GetLaws`, `GetZakon` → `GetLaw`, `GetKategorije` → `GetCategories`, `GetFormaById` → `GetFormById`. Prefer English in new code.

```lua
local laws = exports['Nevera_Court']:GetLaws()
local law  = exports['Nevera_Court']:GetLaw('NKZ-304')
local cats = exports['Nevera_Court']:GetCategories()
```

Events & NUI callbacks use English names (`nevera_court:…`, `getCases`, `printForm`, …).

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Resource won’t start | Check `oxmysql` + `ox_lib`; read console for bridge / `Enums` errors |
| NKZ shows 0 laws | Run `02_seed_laws_english.sql`; confirm table `doj_laws` |
| Laws still English on HR/DE/FR | Run `03_seed_laws_i18n.sql` (and `upgrade/migrate_law_i18n.sql` if columns missing); set `Config.Locale`; restart |
| Panel / tabs still English | Upload `locales/` + rebuilt `web/dist/`; `ensure` resource |
| Save / Print error | Add `document_a4` + PNG; check inventory bridge / `[sv_printer]` |
| Archive won’t open | Check role + `Config.Archive.Passwords` for that role |
| Path / resource name issues | Printer uses `GetCurrentResourceName()` — folder name must match `ensure` |
| No Admin tab | Assign `supreme_court` via SQL `04` or another Supreme Court admin |
| Discord screenshots fail | Set `nevera_court_imgbb_key` + channel webhooks |
| migrate i18n “duplicate column” | Columns already exist — run `03_seed_laws_i18n.sql` only |

---

## Support & community

Buyers should use **Discord** and **Tebex**. That is the standard setup for escrow FiveM products and is enough for install help, bugs, and re-downloads.

| Channel | Use for |
|---------|---------|
| **Discord** | Install help, bugs, feature requests, RP questions |
| **Tebex** | Purchase, invoices, license, re-download |

Replace placeholders before you publish:

- Discord: https://discord.gg/FgWHt4j8Qu
- Store: `https://YOUR_STORE.tebex.io/` *(replace when Tebex is live)*
- Docs: `Install/README.md` (in the purchase pack)

### When opening a support ticket, include

1. Resource version (`fxmanifest.lua` → `version`)  
2. Framework + inventory + phone  
3. `Config.Locale`  
4. Server console excerpt (`[nevera_court]`, `[sv_printer]`, `[DISCORD]`, `[sv_archive]`)  
5. Clear steps to reproduce  

We do **not** support modified escrow binaries, leaked copies, or “fix it for me” tickets without logs.

### Optional: GitHub Issues / Discussions

Enabled on the public docs/support repo if you want them:

| Channel | Use for |
|---------|---------|
| **GitHub Issues** | Reproducible bugs (logs + steps) |
| **GitHub Discussions** | Ideas, RP workflows, translations |

Primary buyer support remains **Discord + Tebex**.

---

## Roadmap (optional)

Planned / possible follow-ups (not a commitment — update before each release):

- [ ] Extra locales beyond EN / HR / DE / FR  
- [ ] More inventory / phone edge-case bridges  
- [ ] Expanded civil procedure templates  
- [ ] Live ESX Legacy end-to-end QA checklist in docs  
- [ ] Public docs site (optional)  

---

## License & support

**Proprietary — Nevera Dev Team.**

Purchase grants a license for **your** FiveM server(s) under Tebex / Cfx.re Asset Escrow terms. Redistribution, resale, or leaking escrow source is prohibited.

© Nevera Dev Team — All rights reserved.

---

<div align="center">

**Nevera Court** `v1.0.0` · Built for serious DOJ roleplay

[Discord](https://discord.gg/FgWHt4j8Qu) · Tebex · `Install/`

</div>
