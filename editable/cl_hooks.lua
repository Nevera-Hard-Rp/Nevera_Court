-- ============================================================
--  nevera_court | editable/cl_hooks.lua   (OPEN — not encrypted)
--  Client hooks: change look / feel without touching the core.
-- ============================================================

CourtHooks = CourtHooks or {}

--- "All rise", "Order in the court", session open/close…
--- Return false to replace the default ox_lib notification with your own.
--- @param call string 'all_rise' | 'be_seated' | 'order' | 'recess' | 'open' | 'close'
--- @param text string translated text
function CourtHooks.OnCourtCall(call, text)
    -- e.g. play your own animation when everybody has to stand up:
    -- if call == 'all_rise' then ClearPedTasks(PlayerPedId()) end
    return true
end

--- Called on every client that hears the gavel. Return false to skip the built-in sound.
--- @param volume number 0.0 - 1.0 (already reduced by distance)
function CourtHooks.OnGavel(volume)
    return true
end
