<h1 align="center">Android 9 Audio Files</h1>

<p align="center">
  <b>Stock ringtones, alarms, notifications, and UI sounds from Android 9 (Pie).</b>
</p>

<p align="center">
  <a href="https://github.com/Mark44928/Android9-audios/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Mark44928/Android9-audios?color=blue" alt="License"/></a>
  <img src="https://img.shields.io/badge/Android-9%20(Pie)-green" alt="Android Version"/>
  <img src="https://img.shields.io/badge/files-217-blue" alt="File Count"/>
  <img src="https://img.shields.io/badge/size-~8.3MB-orange" alt="Size"/>
</p>

---

> **What is this?** A collection of 217 stock `.ogg` audio files extracted from Android 9 (Pie). Use them to restore default sounds on custom ROMs, or as a resource for app development.

---

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
| Alarms | 21 | Wake-up tones (Beep, Argon, Carbon, Helium, etc.) |
| Notifications | 83 | Alert sounds (Adara, Beat Box, Cricket, etc.) |
| Ringtones | 97 | Call tones (ANDROMEDA, Backroad, CrazyDream, etc.) |
| UI Sounds | 16 | System sounds (Dock, Lock, camera click, etc.) |
| **Total** | **217** | All files in `.ogg` format |

---

## Download

[Download the archive (8.7 MB)](https://github.com/Mark44928/Android9-audios/raw/main/audios%20from%20Android%209.7z)

---

## Installation

### On a rooted Android device

1. Extract the `.7z` archive
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

### Alarms (21 files)

| Filename |
|:---|
| Alarm_Beep_01.ogg |
| Alarm_Beep_02.ogg |
| Alarm_Beep_03.ogg |
| Alarm_Classic.ogg |
| Alarm_Rooster_02.ogg |
| Argon.ogg |
| Carbon.ogg |
| Falcon.ogg |
| Helium.ogg |
| Krypton.ogg |
| Neon.ogg |
| Nitrogen.ogg |
| Osmium.ogg |
| Platinum.ogg |
| Promethium.ogg |
| Rhodium.ogg |
| Scandium.ogg |
| Titanium.ogg |
| Xenon.ogg |

### Notifications (83 files)

| Filename |
|:---|
| Adara.ogg |
| Altair.ogg |
| Arcturus.ogg |
| Aurora.ogg |
| Beat_Box_Android.ogg |
| Betelgeuse.ogg |
| Canopus.ogg |
| Ceti_Alpha.ogg |
| Corona.ogg |
| Cricket.ogg |
| Deneb.ogg |
| Donut.ogg |
| Eridani.ogg |
| Filboid Studge.ogg |
| Heisenberg.ogg |
| Io.ogg |
| LowBattery.ogg |
| MagicConch.ogg |
| Mira.ogg |
| Moto.ogg |
| OnTheHunt.ogg |
| Pollen.ogg |
| Procyon.ogg |
| Rigel.ogg |
| Sasquatch.ogg |
| Sceptrum.ogg |
| Shaula.ogg |
| Spica.ogg |
| TauCeti.ogg |
| TinyMech.ogg |
| Triton.ogg |
| Ultraviolet.ogg |
| Vega.ogg |

### Ringtones (97 files)

| Filename |
|:---|
| ANDROMEDA.ogg |
| Andromeda.ogg |
| Arcturus.ogg |
| Backroad.ogg |
| Becoming.ogg |
| BlueIceCream.ogg |
| BrightMorning.ogg |
| Cantina.ogg |
| Chasing.ogg |
| CrazyDream.ogg |
| CreativeTouch.ogg |
| DancinFever.ogg |
| DontPanic.ogg |
| EarlyMorning.ogg |
| Ethereal.ogg |
| Fantasy.ogg |
| Flutey_Phone.ogg |
| Frostbite.ogg |
| Globetrotter.ogg |
| Goliath.ogg |
| HappyAlert.ogg |
| HappySpark.ogg |
| HappyStrum.ogg |
| Highwire.ogg |
| Hydra.ogg |
| hydra.ogg |
| Illuminata.ogg |
| Incoming.ogg |
| Kalimba.ogg |
| KungFu.ogg |
| LoveTrance.ogg |
| MagicAlarm.ogg |
| Mellotron.ogg |
| MidnightBoogie.ogg |
| Money.ogg |
| MoreSpace.ogg |
| MorningFlower.ogg |
| Morse.ogg |
| Nassage.ogg |
| Netsky.ogg |
| NewPlayer.ogg |
| NoProblem.ogg |
| NoisyNeighbor.ogg |
| Nyan.ogg |
| OpenUp.ogg |
| ParadiseCity.ogg |
| Payphone.ogg |
| Phonic.ogg |
| Pixiedust.ogg |
| PixieDust.ogg |
| Plumbing.ogg |
| Rainbow.ogg |
| RedWine.ogg |
| ReRe.ogg |
| Rockin.ogg |
| Romancing.ogg |
| SaltyDog.ogg |
| Saxobeat.ogg |
| SchedulingTheFuture.ogg |
| Seek.ogg |
| StarCommand.ogg |
| Steamy.ogg |
| Stepping.ogg |
| Sunlight.ogg |
| SweetSweetSugar.ogg |
| Tank.ogg |
| TeaTime.ogg |
| TheBigAdventure.ogg |
| TheClang.ogg |
| Thunderbird.ogg |
| Triste.ogg |
| Turbocharge.ogg |
| Twilight.ogg |
| Ultramarine.ogg |
| VeryAlarmed.ogg |
| Victory.ogg |
| Waltz.ogg |
| Wither.ogg |

### UI Sounds (16 files)

| Filename |
|:---|
| Boom.ogg |
| CameraClick.ogg |
| Dock.ogg |
| Ercig.ogg |
| InCall.ogg |
| KeypressDelete.ogg |
| KeypressReturn.ogg |
| KeypressStandard.ogg |
| KeypressSpacebar.ogg |
| KeypressWrong.ogg |
| Lock.ogg |
| LowBattery.ogg |
| NumpadClick.ogg |
| Unavailable.ogg |
| Unlock.ogg |
| WirelessChargingStarted.ogg |

---

## Contributing

Found a missing file or want to add audio from another Android version? Open a PR or [submit an issue](https://github.com/Mark44928/Android9-audios/issues).

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

> **Note:** These audio files are stock Android assets. They are provided as-is for reference and development purposes.

---

---

## You Might Also Like

- [NoNameOS](https://github.com/Mark44928/NoNameOS) - Pure C++ hobbyist OS simulation
- [Anti-Bloatware List](https://github.com/Mark44928/Anti-bloatware-list-for-Android-TV-Boxes-and-Sticks-for-rooted) - Debloat rooted Android TV sticks

---

## Star History

<a href="https://star-history.com/#Mark44928/Android9-audios&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=Mark44928/Android9-audios&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=Mark44928/Android9-audios&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=Mark44928/Android9-audios&type=Date" />
 </picture>
</a>

---

<p align="center">
  <i>Classic Android 9 sounds, preserved and organized.</i>
</p>
