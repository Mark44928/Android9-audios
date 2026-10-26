<h1 align="center">Android 9 Audio Files</h1>

<p align="center">
  <b>📦 217 stock ringtones, alarms, notifications, and UI sounds extracted from Android 9 (Pie) — all in .ogg format.</b>
</p>

<p align="center">
  <a href="https://github.com/Mark44928/Android9-audios/stargazers"><img src="https://img.shields.io/github/stars/Mark44928/Android9-audios?color=f0bd00" alt="Stars"/></a>
  <a href="https://github.com/Mark44928/Android9-audios/network/members"><img src="https://img.shields.io/github/forks/Mark44928/Android9-audios?color=00b8d9" alt="Forks"/></a>
  <a href="https://github.com/Mark44928/Android9-audios/issues"><img src="https://img.shields.io/github/issues/Mark44928/Android9-audios?color=ff6b6b" alt="Issues"/></a>
  <a href="https://github.com/Mark44928/Android9-audios/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Mark44928/Android9-audios?color=blue" alt="License"/></a>
  <img src="https://img.shields.io/badge/Android-9%20(Pie)-green" alt="Android Version"/>
  <img src="https://img.shields.io/badge/files-217-blue" alt="File Count"/>
  <img src="https://img.shields.io/badge/size-~8.7MB-orange" alt="Size"/>
</p>

<div align="center">

