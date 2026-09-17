# WORKSHEET 5: REGIONAL COST & DENIAL PROFILE

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 15 minutes | **Complexity:** ⭐⭐ Medium

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Dual-Axis Bar + Line (Combo) |
| **Data Source** | v_claims_tableau |
| **Dimension** | Region (6 regions: NW, NE, SE, SW, Midwest, West) |
| **Primary Measure** | SUM(Claim Amount) — Bar chart |
| **Secondary Measure** | Denial Rate % — Line chart |
| **Position on Dashboard** | Row 3 — Right 50% |

---

## 🔨 BUILD INSTRUCTIONS

### STEP 5.1: Set Up Dimensions & Measures

```
Menu: Worksheet → New Worksheet
Rename: "Regional Cost and Denial Profile"
```

**Primary Axis (Total Cost by Region)**
- [ ] Drag `Region` → **COLUMNS**
- [ ] Drag `Claim Amount` → **ROWS** (SUM)
- [ ] Tableau creates bar chart (vertical bars, blue)

**Sort Regions by Cost**
- [ ] Right-click `Region` pill → Sort
- [ ] Sort by: **Sum of Claim Amount, Descending**
- [ ] Result: Highest-cost region on left

### STEP 5.2: Add Denial Rate (Secondary Axis)

**Create Denial Rate Calculated Field (if not already done)**
```
Name: Denial Rate %
Formula: (SUM(IF [Claim Status] = "Denied" THEN 1 ELSE 0 END) / COUNTD([Claim ID])) * 100
```

- [ ] Drag `Denial Rate %` → **ROWS** (same shelf as Claim Amount)
- [ ] Right-click → **Dual Axis**
- [ ] Tableau adds second Y-axis (right side)
- [ ] Auto-changes mark to line for secondary measure

### STEP 5.3: Configure Mark Types

