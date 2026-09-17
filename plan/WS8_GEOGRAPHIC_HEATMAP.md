# WORKSHEET 8: GEOGRAPHIC HEATMAP - COST BY STATE

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 15 minutes | **Complexity:** ⭐⭐ Medium

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Filled Map (Geographic Heatmap) |
| **Data Source** | v_claims_tableau |
| **Geographic Level** | US State |
| **Color Encoding** | SUM(Claim Amount) — cost concentration by state |
| **Size Encoding** | COUNT(Claim ID) — claim volume by state |
| **Position on Dashboard** | Row 4 — Right 50% |

---

## 🔨 BUILD INSTRUCTIONS

### STEP 8.1: Set Geographic Role

```
Menu: Worksheet → New Worksheet
Rename: "Geographic Heatmap: Cost by State"
```

**Prepare State Field**
- [ ] Data Source pane → Right-click `State` field
- [ ] Select: **Geographic Role** → **State/Province**
- [ ] Tableau recognizes State as geography (enables map)

### STEP 8.2: Create Map

**Build Geographic Chart**
- [ ] Drag `State` → **DETAIL** (or drag to map area)
- [ ] Tableau auto-creates US map with state boundaries
- [ ] Mark type: Auto-changes to Map (visual cue: map icon)

### STEP 8.3: Add Color Encoding - Total Cost

**Color States by Cost**
- [ ] Drag `Claim Amount` → **COLOR**
- [ ] Right-click → Aggregate = **SUM**
- [ ] Tableau colors each state based on total cost

**Configure Color Gradient**
- [ ] Right-click Color pill → Edit Colors
- [ ] Select palette: **"Yellow-Orange-Red"** or **"Red"** diverging
  - Light Yellow = Low cost (e.g., $50k)
  - Dark Red = High cost (e.g., $800k+)
- [ ] Apply; click OK
- [ ] Color legend shows on right: "Sum of Claim Amount ($)"

### STEP 8.4: Add Size Encoding - Claim Volume

**Size States by Claim Count**
- [ ] Drag `Claim ID` → **SIZE**
- [ ] Right-click → Aggregate = **COUNT**
- [ ] Size scale: 10 (small) to 500 (large)
- [ ] Effect: Larger state bubble overlay = more claims

### STEP 8.5: Add Tooltips

**Hover Information**
- [ ] Drag to Tooltip:
  - `State`
  - `Claim Amount` (SUM, currency)
  - `Claim ID` (COUNT)
  - `Region` (which region the state belongs to)
  - `Denial Rate %` (if calculated at state level)

**Tooltip Format**
```
State: <[State]>
Region: <[Region]>
━━━━━━━━━━━━━━━━━━━
Total Cost: <[SUM(Claim Amount)]>
# Claims: <[COUNT(Claim ID)]>
Denial Rate: <[Denial Rate %]>%
```

### STEP 8.6: Add Region Filter (Optional)

**Drill-Down Capability**
- [ ] Drag `Region` → **FILTERS**
- [ ] Right-click → **Show Filter**
- [ ] Filter type: **Dropdown** or **Checkbox** (6 regions)
- [ ] Effect: Can filter map to show only specific region states

### STEP 8.7: Format Map Display

**Map Styling**
- [ ] Map style: **Tableau light** or **Standard** (default)
- [ ] State borders: **Visible**, 1px, light gray
- [ ] State fill: Color gradient (yellow to red)
- [ ] Tooltip: Show on hover (default enabled)

**Zoom & Pan**
- [ ] Tableau auto-fits map to US bounds
- [ ] Users can zoom/pan on dashboard (interactive)

### STEP 8.8: Add Title

- [ ] Title: "Cost Concentration by State"
- [ ] Subtitle: "Color intensity = total cost; Bubble size = claim volume"
- [ ] Font: 18pt, Bold, Dark Blue

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] US map displays with all state boundaries
- [ ] States with claims show colors (filled)
- [ ] States without claims show gray/neutral (no data)
- [ ] Color range: Yellow (low cost) to Red (high cost)

**Visual Validation**
- [ ] Map readable (no distortion)
- [ ] Color legend visible on right
- [ ] State labels visible (optional: can turn off if too cluttered)
- [ ] Bubble size variations visible (some states larger)

**Functional Validation**
- [ ] Hover tooltip shows all 5+ fields
- [ ] Click + drag to pan map (if enabled)
- [ ] Scroll to zoom map (if enabled)
- [ ] Region filter works (selecting region highlights/filters states)
- [ ] Performance: Loads within 2-3 seconds

---

## 📊 EXPECTED OUTPUT

