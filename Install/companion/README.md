# Companion resources

`nevera_printeri` is a **separate Tebex product**. It is **not** shipped inside Nevera Court (escrow would leak the paid printer source).

Nevera Court includes its own A4 viewer: inventory **Use** on `document_a4` opens the filled form in Court NUI.

If you also own **nevera_printeri** (needs `ox_inventory` + `ox_target`), `ensure` it **before** Court. Court will then open documents in the printer UI instead.

```cfg
ensure nevera_printeri    # only if purchased separately
ensure Nevera_Court
```

Do **not** paste a second `document_a4` from the printer item file (Court owns A4).
