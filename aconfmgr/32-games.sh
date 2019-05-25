# shellcheck disable=SC2148
if [ "$HOSTNAME" == "elisha" ] || [ "$HOSTNAME" == "elizabeth" ]; then
	AddPackage --foreign dwarffortress-ironhand # A single-player fantasy game in which you build a dwarven outpost or play an adventurer in a randomly generated world
	AddPackage --foreign dwarftherapist-git # Heavily modified version of the original Dwarf Therapist.
	AddPackage freeciv # A multiuser clone of the famous Microprose game of Civilization
	AddPackage --foreign minecraft # An open-world game whose gameplay revolves around breaking and placing blocks
	AddPackage stellarium # A stellarium with great graphics and a nice database of sky-objects
fi

if [ "$HOSTNAME" == "elisha" ]; then
	AddPackage --foreign amidst-git # Advanced Minecraft Interface and Data/Structure Tracking
	AddPackage steam # Valve's digital software delivery system
	AddPackage steam-native-runtime # Native replacement for the Steam runtime
	AddPackage stone-soup # Open-source, single-player, role-playing roguelike game of exploration and treasure-hunting
	# AddPackage --foreign tome4 # An open-source, single-player, role-playing roguelike game set in the world of Eyal.
fi
