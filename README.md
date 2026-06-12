# MT4 / MQL4 Skill

This repository contains the `mql4-manual` skill exported from the netcupde OpenCode/agent skill environment.

## Manus import

Manus expects `SKILL.md` to be at the **root of the uploaded zip file**.

Use the packaged zip in this repo:

- `mt4-manus-skill.zip`

Its archive root contains:

- `SKILL.md`
- `references/`
- `README.md`
- `EXPORT-MANIFEST.txt`

Do **not** upload GitHub's automatic repository zip if Manus rejects nested folders, because GitHub wraps repository downloads inside a top-level directory like `mt4-main/`.

## Repository contents

- `SKILL.md` — Manus-compatible root skill entrypoint
- `references/` — Manus-compatible root reference files
- `mql4-manual/SKILL.md` — original exported skill entrypoint
- `mql4-manual/references/` — original exported MQL4 reference manual sections
- `mt4-manus-skill.zip` — ready-to-upload Manus skill zip with `SKILL.md` at archive root

## Scope

MetaTrader 4 / MQL4 programming reference for Expert Advisors, indicators, scripts, trading functions, account information, arrays, objects, strings, files, time/date, and technical indicator calls.
