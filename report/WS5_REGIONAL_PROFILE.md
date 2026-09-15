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
