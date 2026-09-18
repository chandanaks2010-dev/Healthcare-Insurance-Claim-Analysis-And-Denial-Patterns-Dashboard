# WORKSHEET 9: PATIENT LIFETIME VALUE - RFM ANALYSIS

**Healthcare Insurance Claim Analysis Dashboard**  
**Tableau Worksheet Build Guide**  
**Estimated Build Time:** 30-45 minutes | **Complexity:** ⭐⭐⭐⭐ Advanced (HERO VISUALIZATION)

---

## 📊 OVERVIEW

| Attribute | Details |
|-----------|---------|
| **Chart Type** | Bubble Chart (Advanced Segmentation) |
| **Data Source** | v_rfm_analysis (SQL View) |
| **Dimension** | Customer Segment (8 segments) |
| **X-Axis** | Average Lifetime Monetary Value ($) |
| **Y-Axis** | Customer Segment (8 categories) |
| **Bubble Size** | Average Claim Frequency |
| **Color Encoding** | RFM Score (1-4 quartile scale) |
| **Labels** | Member count per segment (n=XXX) |
| **Filters** | Smoking Status (drill-down), optional Region |
| **Position on Dashboard** | Row 5 — Full width (HERO POSITION) |

---

## ⚠️ PRE-BUILD REQUIREMENTS

**STOP! Complete these first:**

- [ ] SQL Query 7.7 has been executed: `07_statistical_analysis.sql` lines ~312-365
- [ ] MySQL view `v_rfm_analysis` exists
- [ ] Test query in MySQL: `SELECT COUNT(DISTINCT customer_segment) FROM v_rfm_analysis;`
  - Expected result: **8 segments**
- [ ] Test query: `SELECT DISTINCT customer_segment FROM v_rfm_analysis ORDER BY customer_segment;`
  - Expected segments: Champions, Loyal, Potential, New, At-Risk High, At-Risk Freq, Hibernating, Lost
- [ ] View contains columns:
  - [ ] patient_id
  - [ ] customer_segment
  - [ ] rfm_score
  - [ ] lifetime_monetary_value
  - [ ] claim_frequency
  - [ ] smoking_status (or smoker flag)
  - [ ] days_since_last_claim

**If any step fails, stop and fix SQL before continuing to Tableau build.**

---

## 🔨 BUILD INSTRUCTIONS

### STEP 9.1: Connect to RFM Data Source

```
Menu: Worksheet → New Worksheet
Rename: "Patient Lifetime Value - RFM Analysis"
```

**Change Data Source**
- [ ] Top toolbar → Data Source selector
- [ ] Current: v_claims_tableau
- [ ] Change to: v_rfm_analysis
  - [ ] MySQL connection → healthcare_claims_db → v_rfm_analysis
- [ ] Verify: Data grid shows ~1,549 rows, ~7 columns

### STEP 9.2: Build Y-Axis (Segments)

**Rows: Customer Segments**
- [ ] Drag `Customer Segment` → **ROWS**
- [ ] Expected segments (in order):
  1. Champions
  2. Loyal
  3. Potential
  4. New
  5. At-Risk High
  6. At-Risk Freq
  7. Hibernating
  8. Lost

**Sort by Lifetime Value (Descending)**
- [ ] Right-click `Customer Segment` pill → Sort
- [ ] Sort by: **Sum/Average of Lifetime Monetary Value, Descending**
- [ ] Result: Champions (highest value) at top, Lost (lowest value) at bottom

### STEP 9.3: Build X-Axis (Lifetime Value)

**Columns: Lifetime Monetary Value**
- [ ] Drag `Lifetime Monetary Value` → **COLUMNS**
- [ ] Right-click → Aggregate = **AVERAGE** (or SUM)
  - **RECOMMEND: AVERAGE** — Shows value per member (fair comparison across segment sizes)
  - SUM would show: Total value of entire segment (skewed by size)
- [ ] X-axis now shows dollar amounts ($0 to $60k+)

### STEP 9.4: Add Bubble Size (Claim Frequency)

**Size Encoding: How Active Are Members?**
- [ ] Drag `Claim Frequency` → **SIZE**
- [ ] Right-click → Aggregate = **AVERAGE**
- [ ] Size scale: 5 (small) to 50 (large)
- [ ] Interpretation:
  - Large bubble = Frequent claimers (active members)
  - Small bubble = Infrequent claimers (dormant members)
