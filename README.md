<p align="center">
  <a href="#launchers" target="_blank"><img alt="undefined" src="https://img.shields.io/badge/launchers-skyblue?style=for-the-badge"></a>
  <a href="#applets" target="_blank"><img alt="undefined" src="https://img.shields.io/badge/applets-lightgreen?style=for-the-badge"></a>
  <a href="#powermenus" target="_blank"><img alt="undefined" src="https://img.shields.io/badge/powermenus-pink?style=for-the-badge"></a>
</p>

# Rofi Launchers Nix

This fork of Rofi launchers has two purposes:
1. Provide an all-in-one CLI for running all launchers with corresponding type, style, color scheme and fonts
2. Provide a Nix flake to easily install it on nix-capable systems

## What is Rofi?

[Rofi](https://github.com/davatorium/rofi) is a window switcher, application launcher and dmenu replacement. Rofi started as a clone of simpleswitcher and It has been extended with extra features, like an application launcher and ssh-launcher, and can act as a drop-in dmenu replacement, making it a very versatile tool. Rofi, like dmenu, will provide the user with a textual list of options where one or more can be selected. This can either be running an application, selecting a window, or options provided by an external script.

## What is Rofi launchers ?
[Rofi launchers](https://github.com/adi1090x/rofi) is a huge collection of Rofi-based custom <i>Applets</i>, <i>Launchers</i> and <i>Powermenus</i>.

<p align="center">
  <img src="previews/logo.png">
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/adi1090x/rofi?style=for-the-badge">
  <img src="https://img.shields.io/github/stars/adi1090x/rofi?style=for-the-badge">
  <img src="https://img.shields.io/github/issues/adi1090x/rofi?color=violet&style=for-the-badge">
  <img src="https://img.shields.io/github/forks/adi1090x/rofi?color=teal&style=for-the-badge">
</p>

<details>
<summary><b><code>Launchers</code></b></summary>

|Type 1|Type 2|Type 3|Type 4|
|--|--|--|--|
|![img](previews/launchers/type-1.gif)|![img](previews/launchers/type-2.gif)|![img](previews/launchers/type-3.gif)|![img](previews/launchers/type-4.gif)|

|Type 5|Type 6|Type 7|
|--|--|--|
|![img](previews/launchers/type-5.gif)|![img](previews/launchers/type-6.gif)|![img](previews/launchers/type-7.gif)|

</details>

<details>
<summary><b><code>Applets</code></b></summary>

|Type 1|Type 2|Type 3|
|--|--|--|
|![img](previews/applets/type-1.gif)|![img](previews/applets/type-2.gif)|![img](previews/applets/type-3.gif)|

|Type 4|Type 5|
|--|--|
|![img](previews/applets/type-4.gif)|![img](previews/applets/type-5.gif)|

</details>

<details>
<summary><b><code>Powermenus</code></b></summary>

|Type 1|Type 2|Type 3|
|--|--|--|
|![img](previews/powermenu/type-1.gif)|![img](previews/powermenu/type-2.gif)|![img](previews/powermenu/type-3.gif)|

|Type 4|Type 5|Type 6|
|--|--|--|
|![img](previews/powermenu/type-4.gif)|![img](previews/powermenu/type-5.gif)|![img](previews/powermenu/type-6.gif)|

</details>

## Usage

You can use the `rofi-launch` command (or `~/.config/rofi/rofi-launch.sh` on imperative systems) as follows:
```
rofi-launch --bin <script> <type> <style> [app-name] --theme <color> <font-name> <font-size>
```
where
- `<script>/<type>/<style>` is a subdirectory of `files/scripts`
- `[app-name]` is the name of a binary file from `files/scripts/<script>/bin`
- `<color>` is the name of a rasi file from `files/assets/colors`
- `<font-name>` is a string and `<font-size>` is an integer

The command will look for a `main.sh` file inside the `files/scripts/<script>/<type>/` directory or a `default.sh` file inside the `files/scripts/<script>/bin` directory. If `[app-name]` is specified, it will look at `files/scripts/<script>/bin/[app-name].sh`.

## Installation

### Declarative
If you use NixOS or home-manager, you can simply use this repository as a flake:
- NixOS
```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # other flakes...
    rofi-launchers.url = "github:BinaryQuantumSoul/rofi-launchers-nix";
  };

  outputs = { self, nixpkgs, , ... }@inputs: {
    nixosConfigurations = {
      "myHost" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          # other nixos modules...
          inputs.rofi-launchers.nixosModule.default
        ];
      };
    };
  };
}
```
- home-manager standalone
```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # other flakes...
    rofi-launchers.url = "github:BinaryQuantumSoul/rofi-launchers-nix";
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    homeConfigurations = {
      "myUser" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
          # other home modules...
          inputs.rofi-launchers.homeModule.default
        ];
      };
    };
  };
};
```

### Imperative

> **Everything here is created on rofi version : `1.7.4`**

* First, make sure you have the same (stable) version of rofi installed.
  - On Arch / Arch-based : **`sudo pacman -S rofi`**
  - On Debian / Ubuntu : **`sudo apt-get install rofi`**
  - On Fedora : **`sudo dnf install rofi`**

- Then, clone this repository
```
$ git clone --depth=1 https://BinaryQuantumSoul/rofi-launchers-nix
```

- Change to cloned directory and make `setup.sh` executable
```
$ cd rofi
$ chmod +x setup.sh
```

- Run `setup.sh` to install the configs
```
$ ./setup.sh

[*] Installing fonts...
[*] Updating font cache...

[*] Creating a backup of your rofi configs...
[*] Installing rofi configs...
[*] Successfully Installed.
```

- (Optional) Add `~/.config/rofi/rofi-launch.sh` to `$PATH`
  - In `bash`
  ``` bash
  echo PATH=$HOME/.config/rofi/:$PATH >> ~/.bashrc
  ```
  - In `zsh`
  ``` zsh
  echo PATH=$HOME/.config/rofi/:$PATH >> ~/.zshrc
  ```

> **Warning:** After changing the shell files, Logout and Login back again to update the `$PATH` environment variable.

- That's it, These themes are now installed on your system.

> **Note** : These themes are like an ecosystem, everything here is connected with each other in some way. So... before modifying anything by your own, make sure you know what you doing.

## Notes on hard-code
There are a few hard-coded values in this project that I'd like to modularize. In the meantime, they are listed here.

- Launchers colors in `type-5`, `type-6` and `type-7` are hard-coded (based on image colors) and can be changed by editing the respective `style-X.rasi` file.

- Powermenus colors in `type-5` and `type-6` are hard-coded (based on image colors) and can be changed by editing the respective `style-X.rasi` file.

- Applets softwares are hard-coded, edit the scripts in `~/.config/rofi/applets/bin` directory.
- Applets colors in `type-4` and `type-5` are hard-coded (based on image colors) and can be changed by editing the respective `style-X.rasi` file.

## Gallery

### Launchers

<details>
<summary><b>Type 1</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/launchers/type-1/1.png)|![img](previews/launchers/type-1/2.png)|![img](previews/launchers/type-1/3.png)|![img](previews/launchers/type-1/4.png)|![img](previews/launchers/type-1/5.png)|

|Style 6|Style 7|Style 8|Style 9|Style 10|
|--|--|--|--|--|
|![img](previews/launchers/type-1/6.png)|![img](previews/launchers/type-1/7.png)|![img](previews/launchers/type-1/8.png)|![img](previews/launchers/type-1/9.png)|![img](previews/launchers/type-1/10.png)|

|Style 11|Style 12|Style 13|Style 14|Style 15|
|--|--|--|--|--|
|![img](previews/launchers/type-1/11.png)|![img](previews/launchers/type-1/12.png)|![img](previews/launchers/type-1/13.png)|![img](previews/launchers/type-1/14.png)|![img](previews/launchers/type-1/15.png)|

</details>

<details>
<summary><b>Type 2</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/launchers/type-2/1.png)|![img](previews/launchers/type-2/2.png)|![img](previews/launchers/type-2/3.png)|![img](previews/launchers/type-2/4.png)|![img](previews/launchers/type-2/5.png)|

