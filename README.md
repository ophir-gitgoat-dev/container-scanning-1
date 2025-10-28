# Container Scanning 1 - Dockerfile Line-Based Scanning Demo

This repository demonstrates **Arnica's line-by-line Dockerfile content scanning** for Python-based containers.

## Files to Copy to Your Destination Repository

```bash
.gitignore
.github/
awsome-lines.Dockerfile
requirements.txt
```

## Setup Steps

### 1. Copy Files

⚠️ **IMPORTANT**: Some files may already exist in your destination repository. Review each file before copying to avoid overwriting:
- `.gitignore` - May have existing rules
- `.github/workflows/*.yml` - May have existing workflows
- `requirements.txt` - May have existing dependencies

**For NEW repositories (no conflicting files):**
```bash
# Set your destination path
DEST_REPO="/path/to/destination/repo"

# Create directories if needed
mkdir -p "$DEST_REPO/.github/workflows"

# Copy files
FILES_TO_COPY=(
  ".gitignore"
  "awsome-lines.Dockerfile"
  "requirements.txt"
)

for file in "${FILES_TO_COPY[@]}"; do
  cp "$file" "$DEST_REPO/"
  echo "✓ Copied $file"
done

# Copy GitHub workflow files specifically (not entire directory)
for workflow in .github/workflows/*.yml .github/workflows/*.yaml; do
  [ -f "$workflow" ] && cp "$workflow" "$DEST_REPO/.github/workflows/" && echo "✓ Copied $workflow"
done
```

**For repositories with EXISTING files:**
```bash
DEST_REPO="/path/to/destination/repo"

# 1. Always safe - copy the Dockerfile
cp awsome-lines.Dockerfile "$DEST_REPO/"

# 2. Review before copying (check if files exist first):
echo "Checking for conflicts..."
[ -f "$DEST_REPO/.gitignore" ] && echo "⚠️  .gitignore exists - manual merge needed"
[ -f "$DEST_REPO/requirements.txt" ] && echo "⚠️  requirements.txt exists - manual merge needed"
[ -d "$DEST_REPO/.github/workflows" ] && echo "⚠️  workflows exist - manual merge needed"

# 3. Manually review and merge conflicts before running the copy loop above
```

### 2. Push to Main
```bash
cd /path/to/destination/repo
git add .
git commit -m "Initial setup for Arnica container scanning demo"
git push origin main
```

**Note:** Verify that GitHub Actions ran successfully in the Actions tab.

### 3. Integrate with Arnica
1. Log into Arnica
2. Go to **Settings** → **Integrations** → **GitHub**
3. Add this repository
4. Wait 1-2 minutes for sync
5. Add Integration for [Container scanning](https://docs.arnica.io/arnica-documentation/getting-started/container-integrations/ghcr)

### 4. Set Up Policy (Line-Based Scanning)
1. In Arnica: **Policies** → **Create New Policy**
2. Configure:
   - **Name**: "Dockerfile Heuristic Linking - Python"
   - **Type**: Code Risk
   - **Trigger**: On Push (real-time scanning)
   - **Scope**: Apply to `container-scanning-1` repository only
   - **Conditions**: Add file path condition for `*.Dockerfile`
   - **Actions**: Configure notifications/alerts as needed
3. Ensure the Label Dockerfiles policy is disabled
4. Save

### 5. View Results in Arnica
- **Repositories** → `container-scanning-1` → **Containers** tab
- **Findings** → Filter by `container-scanning-1`
- **Policies** → Your policy → View findings

## Policy Type
**Code Risk policy with On Push trigger** - Scans Dockerfile content in real-time on every push to detect vulnerabilities line-by-line.

---

See `container-scanning-2` for the **Pull Request labeling policy** demo.
