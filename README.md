# FIPS Validator

## Author: Gustavo Wydler Azuaga
## Date: 06/06/2024
## Overview

The FIPS Validator is a bash script designed to help you check the Federal Information Processing Standard (FIPS) 140-2 compliance of your Linux environment. The script provides an interactive menu to verify various FIPS settings and configurations, making it easy to ensure your system meets the necessary cryptographic module security requirements.

## Features

- **Interactive Menu**: Simple and user-friendly interface to run specific FIPS compliance checks.
- **Checks FIPS Mode**: Verifies if the system is operating in FIPS mode.
- **Kernel Parameters**: Checks if the kernel boot parameters include FIPS.
- **Package Verification**: Confirms if the `dracut-fips` package is installed.
- **OpenSSL Compliance**: Validates if OpenSSL is FIPS capable and operating in FIPS mode.
- **OpenSSH Configuration**: Checks the SSH configuration for FIPS-compliant ciphers.
- **NSS Verification**: Ensures Network Security Services (NSS) are configured for FIPS.
- **Audit Logs**: Examines audit logs for FIPS-related entries.
- **User Feedback**: Provides clear explanations and outcomes for each check.

## Technical Details

### Script Commands

The script includes the following checks:

1. **Check if FIPS mode is enabled**
    ```bash
    cat /proc/sys/crypto/fips_enabled
    ```
    - Output: `1` if FIPS mode is enabled, `0` otherwise.

2. **Verify kernel boot parameters**
    ```bash
    grep -o 'fips=1' /proc/cmdline
    ```
    - Output: Confirms if `fips=1` is set in kernel parameters.

3. **Verify dracut-fips package**
    ```bash
    rpm -q dracut-fips
    ```
    - Output: Indicates if the `dracut-fips` package is installed.

4. **Check OpenSSL for FIPS**
    ```bash
    openssl version -a | grep -i fips
    openssl md5 /etc/hosts
    ```
    - Output: Validates if OpenSSL is FIPS capable and checks FIPS mode enforcement.

5. **Check OpenSSH configuration**
    ```bash
    grep -i ciphers /etc/ssh/sshd_config
    ```
    - Output: Lists the ciphers configured in SSH.

6. **Verify NSS for FIPS**
    ```bash
    modutil -list -dbdir /etc/pki/nssdb/
    ```
    - Output: Displays FIPS approved algorithms in NSS.

7. **Check audit logs for FIPS**
    ```bash
    grep fips /var/log/audit/audit.log
    ```
    - Output: Searches for FIPS-related entries in the audit logs.

### User Interaction

Each command is executed when the corresponding menu option is selected. After running a command, the user is prompted to press Enter to return to the main menu. This design ensures a smooth and interactive experience.

## Usage

### Prerequisites

- Ensure you have the necessary permissions to execute system commands.
- The script should be run on a Linux environment.

### Installation

1. **Clone the Repository**
    ```bash
    git clone https://github.com/yourusername/fips_validator.git
    cd fips_validator
    ```

2. **Make the Script Executable**
    ```bash
    chmod +x fips_validator.sh
    ```

### Running the Script

1. **Execute the Script**
    ```bash
    ./fips_validator.sh
    ```

2. **Select an Option**
    - The script will display a menu with numbered options. Type the number corresponding to the check you want to perform and press Enter.
    - Follow the on-screen instructions and press Enter to return to the main menu after each check.

## Example

```bash
FIPS Validator
==============

Select an option:
1. Check if FIPS mode is enabled
2. Verify kernel boot parameters
3. Verify dracut-fips package
4. Check OpenSSL for FIPS
5. Check OpenSSH configuration
6. Verify NSS for FIPS
7. Check audit logs for FIPS
8. Exit

Enter your choice [1-8]: 1

Checking if FIPS mode is enabled...
FIPS mode is enabled.

Press Enter to return to the main menu...
