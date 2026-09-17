# WORKSHEET 7: PATIENT RISK SEGMENTS (DEMOGRAPHIC HEATMAP)

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 45 minutes | **Complexity:** ⭐⭐⭐⭐ Advanced (HERO VISUALIZATION)

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Heatmap (Highlight Table) — COLOR + TEXT |
| **Data Source** | v_demographic_segmentation (SQL View) |
| **Rows** | Age Group (5 categories: 18-25, 26-35, 36-45, 46-55, 56+) |
| **Columns** | BMI Category (4 categories: Underweight, Normal, Overweight, Obese) |
| **Color Encoding** | Average Claim Cost ($2k - $45k) |
| **Cell Labels** | Cost + Patient Count |
| **Filters** | Smoking Status (YES/NO), Region |
| **Position on Dashboard** | Row 4 — Full width (HERO POSITION) |

---

## ⚠️ PRE-BUILD REQUIREMENTS

**STOP! Complete these first:**

- [ ] SQL Query 7.6 has been executed: `07_statistical_analysis.sql` lines ~251-310
- [ ] MySQL view `v_demographic_segmentation` exists
- [ ] Test query in MySQL: `SELECT COUNT(*) FROM v_demographic_segmentation;`
  - Expected result: 20-40 rows (age × BMI × smoker combinations)
- [ ] View contains columns:
  - [ ] age_group
  - [ ] bmi_category
  - [ ] smoker
  - [ ] avg_claim_cost
  - [ ] denial_rate_pct
  - [ ] patient_count

**If any step fails, stop and fix SQL before continuing to Tableau build.**

---

## 🔨 BUILD INSTRUCTIONS

### STEP 7.1: Connect to Demographic Data Source

```
Menu: Worksheet → New Worksheet
Rename: "Patient Risk Segments"
```

**Change Data Source**
- [ ] Top toolbar → Data Source selector
- [ ] Current: v_claims_tableau
- [ ] Change to: v_demographic_segmentation
  - [ ] Click dropdown → Select v_demographic_segmentation
  - [ ] MySQL connection → healthcare_claims_db → v_demographic_segmentation
- [ ] Verify: Data grid at bottom shows 20-40 rows, ~6 columns

### STEP 7.2: Build Heatmap Structure (Rows × Columns)

**Rows: Age Groups**
- [ ] Drag `Age Group` → **ROWS**
- [ ] Expected order: 18-25, 26-35, 36-45, 46-55, 56+ (top to bottom)
- [ ] If not ordered correctly:
  - [ ] Right-click Age Group pill → Sort → Custom
  - [ ] Define order: 18-25, 26-35, 36-45, 46-55, 56+

**Columns: BMI Categories**
- [ ] Drag `BMI Category` → **COLUMNS**
- [ ] Expected order: Underweight, Normal, Overweight, Obese (left to right)
- [ ] If not ordered:
  - [ ] Right-click BMI Category pill → Sort → Custom
  - [ ] Define order: Underweight, Normal, Overweight, Obese

**Result:** 5 rows × 4 columns = 20 cells (heatmap grid)

### STEP 7.3: Add Color Encoding (Primary Heatmap)

**Color by Average Claim Cost**
- [ ] Drag `Avg Claim Cost` → **COLOR**
- [ ] Right-click → Aggregate = **AVERAGE**
- [ ] Tableau auto-colors cells by value (light to dark)

**Configure Color Gradient**
- [ ] Right-click Color pill → Edit Colors
- [ ] Select palette: **"Red" or "Yellow-Red" diverging palette**
  - Light Yellow/White = Low cost (~$2k)
  - Dark Red/Brown = High cost (~$45k)
