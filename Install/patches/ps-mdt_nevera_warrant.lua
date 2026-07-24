-- ============================================================
--  Install/patches/ps-mdt_nevera_warrant.lua
--  Paste into ps-mdt/server/main.lua (or ensure this file is started
--  as part of ps-mdt server_scripts).
--
--  Stock ps-mdt has no CreateWarrant export. This listener turns
--  Nevera Court warrant events into MDT bulletin / warrant rows
--  using the same pattern as community patches.
--
--  Adjust the INSERT / export below to match YOUR ps-mdt DB schema
--  if it differs from the stock Project Sloth build.
-- ============================================================

AddEventHandler('nevera_court:mdt:warrant', function(data)
    if not data then return end

    local cid  = data.target_citizenid or data.citizenid
    local name = data.target_name or data.name or 'Unknown'
    local wnum = data.warrant_number or 'N/A'
    local wtype = data.warrant_type or 'arrest'
    local desc = data.offense_description or data.charges or data.reason or ''

    -- Preferred: if your ps-mdt fork exposes a create helper, call it.
    -- pcall so stock builds without the export still work via SQL fallback.
    local ok = pcall(function()
        if exports['ps-mdt'] and exports['ps-mdt'].CreateWarrant then
            exports['ps-mdt']:CreateWarrant({
                citizenid = cid,
                name = name,
                warrant_number = wnum,
                warrant_type = wtype,
                description = desc,
            })
            return
        end
        error('no_export')
    end)

    if ok then return end

    -- Fallback: insert into common ps-mdt warrants table (stock schema varies —
    -- uncomment and adjust column names for your build).
    --[[
    MySQL.insert.await(
        'INSERT INTO mdt_warrants (citizenid, linkedincident, name, reportid, expires) VALUES (?, ?, ?, ?, ?)',
        { cid, 0, name, 0, os.date('%Y-%m-%d %H:%M:%S', os.time() + 14 * 86400) }
    )
    --]]

    print(('[ps-mdt] Nevera Court warrant received: %s → %s (%s)'):format(wnum, tostring(cid), wtype))
end)

-- Optional: cases / verdicts (events only — wire to your MDT tables as needed)
AddEventHandler('nevera_court:mdt:case', function(data)
    if data then
        print(('[ps-mdt] Nevera Court case: %s defendant=%s'):format(
            tostring(data.case_number), tostring(data.defendant_citizenid)))
    end
end)

AddEventHandler('nevera_court:mdt:verdict', function(data)
    if data then
        print(('[ps-mdt] Nevera Court verdict: %s → %s'):format(
            tostring(data.case_number), tostring(data.verdict)))
    end
end)
