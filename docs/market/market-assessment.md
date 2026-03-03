# Market Assessment — Virtual AI Patient

## 1. Problem and why now
### 1.1 Training gap
Students and early-career physicians have limited opportunities to practice:
- clinical communication (history taking, empathy, structuring the interview),
- diagnostic reasoning,
- safe decision-making (tests, diagnosis, treatment)
before encountering real patients.

Many training cases are static (text-based) and do not simulate a realistic dialogue where:
- information is revealed progressively,
- patients are emotional or inconsistent,
- the clinician must ask the right questions in the right order.

### 1.2 Market tailwinds
- **Patient safety** and competency-based training push institutions toward simulation.
- **Remote / web-based training** is increasingly accepted and scalable.
- **AI-enabled feedback** and debriefing are becoming feasible at lower cost.

Peer-reviewed literature consistently supports simulation-based training as a way to improve skills while reducing risk to real patients (overview example: Elendu et al., 2024 on simulation-based training modalities and benefits).  
Source: [PMC article](https://pmc.ncbi.nlm.nih.gov/articles/PMC11224887/)

## 2. Target customers and buyers
### 2.1 Primary customer segments
- **Medical schools / universities** (undergraduate medical education)
- **Residency programs / teaching hospitals** (postgraduate training)
- **Nursing and allied health programs** (adjacent expansion)
- **Continuing medical education (CME) platforms**
- **Physician platforms** (integration partner: embed training module as a feature)

### 2.2 Buyer roles
- Academic leadership (deans, program directors)
- Simulation center directors
- Hospital education departments
- Platform product owners (for embedded integration)

### 2.3 Users
- Learners (students, interns, residents)
- Educators / clinical experts (case authors and reviewers)

## 3. Competitive landscape (high level)
### 3.1 Status quo alternatives
- Standardized patients (actors) — high realism, high recurring cost, limited scale
- OSCE stations — standardized but episodic, limited longitudinal dialogue
- Static case banks — scalable but low interactivity and limited feedback

### 3.2 Direct / adjacent competitors (categories)
- **Medical simulation and virtual patient platforms** (often VR or scenario-based)
- **General-purpose AI chat tools** used ad-hoc (not case-grounded, weak scoring, safety risks)
- **Hospital training suites** (bundled with devices / hardware)

Differentiation for Virtual AI Patient:
- case-grounded dialogue (no free-form “generic ChatGPT patient”),
- investigation ordering + plausible result generation,
- automated scoring against a gold standard (diagnosis + diagnostics + treatment),
- scalable authoring/ingestion pipeline to reach 50+ cases quickly,
- integration-ready APIs for partner physician platforms.

## 4. Market size and growth (public sources)
We anchor top-down sizing in the broader **healthcare/medical simulation** market (closest public category), then focus on fast-growing segments relevant to this product: **virtual patient simulation** and **web-based simulation**.

### 4.1 Medical simulation market — public datapoints
- MarketsandMarkets press release (Feb 2026) projects the *medical simulation market* to grow from **~$3.50B (2025)** to **~$7.23B (2030)** at **~15.6% CAGR**. It also notes **virtual patient simulation** as the fastest-growing technology segment and **web-based simulation** as the fastest-growing offering segment.  
Source: [PRNewswire / MarketsandMarkets press release (Feb 2026)](https://www.prnewswire.com/news-releases/medical-simulation-market-worth-7-23-billion-by-2030--marketsandmarkets-302682362.html)

- The Business Research Company (Feb 2026) reports the healthcare/medical simulation market growing from **$2.95B (2025)** to **$3.46B (2026)** and to **$6.33B (2030)** (forecast), highlighting drivers such as limited access to patients and demand for remote training.  
Source: [The Business Research Company — Healthcare/Medical Simulation Market Report 2026](https://www.thebusinessresearchcompany.com/report/healthcare-medical-simulation-global-market-report)

### 4.2 Implication for Virtual AI Patient
Even within the broad simulation market, public sources explicitly highlight:
- **virtual patient simulation** growth,
- **web-based** delivery growth,
which aligns directly with a chat-first AI patient product.

## 5. Bottom-up lens (practical sizing approach)
Because institutions buy training per cohort / per seat, a practical bottom-up approach is:
- choose an initial geography + customer set (e.g., partner physician platform + 2–5 medical schools),
- define pricing per learner/year or per institution,
- estimate adoption as % of target cohorts that complete ≥N cases per term.

This repository does not commit to a single numeric TAM/SAM/SOM estimate without an explicit target geography and pricing model. Instead, we provide a sizing worksheet approach for the go-to-market plan (to be finalized with the pilot partner).

## 6. Go-to-market (GTM) hypothesis
### 6.1 Wedge
- Start with **students / junior doctors** for common, high-yield conditions.
- Deliver measurable value: improved structured history taking, reduced diagnostic omissions, safer treatment choices.

### 6.2 Distribution
- **Pilot via physician platform integration** (preferred, aligned with stated plan).
- Parallel: direct-to-institution pilots with a small number of departments.

### 6.3 Pricing (options to test)
- **Per learner subscription** (annual)
- **Per institution license** (tiered by cohort size)
- Add-on: analytics, custom case packs, and optional cost-of-care simulation module

## 7. Key risks and mitigations (market-side)
- **Clinical credibility**: mitigate via physician expert review workflow + tight case grounding.
- **Procurement friction**: mitigate via integration-first pilot and lightweight web deployment.
- **Content scaling**: mitigate via standardized schema + ingestion pipeline + clinician-in-the-loop.
- **Regulatory perception**: clearly position as training simulation; avoid real-patient advice.

