# Nevera Court — ESX instalacija (SQL) — PRVA INSTALACIJA

Za **ESX kupce** ovo je tvoj **`01`** umjesto `Install/sql/01_nevera_court.sql`.

## Zašto?

Neki MySQL/MariaDB hostovi (često uz ESX) bacaju:

```text
#1067 - Invalid default value for 'indictment_deadline'
```

Ovdje su nullable datumi `DATETIME NULL DEFAULT NULL` — radi na striktnom `sql_mode`.

## Prva instalacija (ESX) — redoslijed

```
1. ESX_instalacija/01_nevera_court.sql
2. sql/02_seed_laws_english.sql
3. sql/03_seed_laws_i18n.sql
4. sql/04_first_supreme_court.sql   ← uredi ESX identifier + ime
```

Zatim: `Config.Locale`, item `document_a4`, `ensure nevera_court` — vidi glavni `Install/README_HR.md`.

## Ne pokreći pri prvoj instalaciji

- `sql/upgrade/` — **ne**
- `esx_identifier_length.sql` — **ne** (već je `VARCHAR(100)`; rješava se u kasnijoj nadogradnji za stare baze)

## Djelomičan stari `01`?

Ako je `doj_roles` nastao, a `doj_cases` nije — pokreni ovaj ESX `01` (nastavit će s ostatkom), ili dropaj sve `doj_*` i kreni ispočetka.
