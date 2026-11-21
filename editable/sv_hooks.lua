-- ============================================================
--  nevera_court | editable/sv_hooks.lua   (OPEN — not encrypted)
--  Server hooks: plug your own scripts in WITHOUT touching the
--  encrypted core. Every function is optional — leave it empty.
-- ============================================================

CourtHooks = CourtHooks or {}

--- A verdict was entered (normal verdict or approved plea deal).
--- @param case_number string
--- @param verdict string  'guilty' | 'not_guilty' | 'mistrial'
--- @param judgeSrc number server id of the judge
function CourtHooks.OnVerdict(case_number, verdict, judgeSrc)
    -- e.g. exports['my_mdt']:AddConviction(case_number, verdict)
end

--- Money arrived in (or left) the DOJ treasury.
--- @param amount number  (+ deposit / - withdrawal)
--- @param source_type string 'fine' | 'fee' | 'exam_fee' | 'bail_forfeit' | 'withdrawal'
--- @param reference string|nil case number / form type
function CourtHooks.OnMoneyIn(amount, source_type, reference)
    -- e.g. exports['my_banking']:AddSocietyMoney('doj', amount)
end

--- Court services events (appeal, expungement, plea deal, licence, session).
--- @param name string  'appeal_filed' | 'appeal_granted' | 'appeal_denied' | 'expungement_granted'
---                     | 'plea_approved' | 'licence_approved' | 'licence_revoked' | 'session_closed'
--- @param data table   event data (case_number, citizenid, …)
function CourtHooks.OnCourtEvent(name, data)
end
