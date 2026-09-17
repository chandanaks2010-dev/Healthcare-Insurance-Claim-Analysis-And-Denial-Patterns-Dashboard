# WORKSHEET 4: DENIAL VS COST BY HOSPITAL (BUBBLE CHART)

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 20 minutes | **Complexity:** ⭐⭐⭐ Medium-Complex

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Bubble Chart (Scatter plot) |
| **Data Source** | v_claims_tableau |
| **Dimensions** | Hospital Name, Region |
| **Measures** | AVG(Claim Amount), Denial Rate %, COUNT(Claim ID) |
| **Bubble Size** | Claim volume (# claims at each hospital) |
| **Color Encoding** | Region (6 colors for 6 regions) |
| **Position on Dashboard** | Row 3 — Left 50% |

---

## 🔨 BUILD INSTRUCTIONS

### STEP 4.1: Set Up Axes

```
Menu: Worksheet → New Worksheet
Rename: "Denial vs Cost by Hospital"
```

**X-Axis (Average Cost)**
- [ ] Drag `Hospital Name` → **DETAIL**
- [ ] Drag `Claim Amount` → **COLUMNS**
- [ ] Right-click → Aggregate = **AVERAGE**
- [ ] Result: X-axis shows avg cost per claim by hospital

**Y-Axis (Denial Rate)**
- [ ] Create calculated field:
  ```
  Name: Denial Rate %
  Formula: (SUM(IF [Claim Status] = "Denied" THEN 1 ELSE 0 END) / COUNTD([Claim ID])) * 100
  ```
- [ ] Drag `Denial Rate %` → **ROWS**
- [ ] Tableau creates scatter plot (dots)

### STEP 4.2: Add Bubble Sizes

**Claim Volume**
- [ ] Drag `Claim ID` → **SIZE**
- [ ] Right-click → Aggregate = **COUNT**
- [ ] Size scale: Edit to 5 (small) to 50 (large)
- [ ] Result: Larger bubble = more claims processed at hospital

### STEP 4.3: Add Color Encoding by Region

- [ ] Drag `Region` → **COLOR**
- [ ] Select color palette: **6 distinct colors** (one per region)
  - NorthWest: Blue
  - NorthEast: Red
  - SouthEast: Orange
  - SouthWest: Purple
  - Midwest: Green
  - West: Brown
- [ ] Legend: Show on right side

### STEP 4.4: Add Reference Lines (4-Quadrant Analysis)

**Horizontal Reference Line (Y-Axis — Avg Denial Rate)**
- [ ] Analytics pane → **Reference Line**
- [ ] Axis: Y-axis (Denial Rate)
- [ ] Value: **Portfolio average denial rate** (calculate: SUM(denied) / SUM(all) *100)
- [ ] Label: "Portfolio Avg Denial Rate"
- [ ] Color: Gray (#808080)
- [ ] Style: Dashed

**Vertical Reference Line (X-Axis — Avg Cost)**
- [ ] Analytics pane → **Reference Line**
- [ ] Axis: X-axis (Average Cost)
- [ ] Value: **Portfolio average cost per claim**
- [ ] Label: "Portfolio Avg Cost"
- [ ] Color: Gray (#808080)
- [ ] Style: Dashed

**Result:** Chart now has 4 quadrants:
- Top-Right: **High-Cost, High-Denial** (needs investigation)
- Top-Left: **Low-Cost, High-Denial** (documentation issues?)
- Bottom-Right: **High-Cost, Low-Denial** (efficient operations)
- Bottom-Left: **Low-Cost, Low-Denial** (good performers)

### STEP 4.5: Format Axes

**X-Axis (Average Cost)**
- [ ] Label: "Average Claim Cost ($)"
- [ ] Format: Currency ($), 0 decimals
- [ ] Range: $0 to (max cost × 1.2)

**Y-Axis (Denial Rate)**
- [ ] Label: "Denial Rate (%)"
- [ ] Format: Number, 0-1 decimals
- [ ] Range: 0 to 100% (or actual max if lower)

### STEP 4.6: Add Tooltips

- [ ] Drag to Tooltip:
  - `Hospital Name`
  - `Claim Amount` (AVG, currency)
  - `Denial Rate %` (percentage)
  - `Claim ID` (COUNT)
  - `Region`

**Tooltip Text**
```
Hospital: <[Hospital Name]>
Region: <[Region]>
Avg Cost: <[AVG(Claim Amount)]>
Denial Rate: <[Denial Rate %]>%
# Claims: <[COUNT(Claim ID)]>
```

### STEP 4.7: Add Hospital Name Labels (Optional)

- [ ] Drag `Hospital Name` → **LABEL**
- [ ] Right-click → Label marks for **top 5 hospitals only** OR mark with highest denial rate
- [ ] This labels the most interesting bubbles (avoids crowding)

### STEP 4.8: Format Title

- [ ] Title: "Denial Rate vs. Average Cost by Hospital"
- [ ] Subtitle: "Bubble size = claim volume; Dashed lines = portfolio average"
- [ ] Font: 18pt, Bold

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] Bubble chart has **10-20 bubbles** (one per hospital)
- [ ] X-axis range: $0 to $10k+ (realistic hospital costs)
- [ ] Y-axis range: 0% to 20%+ (realistic denial rates)
- [ ] Reference lines visible, positioned at averages

**Visual Validation**
- [ ] Bubbles vary in size (volume encoding visible)
- [ ] 6 distinct colors visible (one per region)
- [ ] Reference lines create 4 quadrants clearly
- [ ] Legend shows region colors
- [ ] Tooltip works on bubble hover

**Functional Validation**
- [ ] Performance: Loads within 2-3 seconds
- [ ] No overlapping labels (or intelligently placed)
- [ ] Sheet name shows worksheet number

---

## 📊 EXPECTED OUTPUT

```
DENIAL RATE VS COST BY HOSPITAL
═════════════════════════════════════════════════════════════
Denial%
  20% ├ ● Blue                        High-Denial/High-Cost
      │ (NW)                         Quadrant
  15% ├        ────────────┼──────────  Portfolio Avg Denial
      │       ╱   ●        │      ●   (dashed line)
  10% ├ ●●  ╱   (Red)   (Orange)
      │    ╱ ● (Green)
   5% ├  ╱    ●
      │  ╱
   0% ├─────┴──────●─────┴─●──┴──────────
      └ $1k  $3k  $5k  $7k  $9k  $11k → Avg Cost ($)
                      ↑ Portfolio Avg Cost (vertical dashed)

QUADRANT INSIGHTS:
- Upper-Right (Red zone): Hospital A — High cost + High denial
  → Action: Audit denial reasons + staff training

- Lower-Right (Efficient): Hospital E — High cost but low denial
  → Action: Study operations + potentially benchmark

- Lower-Left (Best): Hospital B, D — Low cost + Low denial
  → Action: Gold standard; consider as benchmark
```

---

## 📝 BUSINESS STRATEGY

**Quadrant-Based Actions:**

| Quadrant | Hospitals | Business Action | Priority |
|----------|-----------|-----------------|----------|
| High-Cost, High-Denial | Upper-Right | Process audit + staff training | 🔴 HIGH |
| High-Cost, Low-Denial | Lower-Right | Benchmark efficiency | 🟡 MEDIUM |
| Low-Cost, High-Denial | Upper-Left | Documentation training | 🟡 MEDIUM |
| Low-Cost, Low-Denial | Lower-Left | Gold standard; replicate model | 🟢 LOW (Good) |

---

---

## 🔧 ADVANCED FEATURES

### 📌 LOD Expressions Applied
**Status:** ❌ **No LOD Expressions**

WS4 (Denial vs Cost Bubble) uses aggregate functions (SUM, AVG, COUNT) but no LOD expressions. Hospital-level aggregations are sufficient.

**See Also:** [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - Aggregation Functions](#)

---

### 🎚️ Cascading Filters Affecting This Sheet

**Region Filter** (Global)
- Status: ✅ **Affects WS4**
- Behavior: Select region → WS4 shows only hospitals in that region
- Configuration: Dashboard filter → "Apply to All Sheets"

**Date Range Filter** (Local)
- Status: ✅ **Affects WS4**
- Behavior: Adjust dates → Denial rate and average cost recalculate
- Configuration: Dashboard filter → "Apply to Sheets" → WS4 + WS2 + WS1

**Smoking Status Filter** (Local)
- Status: ❌ **Does NOT Affect WS4**
- Reason: Bubble chart shows hospital-level, not demographic-level analysis

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Filter Configuration](#)

---

### 🎬 Custom Dashboard Actions Enabled

**Action 1: Hospital Drill Filter**
- Status: ✅ **Affects WS4** as target
- Behavior: Click hospital on WS3 (Pareto) → WS4 highlights or filters to that hospital
- Impact: Shows detailed cost/denial breakdown for selected hospital

**Action 2: Region Filter Action**
- Status: ✅ **Affects WS4** as target
- Behavior: Click region on WS5 → WS4 shows only hospitals in that region

**Action 3: Highlight Action**
- Status: ⚠️ **Optional** - Could highlight high-denial hospitals
- Config: Hover on demographic heatmap → Highlight matching hospitals on WS4

**Action 4: URL Action**
- Status: ⚠️ **Optional** - Hospital detail links

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Custom Actions Section](#)

---

### 📖 Storyboard Involvement

**Storyboard Status:** ❌ **Not Featured in Main Story**

WS4 provides supporting detail for Story Point 3 (Concentration) but is NOT part of the main 5-point narrative arc.

**Optional Usage:** In extended Q&A, could show WS4 to answer "Which hospitals have highest denial rates?" or "How does cost vs. denial correlate?"

**See Also:** [TABLEAU_STORYBOARD_GUIDE.md - Story Point 3](#)

---

### 📚 Cross-References

- **Dashboard Assembly:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Row 3 Layout](#) for WS4 placement (left side, 50/50 split with WS5)
- **Storyboard:** While not in main story, WS4 supports the concentration narrative (Story Point 3)

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Mark Type | Bubble (Circle) |
| X-Axis | AVG(Claim Amount) |
| Y-Axis | Denial Rate % |
| Size | COUNT(Claim ID) |
| Color | Region (6 colors) |
| Reference Lines | Portfolio avg cost & denial rate |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| Bubbles overlapping | Reduce size range (5-30 instead of 5-50) |
| Reference lines not showing | Analytics → Reference Line; set to Axis value |
| Denial Rate showing as decimal (0.15) | Create calc field with *100 to convert to percentage |
| Colors all same (not showing regions) | Ensure Region field on Color pill; check palette selection |
| Tooltip not showing all fields | Drag each field individually to Tooltip shelf |

---

**Worksheet 4 Complete!** ✅ Proceed to Worksheet 5.

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI*
