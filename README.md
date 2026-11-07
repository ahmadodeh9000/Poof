# Poof

Poof is a tiny Mac app that hides your desktop icons and the Dock with one click. It's handy before a Zoom call or screen share, so people see a clean screen instead of your cluttered desktop.

## How to use it

1. Click the eye icon in the menu bar (top right of your screen).
2. Choose **Hide Everything**. Your desktop icons disappear and the Dock tucks away.
3. When you're done, click the icon again and choose **Show Everything**.

Good to know:

- Any open Finder windows close for a moment when icons are hidden or shown. That's normal.
- Quitting Poof puts everything back the way it was.

## Download & install

1. Download **Poof.zip** from the [Releases page](https://github.com/USERNAME/Poof/releases).
2. Double-click the zip to unzip it, then drag **Poof.app** into your **Applications** folder.
3. Open Poof. The first time, macOS will block it with a warning. This is expected: Poof isn't notarized by Apple, which is common for small free apps. To allow it:
   - Click **Done** on the warning.
   - Open **System Settings → Privacy & Security**.
   - Scroll down and click **Open Anyway** next to the message about Poof, then confirm.

   You only need to do this once.
4. Look for the eye icon in your menu bar. Poof has no window and no Dock icon; it lives up there.

## Requirements

macOS 26.5 or later.

## Build from source

1. Clone this repository.
2. Open `Poof.xcodeproj` in Xcode.
3. Press **Run**.

## Uninstall

1. Click the eye icon and choose **Quit**.
2. Drag Poof from your Applications folder to the Trash.

## Author

Ahmad Odeh
