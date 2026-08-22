# Stream Prep iPhone App

Native SwiftUI app for managing stream entrances, conversation topics, chat games, and exits.

## Features
- Four complete content banks from the supplied notes
- Live Mode that surfaces one Entrance, Topic, Game, and Exit at a time
- Random Pick from unused items
- Mark Used / Undo Used
- Used items dim and strike through in the Library
- Reset Session for the next stream
- Favorites
- Search
- Full detail cards for prepared bits
- Exit LONG vs SHORT labels
- Game Top 5 labels
- Offline local persistence with UserDefaults

## Build an unsigned IPA for Sideloadly / AltStore

This repo includes `.github/workflows/build-ipa.yml`. Push it to a GitHub repository, then run the **Build unsigned IPA** workflow. Download the `StreamPrep-unsigned-ipa` artifact and sideload/sign it with your preferred tool.

The app targets iOS 16+ and iPhone.
