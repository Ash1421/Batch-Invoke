# 🚀 PowerShell Batch Request Invoker

> **A powerful PowerShell script for sending batch HTTP requests with parallel processing and real-time monitoring**

## ✨ Socials & Stars

[![Discord](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/xc4D33wBmA)
[![GitHub Stars](https://img.shields.io/github/stars/Ash1421/batch-invoke?style=for-the-badge&color=yellow)](https://github.com/Ash1421/batch-invoke/stargazers)

## 📊 Github Repository Information


[![GitHub Issues](https://img.shields.io/github/issues/Ash1421/batch-invoke?style=for-the-badge)](https://github.com/Ash1421/batch-invoke/issues)
[![Closed Issues](https://img.shields.io/github/issues-closed/Ash1421/batch-invoke?style=for-the-badge&color=red)](https://github.com/Ash1421/batch-invoke/issues?q=is:closed)
[![New Issue](https://img.shields.io/badge/Open%20A%20New%20Issue-yellow?style=for-the-badge)](https://github.com/Ash1421/batch-invoke/issues/new)

## 💜 Made With Love Using

[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-%234D4D4D.svg?style=for-the-badge&logo=windows-terminal&logoColor=white)](https://github.com/microsoft/terminal)
[![Markdown](https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white)](https://daringfireball.net/projects/markdown/)
[![Open Source](https://img.shields.io/badge/Open%20Source-%23302E6.svg?style=for-the-badge&logo=open-source-initiative&logoColor=black)](https://opensource.org/)

## 📜 Licensed Under

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-gold.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0)

---

## 📋 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Usage](#-usage)
- [Configuration](#-configuration)
- [Examples](#-examples)
- [Advanced Features](#-advanced-features)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

---

## ✨ Features

- **Parallel Processing**: Send multiple HTTP requests simultaneously with configurable concurrency
- **Real-time Progress Bar**: Beautiful gradient progress indicator with live statistics
- **Multiple URL Support**: Process requests to multiple URLs from a file or single URL input
- **Performance Metrics**: Track request rate, success/failure counts, and execution time
- **Error Handling**: Robust error handling with failure tracking and reporting
- **Configurable**: Easy-to-modify configuration variables at the top of the script
- **Visual Feedback**: Color-coded output with ASCII art header and detailed summaries

---

## 💻 Requirements

- **Operating System**: Windows 10/11, Windows Server 2016+
- **PowerShell**: Version 5.1 or higher
- **Permissions**: Ability to execute PowerShell scripts (see [Installation](#-installation))
- **Network**: Active internet connection for sending HTTP requests

---

## 📦 Installation

### 1. Download the Script

Clone this repository or download the script directly:

```bash
git clone https://github.com/Ash1421/batch-invoke.git
cd batch-invoke
```

### 2. Set Execution Policy (Optional)

PowerShell may block script execution by default. You have two options:

**Option A: Bypass for Single Execution (Recommended)**
```powershell
powershell -ExecutionPolicy Bypass -File ".\batch-request-invoker.ps1"
```

**Option B: Change Policy Permanently**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 3. Verify Installation

Check your PowerShell version:

```powershell
$PSVersionTable.PSVersion
```

Ensure it's 5.1 or higher.

---

## 🚀 Usage

### Basic Usage

1. Open PowerShell
2. Navigate to the script directory
3. Run the script:

**Method 1: Bypass execution policy (no admin required)**
```powershell
powershell -ExecutionPolicy Bypass -File ".\batch-request-invoker.ps1"
```

**Method 2: Direct execution (if policy already set)**
```powershell
.\batch-request-invoker.ps1
```

4. Follow the interactive prompts:
   - Enter the total number of requests
   - Specify max parallel requests
   - Provide a URL or press Enter for default

### Interactive Prompts

```
→ Total number of requests: 100
→ Max parallel requests: 10
→ URL (Enter for default): https://example.com
```

---

## ⚙️ Configuration

Edit the configuration variables at the top of the script:

### Configuration Variables

```powershell
$ENABLE_URL_FILE = $false  # Enable/disable URL file feature
$DEFAULT_URL = "example.com"  # Default URL when none provided
```

### URL File Feature

When `$ENABLE_URL_FILE = $true`, you can create a `urlfile.txt` in the same directory as the script:

**urlfile.txt example:**
```
https://api1.example.com/endpoint
https://api2.example.com/endpoint
https://example.com/test
https://another-site.com
```

The script will cycle through these URLs for your requests.

---

## 📖 Examples

### Example 1: Simple Load Test

```powershell
# Run the script
.\batch-request-invoker.ps1

# Input:
Total number of requests: 50
Max parallel requests: 5
URL: https://httpbin.org/get
```

### Example 2: High-Volume Parallel Requests

```powershell
# Configuration for stress testing
Total number of requests: 1000
Max parallel requests: 50
URL: https://your-api.com/health
```

### Example 3: Multiple URLs

1. Set `$ENABLE_URL_FILE = $true`
2. Create `urlfile.txt` with your URLs
3. Run the script and choose 'y' when asked about urlfile.txt

---

## 🔧 Advanced Features

### Progress Bar

The script displays a real-time progress bar with:
- **Visual Progress**: Gradient bar showing completion percentage
- **Success Count**: Number of completed requests
- **Active Jobs**: Current parallel requests in progress
- **Failed Requests**: Number of failed requests
- **Request Rate**: Current requests per second

### Color Coding

- 🟣 **Purple/Magenta**: Headers and branding
- 🟢 **Green**: Successful operations
- 🔴 **Red**: Failed requests
- 🟡 **Yellow**: Active/in-progress operations
- 🔵 **Blue**: Informational messages
- ⚪ **White**: Primary data

### Performance Metrics

After completion, you'll see:
- Total requests sent
- Successful vs failed requests
- Total execution time
- Average request rate (req/s)

---

## 🐛 Troubleshooting

### Script Won't Execute

**Error**: "cannot be loaded because running scripts is disabled"

**Solution A** (No admin required):
```powershell
powershell -ExecutionPolicy Bypass -File ".\batch-request-invoker.ps1"
```

**Solution B** (Permanent fix):
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### High Failure Rate

- Check your network connection
- Verify the target URL is accessible
- Reduce `maxParallel` value to avoid overwhelming the server
- Check if the target has rate limiting

### Slow Performance

- Increase `maxParallel` for faster execution (within reason)
- Ensure your network bandwidth can handle the load
- Check target server response times

### URL File Not Found

- Ensure `urlfile.txt` is in the same directory as the script
- Check file name spelling and extension
- Verify the file contains valid URLs (one per line)

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Ideas for Contributions

- Add support for custom HTTP headers
- Implement POST/PUT/DELETE request methods
- Add response time tracking
- Create CSV export for results
- Add authentication support (Bearer tokens, Basic Auth)
- Implement retry logic for failed requests

---

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

### GPL v3 Summary

- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Patent use
- ✅ Private use
- ⚠️ **Must disclose source**
- ⚠️ **Must use same license**
- ⚠️ **Must state changes**
- ❌ Liability
- ❌ Warranty

**Key Point**: Any modifications or derivative works must also be licensed under GPL v3 and made open source.

---

## 👨‍💻 Author

**@Ash1421**

- GitHub: [@Ash1421](https://github.com/Ash1421)
- Version: 2.2.6

---

## 🙏 Acknowledgments

- Built with PowerShell's powerful job management system
- Inspired by the need for simple load testing tools
- Thanks to the PowerShell community for best practices

---

## 📊 Use Cases

- **Load Testing**: Test your application's performance under load
- **API Testing**: Validate API endpoints with multiple requests
- **Health Checks**: Verify service availability across multiple endpoints
- **Stress Testing**: Determine system breaking points
- **Warm-up**: Prime caches and connections before production load

---

## ⚠️ Disclaimer

This tool is designed for testing your own services or services you have permission to test. Unauthorized load testing or stress testing of third-party services may be illegal and is strictly prohibited. Always obtain proper authorization before testing any system.

---

<div align="center">

**If you find this tool useful, please consider giving it a ⭐!**

Made with 💜 by @Ash1421

</div>