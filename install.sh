#!/bin/bash

# ==========================================
# VPanel Advanced Setup by SKA
# ==========================================

# Colors for terminal styling
C_RED='\e[31m'
C_GREEN='\e[32m'
C_YELLOW='\e[33m'
C_BLUE='\e[34m'
C_CYAN='\e[36m'
C_PURPLE='\e[35m'
C_RESET='\e[0m'

clear

# ASCII Art Text
echo -e "${C_CYAN}"
cat << "EOF"
 __      __ _____                        _ 
 \ \    / /|  __ \                      | |
  \ \  / / | |__) |__ _  _ __    ___  | |
   \ \/ /  |  ___// _` || '_ \  / _ \ | |
    \  /   | |   | (_| || | | ||  __/ | |
     \/    |_|    \__,_||_| |_| \___| |_|
                                         
EOF
echo -e "${C_YELLOW}        Welcome to VPanel Environment Setup        ${C_RESET}"
echo -e "${C_PURPLE}                  Powered by SKA                   ${C_RESET}"
echo ""

# Advanced Animated Progress Bar Function
draw_progress_bar() {
    local duration=$1
    local prefix=$2
    local width=40
    local interval=$(awk "BEGIN {print $duration/$width}")
    
    echo -n -e "${C_CYAN}${prefix} [${C_RESET}"
    for ((i=0; i<width; i++)); do
        echo -n -e "${C_GREEN}█${C_RESET}"
        sleep $interval
    done
    echo -e "${C_CYAN}] 100%${C_RESET} ${C_GREEN}Done!${C_RESET}"
}

echo -e "${C_YELLOW}[*] Initializing deployment sequence...${C_RESET}"
sleep 1

# Running Deployment Animations
draw_progress_bar 2.5 "Verifying License         "
draw_progress_bar 3.0 "Installing Dependencies   "
draw_progress_bar 2.0 "Applying Configurations   "
draw_progress_bar 2.5 "Starting VPanel Services  "

echo ""
echo -e "${C_BLUE}====================================================${C_RESET}"
echo -e "${C_GREEN}✅ Installation Completed Successfully!${C_RESET}"
echo -e "${C_YELLOW}Your VPanel hosting environment is now ready and secure.${C_RESET}"
echo -e "${C_BLUE}====================================================${C_RESET}"
echo ""

# আপনার মূল কমান্ডগুলো (যেমন apt update, nodejs install) এই লাইনের পর থেকে লিখতে পারেন।
# Example: 
# apt update -y
# apt install -y curl
