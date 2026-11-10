#!/bin/bash

# ==========================================
# VPanel Advanced Setup by SKA
# ==========================================

C_RED='\e[31m'
C_GREEN='\e[32m'
C_YELLOW='\e[33m'
C_BLUE='\e[34m'
C_CYAN='\e[36m'
C_PURPLE='\e[35m'
C_RESET='\e[0m'

clear

if [ "$EUID" -ne 0 ]; then
  echo -e "${C_RED}[!] Error: Please run this installation script as root (use sudo).${C_RESET}"
  exit 1
fi

echo -e "${C_CYAN}====================================================${C_RESET}"
echo -e "${C_YELLOW}         VPanel Secure Deployment System${C_RESET}"
echo -e "${C_CYAN}====================================================${C_RESET}"
echo ""

read -p "Enter your registered Email: " USER_EMAIL
read -p "Enter your License Key: " USER_KEY
echo ""

echo -e "${C_YELLOW}[*] Verifying license with SKA Server...${C_RESET}"

API_URL="http://78.154.103.44:9109/api/verify"

RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"email\":\"$USER_EMAIL\", \"key\":\"$USER_KEY\"}" $API_URL)

if echo "$RESPONSE" | grep -q '"valid":true'; then
    clear
    
    # 1. ASCII Art
    echo -e "${C_CYAN}"
    cat << "EOF"
  _   _  _____                      _ 
 | | | ||  __ \                    | |
 | | | || |__) |__ _  _ __    ___  | |
 | | | ||  ___// _` || '_ \  / _ \ | |
 | |_| || |   | (_| || | | ||  __/ | |
  \___/ |_|    \__,_||_| |_| \___| |_|
EOF
    echo -e "${C_BLUE}     Welcome to VPanel Environment Setup${C_RESET}"
    echo -e "${C_PURPLE}               Powered by SKA${C_RESET}"
    echo ""
    echo -e "${C_BLUE}>> License Verified. Preparing secure environment...${C_RESET}"
    echo ""

    # 2. Extract Raw URL from API Response
    RAW_URL=$(echo "$RESPONSE" | grep -o '"payload":"[^"]*"' | cut -d'"' -f4)
    
    # 3. Super Fast Beautiful Progress Bar Animation
    echo -e "${C_CYAN}┌──────────────────────────────────────────────────┐${C_RESET}"
    echo -n -e "${C_CYAN}│${C_RESET} Installing VPanel: [${C_GREEN}"
    
    # এখানে টাইম একদম কমিয়ে দেওয়া হয়েছে (0.01), ফলে চোখের পলকে ফিলাপ হবে
    for i in {1..40}; do
        echo -n "█"
        sleep 0.01
    done
    
    echo -e "${C_RESET}${C_CYAN}] 100% │${C_RESET}"
    echo -e "${C_CYAN}└──────────────────────────────────────────────────┘${C_RESET}"
    echo ""

    # 4. Execute the Raw Script in Foreground
    echo -e "${C_GREEN}>> Executing Installation Script...${C_RESET}"
    echo -e "${C_CYAN}----------------------------------------------------${C_RESET}"
    
    bash <(curl -sL "$RAW_URL")
    
    echo -e "${C_CYAN}----------------------------------------------------${C_RESET}"
    echo -e "${C_GREEN}✅ Task Completed Successfully!${C_RESET}"
    echo -e "${C_BLUE}====================================================${C_RESET}"

else
    MESSAGE=$(echo "$RESPONSE" | grep -o '"message":"[^"]*"' | cut -d'"' -f4)
    if [ -z "$MESSAGE" ]; then MESSAGE="Invalid License Key or Network Error"; fi
    echo -e "${C_RED}[!] Verification Failed: $MESSAGE${C_RESET}"
    echo -e "${C_RED}[!] Setup aborted.${C_RESET}"
    exit 1
fi