|Style 6|Style 7|Style 8|Style 9|Style 10|
|--|--|--|--|--|
|![img](previews/launchers/type-2/6.png)|![img](previews/launchers/type-2/7.png)|![img](previews/launchers/type-2/8.png)|![img](previews/launchers/type-2/9.png)|![img](previews/launchers/type-2/10.png)|

|Style 11|Style 12|Style 13|Style 14|Style 15|
|--|--|--|--|--|
|![img](previews/launchers/type-2/11.png)|![img](previews/launchers/type-2/12.png)|![img](previews/launchers/type-2/13.png)|![img](previews/launchers/type-2/14.png)|![img](previews/launchers/type-2/15.png)|

</details>

<details>
<summary><b>Type 3</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/launchers/type-3/1.png)|![img](previews/launchers/type-3/2.png)|![img](previews/launchers/type-3/3.png)|![img](previews/launchers/type-3/4.png)|![img](previews/launchers/type-3/5.png)|

|Style 6|Style 7|Style 8|Style 9|Style 10|
|--|--|--|--|--|
|![img](previews/launchers/type-3/6.png)|![img](previews/launchers/type-3/7.png)|![img](previews/launchers/type-3/8.png)|![img](previews/launchers/type-3/9.png)|![img](previews/launchers/type-3/10.png)|

