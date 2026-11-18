# Rise Insta

iOS Theos tweak built from scratch for Instagram.

## Prototype scope (0.1)
- Native grouped-settings menu presented as a compact iOS sheet
- 11 categories including Downloads, Ghost, Messages, Reels, Comments, Profile, AI, Customization, Account Features, Developer & Employee, Diagnostics
- Full **feature catalog** in the UI: unfinished options explicitly say "Not connected — needs an Instagram hook" instead of falsely claiming they work
- Read-only Objective-C runtime class/selector report, shareable to Files/AirDrop
- Open Rise Insta by holding **three fingers** on the Instagram screen for ~0.8 seconds (no floating button). Replace with a native profile/settings entry after diagnosis
- Namespaced project-owned classes and keys use RiseInsta, not Beegram

## Not yet implemented
Instagram-specific downloading, Photos export, actual account eligibility scanning, feature toggles, Ghost Mode, voice recording and API integrations. The source does not grant employee access or change Instagram server-controlled features. View-once restrictions are not bypassed.

## Build
Requires Theos, appropriate iOS SDK and signing/packaging:
```sh
make package
```
No compilation or on-device testing has been performed here yet. The GitHub repository contains source, **not a compiled .dylib**.

## Diagnostics
Open any Instagram page, hold 3 fingers, then tap Diagnostics → Export Runtime Classes. The report also includes a bounded foreground view tree (class names, frames and visibility, no view text). The user should review the report before sharing.\n\nTap **Diagnostics → Export Runtime Classes**. Output contains class and method names filtered by Instagram-style prefixes only, capped for memory/runtime safety; it does not intentionally export user account data, message text, passwords, or network tokens.
