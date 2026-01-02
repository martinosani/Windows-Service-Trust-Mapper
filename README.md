# WindowsServiceTrustMapper

**WindowsServiceTrustMapper** is a PowerShell module designed to analyze Windows services from a security perspective by mapping **trust boundaries** between privileged services and user-controllable resources.

The tool focuses on identifying **risky service configurations** that can lead to **local privilege escalation (LPE)** and other security issues, without performing exploitation.

---

## Why this tool exists

Windows vulnerabilities often stem from **incorrect trust assumptions**, such as:

- Privileged services executing code from unsafe or user-influenced paths  
- Misconfigured file system permissions on service binaries or parent directories  
- Scripted or indirect execution chains running as SYSTEM  
- Legacy service configurations that violate modern security expectations  

These conditions are still frequently observed in **real-world CVEs affecting third-party Windows software**, including recent releases.

**WindowsServiceTrustMapper** helps surface these conditions early, in a structured and explainable way.

---

## What the tool does

For each Windows service, the tool analyzes:

- Service execution context (account, start mode, state)  
- Service `ImagePath` and command-line arguments  
- Path parsing and quoting issues  
- Executable resolution behavior  
- File system permission risks (ACLs)  
- Trust boundary violations between privileged services and user-controlled resources  

The output is a structured object containing findings and a **context-aware risk classification**.

---

## What the tool does NOT do

- ❌ No exploitation  
- ❌ No payload execution  
- ❌ No vulnerability signature matching  
- ❌ No persistence or system modification  

This is an **analysis and reasoning tool**, not an exploit framework.

---

## Tested against real-world vulnerabilities

**WindowsServiceTrustMapper** has been validated against known Windows service misconfigurations observed in real-world CVEs.

### Sunshine (Windows) – Unquoted Service Path (CVE-2025-54081)

- Software: Sunshine (self-hosted game streaming server for Moonlight)
- Affected versions: prior to `2025.923.33222`
- Issue: Windows service installed with an **unquoted executable path** containing spaces
- Impact: Potential local privilege escalation depending on installation path and directory permissions
- Reference: https://github.com/LizardByte/Sunshine/security/advisories/GHSA-6p7j-5v8v-w45h

When Sunshine is installed in the default directory (`C:\Program Files`), the tool correctly identifies the unquoted path condition and classifies the risk as **Medium**, reflecting the restrictive ACLs of the parent directory.

If the same service is installed in a user-writable path containing spaces, the tool escalates the finding accordingly, demonstrating **context-aware risk assessment** rather than signature-based detection.

---

## Example use cases

- Security engineering and product security reviews  
- Blue team and detection engineering  
- Windows internals and OS security learning  
- Pre-deployment security validation of third-party software  
- Lab and research environments  

---

## Installation and usage (local / development)

```powershell
Import-Module .\src\WindowsServiceTrustMapper.psd1 -Force
Get-WstmServiceTrustMap | Format-Table -AutoSize
