# WORKSHEET 6: CLAIMS STATUS DISTRIBUTION

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 10 minutes | **Complexity:** ⭐ Easy

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Pie Chart |
| **Data Source** | v_claims_tableau |
| **Dimension** | Claim Status (3 values: Approved, Denied, Pending) |
| **Measure** | COUNT(Claim ID) |
| **Position on Dashboard** | Row 4 — Left 50% |

---

## 🔨 BUILD INSTRUCTIONS

### STEP 6.1: Create Pie Chart

```
Menu: Worksheet → New Worksheet
Rename: "Claims Status Distribution"
```

**Set Up Dimensions**
- [ ] Drag `Claim Status` → **COLUMNS**
- [ ] Drag `Claim ID` → **TEXT**
- [ ] Right-click Claim ID → Aggregate = **COUNT**

**Change Mark Type**
- [ ] Top toolbar → Mark Type dropdown
- [ ] Select: **Circle** (pie chart)
- [ ] Tableau converts bar chart to pie chart

### STEP 6.2: Format Pie Slices

**Color Palette (Status-Based)**
- [ ] Right-click `Claim Status` on COLOR shelf
- [ ] Edit Colors
- [ ] Assign colors:
  - **Approved:** Green (#70AD47)
  - **Denied:** Red (#C55A11)
  - **Pending:** Yellow/Gold (#FFC000)

**Slice Labels**
- [ ] Drag `Claim ID` → **LABEL** (COUNT)
- [ ] Format: Show count + percentage
- [ ] Label text: "[Claim Status]: [COUNT] ([Percentage])"
- [ ] Example: "Approved: 1,250 (79%)"
- [ ] Position: **Outside** pie (for readability)
- [ ] Font: 11pt, Arial

### STEP 6.3: Add Data Labels (Percentage)

- [ ] Drag `Claim ID` → **LABEL** again (if not already there)
- [ ] Format to show as **Percentage** on slices
- [ ] Example: Each slice shows "79%", "13%", "8%"

### STEP 6.4: Format Pie

**Size & Styling**
- [ ] Pie diameter: Adjust to fit sheet
- [ ] Legend: Show to right of pie
- [ ] Legend title: "Claim Status"

### STEP 6.5: Add Tooltips

- [ ] Drag to Tooltip:
  - `Claim Status`
  - `Claim ID` (COUNT)
  - Calculated: Percentage

**Tooltip Format**
```
Status: <[Claim Status]>
Count: <[COUNT(Claim ID)]>
% of Total: <[Percentage]>%
```

### STEP 6.6: Add Title

- [ ] Title: "Claims Status Distribution"
- [ ] Subtitle: "% of total claims by status"
- [ ] Font: 18pt, Bold, Dark Blue

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] 3 slices visible (Approved, Denied, Pending)
- [ ] All percentages sum to 100%
- [ ] Approved slice is largest (70-85% typically)
- [ ] Denied + Pending = remainder (15-30%)

**Visual Validation**
- [ ] Colors distinct: Green (Approved), Red (Denied), Yellow (Pending)
- [ ] Pie slices proportional to values
- [ ] Labels readable (no overlap)
- [ ] Legend shows status names
- [ ] Percentage labels visible on each slice

**Functional Validation**
- [ ] Tooltip works on slice hover
- [ ] Sheet loads instantly (simple aggregation)
- [ ] No formula errors

---

## 📊 EXPECTED OUTPUT

```
CLAIMS STATUS DISTRIBUTION
═════════════════════════════════════════════════════════════

          Approved: 1,250 (79%)
              ╱───────╲
            ╱ ██████████ ╲
          │ ██████████████ │     ████ Approved (Green)
          │██████████████  │     ▓▓▓▓ Denied (Red)
          │ ████████░░░░░░ │     ░░░░ Pending (Yellow)
            ╲ ░░░░▓▓▓╱▓▓▓╱
              ╲─────────╱
          Pending    Denied
            8%        13%

KEY INSIGHT:
- Approval rate of 79% = Healthy operational performance
- Denial rate of 13% = ~$590k in rejected claims (opportunity for reduction)
- Pending rate of 8% = Claims in queue (if growing, indicates bottleneck)
```

---

## 📝 BUSINESS INSIGHTS

**Status Distribution Interpretation:**

| Status | Expected % | Action | Priority |
|--------|-----------|--------|----------|
| **Approved** | 75-85% | Monitor (higher is better) | Baseline |
| **Denied** | 10-20% | Reduction opportunity via training/audits | Focus Area |
| **Pending** | 5-15% | Reduce bottlenecks; target <5% | Process Improvement |

**Discussion Points:**
- "Our approval rate of 79% is industry-standard (75-80%). Room to improve to 85%?"
- "13% denial rate costs us $X annually. Targeting 10% would save $Y."
- "Pending claims indicate processing delays. Root cause: volume spike, staffing shortage, or system bottleneck?"

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Chart Type | Pie Chart |
| Dimension | Claim Status (3 values) |
| Measure | COUNT(Claim ID) |
| Colors | Green (Approved), Red (Denied), Yellow (Pending) |
| Expected Distribution | 79% : 13% : 8% (Approved : Denied : Pending) |
| Label Style | "Status: Count (Percentage)" |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| Pie not showing (bar chart instead) | Select Mark Type → Circle |
| Colors all the same | Right-click Claim Status → Edit Colors; assign distinct colors |
| Labels overlapping | Move labels outside pie; reduce font size (9-10pt) |
| Percentages showing decimals | Right-click label → Format → 0 decimal places |
| Legend not showing | Right-click Color legend → Show legend |

---

**Worksheet 6 Complete!** ✅ Proceed to Worksheet 7.

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI*
