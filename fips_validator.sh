#!/bin/bash

# Function to check if FIPS mode is enabled
check_fips_enabled() {
    echo ""
    echo "Checking if FIPS mode is enabled..."
    if [ $(cat /proc/sys/crypto/fips_enabled) -eq 1 ]; then
        echo "FIPS mode is enabled."
    else
        echo "FIPS mode is not enabled."
    fi
    echo ""
    read -p "Press Enter to return to the main menu..."
}

# Function to verify kernel boot parameters
check_kernel_parameters() {
    echo ""
    echo "Verifying kernel boot parameters..."
    if grep -q 'fips=1' /proc/cmdline; then
        echo "Kernel boot parameter fips=1 is set. FIPS mode is enabled."
    else
        echo "Kernel boot parameter fips=1 is not set. FIPS mode is not enabled."
    fi
    echo ""
    read -p "Press Enter to return to the main menu..."
}

# Function to verify dracut-fips package
check_dracut_fips() {
    echo ""
    echo "Verifying dracut-fips package..."
    if rpm -q dracut-fips > /dev/null 2>&1; then
        echo "dracut-fips package is installed."
    else
        echo "dracut-fips package is not installed."
    fi
    echo ""
    read -p "Press Enter to return to the main menu..."
}

# Function to check OpenSSL for FIPS
check_openssl_fips() {
    echo ""
    echo "Checking OpenSSL for FIPS..."
    if openssl version -a | grep -qi fips; then
        echo "OpenSSL is FIPS capable."
    else
        echo "OpenSSL is not FIPS capable."
    fi
    echo ""
    echo "Testing OpenSSL FIPS mode..."
    if openssl md5 /etc/hosts > /dev/null 2>&1; then
        echo "FIPS mode is not enforced, as MD5 is allowed."
    else
        echo "FIPS mode is enforced, as MD5 is not allowed."
    fi
    echo ""
    read -p "Press Enter to return to the main menu..."
}

# Function to check OpenSSH configuration
check_openssh_fips() {
    echo ""
    echo "Checking OpenSSH configuration..."
    echo "The following ciphers are configured in /etc/ssh/sshd_config:"
    grep -i ciphers /etc/ssh/sshd_config
    echo ""
    echo "Ensure the ciphers listed are compliant with FIPS standards."
    echo ""
    read -p "Press Enter to return to the main menu..."
}

# Function to verify NSS for FIPS
check_nss_fips() {
    echo ""
    echo "Verifying NSS for FIPS..."
    modutil -list -dbdir /etc/pki/nssdb/
    echo "Ensure that the output lists FIPS approved algorithms."
    echo ""
    read -p "Press Enter to return to the main menu..."
}

# Function to check audit logs for FIPS
check_audit_logs() {
    echo ""
    echo "Checking audit logs for FIPS..."
    if grep -q fips /var/log/audit/audit.log; then
        echo "Audit logs contain entries related to FIPS."
    else
        echo "No FIPS related entries found in the audit logs."
    fi
    echo ""
    read -p "Press Enter to return to the main menu..."
}

# Display menu and get user input
while true; do
    # Title of the program
    echo "######################################"
    echo "    *** FIPS Validator program  ***   "
    echo 
    echo "Select an option:"
    echo
    echo "1. Check if FIPS mode is enabled"
    echo "2. Verify kernel boot parameters"
    echo "3. Verify dracut-fips package"
    echo "4. Check OpenSSL for FIPS"
    echo "5. Check OpenSSH configuration"
    echo "6. Verify NSS for FIPS"
    echo "7. Check audit logs for FIPS"
    echo "8. Exit"
    echo ""
    read -p "Enter your choice [1-8]: " choice
    echo ""

    case $choice in
        1) check_fips_enabled ;;
        2) check_kernel_parameters ;;
        3) check_dracut_fips ;;
        4) check_openssl_fips ;;
        5) check_openssh_fips ;;
        6) check_nss_fips ;;
        7) check_audit_logs ;;
        8) echo ""; echo "Exiting..."; break ;;
        *) echo ""; echo "Invalid choice, please select a number between 1 and 8."; echo "" ;;
    esac
done
