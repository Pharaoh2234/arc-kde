#!/bin/sh

set -e

gh_repo="arc-kde"
gh_desc="Arc KDE customization"

cat <<- EOF

    AA  RRRR   CCC     K  K DDD  EEEE 
   A  A R   R C        K K  D  D E    
   AAAA RRRR  C        KK   D  D EEE  
   A  A R R   C        K K  D  D E    
   A  A R  RR  CCC     K  K DDD  EEEE

  $gh_desc
  https://github.com/PapirusDevelopmentTeam/$gh_repo


EOF

temp_dir=$(mktemp -d)

echo "=> Getting the latest version from GitHub ..."
wget -O "/tmp/$gh_repo.tar.gz" \
  https://github.com/PapirusDevelopmentTeam/$gh_repo/archive/master.tar.gz
echo "=> Unpacking archive ..."
tar -xzf "/tmp/$gh_repo.tar.gz" -C "$temp_dir"
echo "=> Deleting old $gh_desc ..."
rm -rf ~/.local/share/aurorae/themes/Arc
rm -rf ~/.local/share/aurorae/themes/Arc-Dark
rm -rf ~/.local/share/aurorae/themes/Arc-Transparent
rm -rf ~/.local/share/aurorae/themes/Arc-Dark-Transparent
rm -f ~/.local/share/color-schemes/Arc.colors
rm -f ~/.local/share/color-schemes/ArcDark.colors
rm -f ~/.local/share/konsole/Arc.colorscheme
rm -f ~/.local/share/konsole/ArcDark.colorscheme
rm -rf ~/.config/Kvantum/Arc
rm -rf ~/.config/Kvantum/ArcDark
rm -rf ~/.config/Kvantum/ArcDarkTransparent
rm -rf ~/.config/Kvantum/ArcTransparent
rm -rf ~/.local/share/plasma/desktoptheme/Arc-Dark
rm -rf ~/.local/share/plasma/look-and-feel/com.github.varlesh.arc-dark
rm -rf ~/.local/share/wallpapers/Arc
rm -rf ~/.local/share/wallpapers/Arc-Dark
rm -rf ~/.local/share/yakuake/kns_skins/arc
rm -rf ~/.local/share/yakuake/kns_skins/arc-dark
echo "=> Installing ..."
mkdir -p ~/.local/share
cp --no-preserve=mode,ownership -r \
  "$temp_dir/$gh_repo-master/aurorae" \
  "$temp_dir/$gh_repo-master/color-schemes" \
  "$temp_dir/$gh_repo-master/konsole" \
  "$temp_dir/$gh_repo-master/plasma" \
  "$temp_dir/$gh_repo-master/wallpapers" \
  "$temp_dir/$gh_repo-master/yakuake" \
  ~/.local/share/
cp --no-preserve=mode,ownership -r "$temp_dir/$gh_repo-master/Kvantum" ~/.config/
echo "=> Clearing cache ..."
rm -rf "/tmp/$gh_repo.tar.gz" "$temp_dir" \
  ~/.cache/plasma-svgelements-Arc-Dark* \
  ~/.cache/plasma_theme_Arc-Dark.kcache
echo "=> Done!"
