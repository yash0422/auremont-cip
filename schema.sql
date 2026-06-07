-- ============================================================
-- Auremont Capital | 200-PE-IB Contact Intelligence Platform
-- Schema v1.0 | Run once in Supabase SQL Editor
-- ============================================================

-- Drop if rebuilding
DROP TABLE IF EXISTS public.contacts CASCADE;
DROP TABLE IF EXISTS public.outreach_log CASCADE;

-- ============================================================
-- CONTACTS TABLE
-- ============================================================
CREATE TABLE public.contacts (
  id                      UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  contact_type            TEXT NOT NULL CHECK (contact_type IN ('IB', 'PE')),
  first_name              TEXT,
  last_name               TEXT,
  full_name               TEXT GENERATED ALWAYS AS (COALESCE(first_name, '') || ' ' || COALESCE(last_name, '')) STORED,
  seniority_level         TEXT,
  title                   TEXT,
  company_name            TEXT,
  email                   TEXT,
  email_status            TEXT,
  company_phone           TEXT,
  num_employees           TEXT,
  employee_linkedin_url   TEXT,
  website                 TEXT,
  company_linkedin_url    TEXT,
  employee_city           TEXT,
  employee_state          TEXT,
  employee_country        TEXT,
  company_address         TEXT,
  company_city            TEXT,
  company_state           TEXT,
  company_country         TEXT,
  annual_revenue          TEXT,
  total_funding           TEXT,
  latest_funding_type     TEXT,
  latest_funding_amount   TEXT,
  latest_funding_date     TEXT,
  -- Computed fields
  score                   INTEGER DEFAULT 0,
  deal_matches            TEXT[] DEFAULT '{}',
  priority_tier           TEXT DEFAULT 'Tier 2',
  notes                   TEXT,
  outreach_status         TEXT DEFAULT 'Not contacted' CHECK (outreach_status IN ('Not contacted','Teaser sent','LinkedIn connected','NDA offered','NDA signed','IM shared','Call scheduled','Meeting done','Passed','Converted')),
  created_at              TIMESTAMPTZ DEFAULT NOW(),
  updated_at              TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- OUTREACH LOG TABLE
-- ============================================================
CREATE TABLE public.outreach_log (
  id            UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  contact_id    UUID REFERENCES public.contacts(id) ON DELETE CASCADE,
  action        TEXT NOT NULL,
  deal          TEXT,
  notes         TEXT,
  email_subject TEXT,
  email_body    TEXT,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- INDEXES
-- ============================================================
CREATE INDEX idx_contacts_type     ON public.contacts(contact_type);
CREATE INDEX idx_contacts_score    ON public.contacts(score DESC);
CREATE INDEX idx_contacts_country  ON public.contacts(employee_country);
CREATE INDEX idx_contacts_status   ON public.contacts(outreach_status);
CREATE INDEX idx_contacts_tier     ON public.contacts(priority_tier);
CREATE INDEX idx_outreach_contact  ON public.outreach_log(contact_id);

-- ============================================================
-- AUTO-UPDATE updated_at
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER contacts_updated_at
  BEFORE UPDATE ON public.contacts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- ROW LEVEL SECURITY — disabled (personal tool, single user)
-- ============================================================
ALTER TABLE public.contacts     DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.outreach_log DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- GRANT ACCESS TO ANON ROLE
-- ============================================================
GRANT ALL ON public.contacts     TO anon;
GRANT ALL ON public.outreach_log TO anon;

-- Done
SELECT 'Schema created successfully' AS status;
