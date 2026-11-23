# Nevera Court — INSTALL (Tebex)

Do steps **in order**. Keep this folder with the resource.

```
Install/
  README.md
  sql/01 … 04, 07, 08, 09, 10, 11  ← first install
  sql/05_* and 06_*    ← upgrade only (existing DBs)
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

Court **does not** require `nevera_printeri` to view printed forms.

### server.cfg order

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory           # or: ensure qb-inventory  (not both unless you force provider)
ensure ox_target              # or: ensure qb-target
ensure qbx_core               # or es_extended / qb-core

ensure nevera_printeri        # optional — only if you bought it separately
ensure Nevera_Court
```

Recommended folder name: **`Nevera_Court`** (must match item export).

**Database editor permission** (laptop → Tools → Database). Nobody has it by default, not even Supreme Court. Grant it only to people you fully trust:

```cfg
add_ace qbcore.god nevera.court.db allow                    # e.g. only server owners
# add_ace identifier.license:xxxxxxxx nevera.court.db allow # or one person
```

---

## SQL

### Fresh install (all frameworks)

Run **only** these, in order:

```
sql/01 → sql/02 → sql/03 → sql/04 → sql/07 → sql/08 → sql/09 → sql/10 → sql/11
```

| File | What |
|------|------|
| `01_nevera_court.sql` | Tables (includes `title_hr/de/fr/es`, `sig_hash`, `image_url`) |
| `02_seed_laws_english.sql` | English NKZ base (~93) |
| `03_seed_laws_i18n.sql` | **HR + DE + FR + ES** titles |
| `04_first_supreme_court.sql` | First Supreme Court admin |
| `07_judicial_police.sql` | Judicial Police requests |
| `08_court_extras.sql` | Court services (licences, appointments, treasury, appeals, expungement, plea deals, evidence, minutes) |
| `09_court_procedure.sql` | Court procedure (plea columns, probation / community service, restraining orders, pre-trial detention) |
| `10_house_arrest.sql` | House arrest + ankle monitor |
| `11_db_editor.sql` | Database editor history (`doj_db_history`) |

**Do not** run `05_*` / `06_*` on a new database — those columns are already in `01`.

### Upgrade only (existing Court DB)

Skip if you just ran `01`–`04` on an empty database.

| File | When |
|------|------|
| `05_migrate_laws_i18n_columns.sql` | Old DB without `title_hr/de/fr/es` — then re-run `03` |
| `05_seed_laws_es.sql` | Old DB that has i18n columns but missing Spanish titles (fresh `03` already has ES) |
| `06_migrate_forms_sig_image.sql` | Old DB without `doj_forms.sig_hash` / `image_url` |
| `sql/upgrade/*` | Same idea — existing servers only |

Edit `04_first_supreme_court.sql`:
- QB: short `citizenid`
- ESX: exact `users.identifier` (e.g. `char1:…`) — must match 1:1

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
| `en` / `hr` / `de` / `fr` / `es` | `locales/*.lua` | `web/dist/forms_*` | seeded in `03` |

NUI reads **`web/dist/`** only. After editing forms, sync all `public/forms_*` → `dist/forms_*`.

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
| Use opens empty English frame | Rebuild / sync `web/dist/forms_*`; Court viewer does not need printeri |
| Form half EN / half locale | Sync `web/dist/forms_*` for all languages |
| Laws still English | Run `03`; set `Config.Locale`; restart |
| ox_target / qb-target missing | Optional; F5 panel key still works |

---

## Verify

```sql
SELECT COUNT(*) FROM doj_laws;                              -- ~93
SELECT COUNT(*) FROM doj_laws WHERE title_hr IS NOT NULL;   -- ~93 after 03
SELECT COUNT(*) FROM doj_laws WHERE title_es IS NOT NULL;   -- ~93 after 03
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

In-game: relog → F5 → Supreme Court → print form → inventory → **Use** → filled document.
