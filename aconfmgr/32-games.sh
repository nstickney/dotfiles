# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" ]]
then
    AddPackage freeciv # A multiuser clone of the famous Microprose game of Civilization
    AddPackage jre8-openjdk # OpenJDK Java 9 full runtime environment
    AddPackage mumble # A voice chat application similar to TeamSpeak
    AddPackage steam # Valve's digital software delivery system
    AddPackage steam-native-runtime # Native replacement for the Steam runtime
    AddPackage stone-soup # Open-source, single-player, role-playing roguelike game of exploration and treasure-hunting

    AddPackage --foreign discord #
    AddPackage --foreign dwarffortress-ironhand # A single-player fantasy game in which you build a dwarven outpost or play an adventurer in a randomly generated world
    AddPackage --foreign dwarftherapist-git # Heavily modified version of the original Dwarf Therapist.
    AddPackage --foreign minecraft # An open-world game whose gameplay revolves around breaking and placing blocks
    # AddPackage --foreign runescape-launcher # RuneScape Game Client (NXT)
    # AddPackage --foreign terasology # Yet another high resolution game with blocks like Minecraft!
    AddPackage --foreign tome4 # An open-source, single-player, role-playing roguelike game set in the world of Eyal.
    # AddPackage --foreign wolfenstein3d # Wolfenstein 3D, cult first person shooter video game from id Software and Apogee
fi
