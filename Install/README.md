# Nevera Court — INSTALL (Tebex)

Do steps **in order**. Keep this folder with the resource.

```
Install/
  README.md
  companion/                    ← bl_bridge + nevera_printeri (shipped with Court)
  companion/README.md
  sql/01 … 04
  items/ox_inventory_document_a4.lua
  items/qbx_core_document_a4.lua   ← Qbox: inventory how-to
```

**In-game usage:** F7 / radial — see root `README.md` (Features).

---

## Requirements

| Resource | Required | Why |
|----------|----------|-----|
| `oxmysql` | Yes | Database |
| `ox_lib` | Yes | Notify, keybinds, callbacks |
| `ox_inventory` | Yes | `document_a4` item |
| `ox_target` | Recommended | Courthouse eye zones (F7 works without it) |
| Framework (ESX / QB / Qbox) | Yes | Auto bridge |
| **`nevera_printeri`** | **Yes** (inventory Use) | Opens filled form — **in `Install/companion/`** |
| **`bl_bridge`** | **Yes** (printer dep) | **in `Install/companion/`** — printer will not start without it |

Notify *nevera_printeri must be started* = printer not ensured.

### server.cfg order

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory
ensure ox_target
ensure qbx_core               # or es_extended / qb-core

setr bl:framework   "qbx"     # qb | esx | qbx
setr bl:inventory   "ox"
setr bl:target      "ox"
setr bl:context     "ox"
setr bl:progressbar "ox"
setr bl:radial      "ox"
setr bl:notify      "ox"
setr bl:textui      "ox"

ensure bl_bridge
ensure nevera_printeri
ensure Nevera_Court
```

Full copy steps: **[`companion/README.md`](companion/README.md)**.

Recommended folder name: **`Nevera_Court`** (must match item export).

---

## SQL (first install — all frameworks)

Same schema for every framework — run in order:

```
sql/01 → sql/02 → sql/03 → sql/04
```

| File | What |
|------|------|
| `01_nevera_court.sql` | Tables + `title_hr/de/fr/es` columns |
| `02_seed_laws_english.sql` | English NKZ base (~93) |
| `03_seed_laws_i18n.sql` | **HR + DE + FR + ES** titles |
| `04_first_supreme_court.sql` | First Supreme Court admin |

Edit `04_first_supreme_court.sql`:
- QB: short `citizenid`
- ESX: exact `users.identifier` (e.g. `char1:…`) — must match 1:1

---

## Item `document_a4` (ox_inventory)

### Qbox (`qbx_core`)

`qbx_core` has **no** `shared/items.lua`. Define the item **only** in `ox_inventory/data/items.lua`.  
See **`Install/items/qbx_core_document_a4.lua`**.

### All frameworks (same Lua block)

1. Paste `Install/items/ox_inventory_document_a4.lua` into `ox_inventory/data/items.lua`
2. Copy `document_a4.png` → `ox_inventory/web/images/`
3. **Do not** paste a second `document_a4` from `nevera_printeri/install/ox_items.lua` (overwrites Court)

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
| Use opens empty English frame | Need **`nevera_printeri`** started (baked HTML viewer) |
| Form half EN / half locale | Sync `web/dist/forms_*` for all languages |
| Laws still English | Run `03`; set `Config.Locale`; restart |
| ox_target missing | Optional; F7 still works |

---

## Verify

```sql
SELECT COUNT(*) FROM doj_laws;                              -- ~93
SELECT COUNT(*) FROM doj_laws WHERE title_hr IS NOT NULL;   -- ~93 after 03
SELECT COUNT(*) FROM doj_laws WHERE title_es IS NOT NULL;   -- ~93 after 03
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

In-game: relog → F7 → Supreme Court → print form → inventory → **Use** → filled document.
