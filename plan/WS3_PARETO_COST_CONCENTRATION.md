# WORKSHEET 3: COST CONCENTRATION BY HOSPITAL (PARETO)

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 20 minutes | **Complexity:** ⭐⭐ Medium

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Combo (Bar chart + Line for cumulative %) |
| **Data Source** | v_claims_tableau |
| **Dimension** | Hospital Name |
| **Measures** | SUM(Claim Amount), Cumulative % |
| **Filters** | Optional: Region filter |
| **Position on Dashboard** | Row 2 — Right 50% |

---

## 🔨 BUILD INSTRUCTIONS

### STEP 3.1: Set Up Hospital Costs

```
Menu: Worksheet → New Worksheet
Rename: "Cost Concentration by Hospital"
```

- [ ] Drag `Hospital Name` → **ROWS**
- [ ] Drag `Claim Amount` → **COLUMNS**
- [ ] Right-click Claim Amount → Aggregate = **SUM**
- [ ] Tableau creates bar chart (horizontal)

**Sort Descending**
- [ ] Right-click `Hospital Name` pill → Sort
- [ ] Sort by: **Sum of Claim Amount, Descending**
- [ ] Result: Highest-cost hospital at top

### STEP 3.2: Create Running Total (Cumulative Cost)

**Add Table Calculation**
- [ ] Right-click `Claim Amount` (SUM) pill in COLUMNS
- [ ] Select → **Add Table Calculation**
- [ ] Function: **Running Sum**
- [ ] Compute Using: **Hospital Name** (table down)
- [ ] Tableau adds second metric showing cumulative total

### STEP 3.3: Create Cumulative Percentage

**Create Calculated Field**
```
Name: Cumulative Pct
Formula: (RUNNING_SUM(SUM([Claim Amount])) / WINDOW_SUM(SUM([Claim Amount]))) * 100
```

- [ ] Drag new `Cumulative Pct` field → **COLUMNS** (secondary axis)
- [ ] Right-click → **Dual Axis**
- [ ] Tableau creates second Y-axis (right side)

### STEP 3.4: Configure Marks

