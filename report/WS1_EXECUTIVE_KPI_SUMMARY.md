# WORKSHEET 1: EXECUTIVE KPI SUMMARY

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 25 minutes | **Complexity:** ⭐ Easy

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | KPI Cards (4 independent text cards) |
| **Data Source** | v_claims_tableau |
| **Row Count** | ~1,591 claims (aggregated) |
| **Dimensions** | None (aggregate only) |
| **Measures** | Total Claims, Total Cost, Approval Rate, Avg Cost/Claim |
| **Filters** | None required |
| **Position on Dashboard** | Row 1 — Full width (ABOVE THE FOLD) |

---

## ✅ PRE-BUILD VERIFICATION

Before starting, verify:

- [ ] MySQL database `healthcare_claims_db` is running
- [ ] Tableau Desktop has data source `v_claims_tableau` connected
- [ ] All data fields load without errors in Data Source pane
- [ ] Query test: Row count = 1,591 records

---

## 🔨 BUILD INSTRUCTIONS

### STEP 1: Create New Worksheet
```
Menu: Worksheet → New Worksheet
Rename: "Executive KPI Summary"
```

### STEP 2: Create KPI Card #1 — TOTAL CLAIMS

**Build**
- [ ] Drag `Claim ID` → Measures pane
- [ ] Place on **TEXT** shelf
- [ ] Right-click → Aggregate = **COUNT DISTINCT**
- [ ] Tooltip should show: "SUM(Claim ID Count)" = 1,591

