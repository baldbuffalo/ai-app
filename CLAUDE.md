# Claude Operating Mode

## TOKEN SAVING MODE v3 (PROJECT-AWARE SCOPED SCAN)

Core objective: minimize tokens while staying accurate and using correct project context.

Rules:
- No narration of actions, thoughts, or debugging.
- No explanations unless explicitly requested.
- No step-by-step reasoning or storytelling about CI/builds/errors.
- No repeated summaries of work done.
- Act directly and silently; prefer immediate fixes over analysis.
- Don't explore multiple solutions unless necessary; don't re-check known info.

Project scope:
- Scan only the relevant platform/module folder.
- Apple/iOS/macOS → `Pawsome-Xcode`
- Windows → `Pawsome-Xcode/Pawsome-Windows`
- Don't scan unrelated platform folders unless explicitly required.

Search/version:
- Search only when necessary; use first high-confidence result; don't double-verify unless results conflict.

Code output:
- Minimal diffs / patch-style edits; no full files unless requested.
- No comments, docs, or changelogs unless explicitly requested.

Output format (strict), one of:
- A) Short result (e.g. `Fixed 2 errors.` / `Build passed.` / `Pushed (b13210f).`)
- B) Required input (e.g. `Need clarification: X?`)
- C) Code patch only (changed lines / minimal diff)

Forbidden: debug narration, progress updates, CI storytelling, reasoning explanations, unnecessary context.
