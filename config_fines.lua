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
        { id = 'ubojstvo',           baseAmount = 50000 },
        { id = 'ubojstvo_2',         baseAmount = 60000 },
        { id = 'pokusaj_ubojstva',   baseAmount = 35000 },
        { id = 'napad',              baseAmount = 3000  },
        { id = 'napad_opasno',       baseAmount = 20000 },
        { id = 'pljacka',            baseAmount = 18000 },
        { id = 'otmica',             baseAmount = 50000 },
        { id = 'trgovina_drogom',    baseAmount = 25000 },
        { id = 'posjedovanje_droge', baseAmount = 10000 },
        { id = 'kradja',             baseAmount = 6000  },
        { id = 'kradja_vozila',      baseAmount = 6000  },
        { id = 'bjekstvo',           baseAmount = 5000  },
        { id = 'oruzje',             baseAmount = 20000 },
        { id = 'korupcija',          baseAmount = 25000 },
        -- Example of your own offence:
        -- { id = 'illegal_fishing', label = 'Illegal Fishing', baseAmount = 1500 },
    },

    modifiers = {
        { id = 'povratnik',    multi = 1.50 },  -- repeat offender
        { id = 'organizirani', multi = 1.25 },  -- organized crime
        { id = 'maloljetnik',  multi = 1.30 },  -- minor victim
        { id = 'olakotne',     multi = 0.75 },  -- mitigating circumstances
        { id = 'saradnja',     multi = 0.80 },  -- cooperation with police
        -- { id = 'holiday', label = 'Holiday season (+10%)', multi = 1.10 },
    },
}
