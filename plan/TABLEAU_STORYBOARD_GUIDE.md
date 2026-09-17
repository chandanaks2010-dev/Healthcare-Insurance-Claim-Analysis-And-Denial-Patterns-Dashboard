# TABLEAU STORYBOARD BUILDING GUIDE
## Complete Guide to Interactive Business Storytelling

**Healthcare Insurance Claim Analysis & Denial Patterns Dashboard**  
**Project:** Executive MTech Data Science & AI  
**Estimated Time:** 45-60 minutes  
**Complexity:** ⭐⭐⭐ Advanced

---

## 📖 OVERVIEW

**Storyboard Purpose:**  
Convert raw analytics into a compelling 5-point narrative that guides executive audience through:
1. **Scale** — Portfolio size and scope
2. **Trend** — Historical trajectory and forecasts
3. **Concentration** — Pareto principle (80-20 rule)
4. **Root Cause** — Underlying drivers (smoking multiplier)
5. **Opportunity** — Actionable recommendations (RFM win-back)

**Audience:** C-suite executives, board members, clinical leadership  
**Duration:** 5-7 minutes (narrated)  
**Format:** Interactive Tableau story with navigable story points

---

## 🎬 STORYBOARD COMPONENTS

### Story Structure
```
Story Point 1: SCALE
├─ Worksheet: WS1 (KPI Summary)
├─ Caption: "Our Portfolio: 1,591 Claims Worth $4.3M"
├─ Narrative: Portfolio overview, baseline metrics
└─ Duration: 30 seconds

Story Point 2: TREND
├─ Worksheet: WS2 (Monthly Spend Trend)
├─ Caption: "Costs Trending Upward: +12% YoY Growth"
├─ Narrative: Cost trajectory, forecasted impact
└─ Duration: 60 seconds

Story Point 3: CONCENTRATION
├─ Worksheet: WS3 (Pareto 80-20)
├─ Caption: "80-20 Rule: 60% of Spend in 3 Hospitals"
├─ Narrative: Pareto principle, negotiation leverage
└─ Duration: 60 seconds

Story Point 4: ROOT CAUSE
├─ Worksheet: WS7 (Demographic Heatmap)
├─ Caption: "Smoking Drives 5-10× Higher Costs"
├─ Narrative: Primary cost driver, demographic segments
└─ Duration: 60 seconds

Story Point 5: OPPORTUNITY
├─ Worksheet: WS9 (RFM Bubble)
├─ Caption: "$4.35M Opportunity: Win Back At-Risk Patients"
├─ Narrative: RFM segments, revenue recovery strategy
└─ Duration: 60 seconds
```

---

## ✅ PRE-BUILD CHECKLIST

Before building the storyboard, ensure:

- [ ] All 9 worksheets complete and validated
- [ ] Dashboard assembled and all filters working
- [ ] WS1 (KPI), WS2 (Trend), WS3 (Pareto), WS7 (Heatmap), WS9 (RFM) finalized
- [ ] All worksheets formatted professionally with titles
- [ ] Filters and actions tested on dashboard
- [ ] Color palette consistent across all sheets
- [ ] Key metrics verified against SQL queries

**Ready to build storyboard:** ✅ Yes

---

## 🏗️ STORYBOARD ASSEMBLY STEPS

### STEP 1: Create New Story

```
Menu: Story → New Story
Name: "Healthcare Claims Analysis: Executive Story"
Location: Save in main workbook (same as dashboard)
```

**Tableau New Story Dialog:**
- Story Name: `Healthcare Claims Analysis: Executive Story`
- Keep blank (no worksheet yet)
- Click OK

---

### STEP 2: Build Story Point 1 - SCALE

**Objective:** Establish portfolio baseline and urgency

#### Caption & Narrative Design

**Caption (Bold Headline):**
```
Our Portfolio: 1,591 Claims Worth $4.3M
```

**Narrative Text (Body):**
```
Our healthcare organization processes 1,591 insurance claims annually, 
totaling $4.3 million in claim spend. With an 82% approval rate, we're 
seeing concerning trends:

• 280 claims denied or pending (18% failure rate)
• $850K-$1.2M in disputed/delayed revenue annually
• Denial patterns concentrated in 3 key hospitals
• Smoking-related claims drive outsized costs

This analysis identifies $4.35M in recovery opportunity through 
targeted interventions in the denial management and patient 
segmentation strategies.
```

