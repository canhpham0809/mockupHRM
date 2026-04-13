# Employee 360 – Detail Information
## Widget Organization & UX Strategy

### Overview
The Employee 360 dashboard is strategically organized to provide **Managers** with the most critical employee information in order of priority, enabling quick decision-making and comprehensive employee oversight.

---

## Widget Organization (by priority)

### 1. **Employee Profile** (Full Width)
**Position:** Top priority context
**Why:** Managers need immediate employee identification and key metadata before deep-diving into details.

**Includes:**
- Employee photo/avatar upload area
- Full name & Worker ID
- Job title, location, email, phone
- Key skills overview (Angular, TypeScript, etc.)
- Active status badge

**UX Purpose:** Uses visual hierarchy and avatar as focal point to quickly identify the employee being reviewed.

---

### 2. **Employee Compensation** (Full Width)
**Position:** Primary widget - immediately after profile
**Why:** Managers in HRM/HR context typically prioritize compensation data for salary reviews, raise recommendations, budget planning.

**Key Metrics:**
- Base Salary (35M VND)
- Allowance (+14% YoY growth)
- Bonus YTD (+8% growth trend)
- Grade & Band classification

**Filters Available:**
- `Year` (default) - Annual view
- `Quarter` - Quarterly breakdown

**UX Strategy:** 
- 4-column stat cards for quick scanning
- Color coding for positive (+14% green) vs neutral trends
- Compact table for compliance details (tax code, insurance base, effective date)

---

### 3. **Organization & WR Switcher** (2-Column Layout)
**Position:** Secondary context (rows 2-3)
**Why:** Completes the organizational picture - where does this employee sit?

**Left Column - Employee Organization:**
- Division, Department, Team, Cost Center
- Direct Manager info with mini card showing:
  - Manager avatar (initials)
  - Manager name
  - Manager role & company

**Right Column - Employee WR Switcher (Work Relationship):**
- Legal Entity (company name)
- Employment Type (EMPLOYEE, CONTRACTOR, etc.)
- Employment Status (Active, On Leave, etc.)
- Contract Type (Full-time, Part-time, etc.)
- Period of employment

**UX Pattern:** Separates "where" (left) from "what type of relationship" (right)

---

### 4. **Performance & Career History** (2-Column Layout)
**Position:** Rows 3+
**Why:** Managers need to understand employee trajectory and current performance level.

**Left Column - Employee Performance:**
Historical rating by year with 5-star system:
- 2023: 4.2/5 ⭐⭐⭐⭐◯
- 2022: 3.8/5
- 2021: 3.5/5
- 2020: 2.9/5

Competency breakdown (2023):
- Technical: 88%
- Teamwork: 82%
- Leadership: 70%
- Communication: 76%

**Filters:**
- `Last 4Y` (default) - Shows all history
- `Current Year` - Shows only 2024 metrics

**Right Column - Career History:**
Timeline of career progression:
- Role changes (promotions, transfers)
- Department movements
- Title progression
- Employment dates

**Filters:**
- `All` (default) - Shows complete history
- `Promotions` - Only promotion events
- `Transfers` - Only lateral moves

**UX Purpose:** Manager can quickly assess:
- "Is performance trending up or down?"
- "How long in current role?"
- "Career growth trajectory?"

---

### 5. **Time & Attendance** (Full Width)
**Position:** Bottom (operational metrics)
**Why:** Essential for attendance compliance and workload assessment.

**Layout:** 2-column grid for stable display at system-scaled 125% view, so metric cards remain even and readable without forcing unnecessary horizontal scroll.

**Key Metrics:**
- Working Days (22 in April)
- Present (21 days = 95.5% attendance)
- Leave Used (3 days, 12 remaining)
- OT Hours (14h = –2h vs average)

**Filters:**
- `Monthly` (default) - Current month detail
- `Quarterly` - Q1, Q2, Q3, Q4 view
- `Annual` - Year-to-date totals

**Time Selector:** April 2025 chip (clickable for date range selection)

**UX Strategy:**
- Color coding: green for positive (high attendance), red/orange for concerns
- Benchmarking against monthly average for OT

---

## Top Navigation Enhancements

### Search Bar + Department Filter
**Located:** Topbar right section

**Features:**
1. **Employee Name Search** (primary)
   - Placeholder: "Search employee name..."
   - Current value: "Nguyễn Bùi Thành"

2. **Department Filter** (new dropdown)
   - All Departments (default)
   - Engineering
   - Sales
   - Human Resources
   - Finance
   - Marketing
   - Behavior: Dropdown with visual indicator showing selected department

**UX Purpose:** Allows fast employee switching within same department for comparative review.

---

## Widget Filter Patterns

### Standard Filter Button Group
Each widget has context-specific filters using pill-style buttons:

```
[Filter A (active)] [Filter B] [Filter C]
```

