# Auremont Capital — 200-PE-IB Contact Intelligence Platform

**Private tool. DIFC, Dubai.**

---

## Setup (one-time, ~5 minutes)

### Step 1 — Run the database schema

1. Go to [supabase.com](https://supabase.com) → Project `200-PE-IB-Contact-Intel`
2. Click **SQL Editor** in the left sidebar
3. Open `schema.sql` from this repo
4. Paste the entire contents and click **Run**
5. You should see: `Schema created successfully`

### Step 2 — Deploy to GitHub Pages

1. Go to your repo: `https://github.com/yash0422/auremont-cip`
2. Settings → Pages → Source: **Deploy from branch** → branch: `main` → folder: `/ (root)`
3. Save — live in ~2 minutes at:

```
https://yash0422.github.io/auremont-cip
```

### Step 3 — Upload your contacts

1. Open the platform URL
2. Upload IB Excel → Upload PE Excel
3. Contacts are scored, matched to deals, and saved to Supabase
4. Refresh anytime — data persists

---

## Features

- **Supabase persistence** — contacts survive refresh, browser close, device change
- **Fixed scoring engine** — handles all Excel column name variants
- **IB / PE toggle** — separate views per contact type
- **Deal matching** — auto-matched to 6 active Auremont mandates
- **Outreach status** — update per contact, saved to DB instantly
- **Score filter** — High (75+) / Medium (50–74) / Low (<50)
- **Country filter** — auto-populated from your data
- **LinkedIn links** — direct from table

---

## Files

| File | Purpose |
|---|---|
| `index.html` | Full platform — push to GitHub Pages |
| `schema.sql` | Run once in Supabase SQL Editor |
| `README.md` | This file |

---

## Supabase Project

- **Project:** `200-PE-IB-Contact-Intel`
- **Org:** `Auremont_Capital`
- **Region:** South Asia (Mumbai)
- **URL:** `https://nxqdkiggnflajyzmrsbj.supabase.co`

---

*Auremont Capital | Confidential*