**Primary Axis (Total Cost Bars)**
- [ ] Mark type: **Bar** (blue bars)
- [ ] Color: **Blue** (#4472C4)
- [ ] Show data labels: **Yes**
- [ ] Label format: Currency ($), 0 decimals (e.g., $1,200,000)
- [ ] Label position: Inside top of bar

**Secondary Axis (Denial Rate Line)**
- [ ] Mark type: **Line**
- [ ] Color: **Red** (#C55A11)
- [ ] Line width: **2-3pt**
- [ ] Show data labels: **Yes**
- [ ] Label format: Percentage, 0 decimals (e.g., 12%)
- [ ] Label position: Above line
- [ ] Add circle markers at each data point

### STEP 5.4: Format Axes

**Left Y-Axis (Total Cost)**
- [ ] Label: "Total Cost ($)"
- [ ] Format: Currency ($), comma separator, 0 decimals
- [ ] Range: $0 to (max × 1.2)
- [ ] Font: 11pt, Arial

**Right Y-Axis (Denial Rate)**
- [ ] Label: "Denial Rate (%)"
- [ ] Format: Number, 0 decimals
- [ ] Range: 0 to 20% (or actual max if higher)
- [ ] Font: 11pt, Arial

**X-Axis (Regions)**
- [ ] Label: "Region"
- [ ] Show all 6 region names clearly
- [ ] Font: 11pt, Arial
- [ ] No rotation needed (short names)

### STEP 5.5: Add Tooltips

- [ ] Drag to Tooltip:
  - `Region`
  - `Claim Amount` (SUM, currency)
  - `Claim ID` (COUNT)
  - `Denial Rate %` (percentage)

**Tooltip Format**
```
Region: <[Region]>
Total Cost: <[SUM(Claim Amount)]>
# Claims: <[COUNT(Claim ID)]>
Denial Rate: <[Denial Rate %]>%
```

### STEP 5.6: Format Title & Legend

**Title**
- [ ] Title: "Regional Cost & Denial Profile"
- [ ] Subtitle: "Bars = total cost per region; Line = denial rate"
- [ ] Font: 18pt, Bold, Dark Blue

**Legend**
- [ ] Show legend on right
- [ ] Legend entries: "Sum of Claim Amount" + "Denial Rate %"
- [ ] Colors: Blue bar, Red line

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] 6 regions displayed (NW, NE, SE, SW, Midwest, West)
- [ ] Regions sorted by cost (descending)
- [ ] Cost values match SQL query
- [ ] Denial rate values realistic (0-20% range typically)

**Visual Validation**
- [ ] Blue bars visible, descending left-to-right
- [ ] Red line with circle markers visible
- [ ] Data labels on bars and line (numbers clearly readable)
- [ ] Two Y-axes labeled distinctly (left=$, right=%)
- [ ] No data truncation

**Functional Validation**
- [ ] Tooltip shows all 4 fields on hover
- [ ] Sheet loads within **1-2 seconds**
- [ ] No formula errors
- [ ] Legend distinguishes bar from line

---

## 📊 EXPECTED OUTPUT

```
REGIONAL COST & DENIAL PROFILE
═══════════════════════════════════════════════════════════
Cost($)     ┤ Denial(%)
  $1.2M     ├ $1.2M      $950k      $880k                  12%
            │   ║         ║          ║       ●●●●
  $900k     ├   ║         ║          ║     ●       ●       8%
            │   ║         ║          ║   ●           ●
  $600k     ├   ║         ║          ║  ●             ●     4%
            │   ║         ║          ● ●
  $300k     ├   ║         ║        ●  ●
            │   ║         ║       ●
  $0        └───┴─────────┴────────────────────────────── 0%
           SE    MW    NE    SW    W    NW
          High  ←  Regions  →    Low

KEY METRICS:
Southeast:  $1.2M cost, 10% denial rate (high-cost, elevated denial)
West:       $450k cost,  8% denial rate (moderate cost, good denial control)
NorthWest:  $300k cost,  6% denial rate (low cost, good control - benchmark)
```

---

## 📝 BUSINESS INSIGHTS

**Regional Strategy Discussion:**
1. **Southeast** = Highest cost + elevated denial → Needs process review
2. **Midwest** = High cost but moderate denial → Good operational control
3. **Northwest** = Lowest cost + best denial control → Benchmark for others

**Expected Viva Questions:**
- "Why is Southeast so expensive?" 
  - Answer: "Likely combination of higher patient acuity, higher local hospital rates, and historical case mix. Recommend utilization review."
- "How can we reduce Southeast denial rate?"
  - Answer: "Benchmark their claims processing against Northwest; implement training program for denial reduction."

---

---

## 🔧 ADVANCED FEATURES

### 📌 LOD Expressions Applied
**Status:** ❌ **No LOD Expressions**

WS5 (Regional Profile) uses dual-axis aggregation with SUM and AVG functions but no LOD expressions.

**Note:** Regional data is naturally scoped to the Region dimension; no FIXED/INCLUDE/EXCLUDE needed.

**See Also:** [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - Dual-Axis Charts](#)

---

### 🎚️ Cascading Filters Affecting This Sheet

**Region Filter** (Global - Source of Regional Drill) ⭐ **Primary Filter for WS5**
- Status: ✅ **Affects WS5** (and originates from WS5)
- Behavior: WS5 displays all 6 regions; clicking a region bar filters entire dashboard
- Configuration: Dashboard filter → "Apply to All Sheets" (regions dropdown or buttons)
- Use Case: Executive selects "Southeast" → All 9 sheets update to Southeast data

**Date Range Filter** (Local)
- Status: ✅ **Affects WS5**
- Behavior: Adjust dates → Regional cost and denial metrics recalculate
- Configuration: Dashboard filter → "Apply to Sheets" → WS5 + WS2 + WS1

**Smoking Status Filter** (Local)
- Status: ❌ **Does NOT Affect WS5**

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Filter Configuration](#)

---

### 🎬 Custom Dashboard Actions Enabled

**Action 2: Region Filter Action** ⭐ **Originates from WS5**
- Status: ✅ **Originates from WS5** (source worksheet)
- Behavior: Click any region bar on WS5 → ALL sheets filter to show only that region's data
- Impact: Second-most important drill-down after hospital drill (WS3)
- Configuration: Dashboard → Actions → "Region Filter" (source: WS5, target: All sheets)

**Action 1: Hospital Drill Filter**
- Status: ✅ **Affects WS5** as target
- Behavior: Click hospital on WS3 → WS5 region bars update to show only that hospital's region
- Impact: Supports hierarchical drill-down (Region → Hospital level)

**Action 3: Highlight Action**
- Status: ❌ **Does NOT Affect WS5**

**Action 4: URL Action**
- Status: ⚠️ **Optional** - Regional detail links

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Custom Actions Section - Action 2: Region Filter](#)

---

### 📖 Storyboard Involvement

**Storyboard Status:** ⚠️ **Supporting Role Only**

WS5 is NOT featured in the main 5-point story arc, but supports regional context:

**Optional Reference:** In Story Point 4 (Root Cause - Smoking), presenter could mention: "This smoking multiplier is consistent across all 6 regions—it's not regional; it's fundamental."

Could show WS5 briefly to demonstrate regional consistency of smoking effect.

**See Also:** [TABLEAU_STORYBOARD_GUIDE.md - Story Point 4: ROOT CAUSE](#)

---

### 📚 Cross-References

- **Dashboard Assembly:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Row 3 Layout & Step 5](#) for WS5 placement (right side, 50/50 split with WS4) and region filter setup
- **Storyboard:** See [TABLEAU_STORYBOARD_GUIDE.md - Story Point 4](#) for how regional consistency supports smoking narrative
- **Dashboard Actions:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 6: Action 2 - Region Filter](#) for how WS5 triggers regional drill-down

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Chart Type | Combo (Bar + Line) |
| Primary Axis | Blue Bars, SUM(Cost) |
| Secondary Axis | Red Line, Denial Rate % |
| Sort | Region by Cost Descending |
| Dimensions | 6 Regions |
| Expected Range | Costs: $300k-$1.2M; Denial: 5-12% |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| Line not showing | Right-click secondary measure → Dual Axis |
| Regions not sorted by cost | Right-click Region → Sort by Sum(Amount) descending |
| Data labels overlapping | Reduce font size (9pt) or reposition |
| Second Y-axis not labeled | Right-click secondary axis → Edit; add label text |
| Values appear truncated | Expand axis range; ensure no negative axis bound |

---

**Worksheet 5 Complete!** ✅ Proceed to Worksheet 6.

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI*
