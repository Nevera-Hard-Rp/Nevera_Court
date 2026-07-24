-- Paste into ox_inventory/data/items.lua
--
-- IMPORTANT: export resource name MUST match the folder name exactly (case-sensitive).
--   Folder Nevera_Court  →  export = 'Nevera_Court.viewDocument'
--   Folder nevera_court  →  export = 'nevera_court.viewDocument'
--
-- consume = 0  → document is NOT deleted when opened
--
-- Copy Install/items/document_a4.png → ox_inventory/web/images/document_a4.png

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
