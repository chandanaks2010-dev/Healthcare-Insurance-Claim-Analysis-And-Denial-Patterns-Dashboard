# WORKSHEET 1: EXECUTIVE KPI SUMMARY

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 25 minutes | **Complexity:** ⭐ Easy

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | KPI Cards (4 side-by-side cards in one worksheet) |
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

### STEP 2: Create the Four KPI Calculated Fields

Create these calculated fields from the Data pane. Naming the fields makes them easy to select in `Measure Names`.

```text
Total Claims = COUNTD([Claim ID])
Total Cost = SUM([Claim Amount])
Approval Rate = SUM(IF [Claim Status] = "Approved" THEN 1 ELSE 0 END) / COUNTD([Claim ID])
Average Cost per Claim = SUM([Claim Amount]) / COUNTD([Claim ID])
```

### STEP 3: Put All Four Cards in One Worksheet

- [ ] Drag `Measure Names` to **COLUMNS**
- [ ] Drag `Measure Values` to **TEXT** on the Marks card
- [ ] Filter `Measure Names` to only the four calculated fields above
- [ ] Set the mark type to **Text**
- [ ] Tableau displays one column per measure, producing four side-by-side KPI cards
- [ ] Use **Fit → Entire View** so all cards remain visible

### STEP 4: Format the KPI Cards

- [ ] Format `Total Claims` as a whole number with thousands separator
- [ ] Format `Total Cost` as currency with 0 decimals
- [ ] Format `Approval Rate` as a percentage with 0 decimals
- [ ] Format `Average Cost per Claim` as currency with 0 decimals
- [ ] Use bold, large values and smaller `Measure Names` labels
- [ ] Add column dividers or light backgrounds to distinguish the four cards
- [ ] Use dark blue for cost/count values and green for approval rate

### STEP 5: Add the Worksheet to the Main Dashboard

- [ ] Create or open the dashboard `Healthcare Claims and Denial Dashboard`
- [ ] Drag the single `Executive KPI Summary` worksheet into the top row
- [ ] Set its height to approximately **90-100px**
- [ ] Do not create or add four separate KPI worksheets

### STEP 6: Format Overall Sheet

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
