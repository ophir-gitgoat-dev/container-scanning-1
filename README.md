# Container Scanning 1 - Python-based Dockerfile Content Scanning Demo

This repository demonstrates **Arnica's line-by-line Dockerfile content scanning** capabilities using a Python-based container.

## Purpose

This repo showcases Arnica's ability to scan Dockerfile content for vulnerabilities and security issues at the **line level** during development, identifying problematic packages and configurations before they reach production.

## Repository Contents

### Required Files to Copy to Destination Repository

When setting up a new repository based on this template, copy the following files:

#### 1. `.gitignore` (if present)
- Python and general ignore patterns
- Location: Root directory

#### 2. `.github/workflows/docker.yaml`
- GitHub Actions workflow for building and pushing Docker images
- Triggers on push to `main` branch
- Includes semantic versioning and multi-platform builds
- Location: `.github/workflows/`

#### 3. `awsome-lines.Dockerfile`
- Python 3.9.11-based Dockerfile with intentional vulnerabilities
- Contains `httpx==0.15.3` (known CVEs for demonstration)
- Location: Root directory

#### 4. `requirements.txt`
- Python package dependencies
- Includes:
  - `numpy==2.0.2`
  - `packaging==24.2`
  - `tzdata==2025.1`
  - `requests==2.22.0` (older version with known issues)
- Location: Root directory

## Setup Instructions

### 1. Initial Repository Setup

```bash
# Create your destination repository on GitHub first
# Then copy the required files:

cp .gitignore /path/to/destination/repo/
cp -r .github /path/to/destination/repo/
cp awsome-lines.Dockerfile /path/to/destination/repo/
cp requirements.txt /path/to/destination/repo/
cp README.md /path/to/destination/repo/
```

### 2. Enable GitHub Actions

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Actions** → **General**
3. Under "Actions permissions", select **"Allow all actions and reusable workflows"**
4. Click **Save**

### 3. Push to Main

```bash
cd /path/to/destination/repo
git add .
git commit -m "Initial setup for Arnica container scanning demo"
git push origin main
```

### 4. Integrate with Arnica

1. Log into your Arnica account
2. Go to **Settings** → **Integrations** → **GitHub**
3. Add this repository to Arnica's monitored repositories
4. Wait for initial sync (usually takes 1-2 minutes)

### 5. Set Up Arnica Policy (Line-Based Scanning)

This repository demonstrates **content-based Dockerfile scanning**:

1. In Arnica, navigate to **Policies** → **Create New Policy**
2. Configure the policy:
   - **Name**: "Dockerfile Line Scanning - Python Demo"
   - **Type**: "Container Security" or "Dockerfile Content Scan"
   - **Trigger**: On every commit/push
   - **Scope**: Apply to repository `container-scanning-1`
   - **Rules**: Enable vulnerability detection for:
     - Base image vulnerabilities
     - Package version issues
     - Known CVE detection in dependencies
3. Save the policy

### 6. Verify Integration

After pushing changes:

1. Check GitHub Actions runs successfully
2. In Arnica dashboard:
   - Navigate to **Containers** or **Assets**
   - Verify `container-scanning-1` repository appears
   - Click on the repository to see scan results
3. Expected findings:
   - Vulnerabilities in `httpx==0.15.3`
   - Issues in `requests==2.22.0`
   - Potential base image vulnerabilities in Python 3.9.11

## How to View Scan Results in Arnica

### Method 1: Repository View
1. Go to **Repositories** in Arnica
2. Select `container-scanning-1`
3. View **Containers** tab
4. Click on specific Dockerfile for detailed line-by-line analysis

### Method 2: Findings View
1. Navigate to **Findings** or **Vulnerabilities**
2. Filter by repository: `container-scanning-1`
3. View all detected issues with line numbers and severity

### Method 3: Policy Dashboard
1. Go to **Policies**
2. Select your "Dockerfile Line Scanning" policy
3. View all findings from this policy across scans

## Testing the Scanning

To generate new findings, try:

1. **Modify the Dockerfile**: Add more vulnerable packages
2. **Update requirements.txt**: Add packages with known CVEs
3. **Change base image**: Use different Python versions
4. **Push changes**: Watch Arnica detect new issues

Example:
```bash
# Add a vulnerable package to requirements.txt
echo "django==1.11.0" >> requirements.txt
git add requirements.txt
git commit -m "Test: Add vulnerable Django version"
git push origin main
```

## Key Differences from container-scanning-2

- **This repo (container-scanning-1)**: Demonstrates **line-by-line content scanning** of Dockerfiles
- **container-scanning-2**: Demonstrates **pull request policy** with automated labeling

Both showcase different Arnica policy types and scanning capabilities.

## Troubleshooting

### Actions Not Running
- Check if GitHub Actions are enabled in repository settings
- Verify the workflow file is in `.github/workflows/` directory
- Check GitHub Actions tab for error messages

### Arnica Not Showing Results
- Verify repository integration in Arnica settings
- Check that policy is enabled and properly scoped
- Allow 5-10 minutes for initial scan to complete
- Verify webhook is configured (should be automatic)

### Docker Build Failing
- Check Dockerfile syntax
- Verify all referenced files exist
- Review GitHub Actions logs for specific errors

## Additional Resources

- [Arnica Documentation](https://docs.arnica.io)
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

