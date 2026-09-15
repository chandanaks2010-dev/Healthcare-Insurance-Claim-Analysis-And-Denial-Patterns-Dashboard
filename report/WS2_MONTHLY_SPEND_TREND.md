# WORKSHEET 2: MONTHLY SPEND TREND

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 20 minutes | **Complexity:** ⭐⭐ Easy-Medium

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Line Chart (with area fill + trend line) |
| **Data Source** | v_claims_tableau |
| **Time Dimension** | Claim Date (Month level) |
| **Measures** | SUM(Claim Amount) |
| **Filters** | Optional: Date range slider |
| **Position on Dashboard** | Row 2 — Left 50% |

---

## ✅ PRE-BUILD VERIFICATION

- [ ] Claim Date field contains 12+ months of data
- [ ] Data ranges from first claim to most recent claim
- [ ] v_claims_tableau connection active

---

## 🔨 BUILD INSTRUCTIONS

### STEP 2.1: Create Worksheet & Set Up Time Axis

```
Menu: Worksheet → New Worksheet
Rename: "Monthly Spend Trend"
```

**Configure Time Dimension**
- [ ] Drag `Claim Date` → **COLUMNS** shelf
- [ ] Tableau auto-creates date hierarchy
- [ ] Right-click Claim Date pill → Expand to **Month** level
  - (Not Year, not Quarter — specifically Month)
- [ ] Result shows: Jan 2024, Feb 2024, Mar 2024, ... Dec 2024

### STEP 2.2: Add Primary Measure

- [ ] Drag `Claim Amount` → **ROWS** shelf
- [ ] Right-click → Aggregate = **SUM**
- [ ] Tableau auto-creates line chart (blue line)
- [ ] X-axis now shows months; Y-axis shows dollar amounts

### STEP 2.3: Format Line Chart

