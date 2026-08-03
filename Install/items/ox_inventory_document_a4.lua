-- Paste into ox_inventory/data/items.lua
--
-- Qbox (qbx_core): isti blok — qbx NEMA vlastiti items.lua; samo ox_inventory.
-- Detalji: Install/items/qbx_core_document_a4.lua + Install/companion/README.md
--
-- IMPORTANT: export resource name MUST match the folder name exactly (case-sensitive).
--   Folder Nevera_Court  →  export = 'Nevera_Court.viewDocument'
--   Folder nevera_court  →  export = 'nevera_court.viewDocument'
--
-- consume = 0  → document is NOT deleted when opened
-- stack = false → each print keeps its own metadata
--
-- Copy Install/items/document_a4.png → ox_inventory/web/images/document_a4.png
--
-- Viewing filled forms also needs nevera_printeri started
-- (shipped in Install/companion/nevera_printeri + bl_bridge).

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
