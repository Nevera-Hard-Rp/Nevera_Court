# Nevera Court — izmjene za Tebex (sažetak za tebe)

Kod u `Nevera_Court_2` već sadrži ESX/inventar popravke.  
Za prodaju ažuriraj **Install README** (gotovo) + **item snipet** (gotovo) + prodajni opis ovisnosti.

## Kod (već u Nevera_Court_2)

| Fajl | Što |
|------|-----|
| `client/main.lua` | ESX `playerLoaded` + `DOJ_RefreshRole` + soft `nevera_menuguard` |
| `client/cl_nui.lua` | refresh uloge na F7 + MenuGuard close |
| `client/cl_keys.lua` | soft MenuGuard |
| `client/cl_document.lua` | Use → `nevera_printeri` (ispunjen HTML, bez Court okvira) |
| `client/cl_target.lua` | soft ox_target |
| `server/main.lua` | jedan `myRole` (Utils.GetRole); debug samo ako `Config.Debug` |
| `server/sv_roles.lua` | nema duplog `myRole` |
| `server/sv_printer.lua` | `getPrintedFormHtml` callback |
| `Install/ESX_instalacija/` | SQL bez #1067 |
| `Install/items/ox_inventory_document_a4.lua` | `consume = 0` + `Nevera_Court.viewDocument` |

## Install / README — što kupac mora vidjeti

1. **Ovisnosti:** oxmysql, ox_lib, ox_inventory, ox_target (preporuka), framework, **nevera_printeri**
2. **server.cfg redoslijed** (printeri prije/uz Court)
3. **ESX → ESX_instalacija/01**
4. **Item:** case-sensitive export = ime foldera + `consume = 0`
5. **FAQ:** Građanin / Use / #1067

## Tebex opis (kratko za listing)

Required: oxmysql, ox_lib, ox_inventory, ESX or QBCore/Qbox, **nevera_printeri** (document viewer).  
Optional: ox_target, nevera_menuguard.

## Ne diraj za ovaj release

- `sql/upgrade/esx_identifier_length.sql` — kasnija nadogradnja (kao što smo rekli)
- `bl_bridge` — nije Court dependency

## Prije upload-a na Tebex

1. Folder resourcea zovi **`Nevera_Court`** (ili uskladi item export)
2. Uključi `Install/` cijeli (README + ESX_instalacija + items)
3. Test: ESX Use dokumenta + QB Use dokumenta
4. Nemoj slučajno uploadati `Config.Debug = true`
