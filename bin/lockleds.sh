#! /bin/bash
case "$(xset q 2>/dev/null | grep LED | sed s/[^1-9]//g)" in
        '1')
        echo "⛶⛶"
        ;;
        '2')
        echo "⛶⛶"
        ;;
        '3')
        echo "🄰⛶"
        ;;
        '4')
        echo "⛶⛶"
        ;;
        '5')
        echo "⛶🄰"
        ;;
        '6')
        echo "⛶"
        ;;
        '7')
        echo "🄰"
        ;;
        *)
        echo "⛶⛶⛶"
esac
