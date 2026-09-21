<div align="center">

# ❗**This repository is no longer maintained.**

</div>

<img src="https://github.com/anandnet/Harmony-Music/blob/main/cover.png" width="1200" >

# Dark Tune
Dark Tune is a cross platform app for music streaming made with Flutter(Android, Windows, linux).

# Features
* Ability to play song from Ytube/Ytube Music.
* Song cache while playing
* Radio feature support
* Background music
* Playlist creation & bookmark support
* Artist & Album bookmark support
* Import song,Playlist,Album,Artist via sharing from Ytube/Ytube Music.
* Streaming quality control
* Song downloading support
* Language support
* Skip silence
* Dynamic Theme
* Flexibility to switch between Bottom & Side Nav bar
* Equalizer support
* Android Auto support
* Synced & Plain Lyrics support
* Sleep Timer
* No Advertisment
* No Login required
* Piped playlist integration


# Download

Choose one source for Android APK. Note: you won't be able to update from cross-build APK sources.

### Latest Release

<a href="https://github.com/harryboy50/dark-tune/releases/latest"><img src="https://github.com/harryboy50/dark-tune/blob/main/don_github.png" width="250"></a>

<a href="https://f-droid.org/packages/com.anandnet.darktune"><img src="https://github.com/harryboy50/dark-tune/blob/main/down_fdroid.png" width="250"></a>

> The GitHub button above directs to the **latest release page** where the APK file is available for download. Click it, then click the APK asset to download and install. 

# Release Process

To create a new release with APK distribution:

1. Update version in `pubspec.yaml`:
   ```yaml
   version: 1.12.2+27
   ```

2. Commit and tag:
   ```bash
   git add .
   git commit -m "Release v1.12.2"
   git tag v1.12.2
   git push origin main
   git push origin v1.12.2
   ```

3. The GitHub Actions workflow (`release.yml`) automatically:
   - Builds the release APK
   - Creates a GitHub Release
   - Attaches the APK as a release asset

The download button above always points to the latest release.
<a href="https://hosted.weblate.org/engage/harmony-music/">
<img src="https://hosted.weblate.org/widget/harmony-music/project-translations/multi-auto.svg" alt="Translation status" />
</a>

You can also help us in translation, click status image or <a href="https://hosted.weblate.org/projects/harmony-music/project-translations/"> here </a> to go to Weblate.

# Troubleshoot
* if you are facing Notification control issue or music playback stopped by system optimization, please enable ignore battery optimization option from settings

# License
```
Dark Tune is a free software licensed under GPL v3.0 with following condition.

- Copied/Modified version of this software can not be used for 'non-free' and profit purposes.
- You can not publish copied/modified version of this app on closed source app repository
  like PlayStore/AppStore.

```


# Disclaimer
```
This project has been created while learning & learning is the main intention.
This project is not sponsored or affiliated with, funded, authorized, endorsed by any content provider.
Any Song, content, trademark used in this app are intellectual property of their respective owners.
Dark music is not responsible for any infringement of copyright or other intellectual property rights that may result
from the use of the songs and other content available through this app.

This Software is released "as-is", without any warranty, responsibility or liability.
In no event shall the Author of this Software be liable for any special, consequential,
incidental or indirect damages whatsoever (including, without limitation, any 
other pecuniary loss) arising out of the use of inability to use this product, even if
Author of this Sotware is aware of the possibility of such damages and known defect.
```

# Learning References & Credits
<a href = 'https://docs.flutter.dev/'>Flutter documentation</a> - a best guide to learn cross platform Ui/app developemnt<br/>
<a href = 'https://suragch.medium.com/'>Suragch</a>'s Article related to Just audio & state management,architectural style<br/>
<a href = 'https://github.com/sigma67'>sigma67</a>'s unofficial ytmusic api project<br/>
App UI inspired by <a href = 'https://github.com/vfsfitvnm'>vfsfitvnm</a>'s ViMusic<br/>
Synced lyrics provided by <a href = 'https://lrclib.net' >LRCLIB</a> <br/>
<a href = 'https://piped.video' >Piped</a> for playlists.

#### Major Packages used
* just_audio: ^0.9.40  -  audio player for android
* media_kit: ^1.1.9 - audio player for linux and windows
* audio_service: ^0.18.15 - manage background music & platform audio services
* get: ^4.6.6 -  package for high-performance state management, intelligent dependency injection, and route management
* youtube_explode_dart: ^2.0.2 - Third party package to provide song url
* hive: ^2.2.3 - offline db used 
* hive_flutter: ^1.1.0


