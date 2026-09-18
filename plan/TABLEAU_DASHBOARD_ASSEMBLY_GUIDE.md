# TABLEAU DASHBOARD ASSEMBLY GUIDE
## Complete Guide to Building the Interactive Dashboard

**Healthcare Insurance Claim Analysis & Denial Patterns Dashboard**  
**Project:** Executive MTech Data Science & AI  
**Estimated Time:** 30-45 minutes  
**Complexity:** ⭐⭐⭐ Advanced

---

## 📋 OVERVIEW

**Dashboard Purpose:** Integrate 9 worksheets into a single interactive executive-level dashboard with cascading filters, drill-down actions, and real-time analytics.

**Dashboard Layout:**
```
┌─────────────────────────────────────────────────────────────┐
│ FILTERS: Region | Smoking Status | Date Range              │
├─────────────────────────────────────────────────────────────┤
│ Row 1: Executive KPI Summary (Full Width)                   │
│ [1,549 Claims] [20.4M Cost] [80.05% Approval] [$13,171 Avg]    │
├─────────────────────────────────────────────────────────────┤
│ Row 2 (50/50 Split)                                         │
│ [WS2: Monthly Trend]       | [WS3: Pareto 80/20]          │
├─────────────────────────────────────────────────────────────┤
│ Row 3 (50/50 Split)                                         │
│ [WS4: Denial vs Cost]      | [WS5: Regional Profile]      │
├─────────────────────────────────────────────────────────────┤
│ Row 4: Patient Risk Segments (Full Width - HERO)           │
│ [WS7: Demographic Heatmap - Age × BMI × Smoking]          │
├─────────────────────────────────────────────────────────────┤
│ Row 5 (50/50 Split)                                         │
│ [WS6: Status Distribution] | [WS8: Geographic Map]        │
├─────────────────────────────────────────────────────────────┤
│ Row 6: Patient Lifetime Value (Full Width)                 │
│ [WS9: RFM Bubble Chart]                                    │
└─────────────────────────────────────────────────────────────┘
```

---

## ✅ PRE-ASSEMBLY CHECKLIST

Before assembling the dashboard, verify:

- [ ] All 9 worksheets are complete and error-free
- [ ] Each worksheet displays expected data (row counts match SQL)
- [ ] All worksheets load within 2 seconds
- [ ] LOD expressions added to WS1, WS7, WS9 (per LOD EXPRESSIONS guide)
- [ ] Filters added to WS7 (Smoker) and WS2 (Date) (per CASCADING FILTERS guide)
- [ ] Tooltips customized on all sheets
- [ ] Color palette consistent across all 9 worksheets
- [ ] All titles and subtitles finalized
- [ ] Font sizes and styling consistent

**Checklist Result:**
- [ ] All 9 worksheets: ✅ Complete
- [ ] Ready to assemble: ✅ Yes

---

## 🏗️ DASHBOARD ASSEMBLY STEPS

### STEP 1: Create New Dashboard

```
Menu: Dashboard → New Dashboard
Name: "Healthcare Claims and Denial Analysis"
Size: 1400 × 900 (Full Screen - Auto)
Background: White
Enable dashboard filters: Yes
Enable tooltips: Yes
```

### STEP 2: Add Dashboard Title

