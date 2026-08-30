# ***eka*** (multiplayer UNO-style card game)

![Flutter](https://img.shields.io/badge/Flutter-3.12%2B-02569B?logo=flutter) ![Dart](https://img.shields.io/badge/Dart-3.12%2B-0175C2?logo=dart) ![Firebase](https://img.shields.io/badge/Firebase-Auth%20%2B%20Firestore-DD2C00?logo=firebase)

A fast-paced multiplayer UNO-style card game built with Flutter and Firebase. Create a room, invite players, and play a real-time match where turns, cards, color choices, and win state are synchronized through Firestore. The card faces and action symbols are custom-drawn in Flutter using `CustomPainter`, giving the game its own stylized card visuals.

> Related project: the offline player-vs-bot version of this game was built first, and the multiplayer version was developed using it as a foundation, sharing the same card visuals and animation patterns. See: https://github.com/kmanojkamath/eka_player_vs_bot_app

## Latest APK

The latest Android build is available here:

- [latest_apk/app-arm64-v8a-release.apk](latest_apk/app-arm64-v8a-release.apk)

This APK will be updated as new builds are produced.

## Screenshots

<div align="center">

### App entry and lobby flow

![Host start screen](screenshots/Start%20Screen%20for%20Host.jpeg)

This is the host-side room setup screen, where the game lobby is created and players join before a match begins.

![Player start screen](screenshots/Start%20Screen%20for%20Player.jpeg)

This view represents the player-side entry flow, where a participant joins a lobby and waits for the host to start the game.

### Match setup and turn flow

![Spin wheel turn picker](screenshots/Spin%20Wheel.jpeg)

The spin-wheel screen determines the starting player and introduces the multiplayer turn-order setup before gameplay begins.

### In-game play

![Current player's turn](screenshots/Game%20Play%20(Current%20Turn).jpeg)

This view shows the local player’s turn with their hand, the active discard pile, and the gameplay state they are currently acting on.

![Opponent turn state](screenshots/Game%20Play%20(Opposite%20Player%20Turn).jpeg)

This image captures the turn flow from another player’s perspective, highlighting the multiplayer board state and the animated card interaction.

</div>

## Key Features

- Real-time multiplayer rooms using Firebase Firestore
- Guest sign-in and Google sign-in flow
- Host-managed lobby with room creation and join flow
- 2 to 6 player matches
- Animated card play, draw pile, and turn-based gameplay
- Custom-rendered UNO cards and symbols built in Flutter with `CustomPainter`
- Full UNO-style action cards: Skip, Reverse, Draw Two, Wild, and Wild Draw Four
- Wild color selection during play
- Game win detection and result screen
- Animated UI for cards, names, timers, and room states

## Tech Stack

| Layer | Technology |
| --- | --- |
| App Framework | Flutter + Dart |
| Backend | Firebase Authentication, Firestore |
| Sign-in | Google Sign-In |
| IDE / Tooling | Flutter SDK, VS Code |
| Platforms | Android, iOS, macOS, Linux, Web |

## How to Play

1. Sign in with Google or continue as a guest.
2. Create a room from the home screen or join an existing room using the room ID.
3. Wait for the host to start the match.
4. Each player receives 7 cards at the start.
5. Match the top card by color or number, or play a Wild card and choose a color.
6. Use action cards to affect the turn order and card flow.
7. First player to empty their hand wins.

## Implemented UNO Mechanics

This project implements the core mechanics found in the game logic and card model:

- Number cards: playable when color or value matches the top card.
- Skip: skips the next player's turn.
- Reverse: changes the turn direction.
- Draw Two: forces the next player to draw two cards and skip their turn.
- Wild: allows the current player to select a color.
- Wild Draw Four: forces the next player to draw four cards and skips their turn.
- Draw from deck when no playable card is available.
- Deck reshuffling when the draw pile is exhausted.
- Turn tracking using persisted room logs in Firestore.
- Win detection when a player has no cards left.

The actual game rules are enforced in the logic under `lib/game/host_logic` and `lib/game/player_logic`.

## Project Architecture

The repository is organized as follows:

```text
.
├── android/                  # Android platform configuration
├── ios/                     # iOS platform configuration
├── linux/                   # Linux platform configuration
├── macos/                   # macOS platform configuration
├── web/                     # Web app assets and entry files
├── lib/
│   ├── animations/          # Card and turn animation logic
│   ├── game/
│   │   ├── host_logic/      # Host-side game flow and rules
│   │   ├── player_logic/    # Client-side turn and log processing
│   │   ├── models/          # Shared card, deck, log, and move models
│   │   └── ...
│   ├── helpers/             # Shared helpers such as colors and names
│   ├── layers/              # UI layers for background, cards, and selectors
│   ├── screens/             # Launch, login, lobby, game, and result screens
│   ├── widgets/             # Card widgets, timers, name plates, and buttons
│   ├── firebase_options.dart
│   ├── google_sign_in.dart
│   └── main.dart
├── test/                    # Flutter tests
├── firebase.json            # Firebase emulator config
├── pubspec.yaml             # Flutter/Dart dependencies
├── analysis_options.yaml    # Lint configuration
├── .firebaserc              # Firebase project aliases
├── README.md
└── ...
```

## Installation and Setup

### Prerequisites

- Flutter SDK (project declares Dart SDK `^3.12.2`)
- Firebase CLI if you want to run the local emulators
- A Firebase project connected to this app

### Install dependencies

```bash
flutter pub get
```

### Firebase setup

This project includes Firebase configuration files and emulator settings in `firebase.json`. In debug mode, the app automatically points to local Firebase emulators:

- Auth: `10.0.2.2:9099`
- Firestore: `10.0.2.2:8080`

Start the Firebase emulators:

```bash
firebase emulators:start --only auth,firestore
```

If you are using a fresh Firebase project, make sure the app is configured with the correct `google-services.json` and Firebase options for your platform.

## How to Run

From the project root:

```bash
flutter run
```

For a specific platform:

```bash
flutter run -d android
flutter run -d ios
flutter run -d web
```

## Build Instructions

### Android

```bash
flutter build apk
```

### Web

```bash
flutter build web
```

### iOS / macOS

```bash
flutter build ios
flutter build macos
```

> This project includes native platform folders for Android, iOS, macOS, Linux, and Web, so the standard Flutter build commands above are the relevant ones for deployment.

## Future Improvements

These are reasonable next steps that are not already implemented in the current codebase:

- Better reconnect and recovery flow for dropped players (Penalty System)
- Real-time lobby chat or ready-check system
- Emoji reactions and player status indicators
- Sound effects and background music
- Match history and persistent leaderboard
- Improved matchmaking and room list UI
- Offline fallback / local simulation mode

## Contributing

Contributions are welcome. To contribute:

1. Fork the repository.
2. Create a feature branch.
3. Make your changes in a focused, well-tested way.
4. Run the relevant Flutter validation commands.
5. Open a pull request with a clear summary of the change.

Example:

```bash
git checkout -b feature/my-improvement
flutter test
```

## License

This project is licensed under the [MIT License](LICENSE).

---

This project is a Flutter-based UNO-style multiplayer game with Firebase-backed room synchronization and turn logic. It is best understood as a real-time card game prototype focused on the game flow and multiplayer experience rather than a fully production-ready game platform.
