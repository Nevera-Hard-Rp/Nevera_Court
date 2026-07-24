-- ============================================================
--  Install/items/qbcore_document_a4.lua
--  Paste into qb-core/shared/items.lua (inside Shared.Items / QBShared.Items)
--
--  Image: copy Install/items/document_a4.png →
--    qb-inventory/html/images/document_a4.png
--    (or ps-inventory / lj-inventory images folder)
--
--  Opening filled forms still needs nevera_printeri (viewDocument).
--  Prefer ox_inventory + export when possible.
-- ============================================================

document_a4 = {
    name        = 'document_a4',
    label       = 'Court Document',
    weight      = 50,
    type        = 'item',
    image       = 'document_a4.png',
    unique      = true,   -- one metadata per item (form id, case, etc.)
    useable     = true,
    shouldClose = true,
    combinable  = nil,
    description = 'Official DOJ legal document',
},

-- Older qb-core style (if your items.lua still uses ['name'] = { ... }):
--[[
['document_a4'] = {
    ['name']        = 'document_a4',
    ['label']       = 'Court Document',
    ['weight']      = 50,
    ['type']        = 'item',
    ['image']       = 'document_a4.png',
    ['unique']      = true,
    ['useable']     = true,
    ['shouldClose'] = true,
    ['combinable']  = nil,
    ['description'] = 'Official DOJ legal document',
},
]]