**States:**
- `.active` - Orange highlight (#D85A30), bold text
- `.hover` - Soft border highlight
- `.default` - Gray background

**Filter Types by Widget:**
- **Compensation:** Year vs. Quarter
- **Performance:** Last 4 Years vs. Current Year
- **History:** All vs. Promotions vs. Transfers
- **Time & Attendance:** Monthly vs. Quarterly vs. Annual

---

## Color & Typography Conventions

### Primary Colors
- **Orange** (#D85A30): Active states, highlights, primary CTAs
- **Green** (#3B6D11): Positive metrics, Active status
- **Blue** (#185FA5): Reference info, manager cards
- **Amber** (#BA7517): Warnings, historical year markers

### Typography
- **Font Family:** Be Vietnam Pro (sans-serif)
- **Mono Family:** DM Mono (for dates, IDs, numerical data)

---

## Display Scaling
The page is designed to render at a 125% visual scale using CSS transform scaling rather than native `zoom`, so the layout remains intact and content does not get clipped when the browser is enlarged.

**Why:** Ensures the UI feels slightly larger and easier to read while preserving responsive card spacing and grid behavior.
- **Hierarchy:**
  - Card Titles: 13px, bold
  - Stat Values: 20px, bold
  - Labels: 10px, uppercase, muted
  - Metadata: 11-12px, secondary text

---

## Manager Use Cases

### Use Case 1: Salary Review Meeting
1. Run dashboard for employee
2. Check **Compensation** widget for current salary vs. peers (grade)
3. Review **Performance 2023** to see if raise justified
4. Filter to **Current Year** performance metrics
5. Check **Time & Attendance** - Annual filter for consistency record

### Use Case 2: Performance Appraisal
1. View **Career History** - filter by **Promotions** to see growth pattern
2. Review **Performance** last 4 years for trend
3. Check **Competency bars** for strengths/weaknesses
4. Reference **Organization** to see reporting line
5. Use **Time & Attendance** to note any attendance concerns

### Use Case 3: Department Restructuring
1. Search for multiple employees by **Department Filter**
2. View **Organization** widget for team distribution
3. Check **Compensation** for budget impact
4. Review **Career History** to understand internal mobility patterns

---

## Responsive Design Notes

- **Desktop (1200px+):** 2-column grid layouts maintained
- **Tablet (768px+):** Stack widgets to single column, maintain visual hierarchy
- **Mobile:** Full-width stacking, simplified filter buttons

---

## Future Enhancements

1. **Export Functionality:** PDF report of selected widgets
2. **Comparison View:** Side-by-side comparison of 2+ employees
3. **Historical Tracking:** See how metrics changed month-over-month
4. **API Integration:** Real-time data from HR system
5. **Customizable Dashboard:** Manager can reorder/hide widgets
6. **Performance Benchmarking:** Industry and peer comparisons

---

## Product Owner Review

### Overview
Current Employee 360 layout is a strong foundation for HRM managers: it surfaces employee identity, compensation, organization, performance and time data in a clear hierarchy. The existing widgets are appropriate, but the page can become more actionable by adding HR-centric operational context and risk signals.

### What works well
- **Employee Profile** as top priority is correct; managers must know who the employee is before reviewing details.
- **Compensation** and **Performance** are the right primary follow-up sections for salary review and appraisal decisions.
- **Organization + WR Switcher** is useful to avoid context switching between org chart and employment type.
- **Time & Attendance** at the bottom gives operational context and is a natural close for the page.

### What can be improved
- Add a small **Employee Snapshot** summary at the top with key flags like `At Risk`, `High Performer`, `Eligible for Promotion`, `Open Action Items`.
- Make the **Time & Attendance** section more specific with `Leave Balance` and `Absence Trend` rather than only raw monthly metrics.
- Provide a final **HR Actions** panel or quick links for `Request Promotion`, `Start Performance Conversation`, `Review Compliance`.

---

## Suggested Additional Widgets

### 1. **Employee Snapshot / Talent Card**
**Purpose:** Provide 1–2 sentence HR signal for quick decision-making.
**Includes:**
- Top flag/status: `At Risk`, `High Performer`, `Promotion Ready`, `Probation Ending`
- Headline metrics: current `Tenure`, `Last Promotion`, `Next Review Date`
- Quick action buttons: `View Goal Plan`, `Open HR Case`, `Schedule 1:1`

### 2. **Leave Balance & Absence Trend**
**Purpose:** Turn attendance into actionable absence risk.
**Includes:**
- Current leave balances: `Annual Leave`, `Sick Leave`, `Personal Leave`
- Absence trend sparkline over last 6 months
- Notes for approved leave or frequent short-term absence

### 3. **Learning & Development / Certification**
**Purpose:** Show readiness and career development state.
**Includes:**
- Active training programs, completion status
- Certifications held and expiry dates
- Recommended next skill development areas

### 4. **Engagement / Pulse Feedback**
**Purpose:** Surface employee sentiment as a leading retention indicator.
**Includes:**
- Pulse survey score or last engagement rating
- Recent feedback summary or manager notes
- Risk indicator if score is below threshold

### 5. **Compliance & Documentation**
**Purpose:** Ensure HR review includes mandatory compliance checks.
**Includes:**
- Required documents status: `Contract`, `ID`, `Work Permit`, `Insurance`
- Certification expiration alerts
- Background check / eligibility flags

### 6. **Career Mobility & Succession Readiness**
**Purpose:** Link employee profile to future talent planning.
**Includes:**
- Potential successor status
- Career path options / readiness level
- Mobility interest: `Internal move`, `Development`, `Retention`

---

## PO Recommendation
Use the current layout as the core workflow for managers, then layer in the above widgets as optional sections or tabs for advanced HR users. This keeps the Employee 360 page clean for most users while enabling deeper, action-oriented HR reviews when needed.
