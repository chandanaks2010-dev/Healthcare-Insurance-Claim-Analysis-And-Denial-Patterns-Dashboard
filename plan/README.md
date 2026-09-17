# 📋 Plan Folder

**Implementation guides, checklists, and reference documentation.**

This folder contains all guides needed to build and understand the Healthcare Insurance Dashboard.

---

## 🎯 6 CORE IMPLEMENTATION GUIDES (Start Here)

| Guide | Purpose | Time |
|-------|---------|------|
| **[TABLEAU_WORKSHEET_BUILD_CHECKLIST.md](TABLEAU_WORKSHEET_BUILD_CHECKLIST.md)** | Step-by-step: all 9 worksheets + **LOD expressions** + **cascading filters** + **custom actions** + **storyboard** + dashboard assembly | 4.5-5 hours |
| **[TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md](TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md)** | **NEW:** Comprehensive dashboard build: layout planning, filter architecture, custom actions, styling, performance tuning, troubleshooting | 30-45 min |
| **[TABLEAU_STORYBOARD_GUIDE.md](TABLEAU_STORYBOARD_GUIDE.md)** | **NEW:** Complete storyboard creation: 5-point narrative, captions, annotations, presentation tips, validation | 45-60 min |
| **[TABLEAU_ANALYSIS_GUIDE.md](TABLEAU_ANALYSIS_GUIDE.md)** | Business analysis framework: Pareto, RFM, KPI interpretation, 4 quantified insights | 1-2 hours |
| **[VIVA_PREP.md](VIVA_PREP.md)** | Exam preparation: opening script, 4-min demo, Q&A answers, viva tips, 7-slide structure | 30 min read + practice |
| **[REFERENCE_ONE_PAGE.md](REFERENCE_ONE_PAGE.md)** | Quick lookup card: build sequence, key metrics, quick fixes (print this!) | Desk reference |

---

## 📚 OPTIONAL: Worksheet Reference Guides

Deep-dive specifications for each of the 9 worksheets:

- [WS1_EXECUTIVE_KPI_SUMMARY.md](WS1_EXECUTIVE_KPI_SUMMARY.md) — 4 KPI cards at dashboard top
- [WS2_MONTHLY_SPEND_TREND.md](WS2_MONTHLY_SPEND_TREND.md) — Line chart with trend line + forecast
- [WS3_PARETO_COST_CONCENTRATION.md](WS3_PARETO_COST_CONCENTRATION.md) — Pareto 80/20 bar + cumulative %
- [WS4_DENIAL_VS_COST_BUBBLE.md](WS4_DENIAL_VS_COST_BUBBLE.md) — 4-quadrant bubble analysis
- [WS5_REGIONAL_PROFILE.md](WS5_REGIONAL_PROFILE.md) — Dual-axis bar showing 6 regions
- [WS6_STATUS_DISTRIBUTION.md](WS6_STATUS_DISTRIBUTION.md) — Pie chart of claim status breakdown
- [WS7_DEMOGRAPHIC_HEATMAP.md](WS7_DEMOGRAPHIC_HEATMAP.md) — Age × BMI × Smoking heatmap (hero viz!)
- [WS8_GEOGRAPHIC_HEATMAP.md](WS8_GEOGRAPHIC_HEATMAP.md) — Geographic state-level cost heatmap
- [WS9_RFM_ANALYSIS.md](WS9_RFM_ANALYSIS.md) — RFM 8-segment bubble chart for customer LTV

---

## � PDF SECTION 2.3 REQUIREMENTS COVERAGE

**Per SQL_Tableau_Project_Guidelines.pdf**, all these features are now documented in **TABLEAU_WORKSHEET_BUILD_CHECKLIST.md:**

| PDF Requirement | Page/Section | Complexity |
|-----------------|--------------|-----------|
| **Row-level & table calculations** | WS1-WS9 sections | ⭐ Easy-Medium |
| **Aggregation functions (SUM, AVG, COUNT)** | WS1-WS9 sections | ⭐ Easy |
| **✅ Level of Detail (LOD) expressions** | **"🔧 LOD EXPRESSIONS"** section (3 examples: WS1, WS7, WS9) | ⭐⭐ Medium |
| **✅ Line charts with trend lines & forecasting** | **WS2** section (Monthly Spend Trend) | ⭐⭐ Medium |
| **✅ KPI dashboards & dual-axis charts** | **WS1, WS5** sections | ⭐ Easy |
| **✅ Bubble charts & geographic maps** | **WS9, WS8** sections | ⭐⭐ Medium |
| **✅ Cascading filters (global architecture)** | **"🎚️ CASCADING FILTERS"** section (Region → State → Demographics) | ⭐⭐⭐ Advanced |
| **✅ Custom dashboard actions (Filter/Drill/URL)** | **"🎬 CUSTOM ACTIONS"** section (4 action types) | ⭐⭐⭐ Advanced |
| **✅ Interactive storyboards for storytelling** | **"📖 STORYBOARD"** section (5-point narrative) | ⭐⭐ Medium |

**Result:** 100% PDF 2.3 compliance ✅

---