- [ ] Example:
  - Champions: Large bubble (high frequency + high value)
  - Hibernating: Small bubble (low frequency, dormant)

### STEP 9.5: Add Color Encoding (RFM Score)

**Color: Member Quality (RFM Score)**
- [ ] Drag `RFM Score` → **COLOR**
- [ ] Right-click → Aggregate = **AVERAGE**
- [ ] RFM Score range: 1-4 (quartiles)
  - Score 4 = Best members (recent, frequent, high-value)
  - Score 1 = Worst members (old, infrequent, low-value)

**Configure Color Gradient**
- [ ] Right-click Color pill → Edit Colors
- [ ] Select palette: **"Green-Yellow-Red"** or **"Blue-Red"** diverging
  - Dark Green/Blue = High RFM Score (4) = Good members = Champions/Loyal
  - Yellow/Orange = Medium RFM Score (2-3) = Mixed quality
  - Red = Low RFM Score (1) = Poor members = Lost/Hibernating
- [ ] Apply; click OK

**Color Legend**
- [ ] Legend appears: "Average RFM Score"
- [ ] Range: 1 to 4 (quartile scale)

### STEP 9.6: Add Member Count Labels

**Label: How Many Members in Each Segment?**
- [ ] Drag `Patient ID` → **LABEL**
- [ ] Right-click → Aggregate = **COUNT DISTINCT**
- [ ] Format: "n=XXX" (e.g., "n=234" means 234 members in segment)
- [ ] Label font: 10pt, Bold, Black
- [ ] Example display on bubble: **n=234**

### STEP 9.7: Add Smoking Status Filter (Drill-Down)

**Optional but Powerful**
- [ ] Drag `Smoking Status` → **FILTERS**
- [ ] Filter dialog: Include both Yes and No
- [ ] Right-click → **Show Filter**
- [ ] Filter type: **Checkbox** (Best UX)
  - [ ] ☑ Non-Smoker
  - [ ] ☑ Smoker

**TEST THE FILTER:**
- [ ] Toggle to "Smoker" only → Notice segments shift
- [ ] Expected: At-Risk High, At-Risk Freq, Hibernating segments become LARGER (more smokers in at-risk groups)
- [ ] Toggle to "Non-Smoker" only → Segments shift (fewer members in at-risk groups)
- [ ] This shows: Smoking status correlates with churn risk

### STEP 9.8: Add Comprehensive Tooltips

