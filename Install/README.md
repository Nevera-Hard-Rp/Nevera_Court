# Nevera Court — INSTALL (Tebex)

Do steps **in order**. Keep this folder with the resource.

```
Install/
  README.md
  sql/nevera_court.sql        ← all tables (first install + updates)
  sql/nevera_court_laws.sql   ← penal code, run ONCE
  sql/first_supreme_court.sql ← optional
  sql/upgrade/                ← older databases only
  items/ox_inventory_document_a4.lua
  items/qbcore_document_a4.lua     ← qb-core + qb-inventory
  items/qbx_core_document_a4.lua   ← Qbox: inventory how-to
  items/bolt_cutter.lua            ← optional: house-arrest bracelet cutter
```

**In-game usage:** F5 (default `Config.UI.openKey`) / radial — see root `README.md` (Features).

---

## Requirements

| Resource | Required | Why |
|----------|----------|-----|
| `oxmysql` | Yes | Database |
| `ox_lib` | Yes | Notify, keybinds, callbacks |
| `ox_inventory` **or** `qb-inventory` | Yes | `document_a4` item (`Config.Inventory.provider`) |
| `ox_target` **or** `qb-target` | Recommended | Courthouse / archive / projector eye (F5 panel key works without it). `Config.Target.provider = 'auto'` |
| Framework (ESX / QB / Qbox) | Yes | Auto bridge |
| [`nevera_printeri`](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/printeri) | Optional, **sold separately** (needs `ox_inventory` + `ox_target`) | Physical printers / extra print UI. Court already opens `document_a4` in its own viewer. |
| [`generic_texture_renderer_gfx`](https://forum.cfx.re/t/release-generic-dui-2d-3d-renderer/131208) | Only for the courtroom wall screen | Free tool by **thers**. Not included in this product. Without it the projector stays blank. |

Court **does not** require `nevera_printeri` to view printed forms.

### server.cfg order

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory           # or: ensure qb-inventory  (not both unless you force provider)
ensure ox_target              # or: ensure qb-target
ensure qbx_core               # or es_extended / qb-core

ensure nevera_printeri        # optional — only if you bought it separately
ensure generic_texture_renderer_gfx   # free, only for the wall projector — see below
ensure Nevera_Court
```

Recommended folder name: **`Nevera_Court`** (must match item export).

**Database editor permission** (laptop → Tools → Database). Nobody has it by default, not even Supreme Court. Grant it only to people you fully trust:

```cfg
add_ace qbcore.god nevera.court.db allow                    # e.g. only server owners
# add_ace identifier.license:xxxxxxxx nevera.court.db allow # or one person
```

---

### Wall projector (not included)

The courtroom screen needs a free tool by **thers**. It is not part of this product.

1. Open https://forum.cfx.re/t/release-generic-dui-2d-3d-renderer/131208
2. Download `generic_texture_renderer_gfx.zip` (the “Gimme gimme” file, about 5 KB).
3. Unzip it into `resources`. Leave the folder name `generic_texture_renderer_gfx`. Do not rename the files inside `stream`.
4. In `server.cfg`, **above** `ensure Nevera_Court`:

```cfg
ensure generic_texture_renderer_gfx
```

5. Restart the server once. A resource restart is not enough for a new streamed file.

Then set the screen in `config.lua` → `Config.Courtroom.projector`:

- `coords` — centre of the screen on the wall. Put Z about 1.3 above the floor.
- `rot` — direction the picture faces. If the picture is mirrored, add `180` to `rot.z`.
- `scale` — size. `0.085` is a normal courtroom screen.

YouTube, images and other links are played from the court laptop or the eye target. Allowed sites are `Config.Courtroom.allowedHosts`.

If this resource is missing, the player who starts the projector gets one error. The rest of the court still works. Servers that already run a TV script often already have this folder.

**Database editor permission** (laptop → Tools → Database). Nobody has it by default, not even Supreme Court. Grant it only to people you fully trust:

```cfg
add_ace qbcore.god nevera.court.db allow                    # e.g. only server owners
# add_ace identifier.license:xxxxxxxx nevera.court.db allow # or one person
```

---

## SQL

### Fresh install (all frameworks)

Run **two** files, in this order:

```
sql/nevera_court.sql        ← all tables (safe to run again, never deletes rows)
sql/nevera_court_laws.sql   ← penal code: 93 articles, EN + HR / DE / FR / ES — run ONCE
```

Then make yourself the first Supreme Court: give yourself ACE `nevera.sudstvo.admin`, open **Admin → Role Management → Add player** and pick `supreme_court`.
Or edit and run `sql/first_supreme_court.sql` (QB / Qbox: short `citizenid` · ESX: exact `users.identifier`, e.g. `char1:…`).

⚠ Running `nevera_court_laws.sql` again resets article texts, fines and prison times to the defaults (your in-game Law Code edits are lost).

### Updating an older Court

1. Run `sql/nevera_court.sql` again — adds every missing table and Judicial Police column. No rows are deleted.
2. The audit `license` and Judicial Police `acknowledged_by_license` columns are added automatically when the resource starts.
3. Anything else only if the console / troubleshooting says so — see `sql/upgrade/README.md`.

---

## Item `document_a4`

### qb-core + qb-inventory (no ox_inventory)

1. Paste `Install/items/qbcore_document_a4.lua` into `qb-core/shared/items.lua`
2. Copy `document_a4.png` → `qb-inventory/html/images/`
3. Set `Config.Inventory.provider = 'qb-inventory'` if ox_inventory is still started on the machine
4. `unique = true` + `useable = true` — Court registers `CreateUseableItem` on start (opens NUI from `item.info.doc_id`)

### Qbox (`qbx_core`)

`qbx_core` has **no** `shared/items.lua`. Define the item **only** in `ox_inventory/data/items.lua`.  
See **`Install/items/qbx_core_document_a4.lua`**.

### All frameworks (same Lua block)

1. Paste `Install/items/ox_inventory_document_a4.lua` into `ox_inventory/data/items.lua`
2. Copy `document_a4.png` → `ox_inventory/web/images/`
3. **Do not** paste a second `document_a4` from a printer item file (overwrites Court)

**Critical:**

```lua
consume = 0,  -- otherwise ox DELETES the item on Use
stack = false,
export = 'Nevera_Court.viewDocument',  -- MUST match folder name (case-sensitive)
```

If your folder is `nevera_court`, use `nevera_court.viewDocument`.  
F8 `No such export viewDocument…` = wrong casing.

---

## Config

```lua
Config.Locale = 'en'       -- en | hr | de | fr | es
Config.Framework = 'auto'  -- or 'esx' | 'qb' | 'qbox'
Config.Inventory.provider = 'auto'  -- or 'ox' | 'qb-inventory' (force QB if ox is still started)
```

DOJ roles live in `doj_roles` (not ESX `users.group` / QB job alone).

### Languages (ready out of the box)

| Locale | Panel UI | 37 A4 forms | NKZ titles |
|--------|----------|-------------|------------|
| `en` / `hr` / `de` / `fr` / `es` | `locales/*.lua` | `web/dist/forms_*` | seeded in `nevera_court_laws.sql` |

NUI reads **`web/dist/`**. Edit forms in `web/dist/forms_*/` and restart the resource.

### Judicial Police — set YOUR police jobs (required)

`Config.JudicialPolice.units` must list **your own** police job names, exactly as in your framework
(QBCore `shared/jobs.lua`, Qbox `qbx_core/shared/jobs.lua`, ESX `jobs` table). Otherwise nobody gets the alarm.

```lua
units = {
    { job = 'police',  label = 'LSPD', commandMinGrade = 3 },   -- grade 3+ gets the alarm + can claim/assign
    { job = 'sheriff', label = 'BCSO', commandMinGrade = 3 },
    -- { job = 'swat', label = 'SWAT', commandMinGrade = 3, highRiskOnly = true },
},
```

Then check in the same block:

| Key | Set to |
|---|---|
| `routing` | which units get each request type first / as fallback |
| `locations.court` / `locations.prison` | your courthouse + prison entrance coords (GPS routes) |
| `dutyZone.coords` | courthouse entrance (duty target) |
| `gate` | optional metal detectors — `enabled = true` + one coord per arch |
| `onlyOnDuty` | `true` = only on-duty officers get the alarm |

### Archive (stash points + passwords)

`Config.Archive.Locations` = physical `ox_target` points (e.g. 2× City Hall, PD, hospital).  
Not separate inventories — every point opens **your role stash** after **your role password**.

| What | Where |
|------|--------|
| Add / remove points | `Config.Archive.Locations` — `{ label, coords, heading }` |
| Passwords per role | `Config.Archive.Passwords` — **change before go-live** |
| Only `document_a4` | `AllowedItems = { 'document_a4' }` (blocks junk / abuse) |
| Per-role stash | `UseRoleStashes = true` → `doj_archive_<role>`; citizen = personal |

Full detail: root `README.md` → **Archive (how stashes work)**.

---

## What this version includes (buyer FAQ)

| Issue | Fix / note |
|-------|------------|
| Panel shows Citizen despite SQL | `doj_roles.citizenid` must equal live framework id; relog |
| Use deletes item / does nothing | `consume = 0` + export = exact folder name |
| Use opens empty English frame | Check `web/dist/forms_<lang>/` is complete; Court viewer does not need printeri |
| Form half EN / half locale | Sync `web/dist/forms_*` for all languages |
| Laws still English | Set `Config.Locale`; restart. Empty texts: run `nevera_court_laws.sql` once |
| ox_target / qb-target missing | Optional; F5 panel key still works |
| Judicial Police alarm reaches nobody | `units[].job` = exact job names, grade ≥ `commandMinGrade`, player on duty |
| Request form shows no units | `config.lua` on the server is old / `units` empty — restart |

---

## Verify

```sql
SELECT COUNT(*) FROM doj_laws;                              -- ~93
SELECT COUNT(*) FROM doj_laws WHERE title_hr IS NOT NULL;   -- ~93 after 03
SELECT COUNT(*) FROM doj_laws WHERE title_es IS NOT NULL;   -- ~93 after 03
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

In-game: relog → F5 → Supreme Court → print form → inventory → **Use** → filled document.
