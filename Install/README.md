# Nevera Court — INSTALL (Tebex)

Do steps **in order**. Keep this folder with the resource.

```
Install/
  README.md / README_HR.md
  USER_GUIDE.md                     ← how each panel tab works (staff & players)
  ESX_instalacija/01_nevera_court.sql   ← ESX (#1067 safe)
  sql/01 … 04
  sql/upgrade/                          ← NOT for first install
  items/ox_inventory_document_a4.lua
```

**In-game usage (sidebar, jury, commands):** see [`USER_GUIDE.md`](USER_GUIDE.md).
---

## Requirements

| Resource | Required | Why |
|----------|----------|-----|
| `oxmysql` | Yes | Database |
| `ox_lib` | Yes | Notify, keybinds, callbacks |
| `ox_inventory` | Yes | `document_a4` item |
| `ox_target` | Recommended | Courthouse eye zones (F7 works without it) |
| Framework (ESX / QB / Qbox) | Yes | Auto bridge |
| **`nevera_printeri`** | **Yes** (for inventory Use) | Opens filled form like Discord / QB style |

**Not required for Court:** `bl_bridge` (used by `nevera_printeri`), `nevera_menuguard` (optional soft lock).

### server.cfg order

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory
ensure ox_target
ensure es_extended          # or qb-core / qbx_core
ensure nevera_printeri
ensure Nevera_Court         # folder name is case-sensitive
```

Recommended resource folder name: **`Nevera_Court`** (must match item export).

---

## SQL (first install)

### QBCore

```
sql/01 → sql/02 → sql/03 → sql/04
```

### ESX (all ESX buyers)

```
ESX_instalacija/01 → sql/02 → sql/03 → sql/04
```

If `sql/01` fails with `#1067 Invalid default value for 'indictment_deadline'`, use `ESX_instalacija/01`.

Do **not** run `sql/upgrade/` on a fresh database.

Edit `04_first_supreme_court.sql`:
- QB: short `citizenid`
- ESX: exact `users.identifier` (e.g. `char1:…`) — must match 1:1

---

## Item `document_a4` (ox_inventory)

1. Paste `Install/items/ox_inventory_document_a4.lua` into `ox_inventory/data/items.lua`
2. Copy `document_a4.png` → `ox_inventory/web/images/`

**Critical:**

```lua
consume = 0,  -- otherwise ox DELETES the item on Use
export = 'Nevera_Court.viewDocument',  -- MUST match folder name (case-sensitive)
```

If your folder is `nevera_court`, change export to `nevera_court.viewDocument`.  
F8 error `No such export viewDocument in resource nevera_court` = wrong casing.

---

## Config

```lua
Config.Locale = 'en'       -- en | hr | de | fr
Config.Framework = 'auto'  -- or 'esx' | 'qb' | 'qbox'
```

DOJ roles live in `doj_roles` (not ESX `users.group` / QB job alone).

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

## What this version fixes (buyer FAQ)

| Issue | Fix / note |
|-------|------------|
| MySQL #1067 on ESX | Use `ESX_instalacija/01` |
| Panel shows Citizen despite SQL | `doj_roles.citizenid` must equal live framework id; relog |
| Use deletes item / does nothing | `consume = 0` + export = exact folder name |
| Use opens empty English frame | Need **`nevera_printeri`** started (baked HTML viewer) |
| ox_target missing | Optional; F7 still works |

---

## Verify

```sql
SELECT COUNT(*) FROM doj_laws;  -- ~93
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

In-game: relog → F7 → Supreme Court → print form → inventory → **Use** → filled document.
