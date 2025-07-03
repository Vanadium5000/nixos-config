{pkgs, ...}: let
  rofi-config = pkgs.writeTextFile {
    name = "rofi-config.rasi";
    text = ''
      @import "~/.config/rofi/config.rasi"

      /* ---- Configuration ---- */
      window {
        width: 60%;
      }

      /* ---- Imagebox ---- */
      imagebox {
        orientation: vertical;
        children:
          [ "entry", "listbox"];
      }

      /* ---- Listview ---- */
      listview {
        columns: 4;
        lines: 3;
      }

      /* ---- Element ---- */
      element {
        orientation: vertical;
        padding: 0px;
        spacing: 0px;
      }

      element-icon {
        size: 20%;
      }
    '';
  };
  rofi-wallpaper-selector = pkgs.writeShellScriptBin "rofi-wallpaper-selector" ''
    # Kill Rofi if already running
    if pgrep -x "rofi" >/dev/null; then
      pkill rofi
      echo "Rofi already running, exitting"
      exit 0
    fi

    # WALLPAPERS PATH
    if [[ -n "$1" ]]; then
        wallDIR=$1
    else
        echo "Enter the dir path to the wallpapers"
        exit 1
    fi

    # Retrieve image files using null delimiter to handle spaces in filenames
    mapfile -d "" PICS < <(find "''${wallDIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

    RANDOM_PIC="''${PICS[$((RANDOM % ''${#PICS[@]}))]}"
    RANDOM_PIC_NAME=". random"

    # Rofi command
    rofi_command="rofi -dmenu -p 'Select Wallpaper' -config ${rofi-config}"

    # Sorting Wallpapers
    menu() {
    	# Sort the PICS array
    	IFS=$'\n' sorted_options=($(sort <<<"''${PICS[*]}"))

    	# Place ". random" at the beginning with the random picture as an icon
    	printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"

    	for pic_path in "''${sorted_options[@]}"; do
    		pic_name=$(basename "$pic_path")

    		# Displaying .gif to indicate animated images
    		if [[ ! "$pic_name" =~ \.gif$ ]]; then
    			printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
    		else
    			printf "%s\n" "$pic_name"
    		fi
    	done
    }

    # Choice of wallpapers
    main() {
    	choice=$(menu | $rofi_command)

    	# Trim any potential whitespace or hidden characters
    	choice=$(echo "$choice" | xargs)
    	RANDOM_PIC_NAME=$(echo "$RANDOM_PIC_NAME" | xargs)

    	# No choice case
    	if [[ -z "$choice" ]]; then
    		echo "No choice selected. Exiting."
    		exit 0
    	fi

    	# Random choice case
    	if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    		result="$RANDOM_PIC"
    		return
    	fi

    	# Find the index of the selected file
    	pic_index=-1
    	for i in "''${!PICS[@]}"; do
    		filename=$(basename "''${PICS[$i]}")
    		if [[ "$filename" == "$choice"* ]]; then
    			pic_index=$i
    			break
    		fi
    	done

    	if [[ $pic_index -ne -1 ]]; then
    		result="''${PICS[''$pic_index]}"
    	else
    		echo "Image not found."
    		exit 1
    	fi
    }

    # Check if rofi is already running
    if pidof rofi >/dev/null; then
    	pkill rofi
    	sleep 1 # Allow some time for rofi to close
    fi

    main

    echo "$result"
    swww img "$result"
    cp -f "$result" ~/.current_wallpaper # For rofi wallpaper
  '';
in {
  home.packages = [rofi-wallpaper-selector];
}
