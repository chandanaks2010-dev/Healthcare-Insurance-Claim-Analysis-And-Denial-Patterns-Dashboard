# TABLEAU WORKSHEET BUILD CHECKLIST
## Healthcare Insurance Claim Analysis & Denial Patterns Dashboard
**Project:** Executive MTech — Data Science & AI  
**Workbook:** healthcare_insurance_dashboard.twbx  
**Total Worksheets:** 9  
**Estimated Total Build Time:** 3.5-4 hours  
**Status:** ⏳ READY FOR IMPLEMENTATION

---

## 📋 WORKSHEET BUILD TRACKER

| # | Name | Status | Time | Start | End | Notes |
|---|------|--------|------|-------|-----|-------|
| 1 | Executive KPI Summary | ☐ | 25 min | | | 4 KPI cards in ONE worksheet |
| 2 | Monthly Spend Trend | ☐ | 20 min | | | Line chart + trend line |
| 3 | Cost Concentration by Hospital | ☐ | 20 min | | | Pareto bar chart (80/20) |
| 4 | Denial vs Cost by Hospital | ☐ | 20 min | | | Scatter/bubble chart |
| 5 | Regional Cost and Denial Profile | ☐ | 15 min | | | Dual-axis bar chart (6 regions) |
| 6 | Claims Status Distribution | ☐ | 10 min | | | Pie chart |
| 7 | Patient Risk Segments | ☐ | 45 min | | | Demographic heatmap (HERO) |
| 8 | Geographic Heatmap: Cost by State | ☐ | 15 min | | | US map visualization |
| 9 | Patient Lifetime Value - RFM Analysis | ☐ | 30-45 min | | | Bubble chart (8 segments) |

---

## ✅ WORKSHEET 1: EXECUTIVE KPI SUMMARY

**Purpose:** 4 KPI cards showing key metrics at dashboard top  
**Chart Type:** KPI Cards (4 side-by-side cards in 1 worksheet)
**Data Source:** v_claims_tableau  
**Estimated Time:** 25 minutes  
**Complexity:** ⭐ Easy

### 📌 Pre-Build Checklist
- [ ] MySQL database healthcare_claims_db is running
- [ ] Connected to v_claims_tableau view in Tableau
- [ ] All fields load without errors (check Data Source pane)
- [ ] Row count shows ~1,591 records

### 🔨 Build Steps

**STEP 1.1: Create the Worksheet and Four KPI Fields**
- [ ] New Worksheet → Rename to `Executive KPI Summary`
- [ ] Create calculated field `Total Claims`: `COUNTD([Claim ID])`
- [ ] Create calculated field `Total Cost`: `SUM([Claim Amount])`
- [ ] Create calculated field `Approval Rate`:
  `SUM(IF [Claim Status] = "Approved" THEN 1 ELSE 0 END) / COUNTD([Claim ID])`
- [ ] Create calculated field `Average Cost per Claim`:
  `SUM([Claim Amount]) / COUNTD([Claim ID])`

**STEP 1.2: Build All Four Cards in the Same Worksheet**
- [ ] Drag `Measure Names` to **COLUMNS**
- [ ] Drag `Measure Values` to **TEXT** on the Marks card
- [ ] Filter `Measure Names` to only `Total Claims`, `Total Cost`, `Approval Rate`, and `Average Cost per Claim`
- [ ] Set the mark type to **Text**
- [ ] The four measure columns are the four KPI cards; do not create four additional worksheets

**STEP 1.3: Format the Four KPI Values**
- [ ] `Total Claims`: whole number with thousands separator; dark blue
- [ ] `Total Cost`: currency, 0 decimals; dark blue
- [ ] `Approval Rate`: percentage, 0 decimals; green
- [ ] `Average Cost per Claim`: currency, 0 decimals; dark blue
- [ ] Increase value font size and use bold text
- [ ] Format `Measure Names` as the card labels
- [ ] Use column dividers or light backgrounds to visually separate the cards

**STEP 1.4: Format Overall Sheet**
- [ ] Title: "EXECUTIVE KPI SUMMARY" (20pt, dark blue, bold)
- [ ] No filters needed (displays all data)
- [ ] Sheet background: Clean white
- [ ] Font: Arial or Tableau-standard, consistent sizing

### ✔️ Validation Checklist
- [ ] KPI 1 (Total Claims): Should show 1,591
- [ ] KPI 2 (Total Cost): Should show ~$4,300,000
- [ ] KPI 3 (Approval Rate): Should show ~82% (or actual rate from SQL)
- [ ] KPI 4 (Avg Cost): Should show ~$2,689
- [ ] All 4 cards visible side-by-side without scrolling
- [ ] No errors in formula bar
- [ ] Sheet loads within 1 second

### 📊 Expected Output
```
╔════════════════╦════════════════╦════════════════╦════════════════╗
║  TOTAL CLAIMS  ║   TOTAL COST   ║  APPROVAL RATE ║   AVG COST     ║
║     1,591      ║   $4,345,000   ║      82%       ║    $2,689      ║
╚════════════════╩════════════════╩════════════════╩════════════════╝
```

### 📝 Notes
- This worksheet should refresh instantly (no complex joins)
- Use as the "above the fold" executive view
- No drill-down needed (static summary)
- Add this single worksheet to the top row of the main dashboard

---

## ✅ WORKSHEET 2: MONTHLY SPEND TREND

**Purpose:** Time series showing monthly cost patterns with trend line  
**Chart Type:** Line Chart (with area fill optional)  
**Data Source:** v_claims_tableau  
**Estimated Time:** 20 minutes  
**Complexity:** ⭐⭐ Easy-Medium

### 🔨 Build Steps

**STEP 2.1: Set Up Axes**
- [ ] New Worksheet → Rename to `Monthly Spend Trend`
- [ ] Drag `Claim Date` to COLUMNS → Auto-creates date hierarchy
- [ ] Click dropdown on Claim Date pill → Select Month level (not Year or Quarter)
- [ ] Right-click → Aggregate = Month

**STEP 2.2: Add Primary Measure**
- [ ] Drag `Claim Amount` to ROWS
- [ ] Right-click → Aggregate = SUM
- [ ] Tableau auto-creates line chart