</details>

<details>
<summary><b>Type 4</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/launchers/type-4/1.png)|![img](previews/launchers/type-4/2.png)|![img](previews/launchers/type-4/3.png)|![img](previews/launchers/type-4/4.png)|![img](previews/launchers/type-4/5.png)|

|Style 6|Style 7|Style 8|Style 9|Style 10|
|--|--|--|--|--|
|![img](previews/launchers/type-4/6.png)|![img](previews/launchers/type-4/7.png)|![img](previews/launchers/type-4/8.png)|![img](previews/launchers/type-4/9.png)|![img](previews/launchers/type-4/10.png)|

</details>

<details>
<summary><b>Type 5</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/launchers/type-5/1.png)|![img](previews/launchers/type-5/2.png)|![img](previews/launchers/type-5/3.png)|![img](previews/launchers/type-5/4.png)|![img](previews/launchers/type-5/5.png)|

</details>

<details>
<summary><b>Type 6</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/launchers/type-6/1.png)|![img](previews/launchers/type-6/2.png)|![img](previews/launchers/type-6/3.png)|![img](previews/launchers/type-6/4.png)|![img](previews/launchers/type-6/5.png)|

|Style 6|Style 7|Style 8|Style 9|Style 10|
|--|--|--|--|--|
|![img](previews/launchers/type-6/6.png)|![img](previews/launchers/type-6/7.png)|![img](previews/launchers/type-6/8.png)|![img](previews/launchers/type-6/9.png)|![img](previews/launchers/type-6/10.png)|

</details>

<details>
<summary><b>Type 7</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/launchers/type-7/1.png)|![img](previews/launchers/type-7/2.png)|![img](previews/launchers/type-7/3.png)|![img](previews/launchers/type-7/4.png)|![img](previews/launchers/type-7/5.png)|

|Style 6|Style 7|Style 8|Style 9|Style 10|
|--|--|--|--|--|
|![img](previews/launchers/type-7/6.png)|![img](previews/launchers/type-7/7.png)|![img](previews/launchers/type-7/8.png)|![img](previews/launchers/type-7/9.png)|![img](previews/launchers/type-7/10.png)|

</details>

<details>
<summary><b>Color Schemes</b></summary>

|Adapta|Arc|Black|Catppuccin|Cyberpunk|
|--|--|--|--|--|
|![img](previews/launchers/colors/color-1.png)|![img](previews/launchers/colors/color-2.png)|![img](previews/launchers/colors/color-3.png)|![img](previews/launchers/colors/color-4.png)|![img](previews/launchers/colors/color-5.png)|

