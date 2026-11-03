<div align="center">

# 🌸 waguri

### A dreamy purple SDDM login theme inspired by *Kaoruko Waguri*
*from "The Fragrant Flower Blooms with Dignity" (Kaoru Hana wa Rin to Saku)*

![SDDM](https://img.shields.io/badge/SDDM-theme-b57edc?style=for-the-badge)
![Qt](https://img.shields.io/badge/Qt-QML-9d4edd?style=for-the-badge&logo=qt&logoColor=white)
![License](https://img.shields.io/badge/license-GPL--3.0-f4a6d7?style=for-the-badge)
![Linux](https://img.shields.io/badge/Linux-ready-7b2cbf?style=for-the-badge&logo=linux&logoColor=white)

<img src="screenshots/preview.png" alt="waguri SDDM theme preview" width="850">

*Moonlit cherry blossoms, drifting petals, and a gentle glass-morphism login card.* 💜

</div>

---

## ✨ Features

- 🌙 **Moonlit sakura scene** with falling petals and soft sparkles
- 🪟 **Frosted-glass login card** with rounded corners and a pink-purple glow
- 🕛 **Large clock and date** display, always readable over the artwork
- 👤 **Username and password fields** with icons and a focus highlight
- 🖥️ **Session selector** (GNOME, KDE Plasma, Hyprland, Sway, etc.)
- 🔘 **Gradient Login button**, plus **Shutdown** and **Reboot** buttons
- 💬 Friendly "Welcome back ♡" greeting with a circular avatar
- 🎀 Cute pastel purple + sakura pink palette

## 📦 Requirements

- [SDDM](https://github.com/sddm/sddm)
- Qt / QtQuick (QML) packages required by SDDM on your distro
- Qt5Compat / QtGraphicalEffects, if the theme uses blur effects

> Adjust this list to match the exact Qt version and modules your theme uses.

## 🚀 Installation

### Manual

```bash
git clone https://github.com/YOUR_USERNAME/sddm-waguri-theme.git
cd sddm-waguri-theme
sudo cp -r waguri /usr/share/sddm/themes/
```

### Set as active theme

Create or edit `/etc/sddm.conf.d/theme.conf`:

```ini
[Theme]
Current=waguri
```

### Arch Linux (AUR)

```bash
# coming soon
yay -S sddm-waguri-theme
```

## 🧪 Test before you log out

```bash
# Qt6 SDDM
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/waguri

# Qt5 SDDM
sddm-greeter --test-mode --theme /usr/share/sddm/themes/waguri
```

## 🎨 Customization

Edit `theme.conf` inside the theme folder:

```ini
[General]
background=assets/background.png
avatar=assets/avatar.png
accentColor=#c77dff
```

| Option        | Description                  |
|---------------|------------------------------|
| `background`  | Path to your wallpaper       |
| `avatar`      | Avatar shown above the form  |
| `accentColor` | Main accent color            |

> Update this table to match the options your `theme.conf` actually supports.

## 🖼️ Screenshots

| Login screen | Session menu |
|--------------|--------------|
| ![login](screenshots/login.png) | ![sessions](screenshots/sessions.png) |

## 🗂️ Structure

```
waguri/
├── Main.qml
├── theme.conf
├── metadata.desktop
├── assets/
│   ├── background.png
│   └── avatar.png
└── components/
```

## 🛠️ Troubleshooting

- **Theme not showing up?** Check that the folder is in `/usr/share/sddm/themes/` and contains `metadata.desktop`.
- **Black screen or fallback theme?** Run the test-mode command above to see QML errors.
- **Missing icons or blur?** Install the Qt modules listed under Requirements.

## 🤝 Contributing

Pull requests, issues, and new color variants are welcome! Feel free to open an issue for bugs or ideas.

## ⚖️ Credits & Disclaimer

- Theme code: © YOUR_NAME, licensed under **GPL-3.0**
- *Kaoru Hana wa Rin to Saku* and the character **Kaoruko Waguri** belong to their respective creators and rights holders (author Saka Mikami; anime by CloverWorks).
- This is an **unofficial fan-made project**, not affiliated with or endorsed by them.
- Artwork: credit the original artist here (name + link). If you commissioned or made it yourself, say so.
- Cherry-blossom assets and fonts: list sources and licenses here.

If you are a rights holder and want something removed, please open an issue and I'll take care of it promptly.

## 💜 Support

If you like this theme, leave a ⭐ on the repo. It really helps!

---

<div align="center">
Made with 🌸 and too much purple
</div>