**Rich Information on Hover**
- [ ] Drag to Tooltip:
  - `Customer Segment`
  - `Patient ID` (COUNT DISTINCT = # members)
  - `Lifetime Monetary Value` (AVG, currency)
  - `Claim Frequency` (AVG = avg claims per member)
  - `RFM Score` (AVG, 1-4 scale)
  - `Days Since Last Claim` (AVG = avg days inactive)
  - `Smoking Status` (% smokers in segment, optional)

**Tooltip Text Template**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SEGMENT: <[Customer Segment]>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Members: <[COUNT(Patient ID)]>
Avg Lifetime Value: <[AVG(LTV)]>
Avg Claim Frequency: <[AVG(Freq)]>
RFM Score: <[AVG(RFM Score)]> / 4
Days Inactive: <[AVG(Days)]>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### STEP 9.9: Add Reference Line (Optional: Portfolio Avg Value)

**Show Portfolio Benchmark**
- [ ] Analytics pane → **Reference Line**
- [ ] Axis: X-axis (Lifetime Value)
- [ ] Value: **Portfolio average lifetime value per member**
  - (Calculate: SUM(LTV) / COUNT(Members))
- [ ] Label: "Portfolio Avg Member Value"
- [ ] Color: Gray (#808080)
- [ ] Style: Dashed

**Effect:** Shows which segments are above/below average value

### STEP 9.10: Change Mark Type

- [ ] Top toolbar → Mark type selector
- [ ] Current: Automatic (might be line)
- [ ] Change to: **Circle** (bubble chart)
- [ ] Effect: Clear bubble representation

### STEP 9.11: Format Axes

**X-Axis (Lifetime Value)**
- [ ] Label: "Average Lifetime Monetary Value ($)"
- [ ] Format: Currency ($), 0 decimals
- [ ] Range: $0 to $60k (or max + 10%)

**Y-Axis (Customer Segment)**
- [ ] Label: "Customer Segment"
- [ ] Sorted: Champions (top) to Lost (bottom)

### STEP 9.12: Format Title

- [ ] Title: "Patient Lifetime Value by RFM Segment"
- [ ] Subtitle: "Bubble size = claim frequency; Color = RFM score (Green=loyal, Red=churn-risk)"
- [ ] Font: 18pt, Bold, Dark Blue

---

## ✔️ VALIDATION CHECKLIST

**Data Validation**
- [ ] 8 customer segments visible (all segment names present)
- [ ] Segments ordered by lifetime value (Champions highest, Lost lowest)
- [ ] Member counts reasonable (e.g., Champions n=200-300, Lost n=30-50)
- [ ] Lifetime values realistic ($2k-$55k range typical)
- [ ] Claim frequencies: Champions ~4-5 claims/year, Lost ~1 claim/year

**Visual Validation**
- [ ] Bubbles vary in size (Champions large, Lost small)
- [ ] Color gradient visible: Green (Champions) to Red (Lost)
- [ ] Member count labels on each bubble (n=XXX)
- [ ] Color legend shows 1-4 RFM score scale
- [ ] Reference line visible (if added)
- [ ] Smoking filter shows above chart

**Functional Validation**
- [ ] Tooltip shows all 7+ fields
- [ ] Smoking filter toggles immediately
- [ ] Segments reorder correctly when filtered
- [ ] Sheet loads within **2-3 seconds**
- [ ] Performance smooth (no lag on interaction)

---

## 📊 EXPECTED OUTPUT

```
PATIENT LIFETIME VALUE BY RFM SEGMENT
═════════════════════════════════════════════════════════════
Smoking Status Filter: [☑ Non-Smoker ☑ Smoker]

Segment  ┤
         ├ ●Champions        ●Loyal           ●Potential
    $50k ├ (n=234)           (n=312)          (n=189)
         ├ $52,000           $28,000          $15,000
         │     ●New
    $35k ├     (n=267)
         ├     $12,000
         │
    $20k ├                           ●At-Risk High ●At-Risk Freq
         │                           (n=145)       (n=98)
         │                           $30,000       $8,000
    $10k ├
         │
     $5k ├                                  ●Hibernating  ●Lost
         │                                  (n=76)       (n=42)
         │                                  $2,500       $1,200
      $0 └──────────────────────────────────────────────────
                $10k    $20k    $30k    $40k    $50k    $60k

Legend: 🟢 (Green) = High RFM Score (4) = Good members
        🟡 (Yellow) = Medium RFM Score (2-3) = Mixed
        🔴 (Red) = Low RFM Score (1) = At-Risk

BUBBLE SIZE = Claim Frequency (Large=active, Small=dormant)

KEY INSIGHTS:
1. Champions (234 members, $52k avg) = 15% of base, 40% of revenue
2. At-Risk High Value (145 members, $30k avg) = HIGHEST ROI OPPORTUNITY
   → Dormant ($30k value) but valuable → Win-back campaign
3. Lost (42 members, $1.2k avg) = Lowest priority (small value)
4. Smokers overrepresented in At-Risk segments
   → Prevention program target
```

---

## 🎯 BUSINESS STRATEGY BY SEGMENT

| Segment | Members | Avg Value | Business Action | Expected ROI |
|---------|---------|-----------|-----------------|--------------|
| **Champions** | 234 | $52k | Loyalty rewards, premium services | Retain $52k/member |
| **Loyal** | 312 | $28k | Upsell prevention programs | Increase to $35k |
| **Potential** | 189 | $15k | Convert to frequent → Loyal | Grow to $28k |
| **New** | 267 | $12k | Onboarding, relationship nurture | Build lifetime value |
| **At-Risk High** | 145 | $30k | **WIN-BACK campaigns** | Recover $30k+ |
| **At-Risk Freq** | 98 | $8k | Retention program | Prevent churn |
| **Hibernating** | 76 | $2.5k | Reactivation (IF cost-effective) | Low ROI |
| **Lost** | 42 | $1.2k | Cleanup, exit strategy | Focus elsewhere |

---

## 📝 VIVA DISCUSSION POINTS

**Your Presentation Script:**
"This visualization shows our patient lifetime value segmentation using RFM analysis. RFM stands for Recency, Frequency, and Monetary value—it's a standard retail/healthcare metric. 

Here's what I see: Our 234 Champions generate $52,000 average lifetime value—they're our VIP members. But notice the At-Risk High Value segment: 145 members averaging $30,000 value each, but they're dormant. That's $4.35 million in revenue at risk.

My recommendation: Invest in a targeted win-back campaign for this segment. Based on industry benchmarks, a 20-30% reactivation rate would recover ~$900k in annual value. Cost of campaign: $50-100k. ROI: 9-18x.

Additionally, notice smokers are overrepresented in the At-Risk segments. This validates our prevention program ROI."

**Expected Q&A:**
- Q: "Why are smokers more likely to be at-risk?"
  - A: "Smokers have higher claims, chronic conditions, and cost burden. When costs rise, they become more price-sensitive and shop for alternatives."
- Q: "How do you propose to identify these at-risk members?"
  - A: "RFM calculation is automated monthly. We can flag members entering Hibernating segment for outreach."
- Q: "What's the win-back campaign messaging?"
  - A: "Personalized: 'We noticed you haven't filed claims in 6 months. Here's a health screening offer + new provider network.'

---

---

## 🔧 ADVANCED FEATURES

### 📌 LOD Expressions Applied
**Status:** ✅ **Yes - EXCLUDE Formula**

WS9 (RFM Bubble Chart) uses EXCLUDE LOD to calculate segment-level aggregations while removing individual customer dimension:

**Formula:**
```
Avg Segment Value = {EXCLUDE [Customer ID] : AVG([Lifetime Value])}
Segment Frequency = {EXCLUDE [Customer ID] : COUNT([Transaction ID])}
```

**Purpose:** Aggregate individual transactions up to RFM segment level (8 bubbles). EXCLUDE ensures each segment bubble shows the average across all customers in that segment, regardless of individual customer selection.

**When Used:** Each bubble's size and color represent segment-level statistics.

**Smoking Filter Interaction:** When Smoker filter applied, segment compositions change (e.g., At-Risk High Value segment size shrinks if smokers filtered out), recalculating average values.

**See Also:** [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - LOD Expressions - EXCLUDE Example](#)

---

### 🎚️ Cascading Filters Affecting This Sheet

**Region Filter** (Global)
- Status: ✅ **Affects WS9**
- Behavior: Select region → RFM segments recalculate for that region only (bubble sizes change)
- Configuration: Dashboard filter → "Apply to All Sheets" (includes WS9)

**Smoking Status Filter** (Local - Primary for WS9) ⭐ **Featured**
- Status: ✅ **Affects WS9** (shared with WS7 only)
- Behavior: Toggle "Smoker" and "Non-Smoker" → At-Risk High Value bubble dramatically shrinks/changes
- Configuration: Dashboard filter → "Apply to Sheets" → Select WS9 + WS7 ONLY (not global)
- Use Case: Shows smoking's impact on customer lifetime value; demonstrates opportunity to reduce smoking in portfolio
- Key Insight: At-Risk segment heavily weighted toward smokers; reducing smoking improves segment value

**Date Range Filter** (Local)
- Status: ✅ **Affects WS9**
- Behavior: Adjust dates → Segment calculations recalculate (Frequency, Monetary, Recency change)
- Configuration: Dashboard filter → "Apply to Sheets" → WS9 + WS2 + WS1

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 3: Smoking Status Filter Configuration](#)

---

### 🎬 Custom Dashboard Actions Enabled

**Action 1: Hospital Drill Filter**
- Status: ✅ **Affects WS9** as target
- Behavior: Click hospital on WS3 → WS9 updates to show RFM segments for that hospital

**Action 2: Region Filter Action**
- Status: ✅ **Affects WS9** as target
- Behavior: Click region on WS5 → WS9 updates with region-specific RFM segments

**Action 3: Highlight Action**
- Status: ⚠️ **Optional** - Could highlight at-risk segment when state is hovered on WS8

**Action 4: URL Action**
- Status: ❌ **Does NOT Affect WS9**

**See Also:** [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Custom Actions Section](#)

---

### 📖 Storyboard Involvement

**Story Point 5: OPPORTUNITY — RFM Win-Back** ⭐ **FEATURED**
- Status: ✅ **Prominently Featured in Story Point 5**
- Role: Present quantified revenue recovery opportunity (At-Risk High-Value segment)
- Caption: "$4.35M Opportunity: Win Back At-Risk Patients"
- Interaction: Show all 8 segments; highlight the large red/orange bubble (At-Risk High Value)
- Annotations:
  - Red circle around At-Risk High-Value bubble
  - Label: "145 Patients | $4.35M | 20-30% Recovery = $870K-$1.3M"
  - Green arrow showing pathway to Champions segment (migration path)
  - ROI box: "9-18× Return on $100K Investment"
- Presenter Talking Points:
  - "8 RFM segments - each bubble is a customer group"
  - "This red bubble: At-Risk High-Value (145 customers, $4.35M total value)"
  - "These were active customers 12+ months ago, now dormant"
  - "Win-back campaign targeting these 145 can recover $870K-$1.3M"
  - "Our most strategic segment: high historical value + high recovery potential"

**Storyboard Notes:**
- At-Risk High-Value bubble must be easily identifiable (color, size, position)
- Bubbles must be large enough to read segment labels and values
- Champions bubble shown for comparison (where we want At-Risk to migrate)

**See Also:** [TABLEAU_STORYBOARD_GUIDE.md - Step 6: Story Point 5 - OPPORTUNITY](#)

---

### 📚 Cross-References

- **Dashboard Assembly:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 4 - Row 6 RFM Position](#) for WS9's full-width placement at dashboard bottom
- **Storyboard:** See [TABLEAU_STORYBOARD_GUIDE.md - Step 6: Story Point 5 - OPPORTUNITY - RFM](#) for detailed annotations and narrative flow
- **Cascading Filters:** See [TABLEAU_DASHBOARD_ASSEMBLY_GUIDE.md - Step 5: Smoking Status Filter](#) for how WS9 responds to smoking filter
- **LOD Expressions:** See [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md - LOD Section - EXCLUDE Example](#) for detailed EXCLUDE formula walkthrough
- **RFM Analysis:** See [TABLEAU_ANALYSIS_GUIDE.md - RFM Segmentation Section](#) for business logic and opportunity calculation

---

## 🎯 QUICK REFERENCE

| Element | Specification |
|---------|---------------|
| Chart Type | Bubble Chart |
| Y-Axis | Customer Segment (8 segments) |
| X-Axis | AVG(Lifetime Monetary Value) |
| Bubble Size | AVG(Claim Frequency) |
| Color | AVG(RFM Score), 1-4 scale, Green→Red |
| Labels | Member count per segment |
| Expected Segments | Champions, Loyal, Potential, New, At-Risk High, At-Risk Freq, Hibernating, Lost |
| Sorting | By lifetime value (descending) |

---

## 🚩 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| "Only shows 4-5 segments (not 8)" | Verify SQL Query 7.7 executed; check v_rfm_analysis has all 8 segment values |
| "Bubbles all same size" | Ensure Claim Frequency on SIZE shelf; check data has variation in frequency |
| "Color all same (not gradient)" | Right-click Color pill → Edit Colors → Select continuous palette (Green-Red) |
| "Segments not sorted by value" | Right-click Segment pill → Sort by Sum/Avg of Lifetime Value Descending |
| "Smoking filter doesn't work" | Verify Smoking Status field exists in v_rfm_analysis; drag to FILTERS and Show |
| "Tooltip empty or missing fields" | Drag each field individually to Tooltip shelf; set aggregates (COUNT, AVG, etc.) |
| "Performance slow" | Reduce tooltip fields; test SQL query performance in MySQL directly |

---

**Worksheet 9 Complete!** ✅ This is your SECOND HERO VISUALIZATION. All worksheets now complete!

---

## 🎊 NEXT STEPS: DASHBOARD ASSEMBLY

After completing all 9 worksheets:

1. Create new Dashboard: `Healthcare Claims and Denial Dashboard`
2. Drag worksheets into 5-row layout:
   - Row 1 (100px): WS 1 (KPI Summary) — Full width
   - Row 2 (250px): WS 2 (Trend) | WS 3 (Pareto) — Split 50/50
   - Row 3 (250px): WS 4 (Bubble) | WS 5 (Regional) — Split 50/50
   - Row 4 (300px): WS 7 (Heatmap) — Full width (HERO)
   - Row 5 (200px): WS 6 (Status) | WS 8 (Map) — Split 50/50
   - Optional Row 6: WS 9 (RFM) — Full width (HERO)

3. Add dashboard filters: Region, Smoking Status, Date Range, Claim Status
4. Add dashboard actions: Click region → filter all sheets
5. Format, style, and save

---

*Generated: September 15, 2026 | Program: Executive MTech Data Science & AI | Healthcare Insurance Dashboard*
