#!/bin/sh
# ------------------------------------------------------------
# fetch file
# ------------------------------------------------------------
function fetch() {
  if echo $1 | grep '^https\?://'; then
    curl -o "$2" "$1"
  else
    cp "$1" "$2"
  fi
}
# ------------------------------------------------------------
# sips utils
# ------------------------------------------------------------
function to_png() {
  echo "Convert to png: $1 => $2"
  sips -s format png "$1" --out "$2" || exit 1
}

function resize() {
  sips -Z $1 "$2" -p $1 $1 --padColor FFFFFF --out "$3" || exit 1
}

# ------------------------------------------------------------
# create a icon
# ------------------------------------------------------------
function parse_size() {
  if [[ $1 == Small ]]; then
    echo 29
  else
    echo $1
  fi
}

function icon() {
  src=$1
  path=$2
  size=$3
  scale=$4
  actual_size=$(echo $(parse_size $size) \* $scale | bc)

  if [[ $scale == 1 ]]; then
    name="Icon-${size}.png"
  else
    name="Icon-${size}@${scale}x.png"
  fi

  resize $actual_size $src "${path}/${name}"
}

# ------------------------------------------------------------
# create appiconset
# ------------------------------------------------------------
function appiconset_ios() {
  image=$1
  path=$2

  icon "$image" "$path" 40 1
  icon "$image" "$path" 40 2
  icon "$image" "$path" 40 3

  icon "$image" "$path" 60 2
  icon "$image" "$path" 60 3

  icon "$image" "$path" 76 1
  icon "$image" "$path" 76 2

  icon "$image" "$path" Small 1
  icon "$image" "$path" Small 2
  icon "$image" "$path" Small 3
}

function appiconset_watchos() {
  image=$1
  path=$2

  icon "$image" "$path" 24 2
  icon "$image" "$path" 27.5 2
  icon "$image" "$path" 29 2
  icon "$image" "$path" 29 3

  icon "$image" "$path" 40 2
  icon "$image" "$path" 44 2
  icon "$image" "$path" 86 2
  icon "$image" "$path" 98 2
}

function main() {
  tmp="$$.$(basename $1)"
  png=$$.app_icon.tmp.png

  fetch $1 $tmp

  # convert to png
  to_png $tmp  $png

  # copy placeholder
  cp $png "Shinchoku WatchKit App/image.png"

  # create iconset
  appiconset_ios $png './Shinchoku/ASsets.xcassets/AppIcon.appiconset'
  appiconset_watchos $png './Shinchoku WatchKit App/ASsets.xcassets/AppIcon.appiconset'

  # cleanup
  rm -rf $png $tmp
}

main $@
