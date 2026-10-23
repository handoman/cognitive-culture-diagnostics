# Changelog  
All notable changes to this project are documented here.

This project follows [Semantic Versioning](https://semver.org/) and the structure of [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.4.0] – 2026‑10‑23
### Changed
- Monograph-wide language pass: reframed clinical/population-level claims about SCC and MLCC as first-person, single-subject observations rather than claims about groups (e.g. "personer med SCC" → "jag", generic "ofta" claims struck or replaced with "i mitt fall")
- Chapters 4–5 (SCC/MLCC): prevalence claims softened to personal assumptions; dialogue examples and bullet lists reframed in first person
- Chapter 6 (Differentiation Matrix): matrix reduced from three profile columns to two ("hur mina svar lästes" vs. "hur jag beskriver processen bakom"); section intros and summary reframed as a personal mismatch record rather than a clinical differentiation tool
- Chapter 7 (Self-as-Instrument Design): introspection-quality claims reframed from a validity claim to a reliability claim
- Chapter 9 (Process Analysis): IDA/WAIS discussion personalized; §9.4 clinical-interaction examples moved to past tense and first person throughout
- Chapter 10 (Diagnostic Filter): intro and closing reframed as a personal retrospective rather than a general-purpose clinical filter
- Chapter 11 (Interviewing): opening rationale and closing claims reframed as "what worked for me" rather than clinician guidance; two concrete question formulations consolidated here from the removed Chapter 12 tool section
- Chapter 14 (Epistemology): systemic-pattern claim hedged explicitly as an untested personal hypothesis
- Chapter 15 (Future Diagnostics): conclusion reframed as conditional on similar patterns existing in others
- Appendix B: reframed as the author's own filled-in CCF sheet rather than a blank clinical mapping tool
- Appendix C: clinical checklist rewritten in full as a first-person "what helped me" list
- Appendix E: clinical pitfalls reframed as "how my answers were read" vs. "how I describe it"
- Appendix F: subtitle reframed as personal self-description; content otherwise unchanged

### Removed
- Chapter 12: CCF-Rapid Screen protocol, screening cutoffs, and the three clinical assessment tools (Process-Flow Elicitation, Cognitive-State Switchboard, Misalignment Detector) — replaced with a seven-question personal list ("Frågor som hade hjälpt mig")
- Chapter 13: three-question AST differential-diagnosis protocol, rigidity recalibration test, ADHD subtype recommendation, and the entire medication-guidance section (§13.4) — replaced with a one-line disclaimer that no treatment conclusions are drawn for anyone but the author
- Chapter 15: speculative national-guidelines / DSM-6 systems-development roadmap (§15.4)
- Chapter 16: societal-implications section (§16.5) — population-level claims removed as inapplicable to a single-subject case
- Appendix B: "Diagnostic implications" section (AST/SCC/MLCC risk indicators)

### Notes
- This revision aligns the monograph with its own single-subject-method commitments (policy brief §7.1) by removing or rewriting passages that implied population-level clinical guidance, diagnostic decision rules, or treatment recommendations derived from an n=1 case.

---

## [1.3.0] – 2026‑07‑16
### Added
- MkDocs with Material theme (`mkdocs.yml`, `requirements.txt`)
- Cloudflare Pages deployment — monograph published at https://ccf.csandberg.se/
- Custom domain `ccf.csandberg.se` via Cloudflare DNS
- Cloudflare Web Analytics (privacy-first, no cookies)
- Bing Webmaster Tools verification and sitemap submission
- Google Search Console verification and sitemap submission
- `llms.txt` for LLM crawler accessibility (served at `/llms.txt`)
- `overrides/main.html` for Bing verification meta tag
- ORCID profile created and linked to project
- Zenodo upload initiated for DOI assignment

### Changed
- All GEO/AI index files updated with canonical site URLs (ccf.csandberg.se)
- Web URLs added alongside repo paths in GEO-index.md and meta-CCF-concept-map.md
- Answer Units expanded and synced across all README-AI.md files
- content/en/ clarified: no English monograph planned, translation permitted under CC BY-SA 4.0
- Policy brief metadata block corrected (linebreaks, primary URL updated to ccf.csandberg.se)
- GitHub repo About section updated with site URL and topic tags
- Non-standard Unicode hyphens (U+2011) in README‑AI.md filenames corrected to standard hyphen

### Fixed
- Symlink for policy-brief resolved via file copy (Windows→Linux path compatibility)
- `custom_dir: overrides` added to mkdocs.yml (previously missing)

---

## [1.2.0] – 2026‑07‑01
### Added
- Full AI‑optimized documentation layer (README‑AI.md) for:
  - root level
  - content/sv/
  - meta/
  - policy‑brief/
  - appendices/
- GEO-index.md as a semantic navigation hub for the entire project
- meta-CCF-concept-map.md (complete text-based ontology)
- Relations matrix in table format
- Harmonized internal links across documentation layers

### Changed
- Ontology filename harmonized to `meta-CCF-concept-map.md`
- Improved semantic consistency across all documentation layers
- Updated root README.md with ontology reference

### Fixed
- Minor structural inconsistencies in the documentation hierarchy
- Ensured stable heading structure in all AI-index files

---

## [1.1.0] – 2026‑03‑03  
### Added
- New front page for the policy brief  
- CHANGELOG.md introduced  
- Updated root README.md with clearer structure and cross‑references  
- Linkage between monograph and policy brief  

### Changed
- Full linguistic harmonization across all chapters and appendices  
- Modal normalization (kan, ofta, tenderar att)  
- Reduced absolutism and dichotomies  
- Improved tonal consistency throughout the monograph  
- Updated terminology alignment in appendices  

### Fixed
- Minor editorial inconsistencies  
- Clarified several formulations that could be misinterpreted as normative  

---

## [1.0.0] – 2026‑02‑16  
### Added
- First full Swedish edition of the monograph  
- All appendices (A–F)  
- Meta documentation (structure, scope, methodology)  
- Initial policy brief  