[![GitHub Repo](https://img.shields.io/badge/GitHub-Main%20Repository-black?logo=github)](https://github.com/Mark44928/Android9-audios)
[![Platform](https://img.shields.io/badge/platform-Android%209%20(Pie)-green)](https://github.com/Mark44928/Android9-audios)
[![Format](https://img.shields.io/badge/format-OGG-blue)](https://github.com/Mark44928/Android9-audios)
[![Files](https://img.shields.io/badge/files-217-orange)](https://github.com/Mark44928/Android9-audios)
[![Size](https://img.shields.io/badge/size-~8.7MB-red)](https://github.com/Mark44928/Android9-audios)
[![License](https://img.shields.io/badge/license-MIT-blue)](https://github.com/Mark44928/Android9-audios/blob/main/LICENSE)

</div>

---

> **What is this?** A collection of 217 stock `.ogg` audio files extracted from Android 9 (Pie). Use them to restore default ringtones, alarms, notifications, and system sounds on custom ROMs, or as production-ready audio assets in your Android app projects.

**Keywords:** android, audio, ringtones, alarms, notifications, ui-sounds, ogg, sound-assets, android-9, android-pie, custom-rom, android-development, media-files, stock-sounds

## Table of Contents

- [What's Inside](#whats-inside)
- [Download](#download)
- [Installation](#installation)
- [File Listing](#file-listing)
- [Contributing](#contributing)
- [License](#license)

---

## What's Inside

| Category | Count | Description |
|:---|:---|:---|
| **Alarms** | 23 | Wake-up tones — Beep, Argon, Carbon, Helium, Neon, and more |
| **Notifications** | 75 | Alert sounds — Adara, Beat Box, Cricket, Vega, and more |
| **Ringtones** | 102 | Call tones — ANDROMEDA, Backroad, CrazyDream, Hydra, and more |
| **UI Sounds** | 17 | System tones — Dock, Lock, Camera Click, Wireless Charging, and more |
| **Total** | **217** | All files in `.ogg` format at 44.1kHz |

---

## Perfect For

- **Custom ROM developers** restoring stock Android 9 audio assets
- **App developers** needing production-ready `.ogg` notification and alarm sounds
- **Theming enthusiasts** rebuilding system sound packages
- **AOSP contributors** working on media and audio integration

---

## Download

[Download the archive (8.7 MB)](https://github.com/Mark44928/Android9-audios/raw/main/audios%20from%20Android%209.7z)

Verify the download (optional):

```bash
sha256sum "audios from Android 9.7z"
# 8f175277be1444a6b7b79f288d14ae9302f7b34f55a0bbba5f80d13ea6973742
```

The checksum is also in [`SHA256SUMS.txt`](SHA256SUMS.txt).

Extract the archive with 7-Zip (`pkg install 7zip` on Termux, `7z x` on Linux/Windows):

```bash
7z x "audios from Android 9.7z"
# creates audio/alarms, audio/notifications, audio/ringtones, audio/ui
```

---

## Installation

### On a rooted Android device

1. Extract the `.7z` archive (see above)
2. Push the files to your system partition:

```bash
# Remount system as read-write
adb root
adb remount

# Push all audio files
adb push audio/alarms/ /system/media/audio/alarms/
adb push audio/notifications/ /system/media/audio/notifications/
adb push audio/ringtones/ /system/media/audio/ringtones/
adb push audio/ui/ /system/media/audio/ui/

# Reboot
adb reboot
```

### On a custom ROM

1. Extract the `.7z` archive
2. Copy the desired files to your ROM's `system/media/audio/` directory before flashing

### As a developer

Use these `.ogg` files as placeholder or default sounds in your Android app projects.

---

## File Listing

<details>
<summary><b>Alarms (23 files)</b></summary>

Alarm_Beep_01.ogg, Alarm_Beep_02.ogg, Alarm_Beep_03.ogg, Alarm_Buzzer.ogg, Alarm_Classic.ogg, Alarm_Rooster_02.ogg, Argon.ogg, Barium.ogg, Carbon.ogg, Cesium.ogg, Fermium.ogg, Hassium.ogg, Helium.ogg, Krypton.ogg, Neon.ogg, Neptunium.ogg, Nobelium.ogg, Osmium.ogg, Oxygen.ogg, Platinum.ogg, Plutonium.ogg, Promethium.ogg, Scandium.ogg

</details>

<details>
<summary><b>Notifications (75 files)</b></summary>

Adara.ogg, Aldebaran.ogg, Altair.ogg, Alya.ogg, Antares.ogg, Antimony.ogg, Arcturus.ogg, Argon.ogg, Beat_Box_Android.ogg, Bellatrix.ogg, Beryllium.ogg, Betelgeuse.ogg, CaffeineSnake.ogg, Canopus.ogg, Capella.ogg, Castor.ogg, CetiAlpha.ogg, Cobalt.ogg, Cricket.ogg, DearDeer.ogg, Deneb.ogg, Doink.ogg, DontPanic.ogg, Drip.ogg, Electra.ogg, F1_MissedCall.ogg, F1_New_MMS.ogg, F1_New_SMS.ogg, Fluorine.ogg, Fomalhaut.ogg, Gallium.ogg, Heaven.ogg, Helium.ogg, Highwire.ogg, Hojus.ogg, Iridium.ogg, Krypton.ogg, KzurbSonar.ogg, Lalande.ogg, Merope.ogg, Mira.ogg, OnTheHunt.ogg, Palladium.ogg, Plastic_Pipe.ogg, Polaris.ogg, Pollux.ogg, Procyon.ogg, Proxima.ogg, Radon.ogg, Rubidium.ogg, Selenium.ogg, Shaula.ogg, Sirrah.ogg, SpaceSeed.ogg, Spica.ogg, Strontium.ogg, Syrma.ogg, TaDa.ogg, Talitha.ogg, Tejat.ogg, Thallium.ogg, Tinkerbell.ogg, Upsilon.ogg, Vega.ogg, Voila.ogg, Xenon.ogg, Zirconium.ogg, arcturus.ogg, moonbeam.ogg, pixiedust.ogg, pizzicato.ogg, regulus.ogg, sirius.ogg, tweeters.ogg, vega.ogg

</details>

<details>
<summary><b>Ringtones (102 files)</b></summary>

ANDROMEDA.ogg, Andromeda.ogg, Aquila.ogg, ArgoNavis.ogg, Atria.ogg, BOOTES.ogg, Backroad.ogg, BeatPlucker.ogg, BentleyDubs.ogg, Big_Easy.ogg, BirdLoop.ogg, Bollywood.ogg, BussaMove.ogg, CANISMAJOR.ogg, CASSIOPEIA.ogg, Cairo.ogg, Calypso_Steel.ogg, CanisMajor.ogg, CaribbeanIce.ogg, Carina.ogg, Centaurus.ogg, Champagne_Edition.ogg, Club_Cubano.ogg, CrayonRock.ogg, CrazyDream.ogg, CurveBall.ogg, Cygnus.ogg, DancinFool.ogg, Ding.ogg, DonMessWivIt.ogg, Draco.ogg, DreamTheme.ogg, Eastern_Sky.ogg, Enter_the_Nexus.ogg, Eridani.ogg, EtherShake.ogg, FreeFlight.ogg, FriendlyGhost.ogg, Funk_Yall.ogg, GameOverGuitar.ogg, Gimme_Mo_Town.ogg, Girtab.ogg, Glacial_Groove.ogg, Growl.ogg, HalfwayHome.ogg, Hydra.ogg, InsertCoin.ogg, Kuma.ogg, LoopyLounge.ogg, LoveFlute.ogg, Lyra.ogg, Machina.ogg, MidEvilJaunt.ogg, MildlyAlarming.ogg, Nairobi.ogg, Nassau.ogg, NewPlayer.ogg, No_Limits.ogg, Noises1.ogg, Noises2.ogg, Noises3.ogg, OrganDub.ogg, Orion.ogg, PERSEUS.ogg, Paradise_Island.ogg, Pegasus.ogg, Perseus.ogg, Playa.ogg, Pyxis.ogg, Rasalas.ogg, Revelation.ogg, Rigel.ogg, Ring_Classic_02.ogg, Ring_Digital_02.ogg, Ring_Synth_02.ogg, Ring_Synth_04.ogg, Road_Trip.ogg, RomancingTheTone.ogg, Safari.ogg, Savannah.ogg, Scarabaeus.ogg, Sceptrum.ogg, Seville.ogg, Shes_All_That.ogg, SilkyWay.ogg, SitarVsSitar.ogg, Solarium.ogg, SpringyJalopy.ogg, Steppin_Out.ogg, Terminated.ogg, Testudo.ogg, Themos.ogg, Third_Eye.ogg, Thunderfoot.ogg, TwirlAway.ogg, URSAMINOR.ogg, UrsaMinor.ogg, VeryAlarmed.ogg, Vespa.ogg, World.ogg, Zeta.ogg, hydra.ogg

</details>

<details>
<summary><b>UI Sounds (17 files)</b></summary>

Dock.ogg, Effect_Tick.ogg, KeypressDelete.ogg, KeypressInvalid.ogg, KeypressReturn.ogg, KeypressSpacebar.ogg, KeypressStandard.ogg, Lock.ogg, LowBattery.ogg, Trusted.ogg, Undock.ogg, Unlock.ogg, VideoRecord.ogg, VideoStop.ogg, WirelessChargingStarted.ogg, camera_click.ogg, camera_focus.ogg

</details>

---

## Contributing

Found a missing file or want to add audio from another Android version? Open a PR or [submit an issue](https://github.com/Mark44928/Android9-audios/issues).

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

> **Note:** These audio files are stock Android assets. They are provided as-is for reference and development purposes.

---

## You Might Also Like

| Repository | Description |
|:--:|:--|
| [NoNameOS](https://github.com/Mark44928/NoNameOS) | Pure C++ hobbyist OS simulation |
| [Anti-Bloatware List](https://github.com/Mark44928/Anti-bloatware-list-for-Android-TV-Boxes-and-Sticks-for-rooted) | Debloat rooted Android TV sticks |
| [SnakTUI](https://github.com/Mark44928/SnakTUI) | Neon terminal Snake game built with Python + Textual |
| [Grub Blasters](https://github.com/Mark44928/GrubBlastersHTML) | Single-file Worms-style artillery game |
| [CalculaHTML](https://github.com/Mark44928/CalculaHTML) | Modern calculator PWA with 14 themes |

---

<p align="center">
  <i>Classic Android 9 sounds, preserved and organized.</i>
</p>
