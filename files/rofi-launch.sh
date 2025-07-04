#!/usr/bin/env bash

dir="$HOME/.config/rofi"

# Error handling
set -e

list_options() {
  local path="$1"
  echo "Available $2:"
  find "$path" -mindepth 1 -maxdepth 1 -exec basename {} \; | sed -E 's/\.(rasi|sh)$//'
}

error() {
  echo -e "Error: $1\n" >&2
  [[ -n "$2" ]] && list_options "$2" "$3"
  exit 1
}

usage_bin() {
  error "Usage: --bin <script> <type> <style> [app-name]" "$1" "$2"
}

usage_theme() {
  error "Usage: --theme <color> <font-name> <font-size>" "$1" "$2"
}

usage_theme_msg() {
  echo "Usage: --theme <color> <font-name> <font-size>"
  echo "$1"
  exit 1
}


show_help() {
  cat << EOF
Usage: $0 --bin <script> <type> <style> [app-name] --theme <color> <font-name> <font-size>

Options:
  --bin      Specify the script, type, style and optional app name to run.
  --theme    Specify the color theme, font name, and font size.
  --help     Show this help message and exit.

Examples:
  $0 --bin launchers type-1 style-1 --theme gruvbox "JetBrains Mono Nerd Font" 11
  $0 --bin powermenus type-1 style-1 --theme onedark "Iosevka Nerd Font" 12
EOF
  exit 0
}

validate_dir() {
  [[ -d "$1" ]] || error "$2" "$3" "$4"
}

validate_file() {
  [[ -f "$1" ]] || error "$2" "$3" "$4"
}

# Parse args
bin=""
script=""
type=""
style=""
color=""
font_name=""
font_size=""

if [[ $# -eq 0 ]]; then
  show_help
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)
      show_help
      ;;
    --bin)
      shift
      script="${1-}"
      type="${2-}"
      style="${3-}"

      if [[ -z "$script" ]]; then
        usage_bin "$dir/scripts" "scripts"
      fi
      if [[ -z "$type" ]]; then
        usage_bin "$dir/scripts/$script" "$script > types"
      fi
      if [[ -z "$style" ]]; then
        usage_bin "$dir/scripts/$script/$type" "$script > $type > styles"
      fi

      script="$1"; type="$2"; style="$3"
      shift 3

      if [[ $# -gt 0 && "$1" != --* ]]; then
        bin="$1"
        shift
      fi
      ;;
    --theme)
      shift

      color="${1-}"
      font_name="${2-}"
      font_size="${3-}"

      if [[ -z "$color" ]]; then
        usage_theme "$dir/assets/colors" "colors"
      fi
      if [[ -z "$font_name" ]]; then
        usage_theme_msg "Missing font name."
      fi
      if [[ -z "$font_size" ]]; then
        usage_theme_msg "Missing font size."
      fi


      color="$1"; font_name="$2"; font_size="$3"
      shift 3
      ;;
    *)
      error "Unknown argument: $1"
      ;;
  esac
done

if [[ -z "$script" || -z "$type" || -z "$style" || -z "$color" || -z "$font_name" || -z "$font_size" ]]; then
  error "Missing --bin or --theme"
fi

# Paths
script_dir="$dir/scripts/$script"
type_dir="$script_dir/$type"
style_file="$type_dir/$style.rasi"

bin_dir="$script_dir/bin"
bin_file="$bin_dir/$bin.sh"

colors_dir="$dir/assets/colors"
color_file="$colors_dir/$color.rasi"

font="$font_name $font_size"

# Final validations
validate_dir "$script_dir" "Script '$script' not found." "$dir/scripts" "scripts"
validate_dir "$type_dir" "Type '$type' not found in script '$script'." "$script_dir" "types"
validate_file "$style_file" "Style '$style.rasi' not found in type '$type'." "$type_dir" "styles"
if [[ -n "$bin" ]]; then
  validate_file "$bin_file" "App '$bin.sh' not found." "$bin_dir" "apps"
fi
validate_file "$color_file" "Color '$color.rasi' not found." "$colors_dir" "colors"

[[ "$font_size" =~ ^[0-9]+$ ]] || error "Invalid font size: '$font_size'"


# Determine script to execute
bin_path=""

if [[ -x "$type_dir/main.sh" ]]; then
  bin_path="$type_dir/main.sh"
elif [[ -x "$script_dir/bin/default.sh" ]]; then
  bin_path="$script_dir/bin/default.sh"
elif [[ -n "$bin" ]]; then
  bin_path="$bin_file"
else
  error "No valid script found to execute. Tried:
- $type_dir/main.sh
- $script_dir/bin/default.sh
- $script_dir/bin/$bin.sh (if specified)"
fi

# Set environment
export ROFI_LAUNCH_THEME_MAIN="$style_file"
export ROFI_LAUNCH_THEME_COLOR_STR="@import \"$color_file\""
export ROFI_LAUNCH_THEME_FONT_STR="* {font: \"$font\";}"

exec "$bin_path"
