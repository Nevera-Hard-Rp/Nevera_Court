-- ============================================================
--  nevera_court / config_fines.lua   (escrow-open — edit freely)
--  FINE CALCULATOR (panel → Fines tab)
--
--  • id         = unique key. Built-in ids are translated in locales/*.lua
--                 (fine_cat_<id> / fine_mod_<id>). For your OWN ids add a `label`.
--  • label      = optional text shown instead of the translation
--  • baseAmount = amount added when the offence is ticked
--  • multi      = modifier multiplier (1.50 = +50 %, 0.75 = −25 %)
--                 If you change a built-in multi, also set a `label`
--                 (the translations contain the old percentage).
--
--  The PENAL CODE (articles, fine & prison ranges used for verdicts) lives
--  in the database — edit it in-game: /court → Penal code editor
--  (Supreme Court / ACE nevera.sudstvo.admin).
-- ============================================================

Config.FineCalculator = {
    -- Hard ceiling for one fine issued from the calculator (0 = no ceiling)
    maxTotal = 250000,

    categories = {
        { id = 'murder',              baseAmount = 50000 },
        { id = 'aggravated_murder',   baseAmount = 60000 },
        { id = 'attempted_murder',    baseAmount = 35000 },
        { id = 'assault',             baseAmount = 3000  },
        { id = 'aggravated_assault',  baseAmount = 20000 },
        { id = 'robbery',             baseAmount = 18000 },
        { id = 'kidnapping',          baseAmount = 50000 },
        { id = 'drug_trafficking',    baseAmount = 25000 },
        { id = 'drug_possession',     baseAmount = 10000 },
        { id = 'theft',               baseAmount = 6000  },
        { id = 'vehicle_theft',       baseAmount = 6000  },
        { id = 'evading_police',      baseAmount = 5000  },
        { id = 'illegal_weapon',      baseAmount = 20000 },
        { id = 'corruption',          baseAmount = 25000 },
        -- Example of your own offence:
        -- { id = 'illegal_fishing', label = 'Illegal Fishing', baseAmount = 1500 },
    },

    modifiers = {
        { id = 'repeat_offender',     multi = 1.50 },
        { id = 'organized_crime',     multi = 1.25 },
        { id = 'minor_victim',        multi = 1.30 },
        { id = 'mitigating',          multi = 0.75 },
        { id = 'police_cooperation',  multi = 0.80 },
        -- { id = 'holiday', label = 'Holiday season (+10%)', multi = 1.10 },
    },
}
