-- ============================================================
--  Install/items/qbx_core_document_a4.lua
--  Qbox (qbx_core) — KAKO DODATI document_a4 U INVENTAR
-- ============================================================
--
--  qbx_core NEMA shared/items.lua kao stari qb-core.
--  Qbox koristi ox_inventory → item ide SAMO u:
--      ox_inventory/data/items.lua
--
--  Koraci:
--    1) Zalijepi blok ispod u ox_inventory/data/items.lua (unutar return { ... })
--    2) Kopiraj Install/items/document_a4.png → ox_inventory/web/images/document_a4.png
--    3) ensure bl_bridge + nevera_printeri + Nevera_Court (vidi Install/companion/README.md)
--    4) restart ox_inventory, nevera_printeri, Nevera_Court
--
--  export MORA = ime FOLDERA resursa (case-sensitive):
--    Folder Nevera_Court  →  'Nevera_Court.viewDocument'
--    Folder nevera_court  →  'nevera_court.viewDocument'
--
--  consume = 0  → dokument se NE briše na Use
--  stack = false → svaki ispis ima svoj metadata (HTML/url)
--
--  Ako vidiš "nevera_printeri must be started" / Pisač:
--    → resource nevera_printeri nije started (kopiraj iz Install/companion/)
-- ============================================================

['document_a4'] = {
    label = 'Court Document',
    weight = 50,
    stack = false,
    close = true,
    consume = 0,
    description = 'Official DOJ legal document',
    client = {
        image = 'document_a4.png',
        export = 'Nevera_Court.viewDocument',
    },
},
