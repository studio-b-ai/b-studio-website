# capital.b.studio Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship capital.b.studio — a single-page GitHub Pages landing page for Studio B Capital with locked copy, Direction A palette, HubSpot booking embed, and live DNS.

**Architecture:** Pure static HTML/CSS in a dedicated GitHub Pages repo (`studio-b-ai/capital-b-studio`). No build step, no framework. HubSpot meetings embed is an inline script tag. GoDaddy CNAME routes `capital.b.studio` to GitHub Pages.

**Tech Stack:** HTML5, CSS3 (custom properties), Google Fonts (Fraunces/JetBrains Mono/Inter), HubSpot Meetings embed, GitHub Pages, GoDaddy DNS API.

**Deadline:** 2026-05-05 (before CRM consolidation)

**Prerequisites (must exist before go-live):**
- HubSpot meeting link URL (Kevin to create in HubSpot → Sales → Meetings)
- Docsend data room URL (Kevin to confirm it exists)
- HubSpot workflow: booking confirmed → send Docsend link email (Kevin to build in HubSpot)

---

## File Map

| File | Purpose |
|------|---------|
| `index.html` | Full page — hero, booking embed, footer |
| `CNAME` | GitHub Pages custom domain declaration |

That's it. Two files.

---

### Task 1: Create GitHub repo and enable Pages

**Files:**
- Create: GitHub repo `studio-b-ai/capital-b-studio`
- Create: `CNAME`

- [ ] **Step 1: Create the repo**

```bash
gh repo create studio-b-ai/capital-b-studio \
  --public \
  --description "Studio B Capital landing page" \
  --clone
cd capital-b-studio
```

- [ ] **Step 2: Create the CNAME file**

```bash
echo "capital.b.studio" > CNAME
```

- [ ] **Step 3: Enable GitHub Pages on main branch**

```bash
gh api repos/studio-b-ai/capital-b-studio/pages \
  --method POST \
  -f source='{"branch":"main","path":"/"}'
```

Expected output: JSON with `"url": "https://studio-b-ai.github.io/capital-b-studio/"` and `"status": "queued"`

- [ ] **Step 4: Initial commit**

```bash
git add CNAME
git commit -m "init: enable GitHub Pages with custom domain"
git push -u origin main
```

---

### Task 2: Build index.html — full page

**Files:**
- Create: `index.html`

- [ ] **Step 1: Create index.html with full content**