**Line Style**
- [ ] Select line mark → Format pane
- [ ] Line width: **2-3pt**
- [ ] Line color: **Blue** (#4472C4)
- [ ] Line style: **Solid** (no dashing)

**Area Fill (Optional but Recommended)**
- [ ] Select line mark → Color pane
- [ ] Check "Fill" box
- [ ] Fill color: **Light Blue** (#D6E4F5)
- [ ] Transparency: **50%** (semi-transparent)
- [ ] Effect: Creates shaded region under line

**Data Points**
- [ ] Show circle markers at each month
- [ ] Marker size: **6-8px**
- [ ] Marker color: **Blue** (#4472C4)

### STEP 2.4: Add Trend Line

- [ ] Right side panel → **Analytics** pane
- [ ] Drag **Trend Line** onto chart
- [ ] Tableau analyzes and draws red dashed line through data points

**Format Trend Line**
- [ ] Right-click trend line → Edit
- [ ] Model: **Linear** (unless data shows clear curve)
- [ ] Confidence interval: **95%** (optional)
- [ ] Line color: **Red** (#C55A11)
- [ ] Line style: **Dashed** (-- pattern)
- [ ] Show equation: **Yes**
  - Displays formula like "y = 0.05x + 250000"
  - Helps interpret slope (growth trajectory)

### STEP 2.5: Format Axes

**X-Axis (Time)**
- [ ] Right-click X-axis → Edit
- [ ] Format: **"Jan 2024", "Feb 2024", ... "Dec 2024"**
- [ ] Label: "Month"
- [ ] Font: 11pt, Arial

**Y-Axis (Cost)**
- [ ] Right-click Y-axis → Edit
- [ ] Format: **Currency ($)** with comma separator
- [ ] Range: Start at **$0** (no axis truncation)
- [ ] Label: "Total Claim Amount ($)"
- [ ] Number format: **$0,** (thousands) or **$0,0** (thousands + decimals)
- [ ] Font: 11pt, Arial

**Grid Lines**
- [ ] Horizontal grid: **Light gray** (#D3D3D3), 1px
- [ ] Vertical grid: **None** (month separators sufficient)

### STEP 2.6: Add Tooltips

- [ ] Drag these fields to **Tooltip** shelf:
  - `Claim Date` (month format)
  - `Claim Amount` (SUM, formatted as currency)
  - `Claim ID` (COUNT = # claims that month)
  - `Claim Status` (COUNT distinct values)

**Tooltip Text**
```
Month: <[Claim Date]>
Total Cost: <[SUM(Claim Amount)]>
Claims Processed: <[COUNT(Claim ID)]>
Status: <[COUNT(Claim Status)]>
```

- [ ] Result: On hover, tooltip shows all month details

### STEP 2.7: Format Title & Legend

**Sheet Title**
- [ ] Title: "Monthly Spend Trend"
- [ ] Font: **18pt**, Bold, Arial
- [ ] Color: **Dark Blue** (#1F4E78)
- [ ] Subtitle: "Cost trajectory with linear trend line"
- [ ] Subtitle font: 12pt, Gray

**Legend**
- [ ] Auto-generated for line series (if color legend shows)
- [ ] Label: "Total Cost ($)"
- [ ] Position: Bottom or right side
- [ ] Font: 11pt

**Overall Sheet**
- [ ] Background: White (#FFFFFF)
- [ ] No borders on axes

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] Chart shows **12+ months** of data (or # months in dataset)
- [ ] First month value: Matches SQL query
- [ ] Last month value: Matches SQL query
- [ ] No negative values (all costs positive)
- [ ] Trend line slopes clearly (up = growth, down = decline)

**Visual Validation**
- [ ] Line is **smooth and continuous** (no gaps)
- [ ] Blue area fill under line is visible but transparent
- [ ] Red dashed trend line visible and distinct
- [ ] Circles at each data point clearly visible
- [ ] X-axis shows month labels clearly readable
- [ ] Y-axis shows dollar amounts with comma separator
- [ ] Equation visible on trend line (e.g., "y = 0.05x + 250k")

**Functional Validation**
- [ ] Tooltip shows on hover
- [ ] Tooltip displays all 4 fields
- [ ] Sheet loads within **2 seconds**
- [ ] No errors in formula bar
- [ ] Sorting: Months in chronological order (Jan → Dec)

---

## 📊 EXPECTED OUTPUT

```
MONTHLY SPEND TREND
═══════════════════════════════════════════════════════════
$500k ┤
      ├─ ╱╲           ╱╲
$400k ┤ ╱  ╲        ╱  ╲        Trend Line (Red Dashed)
      ├╱    ╲      ╱    ╲       y = 0.05x + 250k
$300k ┤      ╲    ╱      ╲     ╱
      ├─────  ╲╱ ╱        ╲   ╱  ← Blue line (filled area)
$200k ┤                  ╲ ╱
      ├
$100k ┤
      └─────────────────────────────────────────────
        Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec
                           Months (2024)

KEY INSIGHT: Upward slope = cost growth; Downward = cost decline
```

---

## 📝 KEY DISCUSSION POINTS FOR VIVA

1. **Trend Interpretation:** "The upward trend shows seasonal cost increase (e.g., cold months = higher respiratory claims). We plan mitigation by Q3."
2. **Volatility:** "Spikes in April/October may correlate with seasonal conditions or policy changes. Need further investigation."
3. **Forecasting:** "If trend continues, projected annual cost = $X by end of year."
4. **Seasonality:** "This chart clearly shows seasonal pattern — can optimize staffing and claims processing accordingly."

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Mark Type | Line (Area under) |
| Primary Color | Blue #4472C4 |
| Trend Color | Red #C55A11 (dashed) |
| Axis Labels | Month (X), Cost $ (Y) |
| Time Dimension | Month level |
| Measure | SUM(Claim Amount) |
| Expected Range | $200k - $500k monthly |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| X-axis shows years instead of months | Right-click Date pill → Expand to Month |
| Trend line not showing | Analytics pane → Drag Trend Line to chart |
| Line chart looks jagged/disconnected | Ensure Claim Date is date type (not text) |
| Tooltip not working | Drag fields to Tooltip shelf; right-click → Edit |
| Y-axis starts above $0 | Right-click Y-axis → Edit → Set range to 0 to auto |

---

**Worksheet 2 Complete!** ✅ Proceed to Worksheet 3.

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI*
