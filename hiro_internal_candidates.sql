-- Run in Supabase SQL Editor
-- Internal Candidate Library for Hiro ATS

CREATE TABLE IF NOT EXISTS public.internal_candidates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  department TEXT,
  role_title TEXT,
  manager_name TEXT,
  skills_interests TEXT,
  cv_url TEXT,
  referrer_name TEXT,
  referrer_email TEXT,
  status TEXT NOT NULL DEFAULT 'active',
  reviewed BOOLEAN NOT NULL DEFAULT false,
  hired_at TIMESTAMPTZ,
  reactivation_eligible_at TIMESTAMPTZ,
  notes TEXT,
  source TEXT DEFAULT 'self-registered',
  linked_candidate_id UUID,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.internal_candidates ENABLE ROW LEVEL SECURITY;

CREATE POLICY "auth_all" ON public.internal_candidates
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "anon_insert" ON public.internal_candidates
  FOR INSERT TO anon WITH CHECK (true);

CREATE POLICY "anon_select" ON public.internal_candidates
  FOR SELECT TO anon USING (true);

-- Storage bucket for internal CVs must be created manually:
-- Supabase Dashboard → Storage → New bucket → Name: "internal-cvs" → Public: false
