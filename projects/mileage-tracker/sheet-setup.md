# Google Sheets Setup Guide

## Sheet Configuration

### Sheet Name
Create a sheet named: **`driven`**

### Column Structure

| Column | Type | Description |
|--------|------|-------------|
| **Date** | Text | Single date (e.g., `Dec 17`) or date range (e.g., `Dec 7 - Dec 16`) |
| **km driven so far** | Number | Cumulative odometer reading |
| **km difference** | Number | Distance since last movement (calculated by workflow) |

### Initial Setup

1. **Create a new Google Sheet**
2. **Name the sheet tab:** `driven` (lowercase, exactly as shown)
3. **Add headers in row 1:**
   ```
   | Date | km driven so far | km difference |
   ```
4. **Format columns:**
   - Date: Plain text
   - km driven so far: Number (0 decimals or 1 decimal)
   - km difference: Number (0 decimals or 1 decimal)

### Example Data

```
Date                km driven so far    km difference
May 26             7                   7
May 26             153                 146
May 27             177.9               24.9
May 28             198                 20.1
Nov 26             2204                7
Nov 27 - Dec 3     2204                0
Dec 4              2286                82
Dec 5              2286                0
Dec 6              2310                24
Dec 7 - Dec 16     2310                0
Dec 17             2315                5
```

## Connecting to n8n

### Step 1: Get Sheet ID
Your Sheet ID is in the URL:
```
https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID/edit
                                       ^^^^^^^^^^^^^^^^
```

### Step 2: Get Sheet GID
The sheet GID is also in the URL:
```
https://docs.google.com/spreadsheets/d/.../edit#gid=YOUR_SHEET_GID
                                                     ^^^^^^^^^^^^^^^
```

For the main (first) sheet, GID is usually `0` or `1815861133` (varies).

### Step 3: Configure OAuth2

1. In n8n, create Google Sheets OAuth2 credentials
2. Authorize access to your Google account
3. Use credential ID in workflow nodes

### Step 4: Update Workflow

Replace in `workflow.json`:
- `YOUR_GOOGLE_SHEET_ID` → Your actual Sheet ID
- `YOUR_SHEET_GID` → Your actual sheet GID
- `YOUR_CREDENTIAL_ID` → Your n8n credential ID

## Data Validation Rules (Optional)

To prevent data entry errors, you can add Google Sheets validation:

### For "km driven so far" column:
- **Type:** Number
- **Condition:** Greater than 0
- **Min:** 0
- **Max:** 999999 (adjust based on expected range)

### For "km difference" column:
- **Type:** Number
- **Condition:** Greater than or equal to 0
- **Min:** 0
- **Max:** 500 (adjust based on typical daily riding)

## Permissions

### For Personal Use:
- Keep sheet private
- Only share with your n8n service account

### For Multi-User Deployment:
- Create separate sheets per user
- Use Google Service Account for n8n
- Grant edit access to service account only

## Backup Strategy

### Automated Backup (Recommended)
Set up n8n workflow to:
1. Export sheet data weekly
2. Save to cloud storage (Google Drive, Dropbox)
3. Keep last 4 weeks of backups

### Manual Backup
**File → Download → CSV or Excel**

Store in version-controlled folder outside of n8n workspace.

## Sheet URL for Workflow

The workflow needs the sheet URL in this format:
```
https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID/edit#gid=YOUR_SHEET_GID
```

This is used internally by the workflow for validation and linking.

## Troubleshooting

### "Sheet not found" error
- Check that sheet tab is named exactly `driven` (lowercase)
- Verify Sheet ID is correct
- Ensure n8n credentials have access

### "Insufficient permissions" error
- Re-authorize OAuth2 credentials
- Check that Sheet isn't in "View only" mode
- Verify service account has edit access

### Data not appending
- Check that headers are in row 1
- Ensure columns are named exactly as shown
- Verify workflow is active in n8n

### Duplicate entries
- This shouldn't happen due to edge case logic
- If it does, check date parsing in workflow
- Verify `currentDate` format is consistent

## Advanced: Multiple Bikes

To track multiple bikes:

### Option A: Multiple Sheets
- Create separate sheets: `bike1`, `bike2`
- Duplicate workflow for each bike
- Modify sheet name in each workflow

### Option B: Additional Column
Add column: `bike_id`
- Modify workflow to include bike identifier
- Filter/analyze by bike_id in analysis phase

### Option C: Separate Google Sheets
- One Sheet per bike
- Separate n8n workflows
- Aggregate in analysis pipeline

## Data Export for Analysis

### CSV Export
```
File → Download → Comma Separated Values (.csv)
```

### Pandas (Python)
```python
import pandas as pd

sheet_url = "https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID/edit#gid=0"
df = pd.read_csv(sheet_url.replace('/edit#gid=', '/export?format=csv&gid='))
```

### Direct API Access
Use Google Sheets API v4 with authentication:
```python
from googleapiclient.discovery import build

service = build('sheets', 'v4', credentials=creds)
result = service.spreadsheets().values().get(
    spreadsheetId='YOUR_SHEET_ID',
    range='driven!A:C'
).execute()
```

---

**Next Steps:**
1. Create your Google Sheet with the structure above
2. Get Sheet ID and GID
3. Configure n8n credentials
4. Update workflow.json with your IDs
5. Test with a sample entry