|Dracula|Everforest|Gruvbox|Lovelace|Navy|
|--|--|--|--|--|
|![img](previews/launchers/colors/color-6.png)|![img](previews/launchers/colors/color-7.png)|![img](previews/launchers/colors/color-8.png)|![img](previews/launchers/colors/color-9.png)|![img](previews/launchers/colors/color-10.png)|

|Nord|Onedark|Paper|Solarized|Yousai|
|--|--|--|--|--|
|![img](previews/launchers/colors/color-11.png)|![img](previews/launchers/colors/color-12.png)|![img](previews/launchers/colors/color-13.png)|![img](previews/launchers/colors/color-14.png)|![img](previews/launchers/colors/color-15.png)|

</details>

### Applets

<details>
<summary><b>List of existing applets</b></summary>

|Applets|Description|Required Applications|
|:-|:-|:-|
|**`Apps As Root`**|Open Applications as root|`pkexec` : `alacritty`, `thunar`, `geany`, `ranger`, `vim`|
|**`Apps`**|Favorite or most used Applications|`alacritty`, `thunar`, `geany`, `firefox`, `ncmpcpp`, `xfce4-settings-manager`|
|**`Battery`**|Display battery percentage & charging status with dynamic icons|`pkexec`, `acpi`, `powertop` `xfce4-power-manager-settings`|
|**`Brightness`**|Display and adjust screen brightness|`light`, `xfce4-power-manager-settings`|
|**`MPD`**|Control the song play through **`mpd`**|`mpd`, `mpc`|
|**`Powermenu`**|A classic power menu, with Uptime|`systemd`, `betterlockscreen`|
|**`Quicklinks`**|Bookmarks for most used websites|`firefox` or `chromium` or any other browser|
|**`Screenshot`**|Take screenshots using **`maim`**|`maim`, `xrandr`, `dunst`, `xclip`|
|**`Volume`**|Display and control volume with dynamic icons and mute status|`amixer` and `pavucontrol`|

</details>


<details>
<summary><b>Apps as root</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/1/1.png)|![img](previews/applets/1/2.png)|![img](previews/applets/1/3.png)|![img](previews/applets/1/4.png)|![img](previews/applets/1/5.png)|

</details>

<details>
<summary><b>Apps</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/2/1.png)|![img](previews/applets/2/2.png)|![img](previews/applets/2/3.png)|![img](previews/applets/2/4.png)|![img](previews/applets/2/5.png)|

</details>

<details>
<summary><b>Battery</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/3/1.png)|![img](previews/applets/3/2.png)|![img](previews/applets/3/3.png)|![img](previews/applets/3/4.png)|![img](previews/applets/3/5.png)|

</details>

<details>
<summary><b>Brightness</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/4/1.png)|![img](previews/applets/4/2.png)|![img](previews/applets/4/3.png)|![img](previews/applets/4/4.png)|![img](previews/applets/4/5.png)|

</details>

<details>
<summary><b>MPD</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/5/1.png)|![img](previews/applets/5/2.png)|![img](previews/applets/5/3.png)|![img](previews/applets/5/4.png)|![img](previews/applets/5/5.png)|

</details>

<details>
<summary><b>Powermenu</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/6/1.png)|![img](previews/applets/6/2.png)|![img](previews/applets/6/3.png)|![img](previews/applets/6/4.png)|![img](previews/applets/6/5.png)|

</details>

<details>
<summary><b>Quicklinks</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/7/1.png)|![img](previews/applets/7/2.png)|![img](previews/applets/7/3.png)|![img](previews/applets/7/4.png)|![img](previews/applets/7/5.png)|

</details>

<details>
<summary><b>Screenshot</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/8/1.png)|![img](previews/applets/8/2.png)|![img](previews/applets/8/3.png)|![img](previews/applets/8/4.png)|![img](previews/applets/8/5.png)|

</details>

<details>
<summary><b>Volume</b></summary>

|Type 1|Type 2|Type 3|Type 4|Type 5|
|--|--|--|--|--|
|![img](previews/applets/9/1.png)|![img](previews/applets/9/2.png)|![img](previews/applets/9/3.png)|![img](previews/applets/9/4.png)|![img](previews/applets/9/5.png)|

</details>

### Powermenus

