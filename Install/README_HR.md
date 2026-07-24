# Nevera Court — PRVA INSTALACIJA (Tebex / kupci)

Radi korake **redom**. Baza i exporti ostaju engleski. UI: `Config.Locale`.

```
Install/
  README_HR.md / README.md
  USER_GUIDE.md                     ← EN: how each panel tab works (staff/players)
  ESX_instalacija/01_nevera_court.sql   ← ESX (#1067 safe)
  sql/01 … 04
  sql/upgrade/                          ← NE za prvu instalaciju
  items/ox_inventory_document_a4.lua
```

**Kako koristiti panel (tabovi, porota, komande):** `Install/USER_GUIDE.md` (English).
---

## Ovisnosti (obavezno)

| Resource | Obavezno | Zašto |
|----------|----------|--------|
| `oxmysql` | da | baza |
| `ox_lib` | da | notify, keybind, NUI |
| `ox_inventory` | da | document_a4 item |
| `ox_target` | preporučeno | zone sudnice (bez njega radi F7) |
| Framework (ESX / QB / Qbox) | da | bridge auto |
| **`nevera_printeri`** | **da** (za Use dokumenta) | inventar otvara ispunjeni obrazac kao Discord/QB |

**Nije potrebno:** `bl_bridge` (to je za `nevera_printeri`, ne za Court), `nevera_menuguard` (opcionalno; Court radi i bez njega).

### server.cfg (redoslijed)

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory
ensure ox_target
ensure es_extended          # ili qb-core / qbx
ensure nevera_printeri      # PRIJE ili uz Court — za Use dokumenta
ensure Nevera_Court         # ime foldera = case-sensitive!
```

**Folder resourcea** mora se zvati točno kako piše u item exportu (vidi dolje). Preporuka: **`Nevera_Court`**.

---

## SQL — prva instalacija

### QBCore

```
sql/01 → sql/02 → sql/03 → sql/04
```

### ESX (svi ESX kupci)

```
ESX_instalacija/01 → sql/02 → sql/03 → sql/04
```

Ako `sql/01` padne na `#1067 Invalid default value for 'indictment_deadline'` → koristi `ESX_instalacija/01`.

**Ne pokreći** `sql/upgrade/` na novoj bazi.

`04_first_supreme_court.sql` — stavi svoj ID:
- QB: `citizenid` (npr. `ABC12345`)
- ESX: `users.identifier` (npr. `char1:…`) — mora biti **identičan** string

---

## Item `document_a4` (ox_inventory)

1. Zalijepi `Install/items/ox_inventory_document_a4.lua` u `ox_inventory/data/items.lua`
2. Kopiraj `document_a4.png` → `ox_inventory/web/images/`

**Kritično:**

```lua
consume = 0,   -- inače ox OBRIŠE dokument na Use
export = 'Nevera_Court.viewDocument',  -- mora = ime FOLDERA (velika/mala slova!)
```

Ako folder zoveš `nevera_court` → u itemu mora biti `nevera_court.viewDocument`.  
Greška u F8: `No such export viewDocument in resource nevera_court` = krivi case imena.

---

## Config

```lua
Config.Locale = 'hr'       -- en | hr | de | fr
Config.Framework = 'auto'  -- ili 'esx' / 'qb' / 'qbox'
```

ESX: `Config.ESX.AdminGroups` = admin grupe za ACE komande (nije DOJ uloga).  
DOJ uloga = `doj_roles` tablica (`supreme_court`, …).

### Arhiva (stash točke + lozinke)

`Config.Archive.Locations` = **fizičke** `ox_target` točke na mapi (npr. 2 u Općini, 1 PD, 1 bolnica).  
To **nisu** zasebni stashovi — na svakoj točki igrač otvara **svoj** stash uloge nakon **svoje** lozinke.

| Što | Gdje |
|-----|------|
| Dodaj / makni točke | `Config.Archive.Locations` — `{ label, coords, heading }` |
| Lozinke po ulozi | `Config.Archive.Passwords` — **promijeni prije live-a** |
| Samo `document_a4` u stash | `AllowedItems = { 'document_a4' }` (zaštita od zlouporabe) |
| Stash po ulozi | `UseRoleStashes = true` → `doj_archive_police`, `doj_archive_judge`, …; građanin = osobni |

Detalji: glavni `README.md` → **Archive (how stashes work)**.

---

## Što je novo (ESX / inventar popravci u ovoj verziji)

| Tema | Što kupac treba znati |
|------|------------------------|
| ESX SQL #1067 | `Install/ESX_instalacija/01` |
| ESX uloga Građanin | ID u `doj_roles` = `users.identifier`; relog; F7 |
| Inventar Use prazan / nestaje | `consume = 0` + točan `export` = ime foldera |
| Use = ispunjen obrazac | treba **`nevera_printeri`** started |
| ox_target error | opcionalno; bez njega F7 radi |
| menuguard | opcionalno |

---

## Provjera

```sql
SELECT COUNT(*) FROM doj_laws;            -- ~93
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

U igri: relog → F7 → Vrhovni sud → ispis obrasca → inventar → **Use** → ispunjen dokument (kao Discord).