**Format**
- [ ] Select TEXT mark → Format panel
- [ ] Font size: **72pt**
- [ ] Font weight: **Bold**
- [ ] Font color: **Dark Blue** (#1F4E78)
- [ ] Font family: **Arial**
- [ ] Number format: **No decimals**, add thousands separator
- [ ] Result displays: **1,591**

**Card Container**
- [ ] Create text box label "TOTAL CLAIMS" above or below number
- [ ] Font: 14pt, Arial, Gray (#808080)
- [ ] Background shape: Rectangle, light gray (#F5F5F5), no border
- [ ] Padding: 15px internal

### STEP 3: Create KPI Card #2 — TOTAL COST

**Build**
- [ ] Drag `Claim Amount` → TEXT shelf
- [ ] Right-click → Aggregate = **SUM**
- [ ] Auto-calculates total cost across all claims

**Format**
- [ ] Font size: **72pt**, Bold
- [ ] Font color: **Dark Blue** (#1F4E78)
- [ ] Number format: **Currency ($)**, 0 decimals, comma separator
- [ ] Expected value: **~$4,300,000** to **$4,500,000**
- [ ] Display format: **$4,345,000**

**Card Container**
- [ ] Label: "TOTAL COST"
- [ ] Same styling as KPI #1

### STEP 4: Create KPI Card #3 — APPROVAL RATE

**Build**
- [ ] Create calculated field (Data pane → + icon → Calculated Field):
  ```
  Name: Approval Rate
  Formula: COUNTIF([Claim Status]="Approved") / COUNT([Claim ID])
  ```
- [ ] Drag new `Approval Rate` field → TEXT shelf
- [ ] Right-click → Aggregate = **AVERAGE** (or SUM if already aggregated)

**Format**
- [ ] Font size: **72pt**, Bold
- [ ] Font color: **Green** (#70AD47)
- [ ] Number format: **Percentage**, 0 decimals
- [ ] Expected value: **~80-85%** (e.g., 82%)
- [ ] Display format: **82%**

**Card Container**
- [ ] Label: "APPROVAL RATE"
- [ ] Background color: Light green (#E2EFDA)

### STEP 5: Create KPI Card #4 — AVERAGE COST PER CLAIM

**Build**
- [ ] Create calculated field:
  ```
  Name: Avg Cost per Claim
  Formula: SUM([Claim Amount]) / COUNT([Claim ID])
  ```
- [ ] Drag `Avg Cost per Claim` → TEXT shelf

**Format**
- [ ] Font size: **72pt**, Bold
- [ ] Font color: **Dark Blue** (#1F4E78)
- [ ] Number format: **Currency ($)**, 0 decimals
- [ ] Expected value: **~$2,689**
- [ ] Display format: **$2,689**

**Card Container**
- [ ] Label: "AVG COST/CLAIM"

### STEP 6: Arrange Cards Horizontally

**Layout Method Option A: Floating Containers**
- [ ] Create 4 text box containers
- [ ] Place KPI #1 at X=10, Y=60 (top-left)
- [ ] Place KPI #2 at X=310, Y=60 (top-center-left)
- [ ] Place KPI #3 at X=610, Y=60 (top-center-right)
- [ ] Place KPI #4 at X=910, Y=60 (top-right)
- [ ] All cards same height: **90px**
- [ ] Card width: **250px** each
- [ ] Spacing between: **30px**

**Layout Method Option B: Tiled Container**
- [ ] Dashboard → Right-click → Tiled
- [ ] Drag all 4 KPI sheets into single row
- [ ] Adjust widths manually to 250px each

### STEP 7: Format Overall Sheet

- [ ] Title: "EXECUTIVE KPI SUMMARY"
  - [ ] Font: 20pt, Bold, Arial
  - [ ] Color: Dark Blue (#1F4E78)
  - [ ] Position: Top, centered
- [ ] Subtitle: "Key metrics at a glance"
  - [ ] Font: 12pt, Arial, Gray
  - [ ] Optional
- [ ] Sheet background: **White** (#FFFFFF)
- [ ] No gridlines
- [ ] No row/column headers

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] KPI #1 value: **1,591** (or exact count from database)
- [ ] KPI #2 value: **~$4.3M** (sum of all claim amounts)
- [ ] KPI #3 value: **~80-85%** (percentage of approved vs. total claims)
- [ ] KPI #4 value: **~$2,689** (average = total ÷ count)
- [ ] All values match SQL query results

**Visual Validation**
- [ ] All 4 cards visible on screen **without scrolling**
- [ ] Cards aligned horizontally (same Y-coordinate)
- [ ] Consistent spacing (30px between cards)
- [ ] Font sizes clearly readable (72pt prominent)
- [ ] Colors distinguish each card type
- [ ] No overlap between cards
- [ ] Labels clearly visible

**Functional Validation**
- [ ] Sheet loads **within 1 second** (instant aggregation)
- [ ] No errors in formula bar
- [ ] Filters absent (this sheet shows ALL data, no drill-down)
- [ ] Worksheet tab shows icon + name: "📊 Executive KPI Summary"

---

## 📊 EXPECTED OUTPUT

```
╔════════════════════════════════════════════════════════════════════╗
║          EXECUTIVE KPI SUMMARY                                     ║
╠════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
║  │ 1,591        │  │ $4,345,000   │  │ 82%          │  │ $2,689       │
║  │              │  │              │  │              │  │              │
║  │ TOTAL CLAIMS │  │ TOTAL COST   │  │ APPROVAL     │  │ AVG COST     │
║  │              │  │              │  │ RATE         │  │ PER CLAIM    │
║  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝
```

---

## 📝 NOTES & TIPS

1. **Static Summary:** This sheet has NO filters or drill-down. It's purely informational.
2. **Performance:** Aggregations are very fast (single SUM/COUNT operations).
3. **Color Coding:** KPI #3 (Approval Rate) uses green to indicate positive metric.
4. **Dashboard Placement:** This goes at TOP of dashboard as "executive glance" view.
5. **Tooltip:** Hover over any KPI card to see field name and calculation.

---

## 🎯 QUICK REFERENCE

| Metric | Expected Value | Formula | Color |
|--------|-----------------|---------|-------|
| Total Claims | 1,591 | COUNT DISTINCT([Claim ID]) | Blue |
| Total Cost | $4.3M | SUM([Claim Amount]) | Blue |
| Approval Rate | 82% | COUNTIF("Approved") / COUNT | Green |
| Avg Cost | $2,689 | SUM($) / COUNT(Claims) | Blue |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| Card shows 0 | Verify data source connection; run query in MySQL to confirm data exists |
| Numbers format wrong | Right-click metric → Format Cells → Adjust number format |
| Cards overlapping | Use tiled container instead of floating; adjust widths |
| Sheet loads slow | Remove unnecessary fields from data source; verify MySQL not under load |

---

**Worksheet 1 Complete!** ✅ Mark checkbox above and proceed to Worksheet 2.

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI | Healthcare Insurance Dashboard*