<details>
<summary><b>Type 1</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/powermenu/type-1/1.png)|![img](previews/powermenu/type-1/2.png)|![img](previews/powermenu/type-1/3.png)|![img](previews/powermenu/type-1/4.png)|![img](previews/powermenu/type-1/5.png)|

</details>

<details>
<summary><b>Type 2</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/powermenu/type-2/1.png)|![img](previews/powermenu/type-2/2.png)|![img](previews/powermenu/type-2/3.png)|![img](previews/powermenu/type-2/4.png)|![img](previews/powermenu/type-2/5.png)|

|Style 6|Style 7|Style 8|Style 9|Style 10|
|--|--|--|--|--|
|![img](previews/powermenu/type-2/6.png)|![img](previews/powermenu/type-2/7.png)|![img](previews/powermenu/type-2/8.png)|![img](previews/powermenu/type-2/9.png)|![img](previews/powermenu/type-2/10.png)|

</details>

<details>
<summary><b>Type 3</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/powermenu/type-3/1.png)|![img](previews/powermenu/type-3/2.png)|![img](previews/powermenu/type-3/3.png)|![img](previews/powermenu/type-3/4.png)|![img](previews/powermenu/type-3/5.png)|

</details>

<details>
<summary><b>Type 4</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/powermenu/type-4/1.png)|![img](previews/powermenu/type-4/2.png)|![img](previews/powermenu/type-4/3.png)|![img](previews/powermenu/type-4/4.png)|![img](previews/powermenu/type-4/5.png)|

</details>

<details>
<summary><b>Type 5</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/powermenu/type-5/1.png)|![img](previews/powermenu/type-5/2.png)|![img](previews/powermenu/type-5/3.png)|![img](previews/powermenu/type-5/4.png)|![img](previews/powermenu/type-5/5.png)|

</details>

<details>
<summary><b>Type 6</b></summary>

|Style 1|Style 2|Style 3|Style 4|Style 5|
|--|--|--|--|--|
|![img](previews/powermenu/type-6/1.png)|![img](previews/powermenu/type-6/2.png)|![img](previews/powermenu/type-6/3.png)|![img](previews/powermenu/type-6/4.png)|![img](previews/powermenu/type-6/5.png)|

</details>

## Usage with other softwares

#### with polybar

You can use these `launchers`, `powermenus` or `applets` with polybar by simply adding a **module** like that:

```ini
;; Application Launcher Module
[module/launcher]
type = custom/text

content = 異
content-background = black
content-foreground = green

click-left = ~/.config/rofi/launchers/type-1/launcher.sh
click-right = launcher_t1

;; Power Menu Module
[module/powermenu]
type = custom/text

content = 襤
content-background = black
content-foreground = red

click-left = ~/.config/rofi/powermenu/type-1/powermenu.sh
click-right = powermenu_t1
```

#### with i3wm

You can also use them with the `keybindings` on your **window manager**, For example:

```bash
set $mod Mod4

bindsym $mod+p exec --no-startup-id ~/.config/rofi/launchers/type-2/launcher.sh
bindsym $mod+x exec --no-startup-id powermenu_t2
```

#### with Openbox

Same thing can be done with `openbox` by adding these lines to **`rc.xml`** file:

```xml
  <keyboard>
    <keybind key="W-p">
      <action name="Execute">
        <command>launcher_t3</command>
      </action>
    </keybind>
    <keybind key="W-x">
      <action name="Execute">
        <command>~/.config/rofi/powermenu/type-3/powermenu.sh</command>
      </action>
    </keybind>
  </keyboard>
```

## Thanks to
- [@davatorium](https://github.com/davatorium) for their awesome [Rofi](https://github.com/davatorium/rofi) software.
- [@adi1090x](https://github.com/adi1090x) for their huge collection of Rofi [launchers](https://github.com/adi1090x/rofi) without which this project wouldn't exist.
- [@olaberglund](https://github.com/olaberglund) for their Rofi launchers [nix derivation](https://github.com/olaberglund/nixos-config/blob/master/pkgs/rofi/package.nix) which was the inspiration for the `flake.nix` file.
