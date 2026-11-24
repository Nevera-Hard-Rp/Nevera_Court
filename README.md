<div align="center">

<img src="https://i.imgur.com/7WqUGwg.png" alt="Nevera Court — FiveM DOJ / Court System" width="100%">

# Nevera Court

### Department of Justice — Court & Legal Roleplay System for FiveM

[![FiveM](https://img.shields.io/badge/FiveM-cerulean-orange?style=for-the-badge)](https://fivem.net/)
[![Lua](https://img.shields.io/badge/Lua-5.4-blue?style=for-the-badge&logo=lua)](https://www.lua.org/)
[![ox_lib](https://img.shields.io/badge/ox__lib-required-2ECC71?style=for-the-badge)](https://overextended.dev/)
[![Version](https://img.shields.io/badge/version-1.0.0-informational?style=for-the-badge)](#changelog)
[![Locale](https://img.shields.io/badge/locale-EN%20%7C%20HR%20%7C%20DE%20%7C%20FR%20%7C%20ES-purple?style=for-the-badge)](#localization)
[![License](https://img.shields.io/badge/license-Proprietary-red?style=for-the-badge)](#license--support)
[![Escrow](https://img.shields.io/badge/Cfx.re-Asset%20Escrow-black?style=for-the-badge)](#escrow--editable-files)

**Cases · Forms · Warrants · Bail · Hearings · Jury · Fines · Penal Code · House Arrest · Archive · MDT · Discord**

🎥 **Video — coming soon**

🔒 **Protected with Cfx.re Asset Escrow** — config, locales, bridges, hooks, NUI & forms stay open

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
[Editing the UI](#editing-the-ui) ·
[Exports](#exports--integration) ·
[Troubleshooting](#troubleshooting) ·
[Support](#support--community) ·
[Changelog](#changelog)

</div>

---

## Changelog

### 1.0.0 — Initial release

**Core court**
- Full DOJ panel: cases, 37 A4 forms × 5 languages, warrants, bail, hearings, jury, fines, penal code, archive
- Hard-RP verdict flow: guilty verdict → commitment order → custody / DOC executes at prison intake
- Official court seal, Discord logs + court transcripts (optional, `Config.Forms.requireTranscript`)
- Framework bridges: ESX / QBCore / Qbox / standalone + multi inventory / phone / MDT / prison
- `ox_target` or `qb-target`; courtroom wall screen (no TV prop; YouTube, images and links); gavel with real sound heard by everyone near the judge (`/gavel`)
- One money symbol everywhere (`Config.Currency`) and your own server name (`Config.Branding`) in UI, seal, logs and all A4 forms
- **In-game penal code editor** (prices, prison, texts in 5 languages, new articles) + fine calculator table in `config_fines.lua`

**Judicial Police**
- Request types: **court protection**, **transport to court**, **transport to jail** ("right after the verdict"), **arrest** and **house-arrest violation**
- **Your own police units** (`Config.JudicialPolice.units`): job name, label, command grade, *high risk only* (e.g. SWAT) — the judge ticks which units get the call
- **Routing per request type**: `first` units are alarmed at once, `fallback` units after `fallbackAfterSec` if nobody claims (or at once if nobody from `first` is on duty)
- **Scheduling rules**: court protection / transport to court at least **2 h ahead** (configurable); arrest, house-arrest violation and transport to jail are immediate
- Repeating alarm (sound + banner + SMS + dispatch) only for **on-duty** command grades until someone **claims** it; going on duty later still delivers pending alarms
- **GPS route** on the minimap for the officer who claims / is assigned (court ↔ prison for transports, live position for arrests); removed on complete / cancel
- Location from config (`locations`) or **"My current location"** of the judge; requests not claimed in `expireAfterHours` expire
- **Taskbar badge** 🚨 *Judicial Police N* on the laptop desktop — blinks while something is pending, one click opens the right request
- **Walk-through metal detectors** at the courthouse (`gate`) — beep for anyone carrying a weapon, on-duty officers pass and get notified
- `/jpduty` (or the courthouse-entrance target) toggles duty — the same framework duty as the job

**Court services** (ox_lib menus: `/court`, DOJ menu → *Court services*, case menu → *Case tools*, courthouse eye)
- **Bar exam & licences** — multiple-choice exam, fee, cooldown, judge approval, automatic DOJ role + bar number, revoke
- **Attorney appointments** — citizens request a time with a licensed attorney; accept / decline / reschedule / done
- **DOJ treasury** — fines, court / exam / expungement fees and forfeited bail are logged; optional society push (qb-banking, qb-management, Renewed-Banking, okokBanking, esx_addonaccount)
- **Appeals** to the Supreme Court — granting reopens the case, clears the verdict and cancels pending commitment orders / unpaid fines
- **Expungement** — clear an old conviction; `exports['Nevera_Court']:GetCriminalRecord(citizenid)` ignores expunged cases
- **Plea deals** — prosecutor offers → defense accepts → judge approves = guilty verdict through the normal pipeline
- **Evidence per case** — images / video / links / notes, one click onto the courtroom wall screen (no TV in the room)
- **Courtroom session** — "All rise", "Be seated", "Order in the court", recess; minutes (manual + automatic + optional chat capture) sent to Discord
- **Public court board** — upcoming hearings + recent public verdicts. An eye point on a notice board + `/courtboard`. It does not spawn a TV.

**Court procedure** (each module has its own `Config.Modules` toggle)
- **Arraignment / plea** — guilty · not guilty · no contest; case moves to pre-trial or awaiting verdict
- **Right to counsel (public defender)** — if the defendant has no attorney, the state assigns a public defender to the case with one click (judge, clerk or the defendant can request it; online public defenders first); both are notified
- **Bench warrant on failure to appear** — one click: active arrest warrant (`BW-YYYY-####`), bail forfeited to treasury, police notified + MDT sync
- **Probation & community service** — suspended prison minutes, conditions, work points with scenario + progress (`/court` → *My sentences*); new guilty verdict auto-revokes probation
- **Restraining orders** — distance check every 5 s with grace time; warns the restrained person, alerts the protected one and police (blip), optional auto-warrant
- **Pre-trial detention limits** — HUT starts a detention clock; judge extends / releases, warnings before expiry, verdict closes it
- **Contempt of court** — judge picks a nearby player: on-the-spot fine and/or prison minutes, written to the minutes
- **House arrest + ankle monitor** — judge sets the home address + radius; visible bracelet on the leg, optional live police tracking, alert when the person leaves the zone, auto-revoke after X violations, bolt cutter to cut it (police alerted + warrant)

**Court laptop (new UI)**
- F5 opens a **court laptop**: a desktop with folders for every module (Cases, Forms, Requests, Judicial Police, Warrants, Bail / Bond, Hearings, Jury, Fines, Law Code) and tools (House arrest, Database, Admin — roles + audit log)
- Own dark dropdowns, date fields in `dd.mm.yyyy HH:mm` (per language), no game keys while typing (chat `T` etc. stay closed)
- Every module opens in its own **window** — back button + **ESC** (closes a dialog → goes back → closes the laptop), minimize to the taskbar, size slider + **Letters** slider (80–125 % text size, remembered per player; frame and keyboard stay the same)
- **Taskbar:** open windows, **Help**, **Gavel** (judges), your court role and the clock · **Today in court** card on the desktop
- **Help** window: one card per command — click it to open the right window; you only see what your role allows
- Commands still work and open the laptop straight on their window (`/courtlaws`, `/bracelets`, `/courtboard`, …)
- **Admin → Role Management:** add players (online search or CitizenID), remove roles, ACE admins shown with an **ACE** tag — ESX / QB / Qbox / standalone
- **Audit log with Rockstar license** of whoever did the action; Judicial Police requests store the license of the officer who claims them
- **Penal code editor inside the laptop** (Law Code → Edit) — prices, prison time, texts in 5 languages, **activate / deactivate** articles (inactive ones stay in old cases but can't be charged)
- **House arrest window:** list + **live map** with the home zone, the person's position and status colour (in zone / grace / breach / offline); built-in radar when no map tiles are set
- **Database editor** (Tools → Database) — whitelisted court tables only, locked key columns, history + Restore; **nobody has it until you grant the ACE `nevera.court.db`**

**Editions & customization**
- `Config.Edition = 'full' | 'lite'` — Lite keeps only the core court; every module can be switched on/off in `Config.Modules`
- Escrow-open: `config.lua`, `config_fines.lua`, `locales/`, `bridge/`, `web/`, `Install/` and **`editable/`** hooks to plug in your own scripts
- Performance: server role cache and batched cron queries; client idle ≈ 0.00 ms

Docs: [Nevera Docs — Court](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/overview) · Support: [discord.gg/MUw2uR5MZ6](https://discord.gg/MUw2uR5MZ6)

---

## Overview

**Nevera Court** is a full **Department of Justice (DOJ)** system for serious legal roleplay on FiveM. Police, prosecutors, defense counsel, judges, clerks, and citizens run criminal and civil procedure end-to-end inside one resource:

- Open and manage cases with auto docket numbers  
- Fill, sign, print, and archive official A4 court forms  
- Request and execute arrest / search warrants  
- Set bail, schedule hearings, run jury selection  
- Enter verdicts and issue **commitment orders** (hard RP prison handoff)  
- Calculate fines, browse the penal code (NKZ), and log actions to Discord  
- Dispatch Judicial Police for prisoner transport or optional court protection, with a command-chain alarm that repeats until claimed  

Designed for **Tebex / Cfx.re Asset Escrow**: buyers edit configs, locales, bridges, SQL, and the built NUI (`web/dist` — HTML / JS / CSS + all A4 forms) while core gameplay logic is encrypted.

| | |
|---|---|
| **Version** | `1.0.0` (`fxmanifest.lua`) |
| **Frameworks** | **ESX** · QBCore · Qbox · Standalone (`Config.Framework = 'auto'`) |
| **Inventory** | ox · qs · qb · ps · codem · tgiann · origen · ak47 (`auto`) |
| **Phone** | LB · Quasar · YSeries · 17mov · GKS · NPWD · qb-phone (`auto`) |
| **MDT** | Bridge for tk_mdt (full) · Advanced (manual) · ps-mdt (patch) — see `Install/MDT.md` |
| **UI** | Court laptop — React NUI desktop with windows, taskbar and Help (+ ox_lib alerts / targets) |
| **Languages** | `en` · `hr` · `de` · `fr` · `es` — **full UI + A4 forms + NKZ titles** (`Config.Locale`) |

> **Install pack:** `Install/README.md`

---

## Features

### Case management
- Criminal & civil cases with a full status pipeline:  
  `open` → `investigation` → `pending_indictment` → `probable_cause` → `pre_hearing` → `pre_trial` → `trial` → `awaiting_verdict` → `closed` / `dismissed`
- Auto docket numbers (e.g. `CR-2026-00001`, `CV-2026-00042`)
- Parties, charges linked to the penal code, timeline & audit trail
- Verdicts: Guilty / Not Guilty / Mistrial

### Legal forms (37 A4 HTML templates × 5 languages)
- Fillable US-style court forms in-game (affidavits, complaints, warrants, motions, orders, subpoenas, civil filings, …)
- **Full HTML per language:** `web/dist/forms_{en,hr,de,fr,es}/` — edit the HTML directly, no build needed
- Role-based form access
- Legal misuse warning before print
- Print → `document_a4` inventory item (+ **Discord court transcripts** via imgbb webhook)
- Judge approve / deny / sign workflow
- Optional chrome i18n: `web/dist/i18n/forms_{en,hr,de,fr,es}.json` (`data-i18n`)

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
- **Penal code editor in-game** (`/courtlaws` or `/court` → *Penal code editor*) — change fines, prison time, severity and texts (5 languages), add / deactivate articles; saved to the database and active immediately
- **Fine calculator** table (offences + modifiers) in **`config_fines.lua`**
- **`Config.Currency = '$'` or `'€'`** (or any symbol) — UI display only
- Rookie fine multiplier · civil damages range (`Config.Economy`)
- Pending fines on login · optional `peleg-billing` (pcall-safe)

### Penal code (NKZ)
- ~93 articles · 9 categories · LawPicker on criminal forms
- Localized display titles (`title_hr` / `title_de` / `title_fr` / `title_es`) — all seeded by `nevera_court_laws.sql` on first install
- Server exports for MDT / third-party scripts

### Prison / commitment (hard RP)
- When `Config.Prison.commitmentOrder = true`, a guilty verdict does **not** auto-jail
- Custody / DOC executes the commitment order near the inmate → prison provider handoff
- Bridges: `qb-prison` · `rcore_prison` · `pickle_prisons` · `custom` · `none`

### Judicial Police (court security, transports, arrests)
- **Request types:** court protection · transport to court · transport to jail (*right after the verdict*) · arrest · house-arrest violation
- **Units are yours:** list your own police jobs in `Config.JudicialPolice.units` (any job names — LSPD, BCSO, judicial police, SWAT, …). Each unit has a `commandMinGrade`; `highRiskOnly` units (SWAT) are only called when the judge ticks **High risk**
- **Routing:** per request type `first` units are alarmed immediately; `fallback` units if nobody from `first` is on duty or nobody claims within `fallbackAfterSec`. The judge can change the ticks in the form
- **Scheduling:** court protection and transport to court need a time at least `minHoursAhead` (default 2 h) in the future — the form shows the earliest allowed time and the server checks it again. Arrest, house-arrest violation and transport to jail are immediate. A case that already has a prison sentence shows **Send transport to jail** on the verdict.
- **Alarm:** repeating sound + banner (+ phone SMS + dispatch) to on-duty command grades until one **claims** the request; it then stops for everyone. Going on duty later still delivers pending requests
- **Claim → assign → complete:** command assigns one or more officers; the court is notified at every step. Optional completion note (recommended for transports)
- **GPS:** the officer who claims / is assigned gets a blip + route on the minimap (prison → court → prison for transports; the person's live / last known position for arrests). Removed on complete or cancel
- **Locations:** named places from `Config.JudicialPolice.locations` or **My current location** (the judge's position when sending)
- **Taskbar badge:** 🚨 *Judicial Police N* appears on the laptop desktop while something is open — blinks when pending, one click opens the request
- **Expiry:** pending / claimed requests older than `expireAfterHours` become *expired*
- **Metal detectors** (`gate`): walk through an existing arch. A weapon rings it unless the player is **on duty** in an exempt job. Those officers pass quietly and get the alert. No prop is spawned. Coords stay in config only.
- Duty: `/jpduty` or the courthouse-entrance target — uses the **framework duty** of the job (same as F6)
- Separate from the regular arrest / search-warrant flow — that system is unchanged · Discord channel `nevera_court_log_judicial` · 5 languages

### Document archive
- Password-protected stashes per role (`Config.Archive.Passwords`)
- Optional per-role stashes (`UseRoleStashes = true`): citizen personal stash → police / DA / defense / judge / Supreme Court stacks
- Allowed item: `document_a4` · configurable archive locations

### Court services (`/court`, case menu → *Case tools*, courthouse eye)
- **Bar exam & licences** — multiple-choice exam, fee, cooldown, judge approval, automatic DOJ role + bar number, revoke
- **Attorney appointments** — citizens book a licensed attorney; accept / decline / reschedule / done
- **DOJ treasury** — fines, fees and forfeited bail logged; optional society push (qb-banking, qb-management, Renewed-Banking, okokBanking, esx_addonaccount)
- **Appeals** to the Supreme Court — granting reopens the case and cancels pending commitment orders / unpaid fines
- **Expungement** — clear an old conviction (ignored by `GetCriminalRecord`)
- **Plea deals** — prosecutor offers → defense accepts → judge approves = guilty verdict
- **Evidence per case** — images / video / links / notes, one click onto the wall screen. No TV prop. YouTube plays in the screen itself.
- **Courtroom session** — all rise / be seated / order / recess + minutes to Discord
- **Public court board** — upcoming hearings + recent public verdicts (`/courtboard`)

### Court procedure
- **Arraignment / plea** — guilty · not guilty · no contest
- **Right to counsel (public defender)** — if the defendant has no attorney, the state assigns a public defender to the case with one click (judge, clerk or the defendant can request it; online public defenders first); both are notified
- **Bench warrant on failure to appear** — arrest warrant `BW-YYYY-####`, bail forfeited, police + MDT notified
- **Probation & community service** — suspended prison, conditions, work points (`/court` → *My sentences*), auto-revoke on a new conviction
- **Restraining orders** — distance check with grace time, alerts to the protected person + police blip, optional auto-warrant
- **Pre-trial detention limits** — HUT starts the clock, judge extends / releases, warnings before expiry
- **Contempt of court** — on-the-spot fine and/or prison minutes for a nearby player
- **House arrest + ankle monitor** — home radius (default 100 m), bracelet prop on the leg, live police tracking blips (config switch), warning → police alert with blip → optional auto-revoke + warrant `HA-YYYY-####`, cutting the bracelet with a cutter item, automatic end after the real days, `/bracelets` list for police / judges

### Court laptop (UI)
- **F5** opens a laptop-style DOJ panel: desktop with module folders, windows, taskbar, size slider, **Letters** slider (bigger / smaller text)
- Folders you see depend on your court role — the **server** sends the list
- **Back / ESC** in every window; **Help** on the taskbar lists every command as a clickable card
- Commands open the laptop directly on their window — players don't have to memorize anything
- **Admin** folder (Supreme Court / ACE `nevera.sudstvo.admin`): DOJ roles + audit log
- **Role Management:** *Add player* — search online players (name / server id / CitizenID) or type a CitizenID, pick a role, save. *Remove role* on every row. ACE admins are listed with an **ACE** tag (read-only). Works on ESX, QBCore, Qbox and standalone
- **Penal code editor** in the laptop: activate / deactivate articles, texts in 5 languages
- **Taskbar badge** 🚨 *Judicial Police N* — blinks while a request is pending (`Config.UI.blink`)
- Typing in the laptop never reaches the game (no chat on `T`, no weapon keys)

### House arrest — live map
- List of everyone on house arrest + map with the home zone, position, distance and status colour
- `Config.HouseArrest.mapTiles` — optional URL of GTA map tiles **you are allowed to use** (e.g. from an MDT you own). **No map images ship with this resource**; empty = built-in radar
- **Track on map (GPS)** puts a real blip + waypoint in the game; End / Revoke ask for confirmation

Ready-made tile sets (same layout, the default `map` values fit them):

| Source | `mapTiles` |
|---|---|
| tk_mdt (if you own it) | `https://cfx-nui-tk_mdt/web/build/tiles/{z}/{x}/{y}.png` |
| [meesvrh/GTAV-Map-Tiles](https://github.com/meesvrh/GTAV-Map-Tiles) — atlas (free) | `https://raw.githubusercontent.com/meesvrh/GTAV-Map-Tiles/main/tiles/atlas/{z}/{x}/{y}.jpg` |
| same — satellite (free) | `https://raw.githubusercontent.com/meesvrh/GTAV-Map-Tiles/main/tiles/satellite/{z}/{x}/{y}.jpg` |
| [VIRUXE/gtav-map-tiles](https://github.com/VIRUXE/gtav-map-tiles) — atlas · satellite · grid (free, WebP) | `https://viruxe.github.io/gtav-map-tiles/atlas/{z}/{x}-{y}.webp` (or `satelite` / `grid`) |

Third-party images — use at your own discretion. On a busy server download the tiles into your own small resource (add them to its `files {}`) and use `https://cfx-nui-<your_resource>/tiles/{z}/{x}/{y}.jpg` instead of GitHub.

Want tiles of **your own** map (custom MLOs / map edits)? [McLovinIt101/GTAV-MapTiler](https://github.com/McLovinIt101/GTAV-MapTiler) (MIT) turns your game's `minimap_#_#.png` files into tiles — then calibrate `map.ax/bx/ay/by` on 2–3 known places.

### Database editor (server owners only)
- Laptop → Tools → **Database**: browse and edit court tables **without SQL**
- Only tables / columns listed in `Config.DbEditor.tables` — `edit` or `read`; everything else is hidden
- `id`, case numbers, citizen ids and creation dates are always locked
- Every change is saved to `doj_db_history` → **Restore** in one click, and logged to Discord
- ⚠ **Nobody has access by default — not even Supreme Court.** You grant it with an ACE (see [Roles & permissions](#roles--permissions))

### Editions & hooks
- `Config.Edition = 'full' | 'lite'` + per-module switches in `Config.Modules`
- `editable/sv_hooks.lua` · `editable/cl_hooks.lua` (escrow-open) — `OnVerdict`, `OnMoneyIn`, `OnCourtEvent`, `OnCourtCall`, `OnGavel`

### Admin & audit
- Role assignment (Supreme Court admin panel): add online / offline players by CitizenID, remove roles, ACE admins shown read-only
- Audit log for key DOJ actions — every row stores the actor's **Rockstar license** (`license:…`) next to the name
- Judicial Police requests store the **license of the officer who claims** them (shown under *Acknowledge*)
- Discord: system event logs + **printed form transcripts** (image archive per channel)

### Framework & MDT bridges (new)
- **ESX** + QBCore + Qbox + Standalone (`Config.Framework = 'auto'`)
- MDT push: warrants / cases / verdicts / commitments → `Install/MDT.md`
- Honest sync levels: tk_mdt full · Advanced manual · ps-mdt patch
- `Config.MDT.trustedInvokers` gates every cross-resource write export — `IssueFine`, `CreateFormProgrammatically`, `CreateCommitmentOrder`, `CanExecuteCommitment`, `GetBakedFormHtml` — to your own resource plus this allowlist

### Localization
- One switch: `Config.Locale = 'en' | 'hr' | 'de' | 'fr' | 'es'`
- Covers ox_lib UI, React panel, **full A4 form HTML**, print warning, and NKZ titles  
- Does **not** rename exports / API (always English)

---

## Requirements

| Resource | Required |
|----------|----------|
| [oxmysql](https://github.com/overextended/oxmysql) | **Yes** |
| [ox_lib](https://github.com/overextended/ox_lib) | **Yes** |
| Framework (**ESX** / QB / Qbox) or `standalone` | **Yes** |
| [ox_inventory](https://github.com/overextended/ox_inventory) **or** [qb-inventory](https://github.com/qbcore-framework/qb-inventory) | **Yes** for print / archive `document_a4` (`Config.Inventory.provider = 'auto'`; force `'qb-inventory'` on mixed servers) |
| [ox_target](https://github.com/overextended/ox_target) **or** [qb-target](https://github.com/qbcore-framework/qb-target) | Recommended (courthouse / archive / projector eye). F5 panel works without either. `Config.Target.provider = 'auto'` |
| [generic_texture_renderer_gfx](https://forum.cfx.re/t/release-generic-dui-2d-3d-renderer/131208) | Only for the wall screen. Free tool by **thers**. **Not included** in this product. Without it the projector stays blank; the rest of the court still works. |
| [nevera_printeri](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/printeri) | **Optional, sold separately** (needs `ox_inventory` + `ox_target`) — physical printers. Court already views filled forms on Use. |
| MDT (ps-mdt / tk_mdt / Advanced) | Optional — `Install/MDT.md` |
| Phone / prison | Optional |
| Dispatch (ps-dispatch / cd_dispatch / qs-dispatch) | Optional — escalates the Judicial Police command alarm (`Config.JudicialPolice.notify.dispatch`) |
| [peleg-billing](https://github.com/Pelegrino/peleg-billing) | Optional — invoices use `Config.Billing.issuerJob`; filing prices are `Config.Fees` |

> **Optional:** `nevera_menuguard` (soft lock).  
> **OneSync** recommended. Full guide: [`Install/README.md`](Install/README.md)

---

## Installation

Use the buyer pack under **`Install/`** (SQL, items, Discord convars, guides).

### 1. Place the resources

```text
resources/[nevera]/Nevera_Court/          ← this resource
resources/[nevera]/nevera_printeri/       ← optional, sold separately
```

Use the **exact folder name** in `ensure`. Printer / NUI paths resolve with `GetCurrentResourceName()`.

### 2. Database

Same schema for every framework. **Fresh install** — run two files:

```text
Install/sql/nevera_court.sql        # all tables — safe to run again, never deletes rows
Install/sql/nevera_court_laws.sql   # penal code (93 articles, 5 languages) — run ONCE
```

**Updating an older Court?** Run `nevera_court.sql` again. New columns (audit license, Judicial Police claim license) are added when the resource starts. `Install/sql/upgrade/` is only for very old databases — see its README.

⚠ Running `nevera_court_laws.sql` again resets the penal code to defaults (in-game Law Code edits are lost).

**Verify:**

```sql
SELECT COUNT(*) AS categories FROM doj_law_categories;  -- expect 9
SELECT COUNT(*) AS laws FROM doj_laws;                  -- expect ~93
SELECT COUNT(*) AS laws_hr FROM doj_laws WHERE title_hr IS NOT NULL;  -- ~93 after nevera_court_laws.sql
SELECT COUNT(*) AS laws_es FROM doj_laws WHERE title_es IS NOT NULL;  -- ~93 after nevera_court_laws.sql
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

**ESX `first_supreme_court.sql`:** use exact `users.identifier` (e.g. `char1:…`), not a short QB citizenid.
### 3. Inventory item (`document_a4`)

| Inventory | File |
|-----------|------|
| **ox_inventory** (QB / **Qbox** / ESX) | `Install/items/ox_inventory_document_a4.lua` → `ox_inventory/data/items.lua` |
| **Qbox (`qbx_core`)** | same ox block — `qbx_core` has **no** `shared/items.lua` — see `Install/items/qbx_core_document_a4.lua` |
| **qb-core** + qb/ps inventory | `Install/items/qbcore_document_a4.lua` → `qb-core/shared/items.lua` |
| **Legacy ESX** (`items` SQL table) | `Install/items/esx_document_a4.sql` |

**ESX + ox_inventory:** use the **ox** file only.  
**Do not** paste a second `document_a4` from a printer item file (overwrites Court).

**House arrest cutter (optional):** add the `bolt_cutter` item from `Install/items/bolt_cutter.lua` or set your own item in `Config.HouseArrest.cutterItem`.

Copy `Install/items/document_a4.png` → `ox_inventory/web/images/` **or** `qb-inventory/html/images/`.

**Critical (ox_inventory):**

```lua
consume = 0,                           -- otherwise Use DELETES the item
stack = false,
export = 'Nevera_Court.viewDocument',  -- MUST match folder name (case-sensitive)
```

F8 `No such export viewDocument in resource nevera_court` → wrong folder/export casing.  
Filled forms open in **Court NUI**. If you also own `nevera_printeri`, `ensure` it before Court to use the printer UI.

### 4. `server.cfg`

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_target          # or qb-target — Config.Target.provider = 'auto'
ensure ox_inventory
ensure [your-framework]   # es_extended / qb-core / qbx_core

ensure nevera_printeri    # optional — only if purchased separately
ensure generic_texture_renderer_gfx   # free, only for the wall screen — not included, see below
ensure Nevera_Court       # exact folder name
```

If you own `nevera_printeri`, also run its own SQL once — see `nevera_printeri/install/README.md`.

Optional Discord convars — see [Discord & webhooks](#discord--webhooks) and `Install/server_cfg_discord.cfg`.

### 5. First-boot checklist

- [ ] NKZ: 9 categories, ~93 laws
- [ ] `Config.Locale` + `Config.Framework = 'auto'` (or `'esx'` / `'qb'` / `'qbox'`)
- [ ] Supreme Court in `doj_roles` (ESX: id = `users.identifier`)
- [ ] `document_a4` with `consume = 0` + correct `export`
- [ ] `nevera_printeri` only if you bought it (optional)
- [ ] Print → inventory → **Use** → filled document (Court viewer)
- [ ] Courthouse coords / archive passwords / webhooks (optional)
- [ ] Judicial Police: `units` = **your** police job names + grades, `routing`, `locations` (court + prison coords), `dutyZone.coords`
- [ ] Metal detectors (optional): `gate.enabled = true` + one coord per arch in `gate.gates`
- [ ] Wall screen (optional): `generic_texture_renderer_gfx` started **above** Court, then `Config.Courtroom.projector` coords + rot
---

## Configuration

Primary editable file: [`config.lua`](config.lua) (escrow-open). Fine table: [`config_fines.lua`](config_fines.lua).

### Essentials

```lua
Config.Debug     = false
Config.Locale    = 'en'       -- 'en' | 'hr' | 'de' | 'fr' | 'es'
Config.Currency  = '€'        -- money symbol everywhere: '€', '$', '£', …
Config.Branding  = { ServerName = 'Los Santos', PenalCode = 'PC' }  -- your server name in UI / seal / forms
Config.Edition   = 'full'     -- 'full' | 'lite' (+ Config.Modules to force single modules on/off)
Config.Framework = 'auto'     -- 'esx' | 'qb' | 'qbox' | 'standalone'
Config.Target    = { provider = 'auto' }  -- 'auto' | 'ox_target' | 'qb-target'
Config.MDT = {
    provider = 'auto',        -- tk_mdt → ps-mdt (advanced = manual + resourceName)
    trustedInvokers = { 'ps-mdt', 'tk_mdt' },  -- also gates IssueFine / CreateCommitmentOrder / etc. — see Exports & integration
}
-- MDT sync levels + ps-mdt patch: Install/MDT.md
Config.ESX = { RequireDuty = false, AdminGroups = { 'admin', 'superadmin' } }
Config.Inventory = { provider = 'auto' }
Config.Phone     = { provider = 'auto' }
```

### Currency (`$` / `€`)

Buyers set the symbol themselves — it is **display only** (panel, notifies, forms chrome):

```lua
Config.Currency = '$'   -- US / dollar servers
Config.Currency = '€'   -- EU / euro servers
```

Changing the symbol does **not** convert amounts. Adjust the penal code (in-game editor), `config_fines.lua` and `Config.Economy` to your server economy.

### Fines — where the amounts live

| What | Where | How to change |
|------|-------|---------------|
| **Penal code** (fine & prison range per article — used for verdicts) | database `doj_laws` | **In-game:** `/courtlaws` or `/court` → *Penal code editor* (Supreme Court or ACE `nevera.sudstvo.admin`). Prices, prison, severity, category, name & description in every language, new / deactivated articles. Active immediately. |
| **Fine calculator** (panel → Fines tab) | [`config_fines.lua`](config_fines.lua) | Edit `baseAmount` / `multi`, add your own offences with a `label`. Restart the resource. |
| Court fees, exam / expungement fees | `config.lua` → `Config.Fees`, `Config.Exams`, `Config.Expungement` | Edit the numbers. |

```lua
Config.FineCalculator = {
    maxTotal = 250000,
    categories = {
        { id = 'robbery', baseAmount = 18000 },                          -- built-in (translated)
        { id = 'illegal_fishing', label = 'Illegal Fishing', baseAmount = 1500 },  -- your own
    },
    modifiers = {
        { id = 'repeat_offender', multi = 1.50 },
    },
}
```

Civil damages range and related economy knobs:

```lua
Config.Economy = {
    civilDamagesMin = 1000,
    civilDamagesMax = 500000,
    -- … see config.lua
}
```

Defaults are a reference economy. **Adjust for your city** before go-live.

### MDT sync levels (before you market the MDT bridges)

| Provider | Level |
|----------|--------|
| `tk_mdt` | Full sync (exports) |
| `advanced` | Partial/Full — set `provider` + `resourceName` (no auto-guess) |
| `ps-mdt` | Events + optional patch (`Install/patches/ps-mdt_nevera_warrant.lua`) |

### Map locations (courthouse, desks, archives) — **you must set these**

Nevera Court does **not** know your MLO. Every buyer places targets / zones on **their** map:

| Config | What it is | Who uses it |
|--------|------------|-------------|
| `Config.Courthouse.mainZone` | Main DOJ / court interaction | Open panel at the courthouse |
| `Config.Courthouse.terminalZone` | Clerk / filing terminal | Forms / filings desk |
| `Config.Courthouse.bailZone` | Bail desk | Pay / process bail |
| `Config.Archive.Locations` | Archive rooms / cabinets | Password stashes for documents |
| `Config.Prison.intakeZone` (if used) | Prison intake | Commitment / custody handoff |

Ship coords are **placeholders** (or generic downtown). Before go-live:

1. Stand in-game where the desk / courtroom / archive should be  
2. Copy your `vector3(x, y, z)` (and heading if needed)  
3. Paste into the matching entry in [`config.lua`](config.lua)  
4. Restart / `ensure` the resource and test `ox_target` prompts  

There is **no** separate “lawyer office” resource forced by Nevera Court — attorneys use the same DOJ panel + roles. If you want a dedicated law-firm prop/MLO, put a Courthouse or Archive point there yourself.

```lua
Config.Courthouse = {
    mainZone = {
        coords = vector3(0.0, 0.0, 0.0),  -- ← your courtroom / lobby
        -- …
    },
    terminalZone = { coords = vector3(0.0, 0.0, 0.0) }, -- filing desk
    bailZone     = { coords = vector3(0.0, 0.0, 0.0) }, -- bail window
}

Config.Archive.Locations = {
    { label = 'City Hall archive 1', coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
    { label = 'City Hall archive 2', coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
    { label = 'Police archive',      coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
    { label = 'Hospital archive',    coords = vector3(0.0, 0.0, 0.0), heading = 0.0 },
    -- add / remove rows for every physical cabinet on your map
}
```

> **Locations ≠ separate stashes.** Each row is only an `ox_target` access point.  
> The player always opens **their role stash** (or personal citizen stash) after entering **their role password** — same logic at City Hall, PD, hospital, etc.

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

### Judicial Police

> ⚠ **Set your own police job names.** `job` must match the job name in your framework exactly (QBCore `shared/jobs.lua`, Qbox `qbx_core/shared/jobs.lua`, ESX `jobs` table). Upper / lower case matters. If no unit matches, nobody gets the alarm.

```lua
Config.JudicialPolice = {
    units = {
        { job = 'police',  label = 'LSPD', commandMinGrade = 3 },
        { job = 'sheriff', label = 'BCSO', commandMinGrade = 3 },
        -- { job = 'judicial', label = 'Judicial Police', commandMinGrade = 3 },
        -- { job = 'swat',     label = 'SWAT', commandMinGrade = 3, highRiskOnly = true },
    },
    routing = {
        court_protection       = { first = { 'police' }, fallback = { 'sheriff' }, fallbackAfterSec = 120 },
        transport_to_court     = { first = { 'police' }, fallback = { 'sheriff' }, fallbackAfterSec = 120 },
        transport_to_jail      = { first = { 'police' }, fallback = { 'sheriff' }, fallbackAfterSec = 120 },
        arrest                 = { first = { 'police', 'sheriff' } },
        house_arrest_violation = { first = { 'police', 'sheriff' } },
    },
    onlyOnDuty = true,             -- only on-duty players get the alarm
    alarmIntervalMs = 15000, alarmMaxRepeats = 0,
    alarmSound = { set = 'HUD_MINI_GAME_SOUNDSET', name = 'TIMER_STOP', ['repeat'] = 3 },
    locations = {                  -- ⚠ your own coords
        court  = { label = 'Courtroom 1',        coords = vector3(...) },
        prison = { label = 'Bolingbroke Prison', coords = vector3(...) },
    },
    route = { enabled = true, sprite = 526, colour = 47, arriveDistance = 30.0 },
    expireAfterHours = 6,
    schedule = {
        court_protection   = { required = true, minHoursAhead = 2 },
        transport_to_court = { required = true, minHoursAhead = 2 },
        transport_to_jail  = { immediate = true, label = 'after_verdict' },
        arrest = { immediate = true }, house_arrest_violation = { immediate = true },
    },
    dutyToggleCommand = 'jpduty',
    dutyZone = { enabled = true, coords = vector3(...), radius = 1.5 },
    gate = { enabled = false, exemptJobs = { 'police', 'sheriff' }, gates = { --[[ { coords = vector3(...), label = 'Main entrance' } ]] } },
}
```

| Key | What it does |
|---|---|
| `units[].job` | Your job name (framework). Any number of units |
| `units[].commandMinGrade` | From this grade up: gets the alarm, can claim and assign. Lower grades can only be assigned |
| `units[].highRiskOnly` | Called only when the judge ticks **High risk** |
| `routing.<type>.first / fallback` | Who is alarmed first, who after `fallbackAfterSec` (or at once if nobody from `first` is on duty) |
| `schedule.<type>` | `minHoursAhead` = earliest allowed time; `immediate` = no time field |
| `locations` | Places in the request form; `court` + `prison` are used for transport routes. **My current location** is always offered |
| `gate` | Metal detectors: one coord in the middle of each arch. Needs detector arches in your MLO (or your own props) |

Legacy `commandJobs` / `commandMinGrade` / `assignableJobs` still work, but only when `units` is missing.

### Courtroom wall screen (no TV)

The picture floats on the wall. Nothing is spawned. The `.gfx` file is **not** in this product (it belongs to **thers**).

1. Open https://forum.cfx.re/t/release-generic-dui-2d-3d-renderer/131208
2. Download `generic_texture_renderer_gfx.zip` (Gimme gimme, about 5 KB).
3. Unzip into `resources`. Keep the folder name `generic_texture_renderer_gfx`. Do not rename files in `stream`.
4. `ensure generic_texture_renderer_gfx` **above** `ensure Nevera_Court`.
5. Restart the server once. A new streamed file does not load on a resource restart.

Servers that already run a TV script often already have this folder. Leave it started. Do not copy the `.gfx` into Nevera Court.

Then set only `Config.Courtroom.projector` in `config.lua`:

```lua
Config.Courtroom.projector = {
    enabled = true,
    coords  = vector3(...),          -- centre of the screen on the wall
    rot     = vector3(0.0, 0.0, 0.0), -- direction the picture faces
    scale   = 0.085,
    viewDistance = 18.0,
}
```

| Key | What you set |
|---|---|
| `coords` | Centre of the screen. Put **Z about 1.3 above the floor**, not at the feet. |
| `rot` | Which way the picture looks. If it is mirrored or faces the wall, add `180` to `rot.z`. |
| `scale` | Size. `0.085` is a normal courtroom screen. |
| `viewDistance` | Who can see it and hear YouTube. |
| `projectorRoles` | Who may start it: judge, supreme court, prosecutor, defense, public defender, police. |
| `allowedHosts` | Which sites may be shown (YouTube, Google, Imgur, Discord, …). |

YouTube, images and other links play from the eye target on the wall (**Projector — show evidence**) or from the case, one click. Notes are not shown. If the gfx resource is missing, that player gets one error. The rest of the court still works.

### Archive (how stashes work — important)

Archive is **not** one shared locker for everyone. It is:

1. **Physical points** you place on the map (`Config.Archive.Locations`) — e.g. 2 at City Hall, 1 at police, 1 at hospital.  
2. **Logical stashes** opened by **DOJ role + password** (independent of which point you used).

| Setting | Meaning |
|---------|---------|
| `Locations` | `ox_target` spots only. Add one `{ label, coords, heading }` per cabinet / room. Coords `0,0,0` are skipped. |
| `Passwords` | One password per role. Player must enter **their** role password. Wrong password → stash does **not** open. |
| `UseRoleStashes = true` | Staff → shared role stash `doj_archive_<role>` (all judges share judge stash, all police share police stash, …). Citizen → personal `doj_archive_<citizenid>`. |
| `UseRoleStashes = false` | Staff share one `StashId` (`doj_archive_main`); citizens still get a personal stash. |
| `AllowedItems = { 'document_a4' }` | **Only** printed court forms can go in. Blocks dumping weapons / junk into the archive. |
| `StashSize` | Slots + weight for role / main stashes. |

```lua
Config.Archive = {
    Passwords = {
        citizen          = 'citizen123',   -- CHANGE before publish
        police           = 'police123',
        defense_attorney = 'defense123',
        public_defender  = 'defender123',
        prosecutor       = 'prosecutor123',
        clerk            = 'clerk123',
        judge            = 'judge123',
        supreme_court    = 'supreme123',
    },
    UseRoleStashes = true,
    AllowedItems   = { 'document_a4' },  -- keep this for stash / evidence protection
    StashSize      = { slots = 50, weight = 100000 },
    StashId        = 'doj_archive_main',
    Locations = {
        { label = 'City Hall 1', coords = vector3(...), heading = 0.0 },
        { label = 'City Hall 2', coords = vector3(...), heading = 0.0 },
        { label = 'Police',      coords = vector3(...), heading = 0.0 },
        { label = 'Hospital',    coords = vector3(...), heading = 0.0 },
    },
}
```

**Buyer checklist**

1. **Change all default passwords** before going live.  
2. Stand in-game at each cabinet → copy `vector3` → paste into `Locations` (as many rows as you need).  
3. Restart / `ensure Nevera_Court` → test target prompt.  
4. Each player uses **their role code**; they can use **any** archive point on the map.  
5. Leave `AllowedItems = { 'document_a4' }` unless you intentionally want other items in the stash.

### Editions & modules

```lua
Config.Edition = 'full'      -- 'full' | 'lite'
Config.Modules = {
    jury = nil, judicial_police = nil, archive = nil, projector = nil,  -- nil = follow the edition
    exams = nil, appointments = nil, treasury = nil, appeals = nil,
    alt_sentences = false,   -- example: switch one module off
}
```

### Court services & procedure

| Block | What you set |
|-------|--------------|
| `Config.Extras` | `/court` command + courthouse eye option |
| `Config.Exams` | questions, pass score, fee, cooldown |
| `Config.Appointments` · `Config.Appeals` · `Config.Expungement` · `Config.PleaDeals` | roles, fees, time windows |
| `Config.Treasury` | ledger + optional society account push |
| `Config.Evidence` · `Config.CourtSession` · `Config.CourtBoard` | roles, radius, minutes / board size, `/courtboard` |
| `Config.Arraignment` · `Config.BenchWarrant` | public defender roles, bail forfeit |
| `Config.AltSentences` | community-service work points + scenario |
| `Config.RestrainingOrders` · `Config.Detention` · `Config.Contempt` | radius / grace, max hours + extensions, max fine / minutes |
| `Config.HouseArrest` | radius, grace, auto-revoke, `liveTracking` on/off, police jobs, bracelet prop + offset, `cutterItem` |
| `Config.HouseArrest.mapTiles` · `map` | optional live-map tile URL (empty = radar) + zoom |
| `Config.LawEditor` | roles / ACE for the in-game penal code editor (`/courtlaws`) |
| `Config.DbEditor` | laptop Database editor: ACE, allowed tables (`edit` / `read`), editable columns, locked columns |

### Hooks (`editable/`)

```lua
function CourtHooks.OnVerdict(case_number, verdict, judgeSrc) end   -- server
function CourtHooks.OnMoneyIn(amount, source_type, reference) end   -- server
function CourtHooks.OnCourtEvent(name, data) end                    -- server
function CourtHooks.OnCourtCall(call, text) end                     -- client
function CourtHooks.OnGavel(volume) end                             -- client
```

### System Discord webhooks

```lua
Config.Webhooks = {
    cases = '', warrants = '', bail = '', fines = '',
    verdicts = '', admin = '', audit = '', judicial = '',
}
```

Form **screenshot** channels use `server.cfg` convars (below), not this table.

---

## Localization

| Code | Language | UI (`locales/`) | Full A4 HTML | Form chrome JSON | NKZ titles |
|------|----------|-----------------|--------------|------------------|------------|
| `en` | English (default) | `en.lua` | `forms_en/` | `forms_en.json` | `title` (base) |
| `hr` | Croatian | `hr.lua` | `forms_hr/` | `forms_hr.json` | `title_hr` (laws SQL) |
| `de` | German | `de.lua` | `forms_de/` | `forms_de.json` | `title_de` (laws SQL) |
| `fr` | French | `fr.lua` | `forms_fr/` | `forms_fr.json` | `title_fr` (laws SQL) |
| `es` | Spanish | `es.lua` | `forms_es/` | `forms_es.json` | `title_es` (laws SQL) |

### What `Config.Locale` controls

One switch drives **panel + ox_lib + full form HTML folder + NKZ display titles**. Public API / export names stay **English**.

| Area | Localized |
|------|-----------|
| ox_lib notifies, alerts, menus, targets | Yes |
| React panel (`OPEN_PANEL` strings) | Yes |
| Print legal warning | Yes |
| **Full HTML court forms** (`forms_<locale>/`) | Yes (37 templates each) |
| HTML `data-i18n` chrome (`forms_*.json`) | Yes |
| NKZ titles in DB (`title_*`) | Yes (`nevera_court_laws.sql` — HR/DE/FR/ES) |
| Export / event names | No (always English) |

**Important:** FiveM NUI loads **`web/dist/`**. After editing a form in `web/dist/forms_*/` restart the resource. A file missing in `forms_hr` (etc.) falls back to `forms_en` and can look mixed EN/locale.

**Add a language:** the 5 languages above are built in. You can change any text in `locales/*.lua` and `web/dist/forms_*/`. For a new language open a ticket in [Discord](https://discord.gg/MUw2uR5MZ6) — it needs a small core change.

---

## Discord & webhooks

Two separate Discord layers:

| Layer | Purpose |
|-------|---------|
| **1. System logs** | Case / warrant / bail / fine / verdict / admin / audit text events (`Config.Webhooks`) |
| **2. Court transcripts** | Every **printed** A4 form is screenshot → uploaded → posted to Discord as a lasting visual record |

### Court transcripts (printed forms → Discord)

When a player **Save / Print**s a court form (and accepts the legal warning), Nevera Court can:

1. Capture the filled A4 page as an image  
2. Upload it via **imgbb**  
3. Post an embed into the matching Discord channel  

That channel becomes your **transcript archive** — staff can scroll history and prove what was filed/printed (complaint, warrant, bail bond, verdict, etc.), even if the in-game item is lost.

**Organize like a real docket room:**

- Create **one webhook per channel** (recommended), e.g. `#court-criminal`, `#court-verdicts`, `#court-bail`, …  
- **Or** one shared `#court-transcripts` channel if you prefer a single feed  
- Keep channels staff-only / read-only for citizens if you want controlled access  

By default (`Config.Forms.requireTranscript = true`), the transcript is **mandatory**: if `nevera_court_imgbb_key` and the matching `nevera_court_wh_*` URL aren't configured (or the upload fails), the **print itself is rejected** — before any fee is charged or the form is saved — so there's always a Discord original to catch later tampering. Set `Config.Forms.requireTranscript = false` to go back to optional screenshots, or list form types in `Config.Forms.transcriptExempt` to exempt only those.

> **New to Discord webhooks?** Official guide: [Intro to Webhooks (Discord Support)](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks)

### How to create a webhook (quick steps)

1. Open your Discord server → **Server Settings** → **Integrations** → **Webhooks** → **New Webhook**.
2. Name it (e.g. `Nevera Court — Criminal transcripts`), pick the target **text channel**.
3. Click **Copy Webhook URL** — `https://discord.com/api/webhooks/ID/TOKEN`.
4. Paste into the matching `set nevera_court_wh_…` line in `server.cfg` (or into `Config.Webhooks` for system logs).
5. Repeat per channel so transcripts stay organized.

**Tips**

- You need **Manage Webhooks** permission.
- Treat the URL like a password.
- After editing `server.cfg`, restart the server (or `ensure Nevera_Court`).

**Imgbb API key (required for transcripts)**

1. Free account at [imgbb.com](https://imgbb.com/) → API → copy key.  
2. `set nevera_court_imgbb_key "YOUR_KEY"` in `server.cfg`.

### 1) System event webhooks — `config.lua`

Used for case / warrant / bail / fine / verdict / admin / audit **text** logs (`Config.Webhooks`). These are activity logs, not full form images.

### 2) Form transcript channels — `server.cfg` convars

Printed forms → imgbb → Discord embed (visual **transcript**). Reference: [`Install/server_cfg_discord.cfg`](Install/server_cfg_discord.cfg).

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

| Convar | Transcript channel for |
|--------|-------------------------|
| `nevera_court_imgbb_key` | Imgbb upload (required) |
| `nevera_court_wh_criminal` | Criminal filings / complaints / warrants |
| `nevera_court_wh_verdict` | Verdicts / judgments |
| `nevera_court_wh_fines` | Fine-related prints |
| `nevera_court_wh_bail` | Bail / bond prints |
| `nevera_court_wh_citizen` | Citizen / civil prints |
| `nevera_court_wh_admin` | Admin / Supreme Court prints |
| `nevera_court_wh_audit` | General / catch-all document shots |

> Judicial Police alerts (new requests / claimed / assigned / completed) post as **text** embeds to `nevera_court_log_judicial` (`Config.Webhooks.judicial`) — same system as layer 1, not an image transcript channel.

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

**First admin:** give yourself ACE `nevera.sudstvo.admin`, open **Admin → Role Management → Add player** and assign `supreme_court`. Or edit and run `Install/sql/first_supreme_court.sql` with your **citizenid**.

Optional ACE / group mappings: `Config.Permissions`.

**Database editor (⚠ read this):** nobody has it by default — not even Supreme Court. **You decide who gets it**, in `server.cfg` (or your permissions file):

```cfg
add_ace qbcore.god nevera.court.db allow                    # e.g. only server owners
# add_ace identifier.license:xxxxxxxx nevera.court.db allow # or one specific person
```

Give it only to people you fully trust. Every change is logged to Discord and can be restored from History.

Archive access also requires the correct password for that role in `Config.Archive.Passwords`.

Judicial Police access is **job-based**, not a DOJ role: every job in `Config.JudicialPolice.units` can be assigned and complete requests; from `commandMinGrade` up they also get the alarm and can claim / assign. `judge` / `supreme_court` / `clerk` create requests. With `onlyOnDuty = true` the alarm only reaches players who are on duty.

---

## In-game usage

### Opening the panel

| Method | Description |
|--------|-------------|
| Keybind | `Config.UI.openKey` (default **F5**) — opens the court laptop desktop |
| Commands | open the laptop directly on their window (see below) |
| Courthouse | `ox_target` or `qb-target` on `Config.Courthouse` zones |
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

Everything is also reachable by clicking in the laptop — commands are shortcuts.

| Command / bind | Description | In the laptop |
|----------------|-------------|---------------|
| **F5** (default) | Open / close the court laptop | — |
| `/doj_help` | List DOJ commands | Taskbar → **Help** |
| `/doj_jury` · `/doj_jury_leave` | Register / unregister for the jury pool | **Jury** → Register / Unregister |
| `/doj_commitment` | Commitment orders (custody / DOC / judges) | **Fines** → Commitment orders |
| `/refreshlaws` | Reload penal code from DB (console or admin) | **Law Code** → Reload from database |
| `/courtlaws` | Penal code editor (Supreme Court / ACE admin) | **Law Code** → Edit |
| `/court` | Court services + procedure (*My sentences* for citizens) | **Requests** · **Cases** → case tools |
| `/courtboard` | Public court board (hearings + verdicts) | **Hearings** → Public board |
| `/bracelets` | House arrest: list, live map, GPS (police / judges) | Tools → **House arrest** |
| `/gavel` | Strike the gavel (judge) | Taskbar → **Gavel** |
| `/jpduty` | Open Judicial Police as police + duty on / off | **Judicial Police** · taskbar 🚨 badge |

Command names live in `Config.Commands` (`juryJoin`, `juryLeave`, `refreshLaws`, `help`) and `Config.JudicialPolice.dutyToggleCommand`. `legacyAliases = true` also keeps the old names (`jpdezurni`, `doj_jury_odjava`, `refreshnkz`).

### Print flow

```text
Save/Print → legal warning → Accept → copy count
  → Discord court transcript (imgbb + nevera_court_wh_* if configured)
  → document_a4 item(s) in inventory
  → Hand to counsel / judge or place in archive stash
```

Discord transcript = lasting channel history of what was printed (staff evidence / docket archive).

### Archive flow

1. Approach **any** archive point you configured (City Hall, PD, hospital, …).  
2. Enter the **password for your DOJ role** (`Config.Archive.Passwords`).  
3. Citizen → personal stash `doj_archive_<citizenid>`.  
4. Staff (`UseRoleStashes = true`) → shared role stash `doj_archive_<role>` (e.g. `doj_archive_police`, `doj_archive_judge`).  
5. Deposit / take items — by default **only `document_a4`** is allowed (`AllowedItems`).

---

## Legal forms

Templates live in **per-language folders** (full HTML each — **37 files** + `form-loader.js`):

| `Config.Locale` | Folder |
|-----------------|-------------------------------------|
| `en` | `web/dist/forms_en/` |
| `hr` | `web/dist/forms_hr/` |
| `de` | `web/dist/forms_de/` |
| `fr` | `web/dist/forms_fr/` |
| `es` | `web/dist/forms_es/` |

Missing file in a locale folder **falls back to `forms_en`**.  
Optional JSON chrome: `web/dist/i18n/forms_*.json` (HTML `data-i18n`).  

Access is gated by `Enums.FormsByRole`. Keep `name=` / `id=` on inputs identical across languages (autofill).

---

## Project structure

```text
Nevera_Court/
├── Install/                      # Buyer pack
│   ├── README.md
│   ├── MDT.md
│   ├── patches/ps-mdt_nevera_warrant.lua
│   ├── server_cfg_discord.cfg
│   ├── items/                    # ox + qb-core + legacy ESX item
│   └── sql/
│       ├── nevera_court.sql          # ALL tables — first install + updates (safe to re-run)
│       ├── nevera_court_laws.sql     # penal code EN + HR/DE/FR/ES — run once
│       ├── first_supreme_court.sql   # optional first admin
│       └── upgrade/                  # very old databases only (see upgrade/README.md)
│   └── companion/README.md           # nevera_printeri is sold separately
├── bridge/
│   ├── framework/                # qb · qbox · esx · standalone
│   ├── mdt/                      # ps · tk · advanced
│   ├── inventory/ · phone/
│   └── registry.lua · resolve.lua
├── client/ · server/ · shared/ · locales/
├── editable/                     # open hooks (sv_hooks.lua / cl_hooks.lua)
├── web/dist                      # built NUI (forms_* = A4 templates per language)
├── config.lua · config_fines.lua
└── fxmanifest.lua
```

### Escrow — editable files

Typically open (`escrow_ignore`):

- `config.lua` · `config_fines.lua`
- `locales/**`
- `bridge/**`
- `Install/**` · `editable/**`
- `web/**` (built NUI + A4 form HTML — editable)

Encrypted on release: `server/`, `client/` and `shared/` Lua (core logic). Everything above stays open.

---

## Editing the UI

- The resource ships the **built** NUI (`web/dist/`). Currency, branding, colours, commands and every text in `locales/` work **without** a rebuild.
- A4 form templates: edit `web/dist/forms_<lang>/*.html` directly and restart the resource. Keep `name=` / `id=` on inputs identical across languages.
- `web/dist/court_extras.js` and `web/dist/gavel.wav` are used at runtime — keep them.
- Need a change in the React panel itself? Ask in [Discord](https://discord.gg/MUw2uR5MZ6).

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
| `GetCriminalRecord` / `IsCaseExpunged` | Criminal record (expunged cases excluded) |
| `IsOnHouseArrest` | House arrest |
| `HasLicense` | Bar licence |
| `GetTreasuryBalance` / `TreasuryDeposit` | DOJ treasury |
| `GetHearingsForCase` / `GetNextHearing` | Hearings |
| `GetFormById` / `GetFormsForCase` / `CreateFormProgrammatically` / `GetBakedFormHtml` | Forms |

**Legacy HR aliases** (same functions): `GetZakoni` → `GetLaws`, `GetZakon` → `GetLaw`, `GetKategorije` → `GetCategories`, `GetFormaById` → `GetFormById`. Prefer English in new code.

**Restricted exports:** `IssueFine`, `CreateFormProgrammatically`, `CreateCommitmentOrder`, `CanExecuteCommitment`, and `GetBakedFormHtml` only answer calls from this resource itself or from a resource name listed in `Config.MDT.trustedInvokers` — everything else gets `nil`/`false` and a `BLOCKED …` line in console. Add your MDT/other integration's resource name to that list if a call is being rejected.

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
| Resource won’t start | Check `oxmysql` + `ox_lib`; read console |
| Panel shows **Citizen** despite SQL | `doj_roles.citizenid` = live framework id (ESX = `users.identifier`); relog |
| NKZ shows 0 laws | Run `nevera_court_laws.sql` once |
| Laws still English on HR/DE/FR/ES | Run `03_seed_laws_i18n.sql`; set `Config.Locale`; restart |
| Form half English / half locale | Check `web/dist/forms_<lang>/` has the file (missing → English fallback); restart |
| `No such export viewDocument…` | Item `export` must match **folder name** casing |
| Use deletes item / nothing opens | `consume = 0` + correct `export` folder name |
| Save / Print error | Add `document_a4` + PNG; check `[sv_printer]` |
| Archive won’t open | Role + `Config.Archive.Passwords` |
| Discord screenshots fail | `nevera_court_imgbb_key` + `nevera_court_wh_*` |
| migrate i18n “duplicate column” | Fresh install: skip `sql/upgrade/`. Existing DB: use those scripts once. |
| Print rejected: “requires a Discord transcript” | Expected — `Config.Forms.requireTranscript = true` by default. Configure `nevera_court_imgbb_key` + `nevera_court_wh_*`, or set `requireTranscript = false` / add the type to `transcriptExempt`. |
| Database folder not visible | Expected until you grant the ACE: `add_ace <group> nevera.court.db allow` in server.cfg, restart. Also run `nevera_court.sql` (creates `doj_db_history`). |
| House arrest map is grey / only a grid | `Config.HouseArrest.mapTiles` is empty (built-in radar) or the URL is wrong / that resource isn't started |
| Judicial Police alarm reaches no one | `units[].job` must be your **exact** job names, grade ≥ `commandMinGrade`, and the player **on duty** (`onlyOnDuty = true`). |
| Request form: "Select at least one unit" / no units listed | `Config.JudicialPolice.units` is empty or `config.lua` on the server is old — restart after editing. |
| "Only command staff can do that" on Claim | Your job grade is below that unit's `commandMinGrade`. |
| Request won't save (new types / location) | Run `Install/sql/nevera_court.sql` again on the existing database. |
| Role Management shows 0 players | Normal on a fresh install — use **Add player**. ACE admins appear with the **ACE** tag. |
| Audit log / claim has no license | Older rows were saved before this update. New actions store it; the column is added on resource start (or run `Install/sql/upgrade/audit_rockstar_license.sql` / `judicial_claim_license.sql`). |
| GPS route goes to the wrong place | Set your own `Config.JudicialPolice.locations` coords (court / prison). |
| Metal detector never beeps | `gate.enabled = true`, coords in the middle of each arch, player not in `exemptJobs` while on duty. |
| Wall screen is blank / colour bars | `generic_texture_renderer_gfx` is not started, or the server was not restarted after adding it. It is not shipped inside Court. |
| Wall picture is mirrored | Add `180` to `Config.Courtroom.projector.rot.z` and restart. |
| YouTube link refused | The site must be in `Config.Courtroom.allowedHosts`. Notes cannot be projected. |

---

## Support & community

Buyers should use **Discord** and **Tebex**. That is the standard setup for escrow FiveM products and is enough for install help, bugs, and re-downloads.

| Channel | Use for |
|---------|---------|
| **Discord** | Install help, bugs, feature requests, RP questions |
| **Tebex** | Purchase, invoices, license, re-download |

- Discord: https://discord.gg/MUw2uR5MZ6
- Store: https://nevera-rp.tebex.io/
- Docs: https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/overview

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

- [ ] Extra locales beyond EN / HR / DE / FR / ES  
- [ ] More inventory / phone edge-case bridges  
- [ ] Expanded civil procedure templates  
- [ ] Live ESX Legacy end-to-end QA checklist in docs  
- [x] Public docs: https://nevera-hard-rp.com/Nevera-Docs/#/

---

## License & support

**Proprietary — Nevera Dev Team.**

Purchase grants a license for **your** FiveM server(s) under Tebex / Cfx.re Asset Escrow terms. Redistribution, resale, or leaking escrow source is prohibited.

© Nevera Dev Team — All rights reserved.

---

<div align="center">

**Nevera Court** `v1.0.0` · Built for serious DOJ roleplay

[Discord](https://discord.gg/MUw2uR5MZ6) · [Tebex](https://nevera-rp.tebex.io/) · [Docs](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/overview)

</div>