**STEP 2.3: Format Line Chart**
- [ ] Color: Blue (#4472C4)
- [ ] Line width: 2-3pt
- [ ] Add area fill: Light blue with transparency
- [ ] Marks: Show data points (circles) at each month

**STEP 2.4: Add Trend Line**
- [ ] Analytics pane (right side) → Drag "Trend Line" onto chart
- [ ] Trend model: Linear (unless data shows exponential pattern)
- [ ] Confidence interval: 95% (optional)
- [ ] Color: Red dashed line
- [ ] Label: Show equation (displays slope)

**STEP 2.5: Format Axes**
- [ ] X-axis (Month): Format as "Jan 2024", "Feb 2024", etc.
- [ ] Y-axis (Cost): Format as Currency with comma separator ($0)
- [ ] Axis labels: "Month" and "Total Claim Amount ($)"

**STEP 2.6: Add Tooltips**
- [ ] Drag additional fields to Tooltip: `Claim ID` (COUNT), `Claim Status`, `Region`
- [ ] Tooltip text: "Month: [Date] | Total Cost: [Sum Claim Amount] | Claims: [Count Claim ID]"

**STEP 2.7: Add Title & Formatting**
- [ ] Title: "Monthly Spend Trend" (18pt, bold)
- [ ] Subtitle: "Cost trajectory with trend line"
- [ ] Background: White
- [ ] Grid lines: Light gray, horizontal only

### ✔️ Validation Checklist
- [ ] Chart shows 12+ months of data (or # of months in dataset)
- [ ] Trend line is visible and slopes correctly (up or down)
- [ ] Y-axis starts at $0 (no truncation)
- [ ] No negative values
- [ ] Tooltip shows relevant fields on hover
- [ ] Legend not needed (single line series)
- [ ] Performance: Loads within 2 seconds

### 📊 Expected Output
```
MONTHLY SPEND TREND
═════════════════════════════════════════════════════════════
$500k ┤
      ├─ ╱╲     ╱╲
$400k ┤ ╱  ╲   ╱  ╲   ╱╲
      ├╱    ╲ ╱    ╲ ╱  ╲
$300k ┤        ╱          ╲
      ├────────────────────────  ← Trend line (red dashed)
$200k ┤
      ├
$100k ┤
      └─────────────────────────────────────────────
        Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep
```

### 📝 Notes
- If data spans <12 months, show all available months
- Trend line helps identify growth/decline trajectory
- Perfect for "seasonality" discussion in viva

---

## ✅ WORKSHEET 3: COST CONCENTRATION BY HOSPITAL (PARETO)

**Purpose:** Identify which hospitals drive 80% of total cost (Pareto analysis)  
**Chart Type:** Combo (Bar + Line for cumulative %)  
**Data Source:** v_claims_tableau  
**Estimated Time:** 20 minutes  
**Complexity:** ⭐⭐ Medium

### 🔨 Build Steps

**STEP 3.1: Create Hospital Cost Aggregation**
- [ ] New Worksheet → Rename to `Cost Concentration by Hospital`
- [ ] Drag `Hospital Name` to ROWS
- [ ] Drag `Claim Amount` to COLUMNS (SUM)
- [ ] Sort descending: Right-click hospital pill → Sort → Descending by sum of Claim Amount

**STEP 3.2: Create Running Total (Cumulative Cost)**
- [ ] Right-click `Claim Amount` pill in COLUMNS → Add Table Calculation → Running Sum
- [ ] This creates cumulative total from top to bottom

**STEP 3.3: Create Cumulative Percentage**
- [ ] Create calculated field: `Cumulative %` 
- [ ] Formula: `(RUNNING_SUM(SUM([Claim Amount])) / WINDOW_SUM(SUM([Claim Amount]))) * 100`
- [ ] Drag to secondary COLUMNS axis (right-click → Dual Axis)

**STEP 3.4: Configure Marks**
- [ ] Primary axis (Bar): Show hospital costs as bars (blue)
- [ ] Secondary axis (Line): Show cumulative % as line (red)
- [ ] Right-click secondary axis → Edit Axis → Range: 0-100%

**STEP 3.5: Add 80% Reference Line**
- [ ] Analytics pane → Drag "Reference Line" to chart
- [ ] Set to: Constant value 80%
- [ ] Label: "80% Threshold"
- [ ] Color: Red dashed line
- [ ] This shows which hospitals reach the Pareto threshold

**STEP 3.6: Format Display**
- [ ] Primary Y-axis label: "Hospital Cost ($)"
- [ ] Secondary Y-axis label: "Cumulative % of Total"
- [ ] X-axis: "Hospital Name" (rotated -45° for readability)
- [ ] Colors: Blue bars, Red line, Red dashed 80% reference
- [ ] Legend: Show to distinguish bar vs line

**STEP 3.7: Add Tooltips**
- [ ] Drag `Claim ID` (COUNT) to Tooltip
- [ ] Tooltip: "Hospital: [Name] | Total Cost: [Sum Amount] | # Claims: [Count] | Cumulative: [%]"

**STEP 3.8: Add Title**
- [ ] Title: "Cost Concentration by Hospital (Pareto Analysis)"
- [ ] Subtitle: "Red line = cumulative cost %; reaches 80% at X hospitals"

### ✔️ Validation Checklist
- [ ] Hospitals sorted by cost (highest first)
- [ ] Cumulative line increases left-to-right, reaches ~100%
- [ ] 80% reference line crosses cumulative line (shows Pareto cutoff)
- [ ] Example: If line crosses at 5th hospital, then "Top 5 hospitals drive 80% of cost"
- [ ] No data truncation
- [ ] Performance: Loads within 3 seconds
- [ ] Tooltip works on both bar and line

### 📊 Expected Output & Key Insight
```
COST CONCENTRATION BY HOSPITAL (Pareto Analysis)
═══════════════════════════════════════════════════════════
$800k ┤  ║                                                  100%
      ├  ║              ╱╲                               ╱ 80%
$600k ┤  ║            ╱   ╲                           ╱╱
      ├  ║          ╱       ╲                     ╱╱
$400k ┤  ║        ╱           ╲                ╱╱
      ├  ║      ╱               ╲            ╱┄┄┄┄ 80% threshold
$200k ┤  ║    ╱                   ╲        ╱
      ├  ║╱╲╱                     ╲    ╱
$0    └──┴──────────────────────────╲╱────────────
      Hospital₁ Hosp₂ Hosp₃ ... Hosp₅ ... Hosp₂₀

KEY INSIGHT: Top 5 hospitals (25% of network) = 80% of cost
→ Focus cost containment efforts on these 5 facilities
```

### 📝 Notes
- This is a **classic Pareto/80-20 analysis** — one of most powerful insights
- Perfect for executive discussion: "We can reduce costs 15-20% by focusing on top 5 hospitals"
- Question to prepare: "What if we benchmarked top 5 hospitals against best-in-class?"

---

## ✅ WORKSHEET 4: DENIAL VS COST BY HOSPITAL (SCATTER/BUBBLE)

**Purpose:** Multi-dimensional performance analysis: denial rate vs. average cost  
**Chart Type:** Bubble Chart (Scatter with size encoding)  
**Data Source:** v_claims_tableau  
**Estimated Time:** 20 minutes  
**Complexity:** ⭐⭐⭐ Medium-Complex

### 🔨 Build Steps

**STEP 4.1: Set Up Axes**
- [ ] New Worksheet → Rename to `Denial vs Cost by Hospital`
- [ ] Drag `Hospital Name` to DETAIL (identifies each bubble)
- [ ] Drag `Claim Amount` to COLUMNS (X-axis) → Aggregate = AVG
  - This shows "Average cost per claim by hospital"
- [ ] Create calculated field: `Denial Rate %`
  - Formula: `SUM(IF [Claim Status] = "Denied" THEN 1 ELSE 0 END) / COUNTD([Claim ID]) * 100`
- [ ] Drag `Denial Rate %` to ROWS (Y-axis)
- [ ] Tableau auto-creates bubble chart

**STEP 4.2: Add Bubble Size (Claim Volume)**
- [ ] Drag `Claim ID` to SIZE → Aggregate = COUNT
- [ ] Larger bubble = more claims processed at that hospital
- [ ] Size scale: Small (500 min) to Large (5000 max) for visibility

**STEP 4.3: Add Color by Region**
- [ ] Drag `Region` to COLOR
- [ ] Select color palette: 6 distinct colors (one per region: NW, NE, SE, SW, Midwest, West)
- [ ] This adds a 4th dimension to the chart

**STEP 4.4: Format Axes**
- [ ] X-axis label: "Average Claim Cost ($)"
- [ ] Y-axis label: "Denial Rate (%)"
- [ ] X-axis range: 0 to max + 20% padding
- [ ] Y-axis range: 0 to 100% (or 0 to actual max denial rate)

**STEP 4.5: Add Reference Lines (Optional but Powerful)**
- [ ] Analytics → Add "Reference Line" to X-axis
  - Value: Portfolio average cost (calculated mean of avg costs)
  - Label: "Portfolio Avg Cost"
  - Color: Gray dashed
- [ ] Analytics → Add "Reference Line" to Y-axis
  - Value: Portfolio average denial rate
  - Label: "Portfolio Avg Denial Rate"
  - Color: Gray dashed
- [ ] This creates 4 quadrants: High-Cost/High-Denial, High-Cost/Low-Denial, etc.

**STEP 4.6: Add Tooltips**
- [ ] Include: Hospital Name, Avg Cost, Denial Rate %, Claim Count, Region
- [ ] Tooltip formula: "Hospital: [Name] | Avg Cost: [Avg Amount] | Denial Rate: [%] | Claims: [Count] | Region: [Region]"

**STEP 4.7: Add Legend & Title**
- [ ] Legend: Show "Region" color legend on right
- [ ] Title: "Denial Rate vs. Average Cost by Hospital" (18pt)
- [ ] Subtitle: "Bubble size = claim volume; Dashed lines = portfolio average"

**STEP 4.8: Add Label to Identify Outliers (Optional)**
- [ ] Drag `Hospital Name` to LABEL
- [ ] Right-click → Mark Labels → Only labels for relevant marks
- [ ] Show labels for: High-denial hospitals (top-right quadrant)

### ✔️ Validation Checklist
- [ ] Bubble chart has 10-20 bubbles (one per hospital)
- [ ] Bubble sizes vary (largest = highest claim volume)
- [ ] Colors represent 6 regions distinctly
- [ ] Reference lines visible (show portfolio average)
- [ ] X-axis starts at $0
- [ ] Y-axis shows 0-100% or data range
- [ ] Tooltip shows all expected fields
- [ ] Legend clearly shows region colors
- [ ] Performance: Loads within 2-3 seconds

### 📊 Expected Output & Key Insight
```
DENIAL RATE VS COST BY HOSPITAL
═══════════════════════════════════════════════════════════
Denial%     ┤
    20%     ├ ●(blue)              High-Denial/High-Cost
            │ Northwest      ↑      Quadrant
    15%     ├        ────────┼─────────── Portfolio Avg
            │       ╱        │      ╲
    10%     ├ ●(red)●●●(green)     ● (orange)
            │  Midwest Southeast      West
     5%     ├        ╱      ╲       ╱
            │                ────┼──────
     0%     ├─────┴─────●─────┴─●─┴─────
            └ $1k    $3k    $5k    $7k    $9k → AvgCost($)
                                          ↑
                                 Portfolio Avg Cost

KEY INSIGHT: 
- Upper-right quadrant hospitals (e.g., Hospital A) have BOTH high costs & high denials
- This may indicate: Documentation issues OR complex patient mix
- Action: Audit Hospital A's denial reasons + staff training program
```

### 📝 Notes
- This is an **excellent multi-dimensional viz** — shows relationships, not just rankings
- Quadrant analysis powerful: "Hospitals in upper-right are efficiency problems; focus there first"
- Viva question: "Why might high-cost hospitals also have high denials?"
  - Answer: "Complex diagnoses require better documentation; staff need training"

---

## ✅ WORKSHEET 5: REGIONAL COST AND DENIAL PROFILE

**Purpose:** Compare 6 regions on cost and denial metrics side-by-side  
**Chart Type:** Dual-Axis Bar Chart (Combo)  
**Data Source:** v_claims_tableau  
**Estimated Time:** 15 minutes  
**Complexity:** ⭐⭐ Medium

### 🔨 Build Steps

**STEP 5.1: Set Up Dimensions & Measures**
- [ ] New Worksheet → Rename to `Regional Cost and Denial Profile`
- [ ] Drag `Region` to COLUMNS (sorted by cost desc)
- [ ] Drag `Claim Amount` to ROWS (SUM) → Creates bar chart
- [ ] This shows total cost per region

**STEP 5.2: Add Second Measure (Denial Rate)**
- [ ] Create calculated field: `Denial Rate %` (if not already done)
  - Formula: `SUM(IF [Claim Status] = "Denied" THEN 1 ELSE 0 END) / COUNTD([Claim ID]) * 100`
- [ ] Drag to secondary ROWS axis (right-click → Dual Axis)
- [ ] This adds a second Y-axis for denial rate

**STEP 5.3: Configure Mark Types**
- [ ] Primary axis (Total Cost): Bar chart (blue bars)
- [ ] Secondary axis (Denial Rate): Line chart (red line with dots)
- [ ] Right-click secondary axis → Edit Axis → Range: 0-20% (or actual max)

**STEP 5.4: Format Colors & Styling**
- [ ] Primary bars: Blue (#4472C4)
- [ ] Secondary line: Red (#C55A11)
- [ ] Both axes clearly labeled:
  - Left: "Total Cost ($)"
  - Right: "Denial Rate (%)"

**STEP 5.5: Add Data Labels**
- [ ] Show values on bars (cost amounts)
- [ ] Show values on line (denial percentages)
- [ ] Format: Currency for costs, Percentage for denial rate

**STEP 5.6: Sort Regions**
- [ ] Sort by cost descending: Right-click Region pill → Sort
- [ ] Expected order: (Sorted by highest to lowest cost)
- [ ] Example: "Southeast, Midwest, Northeast, Southwest, West, Northwest"

**STEP 5.7: Add Tooltips**
- [ ] Tooltip: "Region: [Region] | Total Cost: [Sum] | Claims: [Count] | Denial %: [%]"

**STEP 5.8: Add Title**
- [ ] Title: "Regional Cost & Denial Profile" (18pt)
- [ ] Subtitle: "Bars = total cost per region; Line = denial rate"

### ✔️ Validation Checklist
- [ ] 6 region bars visible (NW, NE, SE, SW, Midwest, West)
- [ ] Bars sorted by cost (descending)
- [ ] Secondary line shows denial rates (should be single-digit % or low double-digit)
- [ ] Two Y-axes properly labeled and scaled
- [ ] No negative values
- [ ] Data labels visible on bars and line
- [ ] Tooltip works for both bar and line
- [ ] Performance: Loads within 1 second

### 📊 Expected Output
```
REGIONAL COST & DENIAL PROFILE
═══════════════════════════════════════════════════════════
Cost($)     ┤ Denial(%)
  $1.2M     ├ $1.2M bar    $950k bar  $880k bar         12%
            │       ║           ║         ║      ●●●●
  $900k     ├      ║           ║         ║    ●       ●  8%
            │      ║           ║         ║  ●           ●
  $600k     ├      ║           ║         ║ ●             4%
            │      ║           ║         ●
  $300k     ├      ║           ║        ●
            │      ║           ║      ●
  $0        └──────┴───────────┴───────────────────────  0%
           SE     MW     NE     SW     W     NW
          High   ←  Regions  →    Low

KEY INSIGHTS:
- Southeast = highest cost region ($1.2M) + 10% denial rate
- This may need: Staffing audit, process review
- West = lowest cost but similar denial rate → good operations
```

### 📝 Notes
- Great for **regional strategy discussions** in viva
- Shows both cost AND quality (denial) metrics together
- Can add third dimension: Click region → filters all other sheets (dashboard action)

---

## ✅ WORKSHEET 6: CLAIMS STATUS DISTRIBUTION

**Purpose:** Simple overview of approved vs. denied vs. pending claims  
**Chart Type:** Pie Chart (or Stacked Bar)  
**Data Source:** v_claims_tableau  
**Estimated Time:** 10 minutes  
**Complexity:** ⭐ Easy

### 🔨 Build Steps

**STEP 6.1: Set Up Chart**
- [ ] New Worksheet → Rename to `Claims Status Distribution`
- [ ] Change mark type on the Marks card: Automatic → **Pie**
- [ ] Drag `Claim Status` to **Color** on the Marks card
- [ ] Drag `Claim ID` to **Angle** on the Marks card → Aggregate = COUNT
- [ ] Drag `Claim ID` to **Label** on the Marks card → Aggregate = COUNT
- [ ] Increase the pie size using the **Size** slider if needed

**STEP 6.2: Format Pie Chart**
- [ ] Color palette: 3 distinct colors
  - Approved: Green (#70AD47)
  - Denied: Red (#C55A11)
  - Pending: Yellow/Orange (#FFC000)
- [ ] Turn on **Show Mark Labels** from the Label shelf
- [ ] Slice labels: Show claim status name + count + percentage
  - Format: "Approved: 1,250 (79%)"

**STEP 6.3: Add Data Labels**
- [ ] Ensure `Claim Status` and `COUNT(Claim ID)` are on Label
- [ ] Add a quick table calculation to a second `COUNT(Claim ID)` if percentage labels are required:
  - Right-click the second count → Quick Table Calculation → Percent of Total
- [ ] Position: Outside pie (for readability)

**STEP 6.4: Add Legend & Title**
- [ ] Legend: Show to right of pie
- [ ] Title: "Claims Status Distribution" (18pt)
- [ ] Subtitle: "% of total claims by status"

**STEP 6.5: Add Tooltips**
- [ ] Tooltip: "Status: [Status] | Count: [Count] | % of Total: [%]"

### ✔️ Validation Checklist
- [ ] Pie has 3 slices (Approved, Denied, Pending)
- [ ] All percentages sum to 100%
- [ ] Approved slice is largest (usually 75-85%)
- [ ] Colors distinct and accessible (not red-green if colorblind-friendly needed)
- [ ] Labels readable (not overlapping)
- [ ] Legend present
- [ ] Performance: Loads instantly

### 📊 Expected Output
```
CLAIMS STATUS DISTRIBUTION
═════════════════════════════════════════════════════════════
          
        Approved: 1,250 (79%)
              ╱───────╲
            ╱ ██████████ ╲        ████ Approved (Green)
          │ ██████████████ │       ▓▓▓▓ Denied (Red)
          │██████████████  │       ░░░░ Pending (Yellow)
          │ ████████░░░░░░ │
            ╲ ░░░░▓▓▓╱▓▓▓╱
              ╲─────────╱
          Pending    Denied
            8%        13%

KEY INSIGHT: 79% approval rate = good operational health
But 13% denial = $X in revenue loss opportunity
```

### 📝 Notes
- Simplest worksheet to build (great for confidence!)
- Discussion point: "Which regions have highest denial rates?"

---

## ✅ WORKSHEET 7: PATIENT RISK SEGMENTS (DEMOGRAPHIC HEATMAP)

**Purpose:** HERO VISUALIZATION — Show demographic cost drivers via heatmap  
**Chart Type:** Heatmap (Highlight table)  
**Data Source:** v_demographic_segmentation (SQL view)  
**Estimated Time:** 45 minutes  
**Complexity:** ⭐⭐⭐⭐ Complex (ADVANCED)

### ⚠️ Pre-Build Requirements
- [ ] SQL Query 7.6 has been run: `07_statistical_analysis.sql`
- [ ] View `v_demographic_segmentation` exists and contains data
- [ ] Test query: `SELECT COUNT(*) FROM v_demographic_segmentation;` → Should show 20-40 rows
- [ ] Verify columns exist: age_group, bmi_category, smoker, avg_claim_cost, denial_rate_pct, patient_count

### 🔨 Build Steps

**STEP 7.1: Connect to Demographic Data Source**
- [ ] New Worksheet → Rename to `Patient Risk Segments`
- [ ] Data Source: Change from v_claims_tableau to v_demographic_segmentation
  - Right-click Connection pill → Edit connection
  - Select: healthcare_claims_db → v_demographic_segmentation
- [ ] Verify ~20-40 rows load (one per demographic cell)

**STEP 7.2: Build Heatmap Structure**
- [ ] Drag `Age Group` to ROWS
  - Expected order: 18-25, 26-35, 36-45, 46-55, 56+
  - If not ordered: Right-click → Sort → Custom
- [ ] Drag `BMI Category` to COLUMNS
  - Expected order: Underweight, Normal, Overweight, Obese
  - If not ordered: Right-click → Sort → Custom
- [ ] Drag `Avg Claim Cost` to COLOR
  - This creates heatmap cells colored by cost
- [ ] Change mark type: Automatic → Square (heatmap squares)

**STEP 7.3: Configure Color Gradient**
- [ ] Right-click Color pill → Edit Colors
- [ ] Select color palette: "Diverging" or "Red-Yellow" or custom
  - Light (Yellow/White) = Low cost (~$2k)
  - Dark (Red/Brown) = High cost (~$45k)
- [ ] Tableau auto-maps value range to colors
- [ ] Legend title: "Average Claim Cost ($)"

**STEP 7.4: Add Primary Label - Avg Cost**
- [ ] Drag `Avg Claim Cost` to TEXT
- [ ] Right-click → Aggregate = Average
- [ ] Format: Currency, 0 decimals (e.g., $2,688)
- [ ] Font: Bold, 11pt
- [ ] This displays cost value in each cell

**STEP 7.5: Add Secondary Label - Patient Count**
- [ ] Drag `Patient Count` to TEXT again
  - Tableau stacks labels vertically in each cell
- [ ] Right-click → Aggregate = Sum
- [ ] Format: "n=XXX" (e.g., "n=89")
- [ ] Font: Regular, 9pt
- [ ] Result: Each cell shows TWO lines:
  - Line 1: $12,345
  - Line 2: n=89

**STEP 7.6: Add Smoker Filter**
- [ ] Drag `Smoker` to FILTERS
- [ ] Right-click filter pill → Show Filter
- [ ] Filter type: Checkbox
- [ ] Values: Include both "Yes" and "No"
- [ ] Label: "Smoking Status"
- [ ] Effect: Filter pills appears above heatmap; can toggle Yes/No/Both
- [ ] **KEY TEST:** Toggle between Smoker=Yes, Smoker=No
  - YES should show 5-10× higher costs (visual confirmation)

**STEP 7.7: Add Region Filter (Cascading from Global)**
- [ ] Drag `Region` to FILTERS
- [ ] Right-click → Show Filter
- [ ] This allows filtering heatmap to specific region
- [ ] Effect: Allows drill-down "Show me demographics for Southeast region only"

**STEP 7.8: Add Tooltips**
- [ ] Drag `Denial Rate %`, `Total Cost`, `Claim Count` to TOOLTIP
- [ ] Tooltip text: "Age: [Age Group] | BMI: [BMI] | Smoker: [Smoker] | Avg Cost: [Average Cost] | Denial Rate: [%] | Patients: [Count] | Total Cost: [Sum]"

**STEP 7.9: Format and Title**
- [ ] Title: "Patient Risk Segments - Demographic Cost & Denial Analysis" (18pt, bold)
- [ ] Subtitle: "Darker = Higher cost; Filter by smoking status to compare cohorts"
- [ ] Sheet background: Light gray (#F5F5F5)
- [ ] No gridlines (heatmap cells provide structure)

### ✔️ Validation Checklist
- [ ] Heatmap displays 5 age groups (rows) × 4 BMI categories (columns) = 20 cells
- [ ] Color gradient visible: Light cells (yellow) on bottom-left, dark cells (red) on top-right
- [ ] Cost labels visible in each cell ($2k to $45k range)
- [ ] Patient count labels visible ("n=XX")
- [ ] Smoker filter functional:
  - [ ] Filter by "Yes" only: Colors should be darker (higher costs)
  - [ ] Filter by "No" only: Colors should be lighter (lower costs)
  - [ ] Filter by "Both": Shows full range
- [ ] Region filter works: Selecting region changes cell values
- [ ] Tooltip shows all 8+ fields
- [ ] Performance: Loads within 2-3 seconds
- [ ] Expected cost range: $2k-$45k (5-10× multiplier for smokers)

### 📊 Expected Output
```
PATIENT RISK SEGMENTS - DEMOGRAPHIC COST & DENIAL ANALYSIS
═════════════════════════════════════════════════════════════
Smoking Status Filter: [Both ▼] | Region Filter: [All ▼]

                 UNDERWEIGHT    NORMAL         OVERWEIGHT     OBESE
         ┌───────────────────────────────────────────────────────────┐
18-25   │ ░░░░░          ░░░░░          ░░░░░░░        ░░░░░░░░    │
        │ $1,800         $2,100         $2,800         $3,900      │
        │ n=89           n=156          n=124          n=102       │
        ├───────────────────────────────────────────────────────────┤
26-35   │ ░░░░░░         ░░░░░░         ░░░░░░░░░      ▒▒▒▒▒▒▒     │
        │ $2,200         $2,400         $4,200         $6,800      │
        │ n=112          n=201          n=178          n=145       │
        ├───────────────────────────────────────────────────────────┤
36-45   │ ▒▒▒▒▒▒         ▒▒▒▒▒▒░        ▒▒▒▒▒▒▒▒░      ▓▓▓▓▓▓░    │
        │ $5,400         $6,200         $8,900         $14,500     │
        │ n=98           n=187          n=143          n=167       │
        ├───────────────────────────────────────────────────────────┤
46-55   │ ▒▒▒▒▒▒▒        ▒▒▒▒▒▒▒░       ▓▓▓▓▓▓▓▓░      ██████░    │
        │ $8,700         $10,200        $16,800        $24,500     │
        │ n=76           n=154          n=189          n=198       │
        ├───────────────────────────────────────────────────────────┤
56+     │ ▓▓▓▓▓▓▓        ▓▓▓▓▓▓▓░       ██████░█       ██████████  │
        │ $12,300        $14,800        $28,500        $45,200     │
        │ n=54           n=119          n=156          n=189       │
        └───────────────────────────────────────────────────────────┘

Legend: ░░░ Light (Low Cost) ▒▒▒ Medium (Medium Cost) ██ Dark (High Cost)

INSIGHT: Diagonal gradient (corner to corner) = compound effect of age + BMI
BIGGEST LEVER: Smoker filter shows 5-10× cost increase in same cell
```

### 🎯 Key Business Insights to Articulate
- **Cost Multiplier:** Smoker vs. Non-smoker in same age/BMI cell = 1.9-3.0×
- **Highest-Risk Cohort:** Age 56+ + Obese + Smoker = $45.2k average
- **Prevention Target:** Age 46-55 + Overweight + Smoker = Large volume + moderate cost = HIGH ROI
- **Denial Correlation:** Hover cells → high-cost cohorts have higher denial rates (documentation issue?)

### 📝 Notes
- **This is your HERO VISUALIZATION** — Most impressive for viva
- Practice saying: "This one chart shows our biggest cost driver. Watch what happens when I toggle smoking status... 5-10× difference."
- Perfect for discussing prevention program ROI
- Likely viva question: "How would you use this to design a prevention program?"
  - Answer: "Target 46-55 smokers (balance of size + moderate cost) for cessation program"

---

## ✅ WORKSHEET 8: GEOGRAPHIC HEATMAP - COST BY STATE

**Purpose:** US map visualization showing cost concentration by state  
**Chart Type:** Geographic/Filled Map  
**Data Source:** v_claims_tableau  
**Estimated Time:** 15 minutes  
**Complexity:** ⭐⭐ Medium (Requires geographic setup)

### 🔨 Build Steps

**STEP 8.1: Prepare Geographic Fields**
- [ ] Verify `State` field in v_claims_tableau has geographic role set
  - Data Source → Right-click `State` → Geographic Role → State/Province
- [ ] If not set: Do this now in Data Source pane

**STEP 8.2: Create Map**
- [ ] New Worksheet → Rename to `Geographic Heatmap: Cost by State`
- [ ] Drag `State` to DETAIL
- [ ] Drag `State` to ROWS and/or COLUMNS (auto-creates map)
  - Tableau recognizes geographic field → displays US map
- [ ] Change mark type: Automatic → Map/Filled Map

**STEP 8.3: Add Color Encoding - Cost**
- [ ] Drag `Claim Amount` to COLOR
- [ ] Right-click → Aggregate = SUM
- [ ] Color palette: Yellow-Red or custom gradient
  - Light yellow = Low cost
  - Dark red = High cost
- [ ] Legend: "Total Claim Amount ($)"

**STEP 8.4: Add Size Encoding - Claim Volume**
- [ ] Drag `Claim ID` to SIZE → Aggregate = COUNT
- [ ] Size scale: Small (10) to Large (500)
- [ ] This shows state claim volume via bubble size

**STEP 8.5: Add Tooltips**
- [ ] Drag: `State`, `Claim Amount` (SUM), `Claim ID` (COUNT), `Region`, `Denial Rate %`
- [ ] Tooltip: "State: [State] | Total Cost: [Sum Amount] | # Claims: [Count] | Region: [Region] | Denial Rate: [%]"

**STEP 8.6: Add Filters (Optional)**
- [ ] Drag `Region` to FILTERS
- [ ] Show filter to enable state-level drill-down

**STEP 8.7: Add Title**
- [ ] Title: "Cost Concentration by State" (18pt)
- [ ] Subtitle: "Color intensity = total cost; Bubble size = claim volume"

### ✔️ Validation Checklist
- [ ] US map displays with state outlines visible
- [ ] All states covered by dataset show color (6 regions)
- [ ] Color gradient visible: Yellow states (low cost) to Red states (high cost)
- [ ] Tooltip works on state hover
- [ ] Region filter functional
- [ ] Performance: Map loads within 2-3 seconds
- [ ] No overlap or display issues

### 📊 Expected Output
```
COST CONCENTRATION BY STATE
═════════════════════════════════════════════════════════════

    ┌─────────────────────────────────────────────────┐
    │                                                 │
    │    WA░    MT      ND   MN             MA       │
    │  OR░░░      WY   SD░░   WI  MI  VT░  CT░     │
    │   NV░░░   UT░░   NE   IA░░░░░  NY░░░ RI░░   │
    │    CA██  AZ██  CO░░  MO░░  OH░░  PA░░░░  NJ░░ │
    │    HI██          KS    IN░░  VA░░░░░  VA░░    │
    │         NM██      OK░  KY  NC██  WV░░░       │
    │         TX██  AR    TN░░  SC██  GA██        │
    │             LA░░                MS  FL██     │
    │                                             │
    └─────────────────────────────────────────────┘

Legend: ░░ Light (Low Cost: <$300k)
        ▒▒ Medium (Medium Cost: $300-600k)
        ██ Dark (High Cost: >$600k)

KEY INSIGHT: Southeast concentrated (TX, FL, GA, SC states show highest cost)
→ Consider regional cost containment initiatives in high-cost states
```

### 📝 Notes
- Geographic maps are impressive for executives — "Story at a glance"
- Perfect for discussing regional strategies
- Can click state → filters other sheets (dashboard action)

---

## ✅ WORKSHEET 9: PATIENT LIFETIME VALUE - RFM ANALYSIS

**Purpose:** Advanced segmentation — Identify champions, at-risk, lost members  
**Chart Type:** Bubble Chart  
**Data Source:** v_rfm_analysis (SQL view)  
**Estimated Time:** 30-45 minutes  
**Complexity:** ⭐⭐⭐⭐ Complex (ADVANCED)

### ⚠️ Pre-Build Requirements
- [ ] SQL Query 7.7 has been run: `07_statistical_analysis.sql`
- [ ] View `v_rfm_analysis` exists and contains data
- [ ] Test query: `SELECT DISTINCT customer_segment FROM v_rfm_analysis;` → Should show 8 segments
- [ ] Verify columns: customer_segment, rfm_score, lifetime_monetary_value, claim_frequency, smoking_status

### 🔨 Build Steps

**STEP 9.1: Connect to RFM Data Source**
- [ ] New Worksheet → Rename to `Patient Lifetime Value - RFM Analysis`
- [ ] Data Source: Change to v_rfm_analysis
  - Right-click Connection pill → Edit connection
  - Select: healthcare_claims_db → v_rfm_analysis
- [ ] Verify ~1,591 patient rows load

**STEP 9.2: Build Bubble Chart - Segments**
- [ ] Drag `Customer Segment` to ROWS
  - Expected segments: Champions, Loyal, Potential, New, At-Risk High, At-Risk Freq, Hibernating, Lost
- [ ] Sort by lifetime value (descending):
  - Champions highest (leftmost), Lost lowest (rightmost)

**STEP 9.3: Add X-Axis Measure - Lifetime Monetary Value**
- [ ] Drag `Lifetime Monetary Value` to COLUMNS
- [ ] Right-click → Aggregate = SUM or AVG (depending on desired view)
  - SUM = total value from segment
  - AVG = average value per member in segment
  - **Recommend AVG** for fair comparison across segment sizes

**STEP 9.4: Add Bubble Size - Claim Frequency**
- [ ] Drag `Claim Frequency` to SIZE
- [ ] Right-click → Aggregate = AVG
- [ ] Size scale: 5 (small) to 50 (large)
- [ ] Larger bubble = more active members (frequent claimers)

**STEP 9.5: Add Color Encoding - RFM Score**
- [ ] Drag `RFM Score` to COLOR
- [ ] Right-click → Aggregate = AVG
- [ ] Color palette: Green (high score, good) to Red (low score, at-risk)
- [ ] Legend: "Average RFM Score" (1-4 range)

**STEP 9.6: Add Member Count Labels**
- [ ] Drag `Patient ID` to LABEL → Aggregate = COUNT DISTINCT
- [ ] Format: "n=XXX" to show segment size
- [ ] Font: 10pt, bold
- [ ] This shows how many members in each segment

**STEP 9.7: Add Smoker Drill-Down Filter (Optional but Recommended)**
- [ ] Drag `Smoking Status` to DETAIL
- [ ] OR: Drag to FILTERS and show filter
- [ ] Effect: Can filter to see "% of each segment that smokes"
- [ ] This adds 5th dimension: Segment × Smoking Status interaction

**STEP 9.8: Add Comprehensive Tooltips**
- [ ] Drag: `Customer Segment`, `Count(Patient ID)`, `Avg(Lifetime Value)`, `Avg(Claim Frequency)`, `Avg(RFM Score)`, `Avg(Days Since Last Claim)`
- [ ] Tooltip: "Segment: [Name] | Members: [Count] | Avg Lifetime Value: [LTV] | Avg Claims: [Freq] | RFM Score: [Score] | Days Inactive: [Recency]"

**STEP 9.9: Add Reference Lines (Optional Enhancement)**
- [ ] Analytics → Reference Line on X-axis
  - Value: Portfolio average lifetime value
  - Label: "Avg Member Value"
- [ ] This shows which segments are above/below average

**STEP 9.10: Format and Title**
- [ ] Title: "Patient Lifetime Value by RFM Segment" (18pt, bold)
- [ ] Subtitle: "Bubble size = claim frequency; Color = RFM score (Green=high quality, Red=churn risk)"
- [ ] X-axis label: "Average Lifetime Monetary Value ($)"
- [ ] Y-axis label: "Customer Segment"
- [ ] Legend: Show both Color legend (RFM Score) + Size legend (Claim Frequency)

### ✔️ Validation Checklist
- [ ] 8 customer segments visible (Champions through Lost)
- [ ] Segments ordered by lifetime value (Champions largest, Lost smallest)
- [ ] Bubble sizes vary (Champions/Loyal larger, Lost/Hibernating smaller)
- [ ] Color gradient visible: Green (Champions) to Red (Lost)
- [ ] Member count labels visible on bubbles
- [ ] Tooltip shows all 6+ fields
- [ ] RFM Score range appears to be 1-4 (quartile scores)
- [ ] Smoker filter functional (if added)
- [ ] Performance: Loads within 2-3 seconds

### 📊 Expected Output
```
PATIENT LIFETIME VALUE BY RFM SEGMENT
═════════════════════════════════════════════════════════════
(Bubble size = claim frequency; Color = RFM score)

Segment  │
         │   ●Champions        ●Loyal          
  8k     │   (n=234,avg$52k)   (n=312,avg$28k)
         │           ●Potential ●New
  5k     │           (n=189)    (n=267)
         │
  3k     │                  ●At-Risk High  ●At-Risk Freq
         │                  (n=145)        (n=98)
  1k     │
         │                           ●Hibernating  ●Lost
  500    │                           (n=76)       (n=42)
         │
    0    └────────────────────────────────────────────────
         $0      $10k      $20k      $30k      $40k    $50k
                  Avg Lifetime Monetary Value

Legend:  Green (●) = High RFM Score (Good)  Red (●) = Low RFM Score (At-Risk)
         Bubble Size = Average Claim Frequency (Large = Active, Small = Dormant)

KEY INSIGHTS:
1. Champions (234 members) = 15% of members, $52k avg lifetime value = 40% of total value
2. At-Risk High Value (145 members) = Dormant but valuable → WIN-BACK PRIORITY
3. Lost (42 members) = Smallest group → May not be worth retention effort
4. Smokers overrepresented in At-Risk/Hibernating → Prevention program target
```

### 🎯 Business Actions by Segment
| Segment | Business Action | Expected ROI |
|---------|-----------------|--------------|
| **Champions** | Loyalty rewards, premium services | Retain $52k/member |
| **Loyal** | Cross-sell prevention programs | Upsell $28k → $35k |
| **Potential** | Convert recent high-value to frequent | $5k → $15k over time |
| **New** | Onboarding, relationship nurturing | Grow future value |
| **At-Risk High** | Win-back campaigns, outreach | Recover $30k+ per member |
| **At-Risk Freq** | Retention program, understand churn | Prevent $8k loss |
| **Hibernating** | Reactivation IF cost-effective | Low ROI likely |
| **Lost** | Cleanup or exit | Focus effort elsewhere |

### 📝 Notes
- **This is your MOST SOPHISTICATED VISUALIZATION** — Demonstrates advanced segmentation mastery
- Perfect viva discussion: "Here's our member lifecycle strategy. Champions are our priority for retention; At-Risk High Value is our highest ROI opportunity for win-back campaigns."
- Expected viva question: "How would you combine this RFM insight with the demographic heatmap?"
  - Answer: "Smokers are overrepresented in At-Risk segments. Our prevention program targets smokers showing churn signals before they become Lost."

---

## 📊 DASHBOARD ASSEMBLY CHECKLIST

**After all 9 worksheets are complete:**

### Dashboard Creation
- [ ] Create new Dashboard: Dashboard → New Dashboard
- [ ] Rename: `Healthcare Claims and Denial Dashboard`

### Dashboard Layout (Recommended)
- [ ] **Row 1 (Height ~100px):** Drag WORKSHEET 1 (KPI Summary) — Full width
- [ ] **Row 2 (Height ~250px):** 
  - [ ] Left 50%: WORKSHEET 2 (Monthly Trend)
  - [ ] Right 50%: WORKSHEET 3 (Pareto)
- [ ] **Row 3 (Height ~250px):**
  - [ ] Left 50%: WORKSHEET 4 (Denial vs Cost)
  - [ ] Right 50%: WORKSHEET 5 (Regional Profile)
- [ ] **Row 4 (Height ~300px):** WORKSHEET 7 (Demographic Heatmap) — Full width, HERO position
- [ ] **Row 5 (Height ~200px):**
  - [ ] Left 50%: WORKSHEET 6 (Status Distribution)
  - [ ] Right 50%: WORKSHEET 8 (Geographic Map)
- [ ] **Row 6 (Optional):** WORKSHEET 9 (RFM Analysis) — Full width or side-by-side

### Dashboard Interactivity
- [ ] Filter: Region selector → filters all sheets
- [ ] Filter: Smoking Status → affects Demographic Heatmap + RFM
- [ ] Filter: Date Range → affects Trend + KPI cards
- [ ] Dashboard Action: Click region in Regional Profile → filters all
- [ ] Dashboard Action: Click hospital on Pareto → drills to hospital detail

### Dashboard Styling
- [ ] Background: White or light gray
- [ ] Title: "Healthcare Claims and Denial Analysis" (24pt, bold, dark blue)
- [ ] Consistent color palette across all sheets (6 region colors)
- [ ] Spacing: 10-15px between sheets
- [ ] Professional fonts: Arial or Tableau-standard
- [ ] All labels readable (18pt+ for titles, 11pt+ for labels)

### Save & Package
- [ ] File → Save As: `healthcare_insurance_dashboard.twb`
- [ ] File → Export Workbook: `healthcare_insurance_dashboard.twbx` (for submission)
- [ ] Verify .twbx opens without database connection

---

## 🎯 SUCCESS CRITERIA

**Worksheet Build Complete When:**
✅ All 9 worksheets built and error-free  
✅ Each worksheet displays expected output (data matches SQL)  
✅ Dashboard assembled with all sheets visible  
✅ Filters functional across dashboard  
✅ All tooltips working  
✅ Professional styling applied  
✅ Performance: Dashboard loads in <5 seconds  
✅ Workbook saved as .twb and packaged as .twbx  

---

## 📞 TROUBLESHOOTING QUICK REFERENCE

| Issue | Solution |
|-------|----------|
| "Cannot connect to MySQL" | Verify MySQL running: Services → MySQL80 → Start |
| "Data source shows 0 rows" | Check data source connection; run SQL query to verify view exists |
| "Heatmap has blank cells" | Some demographic combinations may have no data; this is normal |
| "Filters don't cascade" | Right-click filter → "Apply to all sheets" or link explicitly |
| "Map not showing US" | Right-click State field → Geographic Role → State/Province |
| "Bubble chart showing single bubble" | Ensure Customer Segment is in ROWS, not in Marks |
| "Colors not displaying gradient" | Right-click Color pill → Edit Colors → select continuous palette |
| "Performance slow" | Remove unnecessary fields from tooltips; test query performance in SQL |

---

## 📝 BUILD TIMELINE ESTIMATE

| Phase | Duration | Worksheets |
|-------|----------|-----------|
| **SETUP** | 10 min | Data source connection |
| **WS 1-2** | 45 min | KPI + Trend (quick wins) |
| **WS 3-5** | 50 min | Hospital/Region analysis |
| **WS 6** | 10 min | Status Distribution |
| **WS 7** | 45 min | Demographic Heatmap (complex) |
| **WS 8** | 15 min | Geographic Map |
| **WS 9** | 40 min | RFM Analysis (complex) |
| **LOD EXPRESSIONS** | 20 min | Advanced calculations |
| **CASCADING FILTERS** | 25 min | Global filter architecture |
| **DASHBOARD ACTIONS** | 20 min | Filter, drill, URL interactions |
| **STORYBOARD** | 30 min | Interactive story points |
| **DASHBOARD** | 30 min | Assembly + interactivity |
| **POLISH** | 15 min | Styling + save |
| **TOTAL** | **4.5-5 hours** | Complete dashboard + interactions |

---

# 🔧 LEVEL OF DETAIL (LOD) EXPRESSIONS
## Advanced Calculations for WS1, WS7, WS9

Per PDF Section 2.3: "Use Level of Detail (LOD) expressions"

### LOD Concepts (2 min read)
- **FIXED:** Aggregates at specified dimension level, ignoring current filters
- **INCLUDE:** Adds dimensions to current aggregation
- **EXCLUDE:** Removes dimensions from current aggregation

### LOD 1: Worksheet 1 (KPI Cards) - FIXED LOD

**Purpose:** Show total cost across ALL data even when dashboard is filtered by region

**Formula for `Total Cost - No Filtering`:**
```
{FIXED : SUM([Claim Amount])}
```

**Build Steps:**
1. WS1 (Executive KPI Summary) → Create calculated field
2. Name: `Total Cost (Unfiltered)`
3. Formula: `{FIXED : SUM([Claim Amount])}`
4. Use in additional text field to show "Total available cost"
5. Display both: `Total Cost` (filtered) vs. `Total Cost (Unfiltered)` for comparison

**Why:** Shows baseline; when region filter applied, card shows filtered cost while unfiltered version stays constant.

---

### LOD 2: Worksheet 7 (Demographic Heatmap) - INCLUDE LOD

**Purpose:** Calculate average cost per demographic cell, but include smoking status detail

**Formula for `Avg Cost by Risk Group`:**
```
{INCLUDE [Smoker] : AVG([Claim Amount])}
```

**Build Steps:**
1. WS7 (Demographic Heatmap) → Create calculated field
2. Name: `Average Cost by Smoker`
3. Formula: `{INCLUDE [Smoker] : AVG([Claim Amount])}`
4. Drag to Color encoding
5. This forces calculation to include Smoker in the aggregation even if not on axis

**Why:** Ensures heatmap cells show cost differentials by smoking status at finest granularity.

**Validation:** Smoker=Yes cells should be ~5-10× darker than Smoker=No cells.

---

### LOD 3: Worksheet 9 (RFM Analysis) - EXCLUDE LOD

**Purpose:** Calculate segment-level averages without including individual patient IDs

**Formula for `Segment Average Spend`:**
```
{EXCLUDE [Customer ID] : AVG([Claim Amount])}
```

**Build Steps:**
1. WS9 (RFM Bubble Chart) → Create calculated field
2. Name: `Segment Level Cost`
3. Formula: `{EXCLUDE [Customer ID] : AVG([Claim Amount])}`
4. Drag to Size encoding
5. This aggregates at RFM segment level, ignoring patient variation

**Why:** Bubble sizes show cohort averages, not patient-level noise.

**Validation:** Larger bubbles = higher-value segments; sizes should vary smoothly across 8 RFM segments.

---

### LOD Validation Checklist
- [ ] LOD 1: Total Cost (Unfiltered) shows same value regardless of region filter
- [ ] LOD 2: Heatmap cells show smoking-status-specific averages
- [ ] LOD 3: RFM bubble sizes vary by segment, not patient count
- [ ] All LOD formulas error-free (check formula bar)
- [ ] Dashboard performs smoothly with LOD calculations

---

# 🎚️ CASCADING FILTERS (Global Filter Architecture)
## Multi-level filtering: Region → State → Demographics

Per PDF Section 2.3: "Implement cascading filters"

### Filter Hierarchy
```
Dashboard-Level Filters:
├── Region (6 values: Northeast, Southeast, Midwest, Southwest, West, Mid-Atlantic)
│   └── Cascades to: ALL worksheets
├── Smoking Status (Yes/No/All)
│   └── Cascades to: Demographic Heatmap + RFM (WS7, WS9)
└── Date Range (Month/Year)
    └── Cascades to: Trend + KPI (WS2, WS1)
```

### Step 1: Create Dashboard-Level Region Filter

**On Dashboard:**
1. Drag WS5 (Regional Profile) to dashboard
2. Right-click on Region filter → "Apply to All Sheets"
3. This makes Region filter affect ALL worksheets that contain Region data
4. Filter style: Dropdown (compact)
5. Label: "📍 Filter by Region:"

**Effect:** Select "Northeast" → All other sheets update to show only Northeast data

### Step 2: Create Smoking Status Filter (Local to WS7 + WS9)

**On Dashboard:**
1. Drag WS7 (Demographic Heatmap) to dashboard
2. The Smoker filter you added in WS7 becomes a dashboard control
3. Right-click filter → "Apply to Sheets: Patient Risk Segments, Patient Lifetime Value - RFM Analysis"
4. Style: Checkbox (allows Yes/No/Both)
5. Label: "🚬 Smoking Status:"

**Effect:** Toggle smoking status → Heatmap and RFM bubble chart update instantly

### Step 3: Create Date Range Filter (Local to WS2 + WS1)

**On Dashboard:**
1. Drag WS2 (Monthly Spend Trend) to dashboard
2. Right-click Claim Date filter → "Apply to Sheets: Monthly Spend Trend, Executive KPI Summary"
3. Style: Date Range Slider
4. Label: "📅 Date Range:"

**Effect:** Adjust date range → Trend line recalculates, KPI cards update to filtered period

### Step 4: Dashboard Filter Layout

**Recommended positioning:**
```
┌─────────────────────────────────────────────────────────────────┐
│ 📊 HEALTHCARE CLAIMS ANALYSIS DASHBOARD                         │
├─────────────────────────────────────────────────────────────────┤
│ 📍 Region: [All ▼] | 🚬 Smoking: [Both ☑] | 📅 Date: [Jan-Dec] │
├─────────────────────────────────────────────────────────────────┤
│                   [Main Dashboard Content]                      │
└─────────────────────────────────────────────────────────────────┘
```

### Cascading Filter Validation Checklist
- [ ] Region filter affects all region-based worksheets
- [ ] Smoker filter affects only WS7 + WS9
- [ ] Date filter affects only WS2 + WS1
- [ ] Selecting Region = Northeast updates all filtered worksheets
- [ ] Deselecting all Regions shows "No Data"
- [ ] Each filter has descriptive label with icon
- [ ] Filters visually distinct (different colors or styles)

---

# 🎬 CUSTOM DASHBOARD ACTIONS
## Filter, Drill, URL, Parameter Actions

Per PDF Section 2.3: "Implement cascading filters and custom actions"

### Action 1: Filter Action (Click Hospital → Filter All)

**Purpose:** Click a hospital on Pareto chart (WS3) → Filter all other sheets to that hospital

**Build Steps:**
1. Dashboard → Dashboard → Edit Dashboard Actions
2. Create new → **Filter Action**
3. Name: "Hospital Drill"
4. Source Sheet: `Cost Concentration by Hospital`
5. Run On: **Click**
6. Target Sheets: **All** (or select specific worksheets)
7. Source Filters → Hospital: `Hospital Name`
8. Apply to: All relevant target sheets

**Result:** Click "Hospital ABC" on Pareto → All other sheets show only Hospital ABC claims

**Validation:** Click on bar in WS3 Pareto chart → Verify all other sheets filter to that hospital

---

### Action 2: Filter Action (Regional Profile → All)

**Purpose:** Click a region on dual-axis chart (WS5) → Filter all dashboard worksheets

**Build Steps:**
1. Dashboard → Dashboard → Edit Dashboard Actions
2. Create new → **Filter Action**
3. Name: "Region Filter"
4. Source Sheet: `Regional Cost and Denial Profile`
5. Run On: **Click**
6. Target Sheets: **All**
7. Source Filters → Region: `Region`
8. Apply to: All

**Result:** Click "Northeast" bar on WS5 → All sheets update to Northeast only

**Validation:** Click region bar → All worksheets instantly filter

---

### Action 3: Highlight Action (Hover State → Highlight)

**Purpose:** Hover over state on geographic map (WS8) → Highlight that state across visualizations

**Build Steps:**
1. Dashboard → Edit Dashboard Actions
2. Create new → **Highlight Action**
3. Name: "State Highlight"
4. Source Sheet: `Geographic Heatmap: Cost by State`
5. Run On: **Hover**
6. Target Sheets: **Selected** (choose WS7 for demographic matching)
7. Source Filters → State: `State`
8. Highlighting: Select color (e.g., orange)

**Result:** Hover over state on map → That state highlights in demographic heatmap

**Validation:** Hover over a state → Matching state highlighted in WS7

---

### Action 4: URL Action (Click to External Link)

**Purpose:** Click hospital name on Pareto → Open hospital website or detail page

**Build Steps:**
1. Dashboard → Edit Dashboard Actions
2. Create new → **URL Action**
3. Name: "Hospital Detail Link"
4. Source Sheet: `Cost Concentration by Hospital`
5. Run On: **Click**
6. URL: `https://example.com/hospitals/<Hospital Name>`
7. Apply to: All (or selected sheets)

**Example URL:**
```
https://hospital-database.com/search?name=[Hospital Name]&region=[Region]
```

**Result:** Click hospital name → Browser opens hospital information page

**Note:** Replace example URL with actual hospital database URL if available

---

### Custom Actions Validation Checklist
- [ ] Filter Action 1: Click hospital → All sheets filter ✓
- [ ] Filter Action 2: Click region → All sheets filter ✓
- [ ] Highlight Action: Hover state → Demographic heatmap highlights ✓
- [ ] URL Action: Click hospital → Browser opens (if URL configured) ✓
- [ ] Clearing filter (clicking background) removes all filters
- [ ] Multiple filters can be active simultaneously
- [ ] Performance: Dashboard responds within 1 second

---

# 📖 INTERACTIVE STORYBOARD (Business Storytelling)
## 5 Story Points with Narrative Arc

Per PDF Section 2.3: "Develop interactive storyboards for business storytelling"

### Storyboard Purpose
Guide executive audience through 5-step narrative:
1. **Scale** — Portfolio overview (1,591 claims, $4.3M)
2. **Trend** — Cost trajectory (12-month pattern)
3. **Concentration** — Pareto 80/20 rule (60% in 3 hospitals)
4. **Root Cause** — Smoking cost multiplier (5-10×)
5. **Opportunity** — RFM win-back strategy ($4.35M potential)

### Build Steps: Create Storyboard

**STEP 1: Create Story Point 1 - SCALE**
1. Workbook → New Story
2. Name: `Healthcare Claims Story`
3. Drag WS1 (KPI Summary) to first story point
4. Caption: "**Our Portfolio: 1,591 Claims Worth $4.3M**"
5. Body text: "Our healthcare organization processes 1,591 insurance claims annually, totaling $4.3 million in claim spend across 6 US regions. With an 82% approval rate, we identify significant opportunity in the 18% that face issues."

**STEP 2: Create Story Point 2 - TREND**
1. Click "Add Story Point" (+ button)
2. Drag WS2 (Monthly Spend Trend) to story point 2
3. Filter: Show all 12 months
4. Caption: "**Costs Trending Upward: +12% Year-over-Year**"
5. Body text: "Monthly spending shows a clear upward trend. Starting at $350K/month in January, we're now at $390K/month. At this trajectory, annual costs will exceed $4.6M next year without intervention."
6. Annotation: Circle the trend line area

**STEP 3: Create Story Point 3 - CONCENTRATION (Pareto)**
1. Click "Add Story Point"
2. Drag WS3 (Pareto: Cost Concentration by Hospital) to story point 3
3. Highlight top 3 hospitals with annotation boxes
4. Caption: "**80-20 Rule: 60% of Spend in 3 Hospitals**"
5. Body text: "Pareto analysis reveals that just 3 of our 20 contracted hospitals generate 60% of total costs ($2.6M). This concentration suggests opportunity for targeted negotiations. If we can reduce costs in these 3 hospitals by 10-15%, we save $260K-$390K annually."

**STEP 4: Create Story Point 4 - ROOT CAUSE (Smoking)**
1. Click "Add Story Point"
2. Drag WS7 (Demographic Heatmap) to story point 4
3. Pre-filter: Show Smoker = "Yes" ONLY
4. Caption: "**Smoking Drives 5-10× Higher Costs**"
5. Body text: "Our analysis reveals smoking status is the single strongest cost driver. Smokers average $17K-$39K per claim. Non-smokers? $2K-$8K. This 5-10× multiplier is consistent across all age groups and BMI categories. Age 46-55 smokers represent our highest-cost cohort."
6. Annotation: Highlight the darkest (most expensive) cells

**STEP 5: Create Story Point 5 - OPPORTUNITY (RFM)**
1. Click "Add Story Point"
2. Drag WS9 (RFM Bubble Chart) to story point 5
3. Highlight: At-Risk High Value segment (left side, large bubbles)
4. Caption: "**$4.35M Opportunity: Win Back At-Risk Patients**"
5. Body text: "Our RFM analysis identifies 145 at-risk high-value patients representing $4.35M in dormant lifetime value. These were active, high-spending customers who've been inactive for 12+ months. A targeted win-back campaign with 20-30% recovery yields $870K-$1.3M in annual value—a 9-18× ROI."

### Storyboard Formatting
- [ ] Title: "Healthcare Claims Analysis: Executive Story"
- [ ] Story Points ordered logically (Scale → Trend → Concentration → Root Cause → Opportunity)
- [ ] Each story point has clear caption (bold heading)
- [ ] Each story point has supporting narrative text
- [ ] Use annotations to highlight key data points
- [ ] Color annotations consistently (highlight important findings)
- [ ] Font: 14pt for captions, 12pt for body text
- [ ] Background: Professional (light gray or white)

### Storyboard Validation Checklist
- [ ] 5 story points created in correct order
- [ ] Each story point displays relevant worksheet
- [ ] Captions are compelling and data-driven
- [ ] Body text supports key findings with numbers
- [ ] Annotations highlight critical insights
- [ ] Story flows logically: Portfolio → Trend → Pattern → Cause → Action
- [ ] Storyboard can be presented in 5-7 minutes
- [ ] Story is discoverable: Clear buttons to navigate between points

---

# ✅ FINAL DASHBOARD + STORYBOARD CHECKLIST

**Dashboard Complete When:**
✅ All 9 worksheets + LOD calculations + filters + actions + storyboard complete  
✅ Cascading filters functional (Region, Smoking, Date)  
✅ 4+ custom dashboard actions working (Filter, Highlight, URL)  
✅ Storyboard tells complete 5-point narrative  
✅ All tooltips and annotations present  
✅ Professional styling and branding consistent  
✅ Performance: Dashboard loads in <5 seconds  
✅ Workbook saved as .twb and exported as .twbx

**Next Steps:**
1. ✅ Review Plan/TABLEAU_ANALYSIS_GUIDE.md for insights
2. ✅ Study Plan/VIVA_PREP.md for presentation
3. ✅ Use Plan/REFERENCE_ONE_PAGE.md for quick lookup

---

**Status:** READY FOR TABLEAU IMPLEMENTATION ✅  
**Print This Page:** Use as physical checklist while building  
**Share With Team:** Each teammate can use relevant worksheet section  
**Questions?** Refer back to Plan.md or SQL_UPDATES_SUMMARY.md for detailed specs

---

**Generated:** September 15, 2026 | **Program:** Executive MTech Data Science & AI