- [ ] Palette options:
  - Option A: "Red" (White→Red) — Traditional diverging
  - Option B: "Heat Map" — Yellow→Orange→Red
  - Option C: Custom (Light #FFFF00 to Dark #8B0000)
- [ ] Apply: Click OK

**Color Legend**
- [ ] Legend auto-appears on right
- [ ] Title: "Average Claim Cost ($)"
- [ ] Range display: Shows low (~$2k) to high (~$45k)

### STEP 7.4: Add Cell Labels - Cost Values

**Primary Label: Dollar Amount**
- [ ] Drag `Avg Claim Cost` → **TEXT** shelf
- [ ] Right-click → Aggregate = **AVERAGE**
- [ ] Format:
  - [ ] Font: 11pt, **Bold**, Arial
  - [ ] Color: **Black** (auto-adjusts for readability on color background)
  - [ ] Number format: **Currency ($)**, 0 decimals
  - [ ] Example display in cell: **$2,688**

### STEP 7.5: Add Cell Labels - Patient Count

**Secondary Label (Stacked Below Cost)**
- [ ] Drag `Patient Count` → **TEXT** shelf (same shelf as Avg Cost)
- [ ] Right-click → Aggregate = **SUM**
- [ ] Tableau stacks labels vertically in each cell
- [ ] Format:
  - [ ] Font: 9pt, Regular, Arial
  - [ ] Prefix: "n=" (indicates sample size)
  - [ ] Example display: **n=89**

**Result: Each cell now shows TWO lines:**
```
  $2,688
  n=89
```

### STEP 7.6: Add Smoker Filter (Interactive Drill-Down)

**Create Filter**
- [ ] Drag `Smoker` → **FILTERS** shelf
- [ ] Filter dialog appears; select both Yes and No
- [ ] Apply filter

**Show Filter Pill**
- [ ] Right-click Smoker filter → **Show Filter**
- [ ] Filter type: **Checkbox** (best UX)
- [ ] Options displayed:
  - [ ] ☑ No
  - [ ] ☑ Yes

**TEST THE FILTER:**
- [ ] Toggle to "Yes" only → Heatmap should show HIGHER costs (darker red)
- [ ] Toggle to "No" only → Heatmap should show LOWER costs (lighter yellow)
- [ ] Expected multiplier: Smoker cells 2-5× higher cost than non-smoker
- [ ] Example: Same age/BMI, non-smoker=$2k, smoker=$6k

### STEP 7.7: Add Region Filter (Optional Drill-Down)

- [ ] Drag `Region` → **FILTERS** (if Region column exists in view)
- [ ] Show filter → Dropdown or multi-select
- [ ] Effect: Can filter heatmap to show only "Southeast" patients, etc.

### STEP 7.8: Add Tooltips (Rich Context)

**Drag to Tooltip Shelf:**
- [ ] `Age Group`
- [ ] `BMI Category`
- [ ] `Smoker`
- [ ] `Avg Claim Cost`
- [ ] `Denial Rate %`
- [ ] `Patient Count`
- [ ] `Total Cost` (if available)

**Tooltip Text Template**
```
Age: <[Age Group]>
BMI: <[BMI Category]>
Smoker: <[Smoker]>
━━━━━━━━━━━━━━━━━━━
Avg Cost: <[Avg Claim Cost]>
Denial Rate: <[Denial Rate %]>%
# Patients: <[Patient Count]>
Total Cost: <[Total Cost]>
```

### STEP 7.9: Change Mark Type

- [ ] Top toolbar → Mark type selector
- [ ] Current: Automatic (circle)
- [ ] Change to: **Square** or **Rectangle**
- [ ] Effect: Heatmap cells display as squares (better grid appearance)

### STEP 7.10: Format Title & Overall Sheet

**Title**
- [ ] Title: "Patient Risk Segments - Demographic Cost & Denial Analysis"
- [ ] Font: 18pt, **Bold**, Dark Blue (#1F4E78)
- [ ] Subtitle: "Darker = Higher cost; Filter by smoking status to compare cohorts"
- [ ] Font: 12pt, Gray

**Sheet Background**
- [ ] Background color: **Light Gray** (#F5F5F5)
- [ ] This provides contrast to heatmap colors

**Grid Structure**
- [ ] Row/Column headers: Visible, clear labels
- [ ] Borders between cells: Subtle 1px gray lines

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] Heatmap displays all 20 cells (5 age groups × 4 BMI categories)
- [ ] Cost range visible: $2k minimum to $45k+ maximum
- [ ] Patient counts reasonable (n=50 to n=200+ per cell)
- [ ] Smoker filter affects values (Yes shows 2-5× higher costs)

**Visual Validation**
- [ ] Color gradient visible: Light cells (yellow) bottom-left → Dark cells (red) top-right
- [ ] Diagonal pattern expected: Age + BMI + Smoking = compound risk
- [ ] All labels readable (both cost and patient count)
- [ ] No overlapping text
- [ ] Filter checkboxes visible and functional
- [ ] Legend shows color scale from low to high cost

**Functional Validation**
- [ ] Sheet loads within **2-3 seconds**
- [ ] Smoker filter toggles immediately
- [ ] Tooltip shows on cell hover (all 6+ fields visible)
- [ ] No formula errors
- [ ] Region filter works (if added)

---

## 📊 EXPECTED OUTPUT

```
PATIENT RISK SEGMENTS - DEMOGRAPHIC COST & DENIAL ANALYSIS
═════════════════════════════════════════════════════════════
Smoking Status Filter: [☑ Yes ☑ No]  |  Region Filter: [All ▼]

                 UNDERWEIGHT      NORMAL           OVERWEIGHT       OBESE
         ┌────────────────────────────────────────────────────────────────┐
18-25   │ ░░░░░░░░░        ░░░░░░░░░        ░░░░░░░░░░░░      ░░░░░░░░░░░ │
        │  $1,800          $2,100            $2,800            $3,900     │
        │  n=89            n=156             n=124             n=102      │
        ├────────────────────────────────────────────────────────────────┤
26-35   │ ░░░░░░░░░░       ░░░░░░░░░░░░     ░░░░░░░░░░░░░░   ▒▒▒▒▒▒▒▒▒▒░ │
        │  $2,200          $2,400            $4,200            $6,800     │
        │  n=112           n=201             n=178             n=145      │
        ├────────────────────────────────────────────────────────────────┤
36-45   │ ▒▒▒▒▒▒▒▒▒▒       ▒▒▒▒▒▒▒▒▒▒░      ▒▒▒▒▒▒▒▒▒▒░░    ▓▓▓▓▓▓▓▓░░░ │
        │  $5,400          $6,200            $8,900            $14,500    │
        │  n=98            n=187             n=143             n=167      │
        ├────────────────────────────────────────────────────────────────┤
46-55   │ ▒▒▒▒▒▒▒▒▒░       ▒▒▒▒▒▒▒▒▒░░      ▓▓▓▓▓▓▓▓▓▓░░    ██████░░░░░ │
        │  $8,700          $10,200           $16,800           $24,500    │
        │  n=76            n=154             n=189             n=198      │
        ├────────────────────────────────────────────────────────────────┤
56+     │ ▓▓▓▓▓▓▓▓░░       ▓▓▓▓▓▓▓▓░░░      ██████░░░░░░    ████████████ │
        │  $12,300         $14,800           $28,500           $45,200    │
        │  n=54            n=119             n=156             n=189      │
        └────────────────────────────────────────────────────────────────┘

Legend: ░░░ Light ($2k)  ▒▒▒ Medium ($10k)  ██ Dark ($45k)

BUSINESS INSIGHT:
Smoker Filter = YES (Activated):
→ Notice 5-10× cost increase in every cell vs. non-smoker
→ 56+ Obese Smoker = $45.2k (vs. $2k for 18-25 Non-Smoker = 22× difference!)
```

---

## 🎯 KEY BUSINESS INSIGHTS

**Cost Drivers (in order of impact):**
1. **Smoking Status** — 2-5× multiplier across all demographics
2. **Age** — Exponential increase (18-25: ~$2k → 56+: ~$12k non-smoker)
3. **BMI** — Linear increase (Underweight: $2k → Obese: $45k for smokers)

**Prevention Program ROI:**
- **Target Cohort:** Age 46-55 + Overweight + Smoker = Large volume + moderate cost
- **Expected Impact:** Smoking cessation = -2-3× cost reduction
- **ROI:** If 200 members in cohort, avg $16.8k cost, 20% quit smoking:
  - Cost reduction: 200 × 20% × $16.8k × 2.5x = **$840k annual savings**

---

## 📝 VIVA DISCUSSION POINTS

**Your 30-Second Elevator Pitch:**
"This heatmap shows our biggest cost drivers. Watch what happens when I toggle smoking status... the cells turn dark red. Smokers cost 5-10 times more than non-smokers in every age and BMI category. Our highest-risk patient is a 56-plus-year-old, obese smoker at $45k average. By focusing a prevention program on 46-55 smokers, we can achieve $800k+ annual savings."

**Expected Q&A:**
- Q: "Why is the cost so much higher for smokers?"
  - A: "Smoking correlates with respiratory, cardiac, and cancer conditions. These are chronic, expensive to treat."
- Q: "What's your mitigation strategy?"
  - A: "Target smoking cessation program in 46-55 age group (largest volume × moderate intervention cost)."
- Q: "How do you know it will work?"
  - A: "Industry benchmarks show 20-30% quit rates with incentive programs. ROI positive at 15% quit rate."

---

---

## 🔧 ADVANCED FEATURES

### 📌 LOD Expressions Applied
**Status:** ✅ **Yes - INCLUDE Formula** ⭐ **HERO Worksheet**

WS7 (Demographic Heatmap) uses INCLUDE LOD to calculate average cost by demographic segment, regardless of filters:

**Formula:**
```
Avg Cost by Demographics = {INCLUDE [Age Group], [BMI Category], [Smoker] : AVG([Claim Amount])}
```

**Purpose:** Compute demographic-level average costs, then color-code heatmap cells accordingly. INCLUDE ensures each cell shows the average for that demographic combination.

**When Used:** Every cell in the heatmap displays this calculated value with color intensity proportional to cost.

**Smoking Filter Interaction:** When Smoker filter is applied, cells filter in/out but the calculation remains consistent (INCLUDE preserves the demographic grouping).

**See Also:** [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - LOD Expressions - INCLUDE Example](#)

---

### 🎚️ Cascading Filters Affecting This Sheet

**Region Filter** (Global)
- Status: ✅ **Affects WS7**
- Behavior: Select "West" → Heatmap recalculates to show average costs for West region only
- Configuration: Dashboard filter → "Apply to All Sheets" (includes WS7)

**Smoking Status Filter** (Local - Primary Filter for WS7) ⭐ **Featured**
- Status: ✅ **Affects WS7** (and WS9 only)
- Behavior: Toggle "Smoker" and "Non-Smoker" → Heatmap shows/hides corresponding rows, revealing 5-10× cost multiplier
- Configuration: Dashboard filter → "Apply to Sheets" → Select WS7 + WS9 ONLY (not global)
- Use Case: Click filter to toggle smokers OFF → See dramatic cost reduction; toggle ON → See spike
- Key Insight: Smoker=Yes rows (dark colors) vs Smoker=No rows (light colors) clearly show multiplier effect

**Date Range Filter** (Local)
- Status: ✅ **Affects WS7**
- Behavior: Adjust dates → Average cost values recalculate
- Configuration: Dashboard filter → "Apply to Sheets" → WS7 + WS2 + WS1

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 3: Smoking Status Filter Configuration](#)

---

### 🎬 Custom Dashboard Actions Enabled

**Action 1: Hospital Drill Filter**
- Status: ✅ **Affects WS7** as target
- Behavior: Click hospital on WS3 → WS7 updates to show demographics breakdown for that hospital only

**Action 2: Region Filter Action**
- Status: ✅ **Affects WS7** as target
- Behavior: Click region on WS5 → WS7 updates with region-specific demographic costs

**Action 3: Highlight Action** ⭐ **Primary Interaction for WS7**
- Status: ✅ **Affects WS7** and **Originates from WS8** (optional)
- Behavior: Hover state on geographic map (WS8) → Matching rows in WS7 heatmap highlight in orange
- Impact: Links geographic location to demographic profile
- Configuration: Dashboard → Actions → Create Highlight Action from WS8 to WS7 on [State]

**Action 4: URL Action**
- Status: ❌ **Does NOT Affect WS7**

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 6: Actions & Action 3 Highlight](#)

---

### 📖 Storyboard Involvement

**Story Point 4: ROOT CAUSE — Smoking Multiplier** ⭐ **FEATURED**
- Status: ✅ **Prominently Featured in Story Point 4**
- Role: Visually demonstrate 5-10× cost multiplier for smokers vs non-smokers
- Caption: "Smoking Drives 5-10× Higher Costs"
- Interaction: Heatmap shows both Smoker=Yes (dark) and Smoker=No (light) for comparison
- Annotations: Red boxes around darkest cells (smokers age 46-55 = $32K), green boxes around lightest (non-smokers = $3K)
- Presenter Talking Points:
  - "Darker color = higher cost"
  - "Notice smoking rows (top) are dramatically darker"
  - "Age 46-55 smokers: $32K average | Age 46-55 non-smokers: $7K average"
  - "This 5-10× multiplier is the PRIMARY cost driver in our portfolio"

**Storyboard Notes:**
- WS7 positioned as "HERO" worksheet in dashboard (larger, prominent placement)
- Large enough to read individual cell values
- Color contrast must be clear (darkest ≥ $30K cost, lightest ≤ $5K cost)

**See Also:** [TABLEAU_STORYBOARD_GUIDE.md - Story Point 4: ROOT CAUSE - Smoking](#)

---

### 📚 Cross-References

- **Dashboard Assembly:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 4 - Row 4 HERO Position](#) for WS7's prominent placement in dashboard
- **Storyboard:** See [TABLEAU_STORYBOARD_GUIDE.md - Step 5: Story Point 4 - ROOT CAUSE](#) for detailed annotations and narrative
- **Cascading Filters:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 5: Smoking Status Filter](#) for how WS7 filter works
- **LOD Expressions:** See [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - LOD Section - INCLUDE Example](#) for detailed INCLUDE formula walkthrough

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Chart Type | Heatmap (Highlight Table) |
| Rows | Age Group (5 categories) |
| Columns | BMI Category (4 categories) |
| Color | Avg Claim Cost, gradient Yellow→Red |
| Cell Labels | Cost ($) + Patient Count (n=XX) |
| Filters | Smoking Status, Region |
| Color Range | $2k (light) to $45k (dark) |
| Expected Pattern | Diagonal: light bottom-left to dark top-right |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| "20 cells not showing (only 10-15)" | Check: SQL view has data for all age×BMI combinations; some may have zero counts (filtered out) |
| "Smoker filter not affecting color" | Verify: Smoker field on FILTERS shelf; query v_demographic_segmentation directly in MySQL |
| "Labels too small/overlapping" | Font size: 11pt for cost (bold), 9pt for count; use shorter label prefix "n=" |
| "Color gradient not showing" | Right-click Color pill → Edit Colors → Select continuous palette (Red or Heat Map) |
| "Sheet loads slowly" | Remove extra columns from data source; verify database indexes on age_group, bmi_category |

---

**Worksheet 7 Complete!** ✅ This is your HERO VISUALIZATION. Proceed to Worksheet 8.

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI*
