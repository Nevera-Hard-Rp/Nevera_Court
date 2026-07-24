# Nevera Court — MDT Integration

Nevera Court syncs warrants, cases, verdicts, and commitment orders to popular police MDTs via a bridge.

**Read the sync-level table before buying / configuring.** Not every MDT has the same push API.

---

## Sync levels (honest)

| Provider | Auto-detect | Sync level | What actually happens |
|----------|-------------|------------|------------------------|
| `tk_mdt` | Yes (highest priority) | **Full sync** | Uses TK exports: reports, warrants, incidents, calls |
| `advanced` | **No** — manual only | **Partial → Full** | Needs `Config.MDT.resourceName`; probes CreateWarrant / CreateIncident / etc. |
| `ps-mdt` | Yes | **Partial / Events** | Stock has **no** CreateWarrant. Events fire; apply `Install/patches/ps-mdt_nevera_warrant.lua` for real rows |
| `ox_mdt` | Yes (lowest) | **Events only** | Upstream API still WIP — listen to `nevera_court:mdt:*` / `ox_mdt:nevera:*` |

Marketing claim that is accurate: *“MDT bridge for tk_mdt (full), Advanced MDT (manual), ps-mdt (patch), ox_mdt (events).”*  
**Do not** claim “warrants appear in all 4 MDTs out of the box.”

---

## Supported resources

| Provider key | Resource folder | Notes |
|--------------|-----------------|--------|
| `tk_mdt` | `tk_mdt` | Strongest stock push API |
| `ps-mdt` | `ps-mdt` | Free / Project Sloth — apply patch for warrant rows |
| `ox_mdt` | `ox_mdt` | Events only until stable create APIs |
| `advanced` | **your** folder (e.g. `p_mdt`) | Set `resourceName` — never guessed |

---

## Config (`config.lua`)

```lua
Config.MDT = {
    enabled  = true,
    -- auto priority: tk_mdt → ps-mdt → ox_mdt  (advanced never auto)
    provider = 'auto',       -- 'auto' | 'tk_mdt' | 'ps-mdt' | 'ox_mdt' | 'advanced' | 'none'
    resourceName = nil,      -- REQUIRED when provider = 'advanced', e.g. 'p_mdt'
    trustedInvokers = {      -- who may call IssueFine / CreateFormProgrammatically
        'ps-mdt',
        'tk_mdt',
    },
    syncWarrants    = true,
    syncCases       = true,
    syncVerdicts    = true,
    syncCommitments = true,
}
```

`auto` picks the first **started** MDT by priority: **tk_mdt → ps-mdt → ox_mdt**.

Advanced is **never** auto-detected (wrong folder = wrong product). Use:

```lua
Config.MDT.provider = 'advanced'
Config.MDT.resourceName = 'p_mdt'   -- exact Keymaster folder name
```

Set `provider = 'none'` or `enabled = false` to disable push sync (exports / events still available).

### Trusted invokers (SUD-004)

Only `GetCurrentResourceName()` (this resource, whatever the folder is called) plus names in `trustedInvokers` may call `IssueFine` / `CreateFormProgrammatically`.

Do **not** add a generic name like `mdt` — anyone can create a resource with that folder name.

Add your Advanced MDT folder to `trustedInvokers` **or** set `resourceName` (that name is also trusted).

Programmatic form creation is always written to `doj_audit_log` with the invoker name.

---

## What Nevera Court pushes TO the MDT

| Court event | When | Bridge method |
|-------------|------|----------------|
| Warrant approved | Judge approves AW/SW | `NotifyWarrant` |
| Case created | New criminal/civil case | `NotifyCase` |
| Verdict entered | Judge closes with verdict | `NotifyVerdict` |
| Commitment order | Guilty + prison minutes | `NotifyCommitment` |

Always also fires Lua events (any custom script can listen):

```lua
AddEventHandler('nevera_court:mdt:warrant', function(data) end)
AddEventHandler('nevera_court:mdt:case', function(data) end)
AddEventHandler('nevera_court:mdt:verdict', function(data) end)
AddEventHandler('nevera_court:mdt:commitment', function(data) end)
AddEventHandler('nevera_court:mdt:any', function(eventName, data) end)
```

If the MDT resource restarts after Nevera Court, the bridge **re-probes** automatically (`onResourceStart`).

---

## What MDT / other scripts call FROM Nevera Court

**Resource name in `exports['…']` must match your folder name** (case-sensitive).

```lua
local laws   = exports['Nevera_Court']:GetLaws()          -- if folder is Nevera_Court
local case   = exports['nevera_court']:GetCase('CR-2026-00001') -- if folder is nevera_court
```

### MDT helper exports

```lua
local provider = exports[GetCurrentResourceName()]:MDT_GetProvider()
local felon    = exports[...]:MDT_IsFelon(cid)     -- ps-mdt; nil if unsupported
local hasW     = exports[...]:MDT_HasWarrant(cid)  -- tk_mdt / advanced; nil if unsupported
```

### Programmatic forms / fines

```lua
-- Caller resource must be in Config.MDT.trustedInvokers
local formId, err = exports['Nevera_Court']:CreateFormProgrammatically(
    'criminal_pre_filing',
    'CR-2026-00001',
    officerCitizenId,
    { notes = 'Filed from MDT after booking' }
)
```

---

## Per-MDT notes

### tk_mdt (recommended when installed)

- Full sync via `createPoliceReport`, `addCall`, `createIncident`, `doesPlayerHaveWarrant`, …
- Highest auto-detect priority.

### ps-mdt

1. Copy or paste `Install/patches/ps-mdt_nevera_warrant.lua` into `ps-mdt` server scripts.
2. Without the patch: events fire, **no warrant row** in stock ps-mdt.
3. Official stock exports: `IsCidFelon`, `OpenMDT`, weapon helpers — not CreateWarrant.

### ox_mdt

- Events only (`ox_mdt:nevera:*` + `nevera_court:mdt:*`).
- Prefer event listeners until ox_mdt publishes stable create APIs.

### Advanced MDT (asset ~5319152)

```lua
Config.MDT.provider = 'advanced'
Config.MDT.resourceName = 'p_mdt'
Config.MDT.trustedInvokers = { 'ps-mdt', 'tk_mdt', 'p_mdt' }
```

- No folder guessing (`pscripts_mdt` / `qf-mdt` are different products).
- Bridge probes CreateWarrant / CreateIncident / AddAlert when present; always emits events.

---

## Linking an MDT incident to a court case

Fill **MDT Incident ID** when creating a case → stored on `doj_cases.mdt_incident_id`.

---

## Debug

```lua
Config.Debug = true
Config.MDT.provider = 'auto'
```

```
[nevera_court] mdt bridge: tk_mdt
```

---

## Files (escrow_ignore — editable)

```
bridge/mdt/helpers.lua
bridge/mdt/ps.lua
bridge/mdt/tk.lua
bridge/mdt/ox.lua
bridge/mdt/advanced.lua
server/sv_mdt.lua
Install/patches/ps-mdt_nevera_warrant.lua
config.lua → Config.MDT
```