## 🎯 WHAT'S NEW (Sept 17, 2026)

**2 Comprehensive New Dedicated Guides:**

### 📊 **TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md** (30-45 min read)
Complete guide to integrating all 9 worksheets into a single interactive dashboard:
- Dashboard layout planning with visual diagram
- Step-by-step assembly: 6 rows, optimal sizing, positioning
- Filter bar configuration (Region, Smoking Status, Date Range)
- How to set up cascading filters (global vs. local scope)
- 4 custom dashboard actions with build steps (Drill, Highlight, URL)
- Professional styling: colors, fonts, spacing
- Performance optimization for <5 second load time
- Accessibility guidelines
- Troubleshooting table with 10+ common issues
- Validation checklist and success criteria

**When to Read:** After completing all 9 worksheets (WS1-WS9) but before testing dashboard interactivity.

---

### 📖 **TABLEAU_STORYBOARD_GUIDE.md** (45-60 min read)
Complete guide to building a compelling 5-point executive story:
- Story structure & narrative arc explained (Scale → Trend → Concentration → Root Cause → Opportunity)
- Step-by-step creation of each story point (1-5) with:
  - Worksheet assignment
  - Caption and body text (provided)
  - Visual annotations (shapes, arrows, highlights)
  - Presenter talking points
- Story Point 1: Scale (WS1 - $4.3M baseline)
- Story Point 2: Trend (WS2 - +12% YoY growth)
- Story Point 3: Concentration (WS3 - 60% in 3 hospitals)
- Story Point 4: Root Cause (WS7 - Smoking 5-10× multiplier)
- Story Point 5: Opportunity (WS9 - $4.35M RFM win-back)
- Navigation setup and playback configuration
- Presentation script (5-7 minutes)
- Caption writing best practices
- Annotation techniques for visual emphasis
- Validation checklist and success criteria

**When to Read:** After dashboard is complete and tested; before presenting to executives.

---

**Also Updated (Existing Guides):**

**All WS1-WS9 Worksheet Guides now include:**
- ✅ **Advanced Features** section with 4 subsections each:
  1. **LOD Expressions Applied** — Identifies if worksheet uses LOD (which formula, why, when)
  2. **Cascading Filters Affecting** — Lists which filters apply (Region, Smoking, Date) and behavior
  3. **Custom Dashboard Actions** — Shows which dashboard actions target this sheet
  4. **Storyboard Involvement** — Specifies if worksheet featured in story, which story point, role
  5. **Cross-References** — Links to Dashboard guide, Storyboard guide, and master checklist

**Result:** All 9 worksheet guides now fully integrated with dashboard and storyboard architecture.

---

**Updated Overview:**

4 new sections in **TABLEAU_WORKSHEET_BUILD_CHECKLIST.md** remain unchanged + 2 new dedicated guides:
- **TABLEAU_WORKSHEET_BUILD_CHECKLIST.md** — Quick reference for all components
- **TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md** — Deep-dive on dashboard building  
- **TABLEAU_STORYBOARD_GUIDE.md** — Deep-dive on storyboard & storytelling

---

## 🎯 GETTING STARTED (Updated)

### Step 1: Build the Worksheets
Open [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md](TABLEAU_WORKSHEET_BUILD_CHECKLIST.md) and follow section by section. This is your primary reference.

**Key sections in order:**
1. Overview & dependencies
2. Pre-flight checklist
3. WS1-WS9 build steps (25 min each)
4. LOD expressions section (20 min)
5. Cascading filters section (25 min)
6. Custom actions section (20 min)
7. Storyboard section (30 min)
8. Quick troubleshooting table

### Step 2: Build the Dashboard
Open [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md](TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md) after all worksheets are complete.

**Key sections in order:**
1. Dashboard layout planning
2. Step 1-3: Create new dashboard + title + filters
3. Step 4: Build 6 rows (KPI, Trend+Pareto, Denial+Regional, HERO Heatmap, Status+Map, RFM)
4. Step 5: Configure cascading filter scopes
5. Step 6: Add 4 custom dashboard actions
6. Step 7-9: Styling, performance, save & package
7. Validation checklist

### Step 3: Build the Storyboard  
Open [TABLEAU_STORYBOARD_GUIDE.md](TABLEAU_STORYBOARD_GUIDE.md) after dashboard is tested.

**Key sections in order:**
1. Story structure & components
2. Pre-build checklist
3. Step 1: Create new story
4. Steps 2-6: Build story points 1-5 (each with captions, narrative, annotations)
5. Step 7-10: Navigation, formatting, presentation guide
6. Storytelling best practices
7. Validation checklist

### Step 4: Understand the Analysis
Read [TABLEAU_ANALYSIS_GUIDE.md](TABLEAU_ANALYSIS_GUIDE.md) to learn:
- How to interpret Pareto charts (80/20 pattern)
- How to segment customers with RFM (8 lifetime-value cohorts)
- How to extract business insights from the dashboard
- 4 quantified insights worth $800K-$1.3M annually

### Step 5: Prepare for Viva
Study [VIVA_PREP.md](VIVA_PREP.md):
- Memorize your 30-second opening
- Practice the 4-minute demo script
- Review 6 likely examiner Q&A pairs
- Use the 4-day practice schedule

