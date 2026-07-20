# Nevera Court — INSTALL

Do these steps **in order**. Keep this folder next to the resource.

```
Install/
  README.md                 ← English (this file)
  README_HR.md              ← Croatian / Balkan
  MDT.md                    ← MDT bridge (sync levels + trustedInvokers)
  patches/
    ps-mdt_nevera_warrant.lua
  sql/
    01_nevera_court.sql          ← ① create tables
    02_seed_laws_english.sql     ← ② English NKZ
    03_seed_laws_i18n.sql        ← ③ HR / DE / FR law titles
    04_first_supreme_court.sql   ← ④ first Supreme Court admin
    upgrade/                     ← ONLY when upgrading (not fresh)
      upgrade_hr_to_en.sql
      migrate_law_i18n.sql
      esx_identifier_length.sql
  items/
    document_a4.png
    ox_inventory_document_a4.lua   ← ox_inventory
    qbcore_document_a4.lua         ← qb-core/shared/items.lua
    esx_document_a4.sql            ← legacy ESX `items` table only
```

---

## Requirements

| Resource | Required |
|----------|----------|
| `oxmysql` | Yes |
| `ox_lib` | Yes |
| Framework (ESX / QB / Qbox / OX) | Yes |
| Inventory (ox recommended) | Yes |
| MDT (optional) | See `Install/MDT.md` |
| `ox_target` | Recommended |

---

## Which SQL do I run?

### A) Brand new database (most buyers) — YOUR CASE after Drop

```
01 → 02 → 03 → 04
```

Skip the entire `upgrade/` folder.

### B) Upgrading old `nevera_sudstvo` (Croatian tables still exist)

```
upgrade/upgrade_hr_to_en.sql
→ 02 (only if doj_laws empty)
→ 03
→ 04
```

Do **not** run `01` on an old HR database.

### C) Old English Nevera Court (missing title_hr/de/fr columns)

```
upgrade/migrate_law_i18n.sql → 03
```

### D) Existing install — switching to ESX (long identifiers)

```
upgrade/esx_identifier_length.sql
```

Not needed after a fresh `01` (already `VARCHAR(100)`).

---

## Step-by-step (new install)

### 1. Database

1. Open HeidiSQL / phpMyAdmin on your FiveM DB  
2. Run **`sql/01_nevera_court.sql`**  
3. Run **`sql/02_seed_laws_english.sql`**  
4. Run **`sql/03_seed_laws_i18n.sql`**  
5. Edit **`sql/04_first_supreme_court.sql`** — replace `CITIZENID` + name → run it  

Verify:

```sql
SELECT COUNT(*) AS categories FROM doj_law_categories;  -- expect 9
SELECT COUNT(*) AS laws FROM doj_laws;                  -- expect ~93
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

### 2. Inventory item (`document_a4`)

| Setup | What to do |
|-------|------------|
| ox_inventory | Paste `items/ox_inventory_document_a4.lua` into `ox_inventory/data/items.lua` |
| qb-core | Paste `items/qbcore_document_a4.lua` into `qb-core/shared/items.lua` |
| Legacy ESX SQL items | Run `items/esx_document_a4.sql` |
| ESX + ox_inventory | Use **ox** file only (skip ESX SQL) |

Copy `items/document_a4.png` into your inventory images folder.

### 3. Resource

1. Put the resource folder in `resources/`  
2. `ensure nevera_court` (or restart server)  
3. Relog → open panel → role should be Supreme Court  

### 4. Language (optional)

```lua
Config.Locale = 'hr'   -- en | hr | de | fr
```
