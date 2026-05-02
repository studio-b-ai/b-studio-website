# Firm Sites Design — consulting.b.studio · capital.b.studio · benchmarks.b.studio

**Date:** 2026-05-02  
**Priority:** Capital (deadline 2026-05-05) → Consulting → Benchmarks  
**Status:** Approved, ready for implementation

---

## Overview

Three separate GitHub Pages sites, each a single landing page for one Studio B firm. They share the Billboard DNA from b.studio but are not clones — each firm gets its own palette register (Direction A) while inheriting the same typographic and structural system.

---

## Visual System

**Direction A — palette rotation, existing colors only**

| Firm | Ground | Type | Accent |
|------|--------|------|--------|
| Consulting | Yolk `#F7D344` | Ink `#0D0D0D` | Vermillion `#D94425` |
| Capital | Forest `#1A3328` | Paper `#F4F1EB` | Yolk `#F7D344` |
| Benchmarks | Paper `#F4F1EB` | Ink `#0D0D0D` | Forest `#1A3328` |

**Shared DNA (non-negotiable):**
- Fraunces 900 display headlines (italic for accent word)
- JetBrains Mono for labels, tags, metadata
- Inter for body copy
- Diagonal caution stripe (`-45deg`, 8px alternating) — full weight on Consulting + Benchmarks, thinner treatment on Capital
- Hard borders (`3px solid`), no border-radius
- Ink `#0D0D0D` as structural separator

---

## Capital — capital.b.studio (Priority 1)

### Copy

**Headline:** Not sourced. Surfaced.

**Body:** The businesses we back have been in our network for years — advised, measured, and run alongside. We're not introduced to the opportunity. We're already trusted by the operator.

**CTA:** Book a call

**Tag:** Investment firm · $100M target · lower middle market · capital.b.studio

### Newsletter

- **Auto-enrolled:** SDLI Brief + Dispatch
- **Note:** Dispatch opt-in should be a visible checkbox (LP audience may not want operator newsletter as they broaden)

### Page Structure

1. **Hero** — full-viewport, forest ground, headline + body + CTA
2. **HubSpot booking tool** — inline embed, collects LP info on booking
3. **Footer** — links to Consulting, Benchmarks, b.studio

### Lead Flow

```
LP clicks "Book a call"
→ HubSpot booking tool (collects name, email, firm, note)
→ booking confirmed
→ Docsend data room link sent via email
→ enrolled: SDLI Brief (auto) + Dispatch (checkbox)
→ lp_stage = prospect
```

**Dependencies before go-live:**
- Docsend data room must exist
- HubSpot booking page configured + Docsend workflow built
- HubSpot meeting link

### Repo + DNS

- Repo: `studio-b-ai/capital-b-studio` (GitHub Pages)
- CNAME file: `capital.b.studio`
- GoDaddy: add `capital` CNAME → `studio-b-ai.github.io`

---

## Consulting — consulting.b.studio (Priority 2)

### Copy

**Headline:** We don't consult. We embed.

**Body:** Operators don't need more advice. They need someone in the room. Built on AI and scar tissue. We don't send decks — we show up.

**CTA:** Book a call

**Tag:** Services firm · consulting.b.studio

### Newsletter

- **Auto-enrolled:** Dispatch
- **Opt-in:** SDLI Brief (checkbox)

### Page Structure

1. **Hero** — yolk ground, headline + body + CTA
2. **HubSpot booking tool** — inline embed
3. **Footer** — links to Capital, Benchmarks, b.studio

### Repo + DNS

- Repo: `studio-b-ai/consulting-b-studio`
- CNAME: `consulting` → `studio-b-ai.github.io`

---

## Benchmarks — benchmarks.b.studio (Priority 3)

### Copy

**Headline:** Ground truth for the lower *middle market.*

**Body:** The lower middle market has benchmarks. Getting them costs a seat at the institutional table. We're building the open alternative: SDLI, a direct lending index constructed from observed deal data — not surveys, not self-reporting. Ground truth, democratized.

**CTA:** Get early access

**Tag:** Measurement firm · benchmarks.b.studio

### Newsletter

- **Auto-enrolled:** SDLI Brief
- **Opt-in:** Dispatch (checkbox)

### Page Structure

1. **Hero** — paper ground, headline + body + CTA
2. **Email capture form** — name, email, firm → HubSpot contact, enrolled per above
3. **Footer** — links to Consulting, Capital, b.studio

### Repo + DNS

- Repo: `studio-b-ai/benchmarks-b-studio`
- CNAME: `benchmarks` → `studio-b-ai.github.io`

---

## Shared Infrastructure

**Cross-site navigation:** Each footer links to all three firms + b.studio. No top nav (single page, nothing to navigate to).

**OG tags (required on all three per Rule #47):** `og:type`, `og:site_name`, `og:title`, `og:description`, `og:url`, `twitter:card=summary_large_image`

**Analytics:** Add to master-plan.md once decided (Fathom / Plausible / none)

**Fonts:** Load from Google Fonts (same as b.studio): Fraunces, JetBrains Mono, Inter

---

## Open Decisions

- Analytics provider (Fathom / Plausible / none)
- Whether SDLI gets a freemium + premium tier (affects Benchmarks page structure)
