# Rise Insta — installation & menu diagnostics (Instagram 456.0.0)

## Expected entry points in this build
- Temporary **RI** magenta circle near top-left: a visible indicator the library bootstrap reached the foreground key window.
- **Hold three fingers** for 0.8 seconds.
- Fallback: **double-tap with three fingers**.
- Tap **RI** to open the compact Rise Insta bottom sheet.

## If Instagram opens but there is no RI indicator
A successful compile does **not** prove the library loaded. Check:

1. Confirm the new artifact was used (not an old dylib), and re-sign/reinstall the exact modified IPA.
2. Confirm **CFBundleIdentifier** in the installed `Instagram.app/Info.plist`; the Theos injection filter currently uses `com.burbn.instagram`. If a signing tool changed the app identifier, this filter will not match a jailbreak-style injection.
3. If directly sideloading a modified IPA rather than installing a jailbreak tweak, confirm that the Mach-O executable actually references the dylib, that its path is correct, and that all of the dylib's linked dependencies are loadable. Dropping a dylib file into the IPA without a loader does nothing.
4. If using jailbreak injection, check whether the installed environment loads the appropriate Theos/rootless package and its `RiseInsta.plist` bundle filter.
5. If the app is killed immediately, capture device crash logs; a signing or missing dynamic library error occurs before the menu code runs.

## If RI appears but the menu does not
- Tap RI first. This bypasses gesture conflicts in Instagram.
- Capture a screenshot and the console/crash log.
- If the bottom sheet fails, UIKit presentation context or a custom view controller may be blocking presentation.

## Runtime report
After the menu opens, visit **Diagnostics → Export Runtime Classes** and send the resulting text file. It lists matching runtime class/selector names and a capped view hierarchy with class names and geometry, and includes the actual installed app version and bundle identifier. The report does not deliberately read views' text, messages or token values.

## Current limits
No Instagram-specific media hooks, server-side account privileges, privacy bypasses, or View Once saving implementation are present. Feature catalog entries are placeholders until verified for this exact build.