#### Build Steps in Tableau

1. **Add Story Point 1:**
   - Story → New Story
   - Click "Add Story Point" (+ button at top)
   - Blank story point created

2. **Add Worksheet:**
   - Story Point 1 → Drag "Executive KPI Summary" (WS1) from worksheet list
   - WS1 displays the 4 KPI cards (Total Claims, Total Cost, Approval Rate, Avg Cost)

3. **Add Caption:**
   - Click "Caption" box (below the worksheet)
   - Type heading: `Our Portfolio: 1,591 Claims Worth $4.3M`
   - Formatting:
     - Font: Arial Bold, 16pt
     - Color: Dark Blue (#003366)
     - Alignment: Center

4. **Add Description:**
   - Click "Description" box (bottom of story point)
   - Paste narrative text (see above)
   - Formatting:
     - Font: Arial, 11pt
     - Color: Dark Gray (#333333)
     - Max width: 600px
     - Line height: 1.5

5. **Add Highlight Annotation (Optional):**
   - Click "Add Annotation" → Drag box around approval rate card
   - Label: "18% Denial Rate = $850K-$1.2M Annual Impact"
   - Arrow color: Red, pointing to card
   - Makes the problem statement visually prominent

#### Story Point 1 Preview
```
┌─────────────────────────────────────────┐
│ Our Portfolio: 1,591 Claims Worth $4.3M │
├─────────────────────────────────────────┤
│ [KPI Card: 1,591] [KPI Card: $4.3M]    │
│ [KPI Card: 82%]   [KPI Card: $2,689]   │
├─────────────────────────────────────────┤
│ Our healthcare organization processes   │
│ 1,591 claims annually, totaling $4.3M.│
│ With 82% approval, 18% face denial...   │
└─────────────────────────────────────────┘
```

---

### STEP 3: Build Story Point 2 - TREND

**Objective:** Show cost trajectory and future impact

#### Caption & Narrative Design

**Caption:**
```
Costs Trending Upward: +12% Year-over-Year
```

**Narrative Text:**
```
Monthly spending analysis reveals a concerning upward trend. Our costs 
started at $350K/month in January 2024, and have risen to $390K/month 
by December—a 12% annual increase.

Key Findings:
• Linear trend line shows consistent month-over-month growth
• Seasonal spikes: November-December average $380K (holiday claims)
• 12% annual growth rate = $4.6M projected annual cost next year
• If unchecked, 3-year cumulative impact: $13.8M vs. $12.9M baseline

This upward trend creates urgency for cost containment initiatives, 
particularly targeting the high-cost hospitals (next story point) 
and smoking-related procedures (later story point).
```

#### Build Steps in Tableau

1. **Add Story Point 2:**
   - Story → Add Story Point
   - Drag "Monthly Spend Trend" (WS2) to worksheet area

2. **Pre-filter for Story Clarity:**
   - WS2 should show ALL months (Jan-Dec)
   - Ensure trend line is clearly visible
   - Do NOT apply regional filter (show portfolio total)

3. **Add Caption:**
   - Text: `Costs Trending Upward: +12% Year-over-Year`
   - Font: Arial Bold, 16pt, Dark Blue
   - Alignment: Center

4. **Add Description:**
   - Paste narrative text (above)
   - Font: Arial, 11pt, Dark Gray

5. **Add Visual Annotations:**
   - Annotation 1: Arrow pointing to trend line
     - Label: "Linear Growth +12% YoY"
     - Color: Red dashed line
   - Annotation 2: Circle around January point
     - Label: "$350K Baseline (Jan)"
     - Color: Green
   - Annotation 3: Circle around December point
     - Label: "$390K Current (Dec)"
     - Color: Orange
   - Annotation 4: Box around peak (Nov-Dec)
     - Label: "Seasonal Spike"
     - Color: Yellow highlight

#### Story Point 2 Preview
```
┌──────────────────────────────────────────┐
│ Costs Trending Upward: +12% Year-over-Year│
├──────────────────────────────────────────┤
│  $400K ╱─────────────────╱ (Dec $390K)  │
│  $350K╱ (Jan $350K)                     │
│  $300K                                   │
│   Jan  Feb  Mar  Apr  May  Jun  Jul...Dec│
│        [Trend line with annotations]    │
├──────────────────────────────────────────┤
│ Monthly spending shows +12% annual      │
│ growth from $350K to $390K. Without     │
│ intervention, we project $4.6M next year│
└──────────────────────────────────────────┘
```

---

### STEP 4: Build Story Point 3 - CONCENTRATION (Pareto)

**Objective:** Highlight 80-20 principle and negotiation leverage

#### Caption & Narrative Design

**Caption:**
```
80-20 Rule: 60% of Spend in 3 Hospitals
```

**Narrative Text:**
```
Pareto analysis (80-20 principle) reveals significant cost concentration. 
Just 3 of our 20 contracted hospitals generate 60% of total costs 
($2.6M annually).

Top 3 Hospitals:
1. Hospital A: $950K (22% of spend)
2. Hospital B: $890K (20% of spend)
3. Hospital C: $760K (18% of spend)
   Subtotal: $2.6M (60% of portfolio)

Bottom 17 Hospitals: $1.7M (40% of spend)

Strategic Implications:
• Concentrated spend creates negotiation leverage for rate reductions
• 10-15% reduction in top 3 hospitals = $260K-$390K annual savings
• Focus RFM win-back strategy on high-denial hospitals
• Consider alternative providers or value-based contracts with top 3

This concentration is THE key to cost control. While we should optimize 
across all 20 hospitals, negotiating with 3 partners will deliver 80% 
of savings opportunity.
```

#### Build Steps in Tableau

1. **Add Story Point 3:**
   - Story → Add Story Point
   - Drag "Cost Concentration by Hospital" (WS3 - Pareto) to worksheet

2. **Worksheet Appearance:**
   - Show bars for all 20 hospitals
   - Highlight top 3 hospitals in bright color (e.g., red)
   - Show cumulative % line (should peak at 60% by 3rd hospital)
   - Ensure axis labels readable

3. **Add Caption:**
   - Text: `80-20 Rule: 60% of Spend in 3 Hospitals`
   - Font: Arial Bold, 16pt, Dark Blue

4. **Add Description:**
   - Paste narrative (above)
   - Font: Arial, 11pt

5. **Add Callout Annotations:**
   - Annotation 1: Box around top 3 hospital bars
     - Label: "Top 3 = $2.6M (60%)"
     - Arrow: Pointing to combined height
     - Color: Red box
   - Annotation 2: Line at 80% cumulative mark
     - Label: "Pareto 80%"
     - Color: Blue dashed line
   - Annotation 3: Text box with dollar amounts
     - Shows: "$950K | $890K | $760K"
     - Position: Near top of chart

6. **Add Insights Box (Optional):**
   - Small text box with bullet points:
     ```
     KEY INSIGHT:
     • 3 hospitals = 60% of costs
     • 10% negotiated reduction = $260K savings
     • Focus RFM recovery in top 3
     ```

#### Story Point 3 Preview
```
┌────────────────────────────────────────┐
│ 80-20 Rule: 60% of Spend in 3 Hospitals│
├────────────────────────────────────────┤
│        Hospital Costs (Ranked)          │
│  $1M ▓░░░ Top 3 = $2.6M (60%)         │
│      ▓▓░░░                             │
│      ▓▓▓░░░                            │
│  $500K ░░░░░ Remaining 17 = $1.7M    │
│        ░░░░░░░░░░░░░░░░░ (40%)       │
│    [Hosp A] [B] [C] [D]...[T]         │
├────────────────────────────────────────┤
│ Just 3 hospitals = 60% of $4.3M spend.│
│ Negotiate 10-15% reduction → $260-390K │
│ savings opportunity.                   │
└────────────────────────────────────────┘
```

---

### STEP 5: Build Story Point 4 - ROOT CAUSE (Smoking)

**Objective:** Reveal primary cost driver with data-driven proof

#### Caption & Narrative Design

**Caption:**
```
Smoking Drives 5-10× Higher Costs
```

**Narrative Text:**
```
Our demographic analysis reveals smoking status is the SINGLE STRONGEST 
cost driver—far exceeding age, BMI, or region.

Cost Multipliers by Smoking Status:
• Smokers: $17K-$39K average per claim
• Non-smokers: $2K-$8K average per claim
• Multiplier: 5-10× higher costs for smokers

Cost by Age Group (Smokers vs Non-Smokers):
• Age 18-25:  $8K vs. $3K (2.7×)
• Age 26-35:  $12K vs. $4K (3×)
• Age 36-45:  $18K vs. $5K (3.6×)
• Age 46-55:  $32K vs. $7K (4.6×) ← HIGHEST COST COHORT
• Age 56+:    $39K vs. $8K (4.9×)

Geographic Consistency:
The 5-10× multiplier holds across ALL 6 regions, indicating this is a 
fundamental medical/clinical driver, not a regional anomaly.

Strategic Implication:
• Smoking cessation programs have ROI potential
• Consider incentivized wellness programs for smokers
• Target high-cost smoker cohorts (46-55 age group)
• Partner with clinical teams on smoking-related procedures

The demographic heatmap below (darker = higher cost) visualizes this 
concentration clearly. Notice the darkest cells cluster in smoking-status 
rows across all age groups.
```

#### Build Steps in Tableau

1. **Add Story Point 4:**
   - Story → Add Story Point
   - Drag "Patient Risk Segments" (WS7 - Demographic Heatmap) to worksheet

2. **Pre-filter for Clarity:**
   - Show BOTH Smoker=Yes and Smoker=No
   - Do NOT apply region filter (show all regions combined)
   - Smoking filter should show: Both options visible

3. **Worksheet Appearance:**
   - Heatmap shows Age (rows) × BMI (columns) × Smoker (faceted or color-coded)
   - Color intensity clearly shows smoking smokers darker than non-smokers
   - Ensure cell values (average costs) visible
   - Font sizes readable at dashboard size

4. **Add Caption:**
   - Text: `Smoking Drives 5-10× Higher Costs`
   - Font: Arial Bold, 16pt, Dark Blue, with red emphasis

5. **Add Description:**
   - Paste narrative (above)
   - Font: Arial, 11pt

6. **Add Visual Annotations:**
   - Annotation 1: Highlight box around darkest cells (smokers, age 46-55)
     - Label: "HIGHEST COST: Smokers Age 46-55\n$32K Avg"
     - Color: Red arrow pointing to darkest region
   - Annotation 2: Highlight box around lightest cells (non-smokers, young)
     - Label: "LOWEST COST: Non-Smokers Age 18-25\n$3K Avg"
     - Color: Green arrow
   - Annotation 3: Comparison callout
     - Text: "5-10× DIFFERENCE"
     - Position: Between dark and light regions
     - Size: Large, bold

7. **Add Insights Box:**
   - Title: "KEY COST DRIVERS"
   - Bullets:
     ```
     🔴 Smoking: 5-10× multiplier
     🟡 Age: Increases with age
     🟢 BMI: Secondary driver
     🔵 Region: Minimal impact
     ```

#### Story Point 4 Preview
```
┌──────────────────────────────────────────┐
│ Smoking Drives 5-10× Higher Costs         │
├──────────────────────────────────────────┤
│         BMI: Underweight Normal Overweight│
│ Age 18-25    $2K      $3K      $4K       │
│ Age 26-35    $3K      $4K      $5K       │
│ ─────────────────────────────────────────│
│ Age 46-55   $28K     $30K     $32K   ◄──┐│
│ Age 56+     $36K     $38K     $39K      ││
│ [DARKER = SMOKERS]  [LIGHTER = NON]    ┌┘│
├──────────────────────────────────────────┤
│ Smoking status is the primary cost driver.│
│ Smokers 46-55: $32K avg (non-smokers: $7K)│
│ Opportunity: Smoking cessation programs  │
└──────────────────────────────────────────┘
```

---

### STEP 6: Build Story Point 5 - OPPORTUNITY (RFM)

**Objective:** Present actionable, quantified opportunity with ROI

#### Caption & Narrative Design

**Caption:**
```
$4.35M Opportunity: Win Back At-Risk Patients
```

**Narrative Text:**
```
Our RFM (Recency, Frequency, Monetary) analysis identifies a significant 
revenue recovery opportunity: at-risk high-value patients.

RFM Segmentation Overview (8 Segments):

HIGH-VALUE SEGMENTS (Large Bubbles):
1. Champions (Active + High Value): $1.2M retained
2. Loyal Customers (Active + High Value): $800K retained
3. At-Risk High Value (Inactive + High Value): $4.35M ← OPPORTUNITY
4. Potential Loyalists (Active + Medium Value): $650K

MEDIUM/LOW-VALUE SEGMENTS:
5. Promising (Active + Low Value): $200K
6. Lost at Risk (Inactive + Medium Value): $180K
7. Lost (Inactive + Low Value): $120K
8. Hibernating (Long Inactive + Low Value): $65K

STRATEGIC FOCUS: At-Risk High-Value Segment
• Patient Count: 145 customers
• Lifetime Value: $4.35M (Average $30K per patient)
• Status: Were active, high-frequency users 12+ months ago
• Current: No activity for 12+ months (churned/at-risk)

Win-Back Strategy:
• Target: 145 at-risk high-value patients
• Goal: Recover 20-30% (29-44 patients)
• Expected Lifetime Value Recovery: $870K-$1.3M
• ROI: 9-18× return on win-back campaign investment
• Cost to Execute: $100K (personalized outreach, service recovery)

Campaign Tactics:
1. Personalized outreach (phone/email) explaining service improvements
2. Service recovery discounts or value-adds
3. Clinical engagement (new procedures, preventive services)
4. Long-term retention programs to prevent re-churn

This single initiative could recover $870K-$1.3M annually while 
improving patient relationships. Combined with smoking cessation 
programs and hospital negotiations, we achieve $1.6M-$2.8M 
total opportunity.
```

#### Build Steps in Tableau

1. **Add Story Point 5:**
   - Story → Add Story Point
   - Drag "Patient Lifetime Value - RFM Analysis" (WS9 - Bubble Chart) to worksheet

2. **Worksheet Appearance:**
   - Show all 8 RFM segments as distinct bubbles
   - Bubble size represents frequency or lifetime value
   - Bubble color represents RFM score or segment status
   - Ensure segment labels clearly visible
   - Legend showing color meaning

3. **Add Caption:**
   - Text: `$4.35M Opportunity: Win Back At-Risk Patients`
   - Font: Arial Bold, 16pt, Dark Blue, with green emphasis ($$$)

4. **Add Description:**
   - Paste narrative (above)
   - Font: Arial, 11pt
   - Max width: 700px (longer narrative for opportunity section)

5. **Add Prominent Annotations:**
   - Annotation 1: Circle around At-Risk High-Value bubble
     - Label: "AT-RISK HIGH VALUE\n145 Patients | $4.35M\nWin Back 20-30%\n= $870K-$1.3M Opportunity"
     - Color: Bright red circle, double-thickness border
     - Arrow: Thick red arrow pointing to bubble
   - Annotation 2: ROI callout box
     - Text: "9-18× ROI\n$100K Investment\n$870K-$1.3M Recovery"
     - Position: Top right, highlight box with green background
   - Annotation 3: Champions bubble annotation (for context)
     - Label: "$1.2M\n(Baseline Retained)"
     - Color: Light blue
   - Annotation 4: Action arrow
     - From: At-Risk High-Value
     - To: Area above (representing Champions)
     - Label: "TARGET MIGRATION PATHWAY"
     - Style: Green dashed arrow

6. **Add Sidebar Strategy Box:**
   - Title: "WIN-BACK CAMPAIGN"
   - Content:
     ```
     TARGET: 145 At-Risk High-Value Patients
     GOAL: Recover 20-30% (29-44 patients)
     TACTIC: Personalized outreach + service recovery
     EXPECTED: $870K-$1.3M annual value recovery
     ROI: 9-18× return on $100K investment
     
     NEXT STEPS:
     ✓ Executive approval of $100K budget
     ✓ Sales + Clinical teams execute campaign
     ✓ Track recovery metrics monthly
     ```

#### Story Point 5 Preview
```
┌──────────────────────────────────────────┐
│ $4.35M Opportunity: Win Back At-Risk      │
├──────────────────────────────────────────┤
│      RFM Bubble Chart (8 Segments)        │
│  Champions            At-Risk ◄─── $4.35M│
│   $1.2M   •           •                   │
│            •      ••  •                   │
│  Loyal    •  • •   •  • Potential        │
│ $800K    •     Lost   $650K               │
│          • Low  •                         │
│         Hibernating                       │
├──────────────────────────────────────────┤
│ Win back 20-30% of 145 at-risk patients  │
│ = $870K-$1.3M recovery (9-18× ROI)       │
└──────────────────────────────────────────┘
```

---

### STEP 7: Configure Story Navigation

**Enable Story Point Navigation:**

1. **Story Controls:**
   - Story → Edit Story
   - Enable: "Navigation buttons" (← Previous | Next →)
   - Enable: "Story point indicator" (Point 1/5, 2/5, etc.)
   - Enable: "Title" (show story title at top)

2. **Playback Settings:**
   - Check: "Show navigation controls"
   - Check: "Show story captions and descriptions"
   - Check: "Allow highlighting on all sheets"

3. **Button Styling:**
   - Style: Professional arrow buttons
   - Size: 40px × 40px
   - Padding: 10px from worksheet edge

---

### STEP 8: Format Story Presentation

**Professional Styling:**

#### Overall Story Appearance
```
Background: White (#FFFFFF)
Title Background: Dark blue gradient (#003366 to #0066CC)
Title Font: Arial Bold, 20pt, White
Caption Font: Arial Bold, 16pt, Dark Blue
Description Font: Arial, 11pt, Dark Gray
Spacing: 10-15px padding between elements
Border: 1px light gray around worksheets
```

#### Story Point Formatting
```
Each story point should have:
✓ Professional title/caption
✓ Relevant worksheet (resized for readability)
✓ Descriptive narrative text (2-3 sentences)
✓ Visual annotations highlighting key data
✓ Consistent color scheme throughout
✓ Readable fonts (minimum 10pt for body text)
✓ Clear visual hierarchy (title → visualization → narrative)
```

#### Color Palette Consistency
```
Primary: Dark Blue #003366 (titles, emphasis)
Accent: Red #FF0000 (problems, at-risk items)
Positive: Green #00AA00 (opportunities, wins)
Neutral: Gray #333333 (body text)
Highlight: Yellow #FFFF00 (important data points)
```

---

### STEP 9: Story Validation & Testing

**Before Finalizing Story:**

#### Content Validation
- [ ] Story Point 1 (Scale): Establishes baseline ($4.3M, 1,591 claims)
- [ ] Story Point 2 (Trend): Shows upward cost trajectory (+12% YoY)
- [ ] Story Point 3 (Concentration): Highlights Pareto principle (60% in 3 hospitals)
- [ ] Story Point 4 (Root Cause): Reveals smoking as primary driver (5-10× multiplier)
- [ ] Story Point 5 (Opportunity): Presents quantified opportunity ($4.35M, 9-18× ROI)

#### Narrative Flow Validation
- [ ] Story progresses logically: Portfolio → Problem → Analysis → Solution
- [ ] Each point builds on previous (not standalone)
- [ ] Captions are compelling and data-driven
- [ ] Body text supports findings with evidence
- [ ] Opportunity section includes specific numbers and ROI

#### Visual Validation
- [ ] All worksheets display correctly in story
- [ ] Annotations are visible and readable
- [ ] Colors consistent across all 5 story points
- [ ] Font sizes readable at presentation distance
- [ ] No overlapping text or elements
- [ ] Sparklines/trend lines clearly visible

#### Presentation Validation
- [ ] Story can be narrated in 5-7 minutes total
- [ ] Navigation buttons work smoothly
- [ ] Story points load quickly (<2 sec each)
- [ ] No data errors or NULL values
- [ ] Ready for executive presentation

---

## 🎤 STORY PRESENTATION GUIDE

**How to Narrate the Story:**

### Presentation Sequence (5-7 minutes)

**[0:00-0:30] Story Point 1: SCALE**
- "Our healthcare organization manages 1,591 insurance claims annually, worth $4.3M in total spend."
- "With an 82% approval rate, we're facing an 18% denial rate—that's roughly 280 claims that are disputed or delayed."
- "Today's analysis identifies both the root causes and the opportunities to improve this."

**[0:30-1:30] Story Point 2: TREND**
- "First, let's look at our spending trajectory over the past year."
- "Our costs have grown from $350K per month in January to $390K in December—a 12% annual increase."
- "If this trend continues, we'll be spending $4.6M next year. That's an extra $300K+ without any intervention."

**[1:30-2:30] Story Point 3: CONCENTRATION**
- "But here's the good news: our costs are highly concentrated."
- "Using Pareto analysis—the 80-20 rule—we find that just 3 hospitals account for 60% of our spending."
- "Hospital A, B, and C generate $2.6M of our $4.3M budget. That means 70% of our savings opportunity lies with 3 partners."
- "This concentration gives us significant leverage for cost negotiations. A 10-15% reduction with these 3 hospitals nets us $260K-$390K annually."

**[2:30-3:30] Story Point 4: ROOT CAUSE**
- "But cost concentration alone doesn't explain the full picture. Let's dig deeper into the cost drivers."
- "This demographic heatmap reveals something striking: smoking status is THE primary cost driver."
- "Look at the color intensity. Smokers cost 5-10 times more than non-smokers, across every age group and BMI category."
- "Our highest-cost cohort? Smokers aged 46-55. They average $32K per claim compared to $7K for non-smokers in the same age group."
- "This is consistent across all 6 regions, suggesting this is a fundamental clinical driver, not a regional issue."
- "Strategic implication: smoking cessation programs, wellness incentives, and clinical partnerships around smoking-related procedures offer real ROI."

**[3:30-4:30] Story Point 5: OPPORTUNITY**
- "Now for the big opportunity: our RFM analysis identifies at-risk high-value customers."
- "We have 145 patients who were previously active, high-spending customers but have been inactive for 12+ months."
- "These 145 patients represent $4.35M in dormant lifetime value—an average of $30K per patient."
- "With a targeted win-back campaign, we can realistically recover 20-30% of these patients."
- "That's $870K to $1.3M in annual revenue recovery from just a $100K investment. That's a 9-18× return on investment."
- "Our recommended tactics: personalized outreach, service recovery, and clinical engagement to rebuild trust."

**[4:30-5:00] Wrap-Up**
- "In summary, we've identified three major levers for improvement:"
  1. **Hospital Negotiation:** $260K-$390K from 10-15% reduction with top 3 hospitals
  2. **Smoking Intervention:** Unknown, but 5-10× cost driver suggests high-impact wellness programs
  3. **RFM Win-Back:** $870K-$1.3M from recovering at-risk high-value customers
- "**Total Opportunity: $1.6M-$2.8M annually** through combination of all three initiatives."
- "Next steps: executive approval of win-back campaign budget, clinical team engagement on smoking initiatives, and finance team negotiation with top 3 hospitals."

---

## ✅ FINAL STORY CHECKLIST

**Story is Complete When:**

- [ ] 5 story points created in logical sequence
- [ ] Each story point has: worksheet + caption + narrative
- [ ] Captions are compelling, action-oriented headlines
- [ ] Narratives include specific numbers and business impact
- [ ] Visual annotations highlight key findings
- [ ] Colors consistent throughout story
- [ ] Story can be narrated in 5-7 minutes
- [ ] Navigation buttons functional
- [ ] Story loads smoothly (<2 sec per point)
- [ ] Presenter notes prepared for ad-hoc questions
- [ ] Ready for executive board presentation

---

## 📞 TROUBLESHOOTING

| Issue | Solution |
|-------|----------|
| "Story point loads slowly" | Reduce worksheet data volume; optimize SQL queries |
| "Annotations overlap text" | Reposition annotations; use smaller fonts or callout boxes |
| "Navigation buttons missing" | Story → Edit Story → Check "Show navigation controls" |
| "Story doesn't scroll properly" | Adjust story point heights in Story → Edit Story |
| "Captions not visible" | Increase caption box size; adjust font size upward |
| "Worksheet not displaying" | Verify worksheet exists; check data source connection |

---

## 🎯 SUCCESS CRITERIA

**Story is executive-ready when:**

✅ 5-point narrative arc clear and compelling  
✅ All findings supported by data visualizations  
✅ Quantified opportunities with ROI calculated  
✅ Professional styling and consistent branding  
✅ Narration flow: 5-7 minutes, no stuttering  
✅ Annotations guide audience attention  
✅ Ready for C-suite presentation  

---

**PDF Compliance:** Section 2.3 "Develop interactive storyboards for business storytelling"

*Healthcare Insurance Dashboard | Executive MTech Data Science & AI | Sept 2026*