```
COST CONCENTRATION BY STATE
═════════════════════════════════════════════════════════════
              US Geographic Map

    ┌──────────────────────────────────────────────────────┐
    │                                                      │
    │    WA░    MT      ND   MN             MA            │
    │  OR░░░░    WY   SD░░░  WI  MI  VT░  CT░  RI░      │
    │   NV░░░░ UT░░░░ NE░░░ IA░░░░░░ NY░░░░░ NJ░░░    │
    │    CA████ AZ████ CO░░░  MO░░░░░ OH░░░░░ PA░░░░░  │
    │    HI████       KS░░░░  IN░░░░░ VA░░░░░░░ VA░░   │
    │         NM████   OK░░░  KY░░░ NC████ WV░░░      │
    │         TX████ AR░░░░░ TN░░░░ SC████ GA██████    │
    │            LA░░░░░░              MS░░ FL████████  │
    │                                                    │
    └──────────────────────────────────────────────────────┘

Legend: ░░░ Light Yellow ($50k-$200k)
        ▒▒▒ Medium Orange ($200k-$500k)
        ██ Dark Red ($500k-$800k+)

KEY INSIGHT: Southeast states (TX, FL, GA, SC, NC) show highest cost
→ Regional concentration suggests: High hospital rates? Complex case mix?
→ Action: Comparative analysis of Southeast vs. other regions
```

---

## 📝 BUSINESS INSIGHTS

**Geographic Strategy:**
1. **Southeast Concentration** — If TX, FL, SC, GA are all dark red, indicates:
   - Higher local hospital costs?
   - Higher patient volume?
   - Specific conditions prevalent in region?

2. **Benchmarking Opportunity** — Compare:
   - High-cost states vs. low-cost states
   - Within same region (e.g., TX vs. NM within Southwest)
   - Identify best-cost providers/networks

---

---

## 🔧 ADVANCED FEATURES

### 📌 LOD Expressions Applied
**Status:** ❌ **No LOD Expressions**

WS8 (Geographic Heatmap) uses Tableau's built-in geographic capabilities. State-level aggregations are handled natively.

**See Also:** [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - Geographic Maps](#)

---

### 🎚️ Cascading Filters Affecting This Sheet

**Region Filter** (Global)
- Status: ✅ **Affects WS8**
- Behavior: Select "Northeast" → Map highlights only Northeast states
- Configuration: Dashboard filter → "Apply to All Sheets"

**Date Range Filter** (Local)
- Status: ✅ **Affects WS8**
- Behavior: Adjust dates → State-level costs recalculate
- Configuration: Dashboard filter → "Apply to Sheets" → WS8 + WS2 + WS1

**Smoking Status Filter** (Local)
- Status: ❌ **Does NOT Affect WS8**

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Filter Configuration](#)

---

### 🎬 Custom Dashboard Actions Enabled

**Action 1: Hospital Drill Filter**
- Status: ✅ **Affects WS8** as target
- Behavior: Click hospital on WS3 → Map updates to show only states where that hospital operates

**Action 2: Region Filter Action**
- Status: ✅ **Affects WS8** as target
- Behavior: Click region on WS5 → Map highlights only that region's states

**Action 3: Highlight Action** ⭐ **Originates from WS8**
- Status: ✅ **Originates from WS8** (source for heatmap highlight)
- Behavior: Hover over state on map → Matching rows in WS7 (demographic heatmap) highlight in orange
- Impact: Links geographic location to demographic profiles
- Configuration: Dashboard → Actions → Highlight Action from WS8 to WS7 on [State]

**Action 4: URL Action**
- Status: ⚠️ **Optional** - Could link state names to health department pages

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Custom Actions Section - Action 3 Highlight](#)

---

### 📖 Storyboard Involvement

**Storyboard Status:** ❌ **Not Featured in Main Story**

WS8 provides geographic context but is not part of the main 5-point narrative arc.

**Optional Use:** In extended Q&A, could show map to answer "Which states drive most spend?" or "Is there regional variation in costs?"

**Supporting Insight:** Geographic variation is minimal; smoking status is the dominant factor across all states.

**See Also:** [TABLEAU_STORYBOARD_GUIDE.md - Story Point 4: ROOT CAUSE](#) (mentions geographic consistency)

---

### 📚 Cross-References

- **Dashboard Assembly:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Row 5 Layout](#) for WS8 placement (right side, 50/50 split with WS6)
- **Storyboard:** While not featured, WS8 supports Story Point 4 narrative (smoking effect is geographically consistent)
- **Highlight Action:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 6: Action 3 - Highlight](#) for WS8-to-WS7 interaction

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Chart Type | Filled Map (US Geography) |
| Geographic Level | State |
| Color | SUM(Claim Amount), Yellow→Red gradient |
| Size | COUNT(Claim ID), 10-500 scale |
| Tooltip | State, Region, Cost, Claims, Denial % |
| Filters | Region (optional drill-down) |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| Map not showing (blank sheet) | Verify: State field has Geographic Role set to State/Province |
| All states same color | Drag SUM(Claim Amount) to COLOR shelf (ensure aggregate set to SUM) |
| Map zoomed incorrectly | Right-click map → Reset to default zoom bounds |
| States appear as text (not map) | Mark type should be Map (not Circle, Bar, etc.) |
| Tooltip not showing on hover | Drag fields to Tooltip shelf; ensure Show Tooltips enabled |
| Performance slow (takes >5 seconds) | Reduce tooltip fields; remove unnecessary dimensions from data source |

---

**Worksheet 8 Complete!** ✅ Proceed to Worksheet 9 (Final HERO visualization).

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI*
