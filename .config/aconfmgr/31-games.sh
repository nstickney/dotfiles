if grep -v -q microsoft /proc/version; then
	AddPackage --foreign airshipper-git         # The official launcher for Veloren - an open-world, open-source multiplayer voxel RPG
	AddPackage --foreign amidst-git             # Advanced Minecraft Interface and Data/Structure Tracking
	AddPackage asciiquarium                     # An aquarium/sea animation in ASCII art
	AddPackage --foreign dwarffortress-ironhand # A single-player fantasy game in which you build a dwarven outpost or play an adventurer in a randomly generated world
	AddPackage --foreign dwarftherapist-git     # Heavily modified version of the original Dwarf Therapist.
	AddPackage freeciv                          # A multiuser clone of the famous Microprose game of Civilization
	AddPackage --foreign minecraft-launcher     # Official Minecraft Launcher
	AddPackage --foreign ninvaders              # Ncurses based space invaders clone
	AddPackage steam                            # Valve's digital software delivery system
	AddPackage --foreign steam-fonts            # Fonts to fix scrambled or missing text in steam menus
	AddPackage steam-native-runtime             # Native replacement for the Steam runtime using system libraries
	AddPackage stellarium                       # A stellarium with great graphics and a nice database of sky-objects
	AddPackage stone-soup                       # Open-source, single-player, role-playing roguelike game of exploration and treasure-hunting
	AddPackage --foreign tome4                  # An open-source, single-player, role-playing roguelike game set in the world of Eyal.

	CreateLink /opt/minecraft-launcher/swiftshader/libEGL.so /lib64/libEGL.so
	CreateLink /opt/minecraft-launcher/swiftshader/libGLESv2.so /lib64/libGLESv2.so
fi