Create `index.html` with the following complete content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Studio B Capital — Not sourced. Surfaced.</title>

  <!-- SEO -->
  <meta name="description" content="The businesses we back have been in our network for years — advised, measured, and run alongside. We're not introduced to the opportunity. We're already trusted by the operator.">

  <!-- OG tags (Rule #47) -->
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="Studio B Capital">
  <meta property="og:title" content="Not sourced. Surfaced.">
  <meta property="og:description" content="The businesses we back have been in our network for years — advised, measured, and run alongside. We're not introduced to the opportunity. We're already trusted by the operator.">
  <meta property="og:url" content="https://capital.b.studio">
  <meta name="twitter:card" content="summary_large_image">

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,900;1,9..144,900&family=Inter:wght@400;600;800&family=JetBrains+Mono:wght@500;700&display=swap" rel="stylesheet">

  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

    :root {
      --forest: #1A3328;
      --paper: #F4F1EB;
      --yolk: #F7D344;
      --ink: #0D0D0D;
    }

    html { scroll-behavior: smooth; }

    body {
      background: var(--forest);
      color: var(--paper);
      font-family: 'Inter', sans-serif;
      min-height: 100vh;
    }

    /* Caution stripe */
    .stripe {
      height: 6px;
      width: 100%;
      background: repeating-linear-gradient(
        -45deg,
        var(--yolk) 0, var(--yolk) 8px,
        var(--forest) 8px, var(--forest) 16px
      );
    }

    /* Hero */
    .hero {
      padding: 5rem 4rem 4rem;
      max-width: 960px;
      border-bottom: 3px solid var(--ink);
    }

    .firm-label {
      font-family: 'JetBrains Mono', monospace;
      font-size: 0.58rem;
      font-weight: 700;
      letter-spacing: 0.2em;
      text-transform: uppercase;
      color: rgba(244, 241, 235, 0.45);
      margin-bottom: 2rem;
    }

    h1 {
      font-family: 'Fraunces', serif;
      font-weight: 900;
      font-size: clamp(3rem, 6vw, 5.5rem);
      line-height: 0.93;
      letter-spacing: -0.03em;
      color: var(--paper);
      margin-bottom: 1.75rem;
    }

    h1 em {
      font-style: italic;
      color: var(--yolk);
    }

    .hero-body {
      font-size: 1.05rem;
      line-height: 1.65;
      color: rgba(244, 241, 235, 0.72);
      max-width: 560px;
      margin-bottom: 2.5rem;
    }

    .cta {
      display: inline-block;
      font-size: 0.68rem;
      font-weight: 800;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      padding: 0.7rem 1.5rem;
      border: 2px solid var(--paper);
      color: var(--paper);
      text-decoration: none;
      transition: background 0.12s, color 0.12s;
    }

    .cta:hover {
      background: var(--paper);
      color: var(--forest);
    }

    /* Booking section */
    .booking {
      padding: 4rem;
      border-bottom: 3px solid var(--ink);
    }

    .section-label {
      font-family: 'JetBrains Mono', monospace;
      font-size: 0.52rem;
      font-weight: 700;
      letter-spacing: 0.2em;
      text-transform: uppercase;
      color: rgba(244, 241, 235, 0.35);
      margin-bottom: 1.5rem;
    }

    .meetings-iframe-container iframe {
      border: 3px solid var(--ink) !important;
    }

    /* Footer */
    footer {
      padding: 1.75rem 4rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 1rem;
    }

    .footer-copy {
      font-family: 'JetBrains Mono', monospace;
      font-size: 0.5rem;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: rgba(244, 241, 235, 0.25);
    }

    .footer-links {
      display: flex;
      gap: 2rem;
      list-style: none;
    }

    .footer-links a {
      font-family: 'JetBrains Mono', monospace;
      font-size: 0.5rem;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: rgba(244, 241, 235, 0.35);
      text-decoration: none;
      transition: color 0.12s;
    }

    .footer-links a:hover { color: var(--yolk); }

    /* Mobile */
    @media (max-width: 640px) {
      .hero { padding: 3rem 1.5rem 2.5rem; }
      .booking { padding: 2.5rem 1.5rem; }
      footer { padding: 1.5rem; flex-direction: column; align-items: flex-start; }
    }
  </style>
</head>
<body>

<div class="stripe"></div>

<section class="hero">
  <p class="firm-label">Studio B Capital &middot; Investment firm &middot; $100M target &middot; lower middle market</p>
  <h1>Not sourced. <em>Surfaced.</em></h1>
  <p class="hero-body">The businesses we back have been in our network for years — advised, measured, and run alongside. We're not introduced to the opportunity. We're already trusted by the operator.</p>
  <a href="#book" class="cta">Book a call</a>
</section>

<section class="booking" id="book">
  <p class="section-label">LP inquiry &middot; book a call</p>
  <!-- Replace HUBSPOT_MEETING_LINK with your HubSpot meeting URL before going live -->
  <div class="meetings-iframe-container" data-src="HUBSPOT_MEETING_LINK?embed=true&color=1A3328"></div>
  <script type="text/javascript" src="https://static.hsappstatic.net/MeetingsEmbed/ex/MeetingsEmbedCode.js"></script>
</section>

<footer>
  <p class="footer-copy">&copy; 2026 Studio B Consulting, LLC</p>
  <ul class="footer-links">
    <li><a href="https://b.studio">Studio B</a></li>
    <li><a href="https://consulting.b.studio">Consulting</a></li>
    <li><a href="https://benchmarks.b.studio">Benchmarks</a></li>
  </ul>
</footer>

</body>
</html>
```

- [ ] **Step 2: Verify it renders locally**

```bash
python3 -m http.server 8080
```

Open http://localhost:8080 in browser. Confirm:
- Forest green background
- Yolk caution stripe at top (6px, diagonal)
- "Not sourced. Surfaced." headline in Fraunces 900 — "Surfaced." in yolk italic
- Body copy in paper/muted color
- "BOOK A CALL" button with paper border
- Footer with three links

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "feat: add Capital landing page with locked copy and Direction A palette"
git push
```

---

### Task 3: Substitute real HubSpot meeting link

**Files:**
- Modify: `index.html`

**Prerequisite:** Kevin must create the HubSpot meeting link first:
HubSpot → Sales → Meetings → Create meeting link → copy the URL (format: `https://meetings.hubspot.com/kevin-bibelhausen/lp-inquiry` or similar)

- [ ] **Step 1: Replace the placeholder**

In `index.html`, find:
```html
data-src="HUBSPOT_MEETING_LINK?embed=true&color=1A3328"
```

Replace `HUBSPOT_MEETING_LINK` with the actual URL Kevin provides. Example:
```html
data-src="https://meetings.hubspot.com/kevin-bibelhausen/lp-inquiry?embed=true&color=1A3328"
```

- [ ] **Step 2: Verify booking widget loads locally**

```bash
python3 -m http.server 8080
```

Open http://localhost:8080#book. Confirm:
- HubSpot calendar widget renders below the hero
- Widget is interactive (date picker visible)
- No console errors

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "feat: wire HubSpot meeting embed for LP booking"
git push
```

---

### Task 4: Verify GitHub Pages is live

**Files:** none

- [ ] **Step 1: Check Pages status**

```bash
gh api repos/studio-b-ai/capital-b-studio/pages
```

Expected: `"status": "built"` and `"url": "https://studio-b-ai.github.io/capital-b-studio/"`

If status is still `"queued"`, wait 60 seconds and retry.

- [ ] **Step 2: Verify the site is reachable at the GitHub Pages URL**

```bash
curl -s -o /dev/null -w "%{http_code}" https://studio-b-ai.github.io/capital-b-studio/
```

Expected: `200`

- [ ] **Step 3: Verify CNAME file is present**

```bash
curl -s https://studio-b-ai.github.io/capital-b-studio/CNAME
```

Expected: `capital.b.studio`

---

### Task 5: Add GoDaddy DNS CNAME

**Files:** none (DNS change via GoDaddy API)

**Credentials:** In Railway → studiob-api service env vars:
```bash
cd ~/dev/studiob  # or wherever studiob project is
railway variables --service studiob-api --json | python3 -c "
import sys, json
v = json.load(sys.stdin)
print('KEY:', v.get('GODADDY_API_KEY','NOT FOUND'))
print('SECRET:', v.get('GODADDY_API_SECRET','NOT FOUND'))
"
```

- [ ] **Step 1: Check existing b.studio DNS records**

```bash
export GODADDY_KEY=<key from above>
export GODADDY_SECRET=<secret from above>

curl -s -X GET "https://api.godaddy.com/v1/domains/b.studio/records/CNAME" \
  -H "Authorization: sso-key ${GODADDY_KEY}:${GODADDY_SECRET}" \
  -H "Content-Type: application/json" | python3 -m json.tool
```

Confirm `capital` does not already exist in the output.

- [ ] **Step 2: Add the CNAME record**

```bash
curl -s -X PATCH "https://api.godaddy.com/v1/domains/b.studio/records" \
  -H "Authorization: sso-key ${GODADDY_KEY}:${GODADDY_SECRET}" \
  -H "Content-Type: application/json" \
  -d '[{"type":"CNAME","name":"capital","data":"studio-b-ai.github.io","ttl":600}]'
```

Expected: empty response body (HTTP 200 = success).

- [ ] **Step 3: Verify the CNAME propagated**

```bash
dig capital.b.studio CNAME +short
```

Expected: `studio-b-ai.github.io.`

DNS TTL is 600s — may take up to 10 minutes. Retry if empty.

- [ ] **Step 4: Enable HTTPS in GitHub Pages settings**

```bash
gh api repos/studio-b-ai/capital-b-studio/pages \
  --method PUT \
  -f cname="capital.b.studio" \
  -F https_enforced=true
```

Expected: JSON response with `"custom_domain": "capital.b.studio"` and `"https_enforced": true`

---

### Task 6: Verify live site end-to-end

**Files:** none

- [ ] **Step 1: Confirm site loads at custom domain**

```bash
curl -s -o /dev/null -w "%{http_code}" https://capital.b.studio
```

Expected: `200` (may take a few minutes after HTTPS is enabled — retry up to 5 minutes)

- [ ] **Step 2: Verify OG tags are present**

```bash
curl -s https://capital.b.studio | grep -E 'og:|twitter:'
```

Expected output includes:
```
<meta property="og:type" content="website">
<meta property="og:site_name" content="Studio B Capital">
<meta property="og:title" content="Not sourced. Surfaced.">
<meta property="og:description" content="The businesses we back...">
<meta property="og:url" content="https://capital.b.studio">
<meta name="twitter:card" content="summary_large_image">
```

- [ ] **Step 3: Validate OG tags in LinkedIn post inspector**

Open https://www.linkedin.com/post-inspector/ in browser.
Enter `https://capital.b.studio` and click Inspect.
Confirm title and description render correctly in the preview.

- [ ] **Step 4: Smoke test booking flow**

Open https://capital.b.studio in browser.
- Click "BOOK A CALL" — page scrolls to booking section
- HubSpot calendar renders
- Select a time slot and complete booking
- Confirm confirmation email arrives with Docsend link (requires HubSpot workflow to be live)

- [ ] **Step 5: Mobile check**

Open https://capital.b.studio on mobile (or DevTools device emulation at 375px width).
Confirm:
- Hero padding is tight (1.5rem not 4rem)
- Headline is readable (clamp keeps it proportional)
- Footer stacks vertically

---

## Post-Launch Checklist

- [ ] HubSpot workflow confirmed sending Docsend link on booking
- [ ] `lp_stage = prospect` property populating on new HubSpot contacts from bookings
- [ ] Newsletter enrollment (SDLI Brief auto + Dispatch checkbox) wired in HubSpot meeting form settings
- [ ] LinkedIn post inspector shows correct OG preview
- [ ] Ping Kevin to confirm first test booking end-to-end

---

## Follow-On Plans

Consulting and Benchmarks follow the same repo/deploy/DNS pattern. Key differences:
- **Consulting:** yolk ground, different copy, HubSpot booking (same embed pattern), Dispatch auto-enrollment
- **Benchmarks:** paper ground, different copy, two-tier CTA (free early access + institutional waitlist), SDLI Brief auto-enrollment