**Add a title object:**
1. Dashboard → Edit Dashboard
2. Left panel → "Text" object → Drag to top of dashboard
3. Content:
```
Healthcare Insurance Claim Analysis & Denial Patterns Dashboard
Executive-Level Analytics | 1,549 Claims | $20.4M Annual Spend
```
4. Formatting:
   - Font: Arial Bold, 24pt
   - Color: Dark Blue (#003366)
   - Alignment: Center
   - Background: Light gray (#E8E8E8)
   - Padding: 10px top/bottom

### STEP 3: Add Filter Bar (Horizontal Strip)

**Create horizontal container for filters:**
1. Dashboard → Vertical Container (drag to top)
2. Add filter objects in sequence:

#### Filter 1: Region Selection
- Source: WS5 (Regional Cost and Denial Profile)
- Dimension: Region
- Type: Dropdown
- Label: "📍 Filter by Region:"
- Width: 30% of filter bar
- Default: "All"
- Apply to: **All Sheets**

#### Filter 2: Smoking Status
- Source: WS7 (Patient Risk Segments)
- Dimension: Smoker
- Type: Checkbox (allows multiple selection)
- Label: "🚬 Smoking Status:"
- Width: 30% of filter bar
- Default: Both checked
- Apply to: **WS7, WS9 only** (Demographic Heatmap + RFM)

#### Filter 3: Date Range
- Source: WS2 (Monthly Spend Trend)
- Dimension: Claim Date
- Type: Slider (Date Range)
- Label: "📅 Date Range:"
- Width: 40% of filter bar
- Default: All dates
- Apply to: **WS2, WS1 only** (Trend + KPI)

**Filter Bar Styling:**
- Background: Light blue (#D6E8F3)
- Border: 1px gray
- Padding: 10px
- Clear Button: "Reset All Filters" (optional)

### STEP 4: Build Dashboard Content (6 Rows)

#### ROW 1: Executive KPI Summary (Full Width)
```
Position: Top row
Height: 100px
Width: 100%
Content: Drag WS1 (Executive KPI Summary)
Interaction: Read-only (no filters)
```

**Steps:**
1. Dashboard → Vertical Container
2. Drag WS1 into container
3. Right-click → Sizing → Fit width
4. Remove borders/titles from worksheet (if desired)

---

#### ROW 2: Trend & Pareto Analysis (50/50 Split)
```
Position: Row 2
Height: 250px
Layout: Horizontal Split (50% | 50%)
Left (50%): WS2 - Monthly Spend Trend
Right (50%): WS3 - Cost Concentration by Hospital (Pareto)
```

**Steps:**
1. Dashboard → Horizontal Container
2. Left side: Drag WS2 (Monthly Spend Trend)
   - Right-click filter pill → "Apply to all sheets" (Claim Date)
3. Right side: Drag WS3 (Pareto)
   - Set to resize to fit container
4. Add subtle divider between columns (optional)

**Expected Interaction:**
- Region filter affects both sheets
- Date filter affects WS2 only
- Clicking bar on WS3 drills down (dashboard action)

---

#### ROW 3: Denial Analysis & Regional Performance (50/50 Split)
```
Position: Row 3
Height: 250px
Layout: Horizontal Split (50% | 50%)
Left (50%): WS4 - Denial vs Cost by Hospital (Bubble)
Right (50%): WS5 - Regional Cost and Denial Profile (Dual-Axis)
```

**Steps:**
1. Dashboard → Horizontal Container
2. Left side: Drag WS4 (Denial vs Cost bubble)
3. Right side: Drag WS5 (Regional dual-axis bar)
   - Right-click Region filter → "Apply to all sheets"
4. Add subtle divider

**Expected Interaction:**
- Region filter on WS5 cascades to all other sheets
- Clicking region bar on WS5 drills down entire dashboard

---

#### ROW 4: Demographic Risk Segments (Full Width - HERO)
```
Position: Row 4
Height: 350px (taller than other rows - HERO POSITION)
Width: 100%
Content: WS7 - Patient Risk Segments (Demographic Heatmap)
Background: Light yellow (#FFFACD) to highlight importance
```

**Steps:**
1. Dashboard → Vertical Container (with background color)
2. Drag WS7 (Demographic Heatmap) to container
3. Right-click WS7 → Sizing → Fit width
4. Add title: "🎯 HERO INSIGHT: Smoking Status is the Primary Cost Driver"
5. Add subtitle: "Darker = Higher Cost. Filter by smoking status to reveal 5-10× multiplier."

**Why Hero Position:**
- Smoking is the dominant cost driver (5-10× multiplier)
- Most important insight for business decision-makers
- Large heatmap easier to read and interact with
- Smoker filter affects this + WS9

**Expected Interaction:**
- Smoking Status filter shows/hides Yes/No cells
- Region filter also affects this sheet
- Hover cells show detailed cost breakdown

---

#### ROW 5: Status & Geographic Analysis (50/50 Split)
```
Position: Row 5
Height: 250px
Layout: Horizontal Split (50% | 50%)
Left (50%): WS6 - Claims Status Distribution (Pie)
Right (50%): WS8 - Geographic Heatmap (State-Level Map)
```

**Steps:**
1. Dashboard → Horizontal Container
2. Left side: Drag WS6 (Status Distribution pie)
3. Right side: Drag WS8 (Geographic map)
4. Add subtle divider

**Expected Interaction:**
- Pie chart shows % of Approved vs Denied vs Pending
- State map shows cost concentration by state
- Hover state on map highlights in other sheets (highlight action)

---

#### ROW 6: RFM Customer Lifetime Value (Full Width)
```
Position: Row 6
Height: 300px (tall to show 8 bubbles clearly)
Width: 100%
Content: WS9 - Patient Lifetime Value - RFM Analysis (Bubble)
```

**Steps:**
1. Dashboard → Vertical Container
2. Drag WS9 (RFM bubble chart) to container
3. Right-click WS9 → Sizing → Fit width
4. Add title: "Customer Lifetime Value Segmentation (RFM Analysis)"
5. Add annotation: "Size = Frequency | Color = RFM Score"

**Expected Interaction:**
- Smoker filter affects segment sizes
- Clicking segment highlights in other sheets
- Hover bubbles show segment details

---

### STEP 5: Configure Dashboard-Level Filters

**Apply Filters to Sheets (Cascading):**

1. **Region Filter (Global)** → Apply to ALL sheets
   - Right-click Region filter → "Apply to All Sheets"
   - Effect: Select "Northeast" → All 9 sheets update

2. **Smoking Status Filter (Local)** → Apply to specific sheets
   - Right-click Smoker filter → "Apply to Sheets"
   - Select: WS7 (Demographic Heatmap) + WS9 (RFM)
   - Effect: Toggle smoking → Only these 2 sheets update

3. **Date Range Filter (Local)** → Apply to specific sheets
   - Right-click Claim Date filter → "Apply to Sheets"
   - Select: WS2 (Trend) + WS1 (KPI Cards)
   - Effect: Change date range → Only trend & KPI update

**Validation:**
- [ ] Region filter affects all 9 worksheets
- [ ] Smoker filter affects only WS7 + WS9
- [ ] Date filter affects only WS2 + WS1
- [ ] Clearing filter (clicking background) removes all filters

---

### STEP 6: Add Dashboard Actions (Drill-Down & Interactions)

**Per CUSTOM ACTIONS guide, add 4 actions:**

#### Action 1: Filter Action - Hospital Drill
```
Name: "Hospital Drill"
Source: WS3 (Pareto chart)
Action: Click hospital bar → Filter all sheets
Target: All sheets containing Hospital Name dimension
Effect: Click "Hospital ABC" → All sheets show only Hospital ABC
```

**Build Steps:**
1. Dashboard → Edit Dashboard Actions
2. Create → Filter Action
3. Name: "Hospital Drill"
4. Source Sheet: Cost Concentration by Hospital
5. Run On: Click
6. Target Sheets: All
7. Source Filter: Hospital Name

**Test:**
- [ ] Click bar on Pareto chart
- [ ] All other sheets filter to that hospital

---

#### Action 2: Filter Action - Region Drill
```
Name: "Region Filter"
Source: WS5 (Regional Profile)
Action: Click region bar → Filter all sheets
Target: All sheets
Effect: Click "Northeast" → All sheets show only Northeast
```

**Build Steps:**
1. Dashboard → Edit Dashboard Actions
2. Create → Filter Action
3. Name: "Region Filter"
4. Source Sheet: Regional Cost and Denial Profile
5. Run On: Click
6. Target Sheets: All
7. Source Filter: Region

**Test:**
- [ ] Click region bar on WS5
- [ ] All sheets update to that region

---

#### Action 3: Highlight Action - State Highlight
```
Name: "State Highlight"
Source: WS8 (Geographic Map)
Action: Hover state → Highlight in demographic heatmap
Target: WS7 (Demographic Heatmap)
Effect: Hover state → Matching rows highlight in WS7
```

**Build Steps:**
1. Dashboard → Edit Dashboard Actions
2. Create → Highlight Action
3. Name: "State Highlight"
4. Source Sheet: Geographic Heatmap
5. Run On: Hover
6. Target Sheets: Patient Risk Segments
7. Highlight Color: Orange
8. Source Filter: State

**Test:**
- [ ] Hover over state on WS8 map
- [ ] Rows with that state highlight in WS7

---

#### Action 4: URL Action - Hospital Detail Link (Optional)
```
Name: "Hospital Detail Link"
Source: WS3, WS4, WS5 (any hospital-based sheet)
Action: Click hospital → Open external link
Target: Browser
URL: https://hospital-database.com/search?hospital=[Hospital Name]
```

**Build Steps:**
1. Dashboard → Edit Dashboard Actions
2. Create → URL Action
3. Name: "Hospital Detail Link"
4. Source Sheet: Cost Concentration by Hospital
5. Run On: Click
6. URL: `https://example.com/hospitals/<Hospital Name>`
7. Apply to: Sheets containing Hospital Name

**Note:** Configure URL to your hospital database or information system.

---

### STEP 7: Dashboard Styling & Formatting

#### Color Scheme
```
Primary: Dark Blue #003366 (titles, key metrics)
Accent: Orange #FF8C00 (highlights, alerts)
Background: White #FFFFFF (worksheets)
Filter Bar: Light Blue #D6E8F3
Hero Row: Light Yellow #FFFACD
Text: Dark Gray #333333 (body), Dark Blue (headers)
```

#### Fonts
```
Dashboard Title: Arial Bold, 24pt, Dark Blue
Section Headers: Arial Bold, 14pt, Dark Blue
Filter Labels: Arial, 11pt, Dark Gray
Chart Titles: Arial, 12pt, Dark Gray
Axis Labels: Arial, 10pt, Dark Gray
```

#### Spacing & Layout
```
Top Margin: 15px (below title bar)
Filter Bar Height: 50px
Row Padding: 10px (between rows)
Column Padding: 10px (between worksheets)
Border: 1px light gray between rows (optional)
```

#### Professional Touches
- [ ] Remove default worksheet titles (use dashboard-level labels instead)
- [ ] Remove legend duplication (show legend once, not on every sheet)
- [ ] Use consistent color palette across all worksheets
- [ ] Align all sheets to grid (Dashboard → View → Show Grid)
- [ ] Add "Last Updated: [Date]" timestamp at bottom
- [ ] Add instructions or legend box if needed

---

### STEP 8: Performance Optimization

**Ensure dashboard loads quickly:**

1. **Query Performance**
   - [ ] Each worksheet query completes in <2 seconds
   - [ ] Test in SQL before adding to dashboard
   - [ ] Consider materialized views for complex aggregations

2. **Worksheet Optimization**
   - [ ] Remove unnecessary fields from Marks (especially tooltips)
   - [ ] Use Aggregated data source if available
   - [ ] Avoid cross-data-source worksheets
   - [ ] Use filters to reduce data volume

3. **Dashboard Performance**
   - [ ] Total load time target: <5 seconds
   - [ ] Minimize LOD calculations (use only when necessary)
   - [ ] Use dashboard-level filters strategically
   - [ ] Avoid circular filter dependencies

4. **Test Performance**
   - [ ] Open dashboard: <5 sec
   - [ ] Click filter: <2 sec response
   - [ ] Click drill-down action: <2 sec response
   - [ ] Hover for tooltip: <1 sec

---

### STEP 9: Save & Package Workbook

**Save Dashboard:**
```
File → Save As
Filename: "healthcare_insurance_dashboard.twb"
Location: /tableau/ folder
Keep: MySQL data source connection
```

**Export Workbook (for submission):**
```
File → Export Workbook as .twbx
Filename: "healthcare_insurance_dashboard.twbx"
Include data? NO (to keep file size small)
Location: /tableau/ folder
```

**Verify .twbx works:**
- [ ] Close Tableau
- [ ] Double-click .twbx file
- [ ] Tableau opens workbook
- [ ] All 9 worksheets visible
- [ ] Filters functional
- [ ] Dashboard actions work

---

## ✅ DASHBOARD VALIDATION CHECKLIST

**Before Finalizing:**

### Layout & Appearance
- [ ] All 9 worksheets visible on dashboard
- [ ] No overlapping elements
- [ ] Dashboard title visible at top
- [ ] Filter bar at top with 3 filters (Region, Smoking, Date)
- [ ] Professional color scheme applied
- [ ] Fonts consistent and readable (18pt+ headers, 11pt+ labels)
- [ ] No data errors or NULL values visible

### Functionality
- [ ] Region filter applies to all sheets
- [ ] Smoking Status filter applies to WS7 + WS9 only
- [ ] Date Range filter applies to WS2 + WS1 only
- [ ] All 4 dashboard actions work (Filter 1, Filter 2, Highlight, URL)
- [ ] Clearing filters resets dashboard
- [ ] No errors in Tableau console

### Data Integrity
- [ ] KPI totals match SQL query results (1,549 claims, $20.4M spend)
- [ ] Heatmap cells populate correctly
- [ ] Pareto chart shows top hospitals
- [ ] RFM bubbles show 8 distinct segments
- [ ] Map displays all states with color gradient

### Performance
- [ ] Dashboard loads in <5 seconds
- [ ] Filter click response <2 seconds
- [ ] Action click response <2 seconds
- [ ] No lag when hovering over elements
- [ ] Smooth scrolling (if vertical scroll needed)

### Professional Quality
- [ ] No visible errors or warnings
- [ ] Tooltips formatted and informative
- [ ] All worksheet titles match business naming
- [ ] "Last Updated" timestamp visible
- [ ] Instructions/legend visible (if needed)
- [ ] Workbook saved as .twb and .twbx

---

## 🎯 SUCCESS CRITERIA

**Dashboard is complete and ready for presentation when:**

✅ All 9 worksheets integrated and functional  
✅ 3 cascading filters (Region, Smoking, Date) working  
✅ 4 dashboard actions (2 Filters, 1 Highlight, 1 URL) functional  
✅ Professional styling applied (consistent fonts, colors, spacing)  
✅ Performance target: <5 second load time  
✅ All data validated against SQL queries  
✅ Workbook saved as .twb (live) and .twbx (packaged)  
✅ Ready for Viva presentation and submission  

---

## 📞 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| "Dashboard loads slowly" | Reduce data volume; optimize SQL queries; remove unnecessary fields from tooltips |
| "Filters not cascading" | Right-click filter → "Apply to all sheets" explicitly |
| "Filter not affecting a sheet" | Check data source joins; ensure dimension exists in sheet |
| "Dashboard action not working" | Edit action → verify source/target sheets; check dimension names match |
| "Worksheets misaligned" | Use Dashboard → View → Show Grid; align to grid |
| "Colors not consistent" | Apply color palette globally via Dashboard → Format → Colors |
| ".twbx file too large" | File → Export Workbook → Uncheck "Include Data"; rely on live connection |

---

**PDF Compliance:** Section 2.3 "Develop interactive dashboards with filtering and actions"

*Healthcare Insurance Dashboard | Executive MTech Data Science & AI | Sept 2026*