### Step 6: Keep Reference Handy
Print [REFERENCE_ONE_PAGE.md](REFERENCE_ONE_PAGE.md) and keep it on your desk during build and viva.

---

## 📂 Folder Structure

```
project-root/
├── plan/                                ← YOU ARE HERE
│   ├── TABLEAU_WORKSHEET_BUILD_CHECKLIST.md     (master reference)
│   ├── TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md      (new: 30-45 min)
│   ├── TABLEAU_STORYBOARD_GUIDE.md              (new: 45-60 min)
│   ├── TABLEAU_ANALYSIS_GUIDE.md                (core guide)
│   ├── VIVA_PREP.md                             (core guide)
│   ├── REFERENCE_ONE_PAGE.md                    (quick ref)
│   ├── WS1-WS9_*.md                             (optional reference, now with cross-references)
│   └── README.md                                (this file)
│
├── report/                              ← Final outputs
│   ├── generate_presentation.py
│   ├── Healthcare_Insurance_Dashboard_Presentation.pptx
│   └── README.md
│
├── data/                                ← Raw & processed data
│   ├── raw/
│   └── processed/
│
├── sql/                                 ← SQL scripts
│   ├── 00_data_profiling.sql
│   ├── 01_schema_creation.sql
│   ├── ... (7 total SQL files)
│   └── insurance_claim_analysis.sql
│
├── tableau/                             ← Tableau workbook
│   └── healthcare_insurance_dashboard.twbx
│
├── Plan.md                              ← Master project plan
└── README.md                            ← Project overview
```

---

## ✅ Validation Checklist

**Before starting:**
- [ ] Read Plan.md (project overview)
- [ ] Review SQL scripts in `/sql/` folder (query foundation)
- [ ] Verify MySQL database is accessible

**During worksheet build:**
- [ ] Follow TABLEAU_WORKSHEET_BUILD_CHECKLIST.md steps 1-8 (all 9 worksheets)
- [ ] Reference individual WS1-WS9 guides for detailed specs as needed
- [ ] Validate each worksheet against expected output
- [ ] Use REFERENCE_ONE_PAGE.md for quick fixes

**During dashboard build:**
- [ ] Follow TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md steps 1-9
- [ ] Test each row layout before moving to next
- [ ] Validate filter cascading (Region → all sheets, Smoking → WS7+WS9, Date → WS2+WS1)
- [ ] Test all 4 custom dashboard actions (Hospital drill, Region drill, Highlight, URL)
- [ ] Check dashboard load time: <5 seconds
- [ ] Complete dashboard validation checklist

**During storyboard build:**
- [ ] Follow TABLEAU_STORYBOARD_GUIDE.md steps 1-10
- [ ] Build each of 5 story points with provided captions
- [ ] Add visual annotations (shapes, arrows, highlights)
- [ ] Practice presentation narration (5-7 minutes)
- [ ] Complete storyboard validation checklist

**After build:**
- [ ] Review TABLEAU_ANALYSIS_GUIDE.md to interpret your visualizations
- [ ] Prepare 4 quantified business insights
- [ ] Create presentation deck from VIVA_PREP.md guidelines

**Before viva:**
- [ ] Study VIVA_PREP.md completely
- [ ] Practice 30-second opening (aloud, 5+ times)
- [ ] Run through 4-minute demo with filters and actions
- [ ] Review Q&A answers
- [ ] Complete 4-day practice schedule

---

## 🎯 PDF Compliance Mapping

**All PDF Section 2.3 requirements covered in these guides:**

| Requirement | Guide | Marks |
|-------------|-------|-------|
| Row-level & table calculations | WORKSHEET_BUILD_CHECKLIST | 2 |
| Aggregation functions (SUM, AVG, COUNT) | WORKSHEET_BUILD_CHECKLIST | 2 |
| **LOD expressions (FIXED/INCLUDE/EXCLUDE)** | **WORKSHEET_BUILD_CHECKLIST** | **2** |
| Line charts with trend lines & forecasting | WORKSHEET_BUILD_CHECKLIST (WS2) | 1 |
| KPI dashboards & dual-axis charts | WORKSHEET_BUILD_CHECKLIST (WS1, WS5) | 1 |
| Bubble charts & geographic maps | WORKSHEET_BUILD_CHECKLIST (WS9, WS8) | 1 |
| **Cascading filters (global architecture)** | **DASHBOARD_ASSEMBLY_GUIDE** | **2** |
| **Custom dashboard actions** | **DASHBOARD_ASSEMBLY_GUIDE** | **2** |
| **Interactive storyboards for storytelling** | **STORYBOARD_GUIDE** | **2** |

**Total Tableau Coverage:** 15 marks of 30-mark rubric  
**PDF Compliance Status:** ✅ 100%

---

**Healthcare Insurance Dashboard | Executive MTech Data Science & AI**

*Last Updated: Sept 17, 2026 | Total Time: ~8-10 hours (worksheets 4.5-5h + dashboard 30-45m + storyboard 45-60m + analysis 1-2h)*
