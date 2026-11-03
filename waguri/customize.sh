#!/bin/bash

GREEN='\033[0;32m'
PURPLE='\033[0;35m'
PINK='\033[1;35m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

THEME_DIR=$(dirname "$(readlink -f "$0")")
THEME_NAME=$(basename "$THEME_DIR")
if [ "$THEME_NAME" = "yume" ]; then
    THEME_NAME="waguri"
fi
CONFIG_FILE="$THEME_DIR/theme.conf"

echo -e "${PINK}"
echo "+---------------------------------------------------+"
echo "|          WAGURI - SUPER CUTIE PURPLE THEME        |"
echo "|      A sweet Kaoruko Waguri SDDM Greeter Theme    |"
echo "+---------------------------------------------------+"
echo -e "${NC}"

if [ ! -w "$THEME_DIR" ]; then
    echo -e "${RED}Error: Cannot write to theme directory.${NC}"
    echo "Please run this script with proper permissions (or sudo if installed to /usr/share/sddm/themes)."
    exit 1
fi

set_conf() {
    local key="$1"
    local value="$2"
    if grep -q "^${key}=" "$CONFIG_FILE"; then
        sed -i "s|^${key}=.*|${key}=${value}|" "$CONFIG_FILE"
    else
        sed -i "/^\[General\]/a ${key}=${value}" "$CONFIG_FILE"
    fi
}

echo -e "Customizing theme at: ${CYAN}$THEME_DIR${NC}"

# Wallpaper selection
echo
echo -e "${PURPLE}Choose your Waguri Wallpaper:${NC}"
echo "1. Moonlight Pagoda (Waguri under giant purple moon & Mt Fuji) [Default]"
echo "2. Neon Dreams (Waguri double peace sign in cyberpunk purple/pink)"
echo "3. Sweets & Flowers (Chibi Waguri eating cake with puffy blush)"
echo "4. Starry Phone (Waguri looking up with phone & sparkle eyes)"
echo "5. Radiant Smile (Summer smile & waving)"
read -p "Enter selection [1-5, default 1]: " -n 1 -r < /dev/tty
echo

BG_CHOICE="Assets/waguri-moonlight.jpg"
if [[ $REPLY =~ ^[2]$ ]]; then
    BG_CHOICE="Assets/waguri-neon.jpg"
elif [[ $REPLY =~ ^[3]$ ]]; then
    BG_CHOICE="Assets/waguri-sweets.png"
elif [[ $REPLY =~ ^[4]$ ]]; then
    BG_CHOICE="Assets/waguri-phone.png"
elif [[ $REPLY =~ ^[5]$ ]]; then
    BG_CHOICE="Assets/waguri-smile.jpg"
fi

set_conf "background" "$BG_CHOICE"
echo -e "${GREEN}Set background to: $BG_CHOICE${NC}"

# Background blur
echo
echo -e "${PURPLE}Choose background blur strength:${NC}"
echo "1. None (0.0) - Sharp & Pristine [Default]"
echo "2. Light (0.25)"
echo "3. Medium (0.50) - Balanced"
echo "4. Strong (0.80) - Dreamy"
read -p "Enter selection [1-4, default 1]: " -n 1 -r < /dev/tty
echo

BLUR_VAL="0.0"
if [[ $REPLY =~ ^[2]$ ]]; then
    BLUR_VAL="0.25"
elif [[ $REPLY =~ ^[3]$ ]]; then
    BLUR_VAL="0.50"
elif [[ $REPLY =~ ^[4]$ ]]; then
    BLUR_VAL="0.80"
fi

set_conf "BlurStrength" "$BLUR_VAL"
echo -e "${GREEN}Set BlurStrength to: $BLUR_VAL${NC}"

# Floating Sakura Petals
echo
read -p "Enable floating sakura flower petals? [Y/n] " -n 1 -r < /dev/tty
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    set_conf "showFloatingPetals" "false"
    echo -e "${GREEN}Floating petals disabled.${NC}"
else
    set_conf "showFloatingPetals" "true"
    echo -e "${GREEN}Floating petals enabled.${NC}"
fi

# Clock
echo
read -p "Show the clock above the login card? [Y/n] " -n 1 -r < /dev/tty
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    set_conf "showClock" "false"
else
    set_conf "showClock" "true"
fi

echo -e "${GREEN}Configuration saved successfully!${NC}"

# Activation Logic
read -p "Do you want to ACTIVATE the theme now in SDDM? [y/N] " -n 1 -r < /dev/tty
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    CONFIG_DIR="/etc/sddm.conf.d"
    TARGET_CONF=""

    if [ -f "$CONFIG_DIR/kde_settings.conf" ]; then
        TARGET_CONF="$CONFIG_DIR/kde_settings.conf"
    elif [ -f "$CONFIG_DIR/theme.conf.user" ]; then
        TARGET_CONF="$CONFIG_DIR/theme.conf.user"
    elif [ -f "$CONFIG_DIR/theme.conf" ]; then
        TARGET_CONF="$CONFIG_DIR/theme.conf"
    else
        TARGET_CONF="$CONFIG_DIR/theme.conf"
    fi

    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
    fi

    for f in "$CONFIG_DIR"/*.conf; do
        if [[ "$f" != "$TARGET_CONF" ]] && grep -q "Current=" "$f" 2>/dev/null; then
            echo -e "${RED}Warning: Found conflicting config: $f${NC}"
            cp "$f" "${f}.bak.$(date +%F_%T)"
            sed -i -E 's/^Current=/#Current=/' "$f"
            echo -e "${GREEN}Backed up and commented out conflict in: $f${NC}"
        fi
    done

    if grep -q "^\[Theme\]" "$TARGET_CONF" 2>/dev/null; then
        if grep -q "Current=" "$TARGET_CONF" 2>/dev/null; then
            sed -i "s|^Current=.*|Current=$THEME_NAME|" "$TARGET_CONF"
        else
            sed -i "/^\[Theme\]/a Current=$THEME_NAME" "$TARGET_CONF"
        fi
    else
        echo -e "\n[Theme]\nCurrent=$THEME_NAME" >> "$TARGET_CONF"
    fi

    echo -e "${GREEN}Theme activated as '$THEME_NAME' in $TARGET_CONF!${NC}"

    if [ -f "$CONFIG_DIR/virtualkeyboard.conf" ]; then
        echo
        echo -e "${RED}Found Config for Virtual Keyboard ($CONFIG_DIR/virtualkeyboard.conf).${NC}"
        echo "This file often causes the on-screen keyboard to pop up unnecessarily."
        read -p "Do you want to remove it? [y/N] " -n 1 -r < /dev/tty
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm "$CONFIG_DIR/virtualkeyboard.conf"
            echo -e "${GREEN}Removed virtualkeyboard.conf${NC}"
        else
            echo "Skipped removal of virtualkeyboard.conf"
        fi
    fi

else
    echo "Done. Don't forget to restart SDDM when you're ready!"
fi