**Primary Axis (Bars)**
- [ ] Mark type: **Bar** (blue bars)
- [ ] Represents: Total cost per hospital
- [ ] Color: **Blue** (#4472C4)
- [ ] Show data labels: Yes, format as currency

**Secondary Axis (Line)**
- [ ] Right-click secondary axis → Select layer → Edit marks
- [ ] Mark type: **Line** (red line with dots)
- [ ] Color: **Red** (#C55A11)
- [ ] Show data labels: Yes, format as percentage (0 decimals)
- [ ] Size: 2-3pt line width

### STEP 3.5: Add 80% Reference Line

**Pareto Threshold**
- [ ] Right side panel → **Analytics** pane
- [ ] Drag **Reference Line** to secondary axis (right Y-axis)
- [ ] Set value to: **80**
- [ ] Label: "80% Threshold"
- [ ] Color: **Red** (#C55A11)
- [ ] Line style: **Dashed** (-- pattern)
- [ ] This line shows exactly which hospitals reach Pareto cutoff

### STEP 3.6: Format Axes

**Primary Y-Axis (Left)**
- [ ] Label: "Hospital Cost ($)"
- [ ] Format: Currency, 0 decimals
- [ ] Range: 0 to max cost + 10%

**Secondary Y-Axis (Right)**
- [ ] Label: "Cumulative % of Total"
- [ ] Format: Number, 0 decimals (0, 10, 20, ... 100)
- [ ] Range: 0 to 100%

**X-Axis (Hospital Names)**
- [ ] Rotate labels: **-45°** for readability
- [ ] Font: 10pt, Arial
- [ ] Allow automatic truncation if labels too long

### STEP 3.7: Add Tooltips

- [ ] Drag to Tooltip shelf:
  - `Hospital Name`
  - `Claim Amount` (SUM, currency)
  - `Claim ID` (COUNT = # claims)
  - `Cumulative Pct` (percentage)

**Tooltip Format**
```
Hospital: <[Hospital Name]>
Total Cost: <[SUM(Claim Amount)]>
# Claims: <[COUNT(Claim ID)]>
Cumulative: <[Cumulative Pct]>%
```

### STEP 3.8: Add Title

- [ ] Title: "Cost Concentration by Hospital (Pareto Analysis)"
- [ ] Subtitle: "Red line shows cumulative cost; crosses 80% at X hospitals"
- [ ] Font: 18pt, Bold

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] Hospitals sorted by cost (highest first)
- [ ] Cumulative line increases left-to-right from 0% to 100%
- [ ] Cumulative line crosses 80% threshold (red dashed line)
- [ ] Example insight: "Top 5 hospitals drive 80% of cost"

**Visual Validation**
- [ ] Blue bars descending (sorted correctly)
- [ ] Red line ascending smoothly
- [ ] 80% reference line clearly visible
- [ ] Two Y-axes labeled distinctly (left=$, right=%)
- [ ] Bar colors consistent; line color distinct

**Functional Validation**
- [ ] Tooltip shows all 4 fields on hover
- [ ] Performance: Loads within 3 seconds
- [ ] No data truncation (all hospitals visible)

---

## 📊 EXPECTED OUTPUT

```
COST CONCENTRATION BY HOSPITAL (PARETO)
═════════════════════════════════════════════════════════════
$800k    │                                        │ 100%
         │  ║                                  ╱ │ 90%
$600k    │  ║            Cumulative         ╱   │ 80%
         │  ║          Line (red ----→      ╱ ---- 80% threshold
$400k    │  ║        ╱╲                   ╱     │
         │  ║      ╱   ╲                ╱       │
$200k    │  ║    ╱       ╲            ╱         │
         │  ║╱╲╱         ╲        ╱             │
    $0   │──┴──────────────╲╱───────────────────┴──────
         │ H1  H2  H3  H4  H5  H6  H7 ... H20
             
KEY: Bar = individual hospital cost (Blue)
     Line = cumulative total across hospitals (Red)
     
INSIGHT: Cumulative line reaches 80% at hospital H5
→ Top 5 hospitals = 80% of total costs
→ Focus operational efficiency on these 5 facilities
```

---

## 📝 BUSINESS INSIGHTS

**Pareto Principle (80/20 Rule):**
- Typically: ~20% of hospitals drive ~80% of costs
- If your data shows: Top 5 hospitals = 80%, then focus on these 5
- ROI Opportunity: Cost reduction program for top 5 hospitals can yield 15-20% total savings

**Expected Discussion Points:**
1. "Why are these 5 hospitals so expensive?" (Case mix? Inefficiency? High-acuity patients?)
2. "Can we benchmark top performers?" (Compare high-cost vs. efficient hospitals)
3. "What's the intervention plan?" (Staff training? Process improvement? Rebalance case mix?)

---

---

## 🔧 ADVANCED FEATURES

### 📌 LOD Expressions Applied
**Status:** ❌ **No LOD Expressions**

WS3 (Pareto) does not use LOD expressions. The cumulative % line is calculated using Tableau's RUNNING_SUM() window function:
```
Running Total % = RUNNING_SUM(SUM([Claim Amount])) / TOTAL(SUM([Claim Amount]))
```
This is a table calculation, not an LOD expression.

**See Also:** [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - Window Functions Section](#)

---

### 🎚️ Cascading Filters Affecting This Sheet

**Region Filter** (Global)
- Status: ✅ **Affects WS3**
- Behavior: Select "Midwest" → WS3 recalculates to show top 20 hospitals in Midwest only
- Configuration: Dashboard filter → "Apply to All Sheets" (includes WS3)

**Date Range Filter** (Local)
- Status: ✅ **Affects WS3**
- Behavior: Adjust date range → Hospital rankings update based on filtered period
- Configuration: Dashboard filter → "Apply to Sheets" → WS3 + WS2 + WS1

**Smoking Status Filter** (Local)
- Status: ❌ **Does NOT Affect WS3**
- Reason: Pareto chart ranks all hospitals regardless of smoking status

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Filter Configuration](#)

---

### 🎬 Custom Dashboard Actions Enabled

**Action 1: Hospital Drill Filter** ⭐ **Primary Action for WS3**
- Status: ✅ **Originates from WS3** (source worksheet)
- Behavior: Click any hospital bar on WS3 → ALL sheets filter to show only that hospital's data
- Impact: Most important drill-down action on dashboard; drives all cross-sheet filtering
- Configuration: Dashboard → Actions → "Hospital Drill" (source: WS3, target: All sheets)

**Action 2: Region Filter Action**
- Status: ✅ **Affects WS3** as target
- Behavior: Click region on WS5 → WS3 updates with regional hospital rankings

**Action 3: Highlight Action**
- Status: ❌ **Does NOT Affect WS3**

**Action 4: URL Action**
- Status: ⚠️ **Optional** - Could link to hospital detail pages
- Config: Click hospital bar → Open URL like `https://hospital-db.com/hospitals/[Hospital Name]`

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Custom Actions Section - Action 1: Hospital Drill](#)

---

### 📖 Storyboard Involvement

**Story Point 3: CONCENTRATION — Pareto 80-20**
- Status: ✅ **Featured in Story Point 3**
- Role: Reveal cost concentration (60% in 3 hospitals) and negotiate leverage
- Caption: "80-20 Rule: 60% of Spend in 3 Hospitals"
- Interaction: Show all 20 hospitals (no filters); highlight top 3
- Annotations: Red boxes around top 3 bars, cumulative % line marked at 60%, callout showing $2.6M dollar amount
- Presenter Talking Points: Negotiation leverage, $260K-$390K savings potential from 10-15% reduction

**See Also:** [TABLEAU_STORYBOARD_GUIDE.md - Story Point 3: CONCENTRATION](#)

---

### 📚 Cross-References

- **Dashboard Assembly:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Row 2 Layout](#) for WS3 placement (50/50 split right side with WS2)
- **Storyboard:** See [TABLEAU_STORYBOARD_GUIDE.md - Story Point 3](#) for WS3's role in cost concentration narrative
- **Dashboard Actions:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 6: Actions](#) for how WS3 triggers hospital drill-down

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Mark Type | Combo (Bar + Line) |
| Primary Axis | Blue Bars, SUM(Cost) |
| Secondary Axis | Red Line, Cumulative % |
| Reference Line | 80% Threshold (Red dashed) |
| Sort | Hospital Cost, Descending |
| Tooltip | Name, Cost, Claims, Cumulative % |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| Two axes not visible | Right-click secondary axis → Show dual axis |
| Cumulative line not calculated | Check Table Calculation settings; reapply Running Sum |
| 80% line not showing | Analytics pane → Reference Line → Set value to 80 |
| Hospitals not sorted correctly | Right-click Hospital Name → Sort by sum of Claim Amount descending |

---

**Worksheet 3 Complete!** ✅ Proceed to Worksheet 4.

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI*
