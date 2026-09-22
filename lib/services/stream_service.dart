import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class StreamProvider {
  final bool playable;
  final List<Audio>? audioFormats;
  final String statusMSG;
  StreamProvider(
      {required this.playable, this.audioFormats, this.statusMSG = ""});

  static Future<StreamProvider> fetch(String videoId) async {
    final yt = YoutubeExplode();

    try {
      // yt.videos.streams is the current name for this client (older
      // versions of the library called it streamsClient).
      final res = await yt.videos.streams.getManifest(videoId);
      final audio = res.audioOnly;

      // YouTube sometimes serves a manifest with zero playable audio-only
      // formats (e.g. transient 403s on audio streams). Treat that the same
      // as any other "can't play this" case instead of crashing later when
      // something tries to read the (empty) audioFormats list.
      if (audio.isEmpty) {
        return StreamProvider(
          playable: false,
          statusMSG: "No playable audio stream found for this song",
        );
      }

      return StreamProvider(
          playable: true,
          statusMSG: "OK",
          audioFormats: audio
              .map((e) => Audio(
                  itag: e.tag,
                  audioCodec:
                      e.audioCodec.contains('mp') ? Codec.mp4a : Codec.opus,
                  bitrate: e.bitrate.bitsPerSecond,
                  // v3.x's AudioOnlyStreamInfo has no `duration` getter at
                  // all (confirmed against the library's actual source) --
                  // it was specific to the old fork. This field is only
                  // used for cosmetic display in the "song info" dialog,
                  // which already falls back to the song's own known
                  // duration when this is 0/missing, so it's safe to drop.
                  duration: 0,
                  // The upstream library doesn't expose a loudness value
                  // (that was specific to the old anandnet fork); normalize
                  // against a neutral 0 instead of reading a removed field.
                  loudnessDb: 0,
                  url: e.url.toString(),
                  size: e.size.totalBytes))
              .toList());
    } catch (e) {
      if (e is SocketException) {
        return StreamProvider(
          playable: false,
          statusMSG: "networkError",
        );
        // VideoRequiresPurchaseException and VideoUnavailableException both
        // extend VideoUnplayableException in the current library, so the
        // more specific checks must come first -- otherwise they'd always
        // be caught by the generic VideoUnplayableException branch below
        // and their own branches would never run.
      } else if (e is VideoRequiresPurchaseException) {
        return StreamProvider(
          playable: false,
          statusMSG: "Song requires purchase",
        );
      } else if (e is VideoUnavailableException) {
        return StreamProvider(
          playable: false,
          statusMSG: "Song is unavailable",
        );
      } else if (e is VideoUnplayableException) {
        // There's no separate `.reason` field on this exception -- the
        // reason is already embedded in `.message`.
        return StreamProvider(
          playable: false,
          statusMSG: e.message,
        );
      } else if (e is YoutubeExplodeException) {
        return StreamProvider(
          playable: false,
          statusMSG: e.message,
        );
      } else {
        return StreamProvider(
          playable: false,
          statusMSG: "Unknown error occurred",
        );
      }
    } finally {
      // Every fetch() call used to leak its YoutubeHttpClient (sockets
      // never released) because this was never called -- across a long
      // listening session that adds up and can eventually make playback
      // fail/slow down for reasons unrelated to any single song.
      yt.close();
    }
  }

  // `audioFormats` being null OR empty must both mean "nothing to give
  // back" here -- calling `.first` on an empty list throws StateError,
  // which used to escape uncaught and leave the player stuck on
  // "loading" forever (see StreamProvider.fetch / audio_handler.dart).
  Audio? get highestQualityAudio => (audioFormats == null || audioFormats!.isEmpty)
      ? null
      : audioFormats!.lastWhere((item) => item.itag == 251 || item.itag == 140,
          orElse: () => audioFormats!.first);

  Audio? get highestBitrateMp4aAudio => (audioFormats == null || audioFormats!.isEmpty)
      ? null
      : audioFormats!.lastWhere((item) => item.itag == 140 || item.itag == 139,
          orElse: () => audioFormats!.first);

  Audio? get highestBitrateOpusAudio => (audioFormats == null || audioFormats!.isEmpty)
      ? null
      : audioFormats!.lastWhere((item) => item.itag == 251 || item.itag == 250,
          orElse: () => audioFormats!.first);

  Audio? get lowQualityAudio => (audioFormats == null || audioFormats!.isEmpty)
      ? null
      : audioFormats!.lastWhere((item) => item.itag == 249 || item.itag == 139,
          orElse: () => audioFormats!.first);

  Map<String, dynamic> get hmStreamingData {
    return {
      "playable": playable,
      "statusMSG": statusMSG,
      "lowQualityAudio": lowQualityAudio?.toJson(),
      "highQualityAudio": highestQualityAudio?.toJson()
    };
  }
}

class Audio {
  final int itag;
  final Codec audioCodec;
  final int bitrate;
  final int duration;
  final int size;
  final double loudnessDb;
  final String url;
  Audio(
      {required this.itag,
      required this.audioCodec,
      required this.bitrate,
      required this.duration,
      required this.loudnessDb,
      required this.url,
      required this.size});

  Map<String, dynamic> toJson() => {
        "itag": itag,
        "audioCodec": audioCodec.toString(),
        "bitrate": bitrate,
        "loudnessDb": loudnessDb,
        "url": url,
        "approxDurationMs": duration,
        "size": size
      };

  factory Audio.fromJson(json) => Audio(
      audioCodec: (json["audioCodec"] as String).contains("mp4a")
          ? Codec.mp4a
          : Codec.opus,
      itag: json['itag'],
      duration: json["approxDurationMs"] ?? 0,
      bitrate: json["bitrate"] ?? 0,
      loudnessDb: (json['loudnessDb'])?.toDouble() ?? 0.0,
      url: json['url'],
      size: json["size"] ?? 0);
}

enum Codec { mp4a, opus }