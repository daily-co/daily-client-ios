# Changelog

All notable changes to the **daily-client-ios** SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.16.0] - 2024-02-26

### Changed

- More SDK logging now appears in the dashboard.

- In HIPAA mode, the user ID is no longer redacted in dashboard logs if it's a valid UUID.

### Fixed

- Enable Opus FEC to improve audio with network packet loss.

## [0.15.0] - 2024-01-31

### Fixed

- Fixed multiple issues which could cause a deadlock during network reconnection.

- Ensure that `updateInputs()` continues to be usable while the network is down.

- Fixed a crash which could occur if the network connection drops soon after joining.

## [0.14.0] - 2023-12-22

### Added

- Allowed to choose the preferred codec.
  ```swift
    self.callClient.updatePublishing(.set(
        camera: .set(
            isPublishing: .set(self.cameraIsPublishing),
            sendSettings: .set(
                preferredCodec: .set(.h264)
            )
        )
    ), completion: nil)
  ```
- Added a remote participant audio level observer that provides the audio level for all remote participants respecting the specified frequency.
  ```swift
    // Starts the remote audio level observer
    self.callClient.startRemoteParticipantsAudioLevelObserver(intervalMs:1000, completion: nil)
    // Stops the remote audio level observer
    self.callClient.stopRemoteParticipantsAudioLevelObserver(completion: nil)
    // New CallClientDelegate function
    func callClient(_ callClient: Daily.CallClient, remoteParticipantsAudioLevel participantsAudioLevel: Daily.KeyedSettings<Daily.ParticipantID, Float>) {
        // audio level for each remote participant
    }
  ```

## [0.13.0] - 2023-12-05

### Added

- Added support to change screen share publish settings.
  ```swift
    self.callClient.updatePublishing(.set(
        screenVideo: .set(
            isPublishing: .set(true),
            sendSettings: .set(
                maxQuality: .set(.low),
                encodings: .set(
                    .config(VideoEncodingSettingsByQualityUpdate(
                        low: .set(
                            maxBitrate: .set(1_200_000),
                            maxFramerate: .set(15),
                            scaleResolutionDownBy: .set(1)
                        )
                    )
                    )
                )
            )
        )
    ), completion: nil)
  ```

## [0.12.0] - 2023-11-20

### Added

- Added support for screen sharing:
  - Note: Screen share for iOS is composed by two parts, broadcast upload extension, and the screen share support inside our SDK.
    In order to start the broadcast upload extension, you should use the native component `RPSystemBroadcastPickerView`.
  - There are two new delegate functions inside `CallClientDelegate`:
    - `callClientDidDetectStartOfSystemBroadcast`: invoked when the broadcast upload extension has started.
    - `callClientDidDetectEndOfSystemBroadcast`: invoked when the broadcast upload extension has stopped.
  - New property `screenVideo` inside `updateInputs`.
    - When enabled, starts a screen share from the local participant.
    - When disabled, stops the local participant current screen share, if there is one.

  ```swift
    func callClientDidDetectStartOfSystemBroadcast(
        _ callClient: CallClient
    ) {
        callClient.updateInputs(
            .set(screenVideo: .set(isEnabled: .set(true))),
            completion: nil
        )
    }

    public func callClientDidDetectEndOfSystemBroadcast(
        _ callClient: CallClient
    ) {
        callClient.updateInputs(
            .set(screenVideo: .set(isEnabled: .set(false))),
            completion: nil
        )
    }
  ```

- Introduced `CameraPreviewView` for use in apps that do not support rotation.
  The `CameraPreviewView.preferred` property can be used to prevent unnecessary
  view recreation in `UIViewRepresentable` implementations in `SwiftUI` apps.

  *Note: Video shown in the `CameraPreviewView` for the user facing camera will
  be mirrored.*

### Changed

- The `VideoView` will now report an undefined `intrinsicContentSize`. Client
  code that was relying on the intrinsic size should instead create explicit
  Auto Layout constraints to manage the size and position of any `VideoView`
  instances. The `videoView(_:didChangeVideoSize:)` method available via
  `VideoViewDelegate` can be used to make any needed constraint updates when the
  size and corresponding aspect ratio of the video changes.

### Fixed

- Fixed a possible crasher that could occur when configuring the `AVAudioSession` without an audio input.

## [0.11.1] - 2023-10-27

### Fixed

- Joining a call where a recording with participant-selection properties specified is ongoing will no longer fail.
- The library's version should now be correctly reported in dashboard logs as 0.11.1.

## [0.11.0] - 2023-10-05

### Fixed

- Video will no longer flicker when muting or unmuting the microphone.
- The green camera use light will now disappear when muting the camera.
- Temporary network interruptions will now be handled properly and reconnected.
- Audio device selection issues:
    - When the preferred audio device is no longer available, it will now fall back to our default behavior for audio device selection.
    - Fixed issue where in some scenarios it was changing to use Earpiece without the user having requested it.

## [0.10.1] - 2023-09-12

### Fixed

- Update video track management in UserMedia, to cache previously-held video tracks and fix an issue where updating other parts of media state could cause video to flicker.
- Fixed an issue with the SDK's self-reported version.

## [0.10.0] - 2023-09-08

### Added

- Async methods have been added to the `CallClient` for all methods that
  previously accepted a completion handler.

  *note: Completion blocks are now required, so errors that need to be handled
  will be obvious. Calls to methods that accept a completion handler will need
  to be updated to pass `nil` in cases where `nil` was previously being supplied
  by a default value.*

- Renamed the following `CallClient` methods:

  - `set(username:)` to `setUsername(_:)`
  - `set(preferredAudioDevice:)` to `setPreferredAudioDevice(_:)`

- Added a new field `inputsEnabled` in the argument to the method `updateRemoteParticipants(_:completion:)`, allowing participant admins to remote-mute others, and meeting owners to remote-mute or -unmute others.

  ```swift
  public struct RemoteParticipantUpdate {
    /// A desired update to a remote participant's input enabled states.
    public var inputsEnabled: RemoteInputsEnabledUpdate?

    // ...
  }

  /// A desired update to a remote participant's input enabled states.
  public struct RemoteInputsEnabledUpdate {
    /// Whether to mute or unmute a remote participant's microphone.
    public var microphone: Bool?

    /// Whether to mute or unmute a remote participant's camera.
    public var camera: Bool?

    // ...
  }
  ```

### Changed

- Publishing mode `iOSOptimized` introduced in 0.9.0 has been renamed to `adaptiveHEVC`.

## [0.9.0] - 2023-07-27

### Added

<!-- for new functionality -->

- Associated value (`DefaultStreamingLayout`) for `StreamingLayout.default`:

  ```swift
  enum StreamingLayout {
      case `default`(DefaultStreamingLayout)

      // ...
  }
  ```

- Variant `.staged` in `enum SubscriptionState`:

  ```swift
  enum SubscriptionState {
      /// The track has been staged and has made preparations to subscribe to data quickly.
      case staged

      // ...
  }
  ```

- Added a new publishing mode called `iOSOptimized`. When enabling the `iOSOptimized` mode
  for a call, your daily-ios client will send both a high quality HEVC (also known as H.265)
  encoded video stream and a medium and low quality H.264 encoded video stream.

  ```swift
  call.updatePublishing(.set(
    camera: .set(
      isPublishing: .set(true),
      sendSettings: .set(
        maxQuality: .set(.high),
        encodings: .set(.mode(.iOSOptimized))
      )
    )
  ))
  ```

- Added a new property called `canAdmin` to the `permissions` field that's part of the
  `updatePermissions()` method. `canAdmin` can be used to dynamically change permissions
  for participants from within a call. Admins have the ability to manage participants
  in a call or manage transcriptions.

### Changed

<!-- for changed functionality -->

- Renamed `CustomStreamingCompositionParamId` to `CustomStreamingCompositionParamID`
- Renamed `CustomStreamingSessionAssetId` to `CustomStreamingSessionAssetID`
- Renamed `MediaStreamTrackId` to `MediaStreamTrackID`
- Renamed `ParticipantId` to `ParticipantID`
- Renamed `RecordingId` to `RecordingID`
- Renamed `RequestId` to `RequestID`
- Renamed `SessionId` to `SessionID`
- Renamed `StreamCompositionId` to `StreamCompositionID`
- Renamed `StreamId` to `StreamID`
- Renamed properties with the following acronyms to use consistent casing
  - `id…`, `…ID`
  - `url…`, `…URL`
  - `rtmp…`, `…RTMP`

### Fixed

<!-- for fixed bugs -->

- Fixed a crash that could occur during the de-initialization of a call client.
- Documentation for default value of `VideoSendSettingsUpdate.encodings`.
- Fixed a couple of bugs that could cause JSON decoding errors to be thrown.

## [0.8.0] - 2023-05-10

### Added

<!-- for new functionality -->

- Methods `init?(uuidString:)` and `var uuidString: String` on `struct ParticipantId`:

  ```swift
  struct ParticipantId {
    /// The string representation of the ID.
    var uuidString: String

    /// Creates an ID from a UUID in its string-representation.
    init?(uuidString: String)

    // ...
  }
  ```

- Methods `init?(uuidString:)` and `var uuidString: String` on `struct RecordingId`:

  ```swift
  struct RecordingId {
    /// The string representation of the ID.
    var uuidString: String

    /// Creates an ID from a UUID in its string-representation.
    init?(uuidString: String)

    // ...
  }
  ```

- Methods `init?(uuidString:)` and `var uuidString: String` on `struct SessionId`:

  ```swift
  struct SessionId {
    /// The string representation of the ID.
    var uuidString: String

    /// Creates an ID from a UUID in its string-representation.
    init?(uuidString: String)

    // ...
  }
  ```

- Methods `init?(uuidString:)` and `var uuidString: String` on `struct StreamId`:

  ```swift
  struct StreamId {
    /// The string representation of the ID.
    var uuidString: String

    /// Creates an ID from a UUID in its string-representation.
    init?(uuidString: String)

    // ...
  }
  ```

- Method `updateSubscriptions(forParticipants:completion:)` on `class CallClient`:

  ```swift
  /// Configure how (or if) to subscribe to remote media tracks.
  ///
  /// A variant of `updateSubscriptions(forParticipants:participantsWithProfiles:completion:)`
  /// with the `participantsWithProfiles:` argument omitted.
  func updateSubscriptions(
      forParticipants subscriptionsById: Update<SubscriptionSettingsUpdatesById>,
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
  )
  ```

  - Method `updateSubscriptions(participantsWithProfiles:completion:)` on `class CallClient`:

  ```swift
  /// Configure how (or if) to subscribe to remote media tracks.
  ///
  /// A variant of `updateSubscriptions(forParticipants:participantsWithProfiles:completion:)`
  /// with the `forParticipants:` argument omitted.
  func updateSubscriptions(
      forParticipantsWithProfiles subscriptionsByProfile: Update<SubscriptionSettingsUpdatesByProfile>,
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
  )
  ```

### Changed

<!-- for changed functionality -->

- Converted `MediaType` into `InboundMediaType` and `OutboundMediaType`:

  ```swift
  public enum InboundMediaType {
      static public var standardTypes: [InboundMediaType] {
          return [.audio, .video, .screenAudio, .screenVideo]
      }

      case audio
      case video
      case screenAudio
      case screenVideo
      case customAudio(CustomTrackName)
      case customVideo(CustomTrackName)
  }

  public enum OutboundMediaType {
      case microphone
      case camera
  }
  ```

- Made properties of `struct PreconfiguredEndpoints` mutable:

  - `var preconfiguredEndpoints: [String]`

- Made properties of `struct RtmpUrlEndpoints` mutable:

  - `var rtmpUrls: [URL]`

- Made properties of `struct LiveStreamingSettings` mutable:

  - `var audio: AudioStreamingSettings?`
  - `var video: VideoStreamingSettings?`
  - `var layout: StreamingLayout?`
  - `var maxDuration: TimeInterval?`

- Made properties of `struct DefaultStreamingLayout` mutable:

  - `var maxCamStreams: Int?`

- Made properties of `struct SingleParticipantStreamingLayout` mutable:

  - `var sessionId: ParticipantId`

- Made properties of `struct SingleParticipantStreamingLayout` mutable:

  - `var sessionId: ParticipantId`

- Made properties of `struct PortraitStreamingLayout` mutable:

  - `var variant: PortraitStreamingLayoutVariant`
  - `var maxCamStreams: Int?`

- Made properties of `struct CustomStreamingLayout` mutable:

  - `var compositionId: StreamCompositionId`
  - `var compositionParams: CustomStreamingCompositionParams`
  - `var sessionAssets: CustomStreamingSessionAssets?`

- Made properties of `struct AudioStreamingSettings` mutable:

  - `var bitrate: Int?`

- Made properties of `struct VideoStreamingSettings` mutable:

  - `var width: Int?`
  - `var height: Int?`
  - `var fps: Double?`
  - `var bitrate: Int?`
  - `var backgroundColor: String?`

- Made properties of `struct StreamingSettings` mutable:

  - `var video: VideoStreamingSettings?`
  - `var layout: StreamingLayout?`

- Made `class CallClient` conform to `protocol ObservableObject`.

### Fixed

<!-- for fixed bugs -->

- Fixed a possible crash when joining a call without a call configuration.

## [0.7.0] - 2023-03-01

### Added

- Type `struct SessionId`:

  ```swift
  /// A call session's unique ID.
  struct SessionId: Equatable, Hashable {
      /// The internal UUID representation.
      let uuid: UUID

      init(uuid: UUID)
  }
  ```

- Method `callClient(_:callConfigurationUpdated:)` on `protocol CallClientDelegate`:

  ```swift
  protocol CallClientDelegate {
      /// The call's configuration has changed.
      func callClient(
          _ callClient: CallClient,
          callConfigurationUpdated callConfiguration: CallConfiguration?
      )

      // ...
  }
  ```

- Method `callClient(_:networkStatsUpdated:)` on `protocol CallClientDelegate`:

  ```swift
  protocol CallClientDelegate {
      /// The call's network stats have changed.
      func callClient(
          _ callClient: CallClient,
          networkStatsUpdated networkStats: NetworkStats
      )

      // ...
  }
  ```

- Method `callClient(_:participantCountsUpdated:)` on `protocol CallClientDelegate`:

  ```swift
  protocol CallClientDelegate {
      /// The number of participants has changed.
      func callClient(
          _ callClient: CallClient,
          participantCountsUpdated participantCounts: ParticipantCounts
      )

      // ...
  }
  ```

- Conformance of type `class AudioTrack` to `protocol ObservableObject`, allowing for observation of its `id` and `isEnabled` properties.

- Conformance of type `class VideoTrack` to `protocol ObservableObject`, allowing for observation of its `id` and `isEnabled` properties.

- Conformance of type `class AudioTrack` to `protocol Equatable`, based on the identity of the underlying WebRTC media track.

- Conformance of type `class VideoTrack` to `protocol Equatable`, based on the identity of the underlying WebRTC media track.

- Method `set(camera:microphone:)` on `enum Update<InputSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == InputSettingsUpdate
  {
     static func set(
        camera: Update<CameraInputSettingsUpdate>? = nil,
        microphone: Update<MicrophoneInputSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(isEnabled:settings:)` on `enum Update<CameraInputSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == CameraInputSettingsUpdate
  {
     static func set(
        isEnabled: Update<Bool>? = nil,
        settings: Update<VideoMediaTrackSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(isEnabled:settings:)` on `enum Update<MicrophoneInputSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == MicrophoneInputSettingsUpdate
  {
     static func set(
        isEnabled: Update<Bool>? = nil,
        settings: Update<AudioMediaTrackSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(camera:microphone:)` on `enum Update<AudioMediaTrackSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == AudioMediaTrackSettingsUpdate
  {
     static func set(
        deviceId: Update<MediaTrackDeviceId>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(deviceId:width:height:frameRate:facingMode:)` on `enum Update<VideoMediaTrackSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == VideoMediaTrackSettingsUpdate
  {
     static func set(
        deviceId: Update<MediaTrackDeviceId>? = nil,
        width: Update<MediaTrackWidth>? = nil,
        height: Update<MediaTrackHeight>? = nil,
        frameRate: Update<MediaTrackFrameRate>? = nil,
        facingMode: Update<MediaTrackFacingMode>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(channelConfig:bitrate:)` on `enum Update<AudioSendSettingsConfigUpdate>`:

  ```swift
  extension Update
  where
      Value == AudioSendSettingsConfigUpdate
  {
     static func set(
        channelConfig: Update<AudioSendSettingsChannelConfig>? = nil,
        bitrate: Update<UInt32>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(camera:microphone:)` on `enum Update<PublishingSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == PublishingSettingsUpdate
  {
     static func set(
        camera: Update<CameraPublishingSettingsUpdate>? = nil,
        microphone: Update<MicrophonePublishingSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(isPublishing:sendSettings:)` on `enum Update<CameraPublishingSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == CameraPublishingSettingsUpdate
  {
     static func set(
        isPublishing: Update<Bool>? = nil,
        sendSettings: Update<VideoSendSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(isPublishing:sendSettings:)` on `enum Update<MicrophonePublishingSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == MicrophonePublishingSettingsUpdate
  {
     static func set(
        isPublishing: Update<Bool>? = nil,
        sendSettings: Update<AudioSendSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(camera:microphone:)` on `enum Update<MediaSubscriptionSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == MediaSubscriptionSettingsUpdate
  {
     static func set(
        camera: Update<CameraSubscriptionSettingsUpdate>? = nil,
        microphone: Update<MicrophoneSubscriptionSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(subscriptionState:receiveSettings:)` on `enum Update<CameraSubscriptionSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == CameraSubscriptionSettingsUpdate
  {
     static func set(
        subscriptionState: Update<SubscriptionState>? = nil,
        receiveSettings: Update<VideoReceiveSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(subscriptionState:)` on `enum Update<CameraSubscriptionSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == MicrophoneSubscriptionSettingsUpdate
  {
     static func set(
        subscriptionState: Update<SubscriptionState>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(profile:media:)` on `enum Update<SubscriptionSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == SubscriptionSettingsUpdate
  {
     static func set(
        profile: Update<SubscriptionProfile>? = nil,
        media: Update<MediaSubscriptionSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(profile:media:)` on `enum Update<VideoReceiveSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == VideoReceiveSettingsUpdate
  {
     static func set(
        maxQuality: Update<VideoReceiveSettingsMaxQuality>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(maxBitrate:maxFramerate:scaleResolutionDownBy:)` on `enum Update<VideoEncodingSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == VideoEncodingSettingsUpdate
  {
     static func set(
        maxBitrate: Update<UInt32>? = nil,
        maxFramerate: Update<Float64>? = nil,
        scaleResolutionDownBy: Update<Float64>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(low:medium:high:)` on `enum Update<VideoEncodingSettingsByQualityUpdate>`:

  ```swift
  extension Update
  where
      Value == VideoEncodingSettingsByQualityUpdate
  {
     static func set(
        low: Update<VideoEncodingSettingsUpdate>? = nil,
        medium: Update<VideoEncodingSettingsUpdate>? = nil,
        high: Update<VideoEncodingSettingsUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Method `set(maxQuality:encodings:)` on `enum Update<VideoSendSettingsUpdate>`:

  ```swift
  extension Update
  where
      Value == VideoSendSettingsUpdate
  {
     static func set(
        maxQuality: Update<VideoSendSettingsMaxQuality>? = nil,
        encodings: Update<VideoEncodingSettingsByQualityUpdate>? = nil
    ) -> Self

    // ...
  }
  ```

- Type `struct PreconfiguredEndpoints`:

  ```swift
  /// A list of preconfigured endpoints for a live stream.
  struct PreconfiguredEndpoints: Encodable {
      /// Preconfigured endpoint names.
      let preconfiguredEndpoints: [String]

      init(preconfiguredEndpoints: [String])
  }
  ```

- Type `struct RtmpUrlEndpoints`:

  ```swift
  /// A list of RTMP endpoints for a live stream.
  struct RtmpUrlEndpoints: Encodable, ExpressibleByArrayLiteral {
      /// RTMP endpoint urls.
      let rtmpUrls: [URL]

      init(rtmpUrls: [URL])
  }
  ```

- Type `struct LiveStreamEndpoints`:

  ```swift
  /// A list of endpoints for a live stream.
  enum LiveStreamEndpoints: Encodable {
      /// Preconfigured endpoints.
      case preconfigured(PreconfiguredEndpoints)

      /// RTMP endpoints.
      case rtmpUrls(RtmpUrlEndpoints)
  }
  ```

- Type `struct AudioStreamingSettings`:

  ```swift
  /// A stream's audio settings.
  struct AudioStreamingSettings: Encodable {
      /// A stream's bitrate in bits/s.
      let bitrate: Int?

      init(bitrate: Int? = nil)
  }
  ```

- Type `struct LiveStreamingSettings`:

  ```swift
  /// A stream's settings.
  struct LiveStreamingSettings: Encodable {
      let audio: AudioStreamingSettings?
      let video: VideoStreamingSettings?
      let layout: StreamingLayout?
      let maxDuration: TimeInterval?

      init(
          audio: AudioStreamingSettings? = nil,
          video: VideoStreamingSettings? = nil,
          layout: StreamingLayout? = nil,
          maxDuration: TimeInterval? = nil
      )
  }
  ```

- Methods on `class CallClient` for starting, updating and stopping live-streams:

  ```swift
  class CallClient {
      /// Start a new live-stream, if possible.
      func startLiveStream(
          endpoints: LiveStreamEndpoints,
          streamingSettings: StreamingSettings? = nil,
          streamId: StreamId? = nil,
          forceNew: Bool? = nil,
          completion: ((Result<StreamId, CallClientError>) -> Void)? = nil
      )

      /// Updates an ongoing live-stream.
      func updateLiveStream(
          streamingSettings: StreamingSettingsUpdate,
          streamId: StreamId? = nil,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Stops an ongoing live-stream.
      func stopLiveStream(
          streamId: StreamId? = nil,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

- Methods on `protocol CallClientDelegate` for starting, updating and stopping live-streams:

  ```swift
  class CallClientDelegate {
      /// A live-stream was started.
      func callClient(
          _ callClient: CallClient,
          liveStreamStartedWithStatus status: LiveStreamStatus
      )

      /// A live-stream was stopped.
      func callClient(
          _ callClient: CallClient,
          liveStreamStoppedForStreamWithId streamId: StreamId
      )

      /// A live-stream error has occurred.
      func callClient(
          _ callClient: CallClient,
          liveStreamError error: String,
          forStreamWithId streamId: StreamId
      )

      /// A live-stream warning has occurred.
      func callClient(
          _ callClient: CallClient,
          liveStreamWarning warning: String,
          forStreamWithId streamId: StreamId
      )

      // ...
  }
  ```

- Methods on `class CallClient` for starting, updating and stopping recordings:

  ```swift
  class CallClient {
      /// Start a new recording, if possible.
      func startRecording(
          streamingSetting: StreamingSettings? = nil,
          streamId: StreamId? = nil,
          forceNew: Bool? = nil,
          completion: ((Result<StreamId, CallClientError>) -> Void)? = nil
      )

      /// Updates an ongoing recording.
      func updateRecording(
          streamingSettings: StreamingSettings,
          streamId: StreamId? = nil,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Stops an ongoing recording.
      func stopRecording(
          streamId: StreamId? = nil,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

- Methods on `protocol CallClientDelegate` for starting, updating and stopping recordings:

  ```swift
  class CallClient {
      /// A recording was started.
      func callClient(
          _ callClient: CallClient,
          recordingStartedWithStatus status: RecordingStatus
      )

      /// A recording was stopped.
      func callClient(
          _ callClient: CallClient,
          recordingStoppedForStreamWithId streamId: StreamId
      )

      /// A recording error has occurred.
      func callClient(
          _ callClient: CallClient,
          recordingError error: String,
          forStreamWithId streamId: StreamId
      )

      // ...
  }
  ```

- Type `struct StreamId`:

  ```swift
  /// A stream's unique ID.
  struct StreamId: Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
      let uuid: UUID

      init(uuid: UUID)
  }
  ```

  - Type `struct RecordingId`:

  ```swift
  /// A recording's unique ID.
  struct RecordingId: Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
      let uuid: UUID

      init(uuid: UUID)
  }
  ```

- Type `struct StreamCompositionId`:

  ```swift
  /// A recording's unique ID.
  struct StreamCompositionId: Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
      let stringValue: String

      init(stringValue: String)
  }
  ```

- Type `struct CustomStreamingCompositionParamId`:

  ```swift
  /// A composition param's unique ID.
  struct CustomStreamingCompositionParamId: Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
      let stringValue: String

      init(stringValue: String)
  }
  ```

- Type `struct CustomStreamingSessionAssetId`:

  ```swift
  /// A composition asset's unique ID.
  struct CustomStreamingSessionAssetId: Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
      let stringValue: String

      init(stringValue: String)
  }
  ```

- Type `struct DefaultStreamingLayout`:

  ```swift
  /// A stream's default layout.
  struct DefaultStreamingLayout {
      let maxCamStreams: Int?
  }
  ```

- Type `struct SingleParticipantStreamingLayout`:

  ```swift
  /// A stream's single-participant layout.
  struct SingleParticipantStreamingLayout {
      let sessionId: ParticipantId
  }
  ```

- Type `struct StreamingSettingsUpdate`:

  ```swift
  enum PortraitStreamingLayoutVariant: String {
      case vertical
      case inset
  }
  ```

- Type `struct PortraitStreamingLayout`:

  ```swift
  /// A stream's portrait layout.
  struct PortraitStreamingLayout {
      let variant: PortraitStreamingLayoutVariant
      let maxCamStreams: Int?
  }
  ```

- Type `enum CustomStreamingCompositionParam`:

  ```swift
  /// A stream's custom layout composition param.
  enum CustomStreamingCompositionParam {
      case boolean(Bool)
      case float(Double)
      case integer(Int)
      case string(String)
  }
  ```

- Type `typealias CustomStreamingCompositionParams`:

  ```swift
  /// A stream's custom layout composition params.
  typealias CustomStreamingCompositionParams = KeyedSettings<CustomStreamingCompositionParamId, CustomStreamingCompositionParam>
  ```

- Type `typealias CustomStreamingSessionAssets`:

  ```swift
  /// A stream's custom layout session assets.
  typealias CustomStreamingSessionAssets = KeyedSettings<CustomStreamingSessionAssetId, URL>
  ```

- Type `struct CustomStreamingLayout`:

  ```swift
  /// A stream's custom layout.
  struct CustomStreamingLayout {
      let compositionId: StreamCompositionId
      let compositionParams: CustomStreamingCompositionParams
      let sessionAssets: CustomStreamingSessionAssets?
  }
  ```

- Type `struct VideoStreamingSettings`:

  ```swift
  /// A stream's video settings.
  struct VideoStreamingSettings {
      let width: Int?
      let height: Int?
      let fps: Double?
      let backgroundColor: String?
  }
  ```

- Type `enum StreamingLayout`:

  ```swift
  /// A stream's layout.
  enum StreamingLayout {
      case `default`
      case singleParticipant(SingleParticipantStreamingLayout)
      case activeParticipant
      case portrait(PortraitStreamingLayout)
      case custom(CustomStreamingLayout)
  }
  ```

- Type `struct StreamingSettingsUpdate`:

  ```swift
  /// A stream's settings.
  struct StreamingSettings {
      let video: VideoStreamingSettings?
      let layout: StreamingLayout?
  }
  ```

- Type `struct StreamingSettingsUpdate`:

  ```swift
  /// A stream's settings update.
  struct StreamingSettingsUpdate {
      let layout: StreamingLayout?
  }
  ```

  ```swift
  struct RecordingStatus: Equatable {
      let streamId: StreamId
      let recordingId: RecordingId
      let startedBy: ParticipantId?
      let layout: StreamingLayout?
  }
  ```

- Method `sendAppMessage(_:recipient:completion:)` on `class CallClient`:

  ```swift
  class CallClient {
      /// Sends an App Message.
      ///
      /// `appMessage` should be a valid JSON-encoded value, at most 4kB in length.
      ///
      /// `recipient` is used to determine who receives the message. You can either send the App Message to the entire room using
      /// `.all`, or a single participant with `.participant(participant_id)`.
      ///
      ///  Because this method uses a legacy FFI call, there is no way to tell if your `sendAppMessage` call resulted with an error.
      func sendAppMessage(
          json jsonData: Data,
          to recipient: AppMessageRecipient,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

- Method `callClient(_:appMessage:from:)` on `protocol CallClientDelegate`:

  ```swift
  protocol CallClientDelegate {
      /// An App Message was received.
      func callClient(
          _ callClient: CallClient,
          appMessageAsJson jsonData: Data,
          from participantId: ParticipantId
      )

      // ...
  }
  ```

- Method `callConfigFor(url:token:completion:)` on `class CallClient`:

  ```swift
  class CallClient {
      func callConfigFor(
          url: URL,
          token: MeetingToken?,
          completion: ((Result<CallConfiguration, CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

- Property `callConfiguration` on `class CallClient`:

  ```swift
  class CallClient {
      /// The current call configuration, if any.
      @Published
      private(set) var callConfiguration: CallConfiguration?

      // ...
  }
  ```

- Convenience methods `setInput[s]Enabled(…)` on `class CallClient`:

  ```swift
  class CallClient {
      /// Enable or disable a media input device, like a camera or microphone.
      ///
      /// - Example: enable camera input.
      ///
      ///   ```
      ///   call.setInputEnabled(.camera, true)
      ///   ```
      ///
      /// For more advanced input settings, see `updateInputs()`.
      func setInputEnabled(
          _ mediaType: MediaType,
          _ isEnabled: Bool,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Enable or disable media input devices, like a camera and/or microphone.
      ///
      /// - Example: enable camera input and disable microphone input.
      ///
      ///   ```
      ///   call.setInputsEnabled([
      ///       .camera: true,
      ///       .microphone: false
      ///   ])
      ///   ```
      ///
      /// For more advanced input settings, see `updateInputs()`.
      func setInputsEnabled(
          _ mediaTypeToIsEnabled: [MediaType: Bool],
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

- Convenience methods `setIsPublishing(…)` on `class CallClient`:

  ```swift
  class CallClient {
      /// Publish or unpublish a media track, like a camera or microphone track.
      ///
      /// - Example: publish the camera track.
      ///
      ///   ```
      ///   call.setIsPublishing(.camera, true)
      ///   ```
      ///
      /// For more advanced publishing settings, see `updatePublishing()`.
      func setIsPublishing(
          _ mediaType: MediaType,
          _ isPublishing: Bool,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Publish or unpublish media tracks, like a camera and/or microphone track.
      ///
      /// - Example: publish the camera track and unpublish the microphone track.
      ///
      ///   ```
      ///   call.setIsPublishing([
      ///       .camera: true,
      ///       .microphone: false
      ///   ])
      ///   ```
      ///
      /// For more advanced publishing settings, see `updatePublishing()`.
      func setIsPublishing(
          _ mediaTypeToIsPublishing: [MediaType: Bool],
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

- Convenience methods `setSubscriptionState(…)` on `class CallClient`:

  ```swift
  class CallClient {
      /// Start or stop subscribing to all of a remote participant's tracks.
      ///
      /// - Example: subscribe to a remote participant's tracks.
      ///
      ///   ```
      ///   call.setSubscriptionState(for: participantId, .subscribed)
      ///   ```
      ///
      /// For more advanced subscription settings, see `updateSubscriptions()`.
      func setSubscriptionState(
          for participantId: ParticipantId,
          _ state: SubscriptionState,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Start or stop subscribing to specific tracks from a remote participant.
      ///
      /// - Example: subscribe to a remote participant's camera track and unsubscribe from their microphone track.
      ///
      ///   ```
      ///   call.setSubscriptionState(for: participantId, [
      ///       .camera: .subscribed,
      ///       .microphone: .unsubscribed
      ///   ])
      ///   ```
      ///
      /// For more advanced subscription settings, see `updateSubscriptions()`.
      func setSubscriptionState(
          for participantId: ParticipantId,
          _ mediaTypeToState: [MediaType: SubscriptionState],
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Start or stop subscribing to all tracks from specific remote participants.
      ///
      /// - Example: subscribe to a remote participant's tracks, and stop subscribing to another remote participant's tracks.
      ///
      ///   ```
      ///   call.setSubscriptionState([
      ///       participantId1: .subscribed,
      ///       participantId2: .unsubscribed
      ///   ])
      ///   ```
      ///
      /// For more advanced subscription settings, see `updateSubscriptions()`.
      func setSubscriptionState(
          _ participantIdToState: [ParticipantId: SubscriptionState],
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Start or stop subscribing to specific tracks from specific remote participants.
      ///
      /// - Example: subscribe to two remote participant's camera tracks, and stop subscribing to their microphone tracks.
      ///
      ///   ```
      ///   call.setSubscriptionState([
      ///       participantId1: [
      ///           .camera: .subscribed,
      ///           .microphone: .unsubscribed
      ///       ],
      ///       participantId2: [
      ///           .camera: .subscribed,
      ///           .microphone: .unsubscribed
      ///       ]
      ///   ])
      ///   ```
      ///
      /// For more advanced subscription settings, see `updateSubscriptions()`.
      func setSubscriptionState(
          _ participantIdToMediaTypeToState: [ParticipantId: [MediaType: SubscriptionState],
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

- Convenience methods `setSubscriptionProfile(…)` on `class CallClient`:

  ```swift
  class CallClient {
      /// Assign a remote participant to a subscription profile.
      ///
      /// - Example: assign a remote participant to a "presenter" profile.
      ///
      ///   ```
      ///   call.setSubscriptionProfile(for: participantId, "presenter")
      ///   ```
      ///
      /// To define your own subscription profiles, see `updateSubscriptionProfiles()`.
      /// For more advanced subscription settings, see `updateSubscriptions()`.
      func setSubscriptionProfile(
          for participantId: ParticipantId,
          _ profile: SubscriptionProfile,
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      /// Assign remote participants to subscription profiles.
      ///
      /// - Example: assign a remote participant to a "presenter" profile and another remote participant to an "audience" profile.
      ///
      ///   ```
      ///   call.setSubscriptionProfile([
      ///       participantId1: "presenter",
      ///       participantId2: "audience"
      ///   ])
      ///   ```
      ///
      /// To define your own subscription profiles, see `updateSubscriptionProfiles()`.
      /// For more advanced subscription settings, see `updateSubscriptions()`.
      func setSubscriptionProfile(
          _ participantIdToProfile: [ParticipantId: SubscriptionProfile],
          completion: ((Result<(), CallClientError>) -> Void)? = nil
      )

      // ...
  }
  ```

### Removed

- Overloads for `func updateInputs(…)` of `class CallClient`.

  ```swift
  class CallClient {
    func updateInputs(
      _ closure: (inout InputSettingsUpdate) -> (),
      completion: ((Result<InputSettings, CallClientError>) -> Void)? = nil
    )
    func updateInputs(
      _ inputs: InputSettingsUpdate,
      completion: ((Result<InputSettings, CallClientError>) -> Void)? = nil
    )

    // ...
  }
  ```

- Overloads for `func updatePublishing(…)` of `class CallClient`.

  ```swift
  class CallClient {
    func updatePublishing(
      _ closure: (inout PublishingSettingsUpdate) -> (),
      completion: ((Result<PublishingSettings, CallClientError>) -> Void)? = nil
    )
    func updatePublishing(
      _ publishing: PublishingSettingsUpdate,
      completion: ((Result<PublishingSettings, CallClientError>) -> Void)? = nil
    )

    // ...
  }
  ```

- Overloads for `func updateSubscriptions(…)` of `class CallClient`.

  ```swift
  class CallClient {
    func updateSubscriptions(
      forParticipants closure: (inout SubscriptionSettingsUpdatesById) -> (),
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptions(
      forParticipants subscriptionsById: SubscriptionSettingsUpdatesById,
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptions(
      forParticipants subscriptionsById: Update<SubscriptionSettingsUpdatesById>,
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptions(
      forParticipantsWithProfiles closure: (inout SubscriptionSettingsUpdatesByProfile) -> (),
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptions(
      forParticipantsWithProfiles subscriptionsByProfile: SubscriptionSettingsUpdatesByProfile,
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptions(
      forParticipantsWithProfiles subscriptionsByProfile: Update<SubscriptionSettingsUpdatesByProfile>,
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptions(
      forParticipants closureForParticipants: (inout SubscriptionSettingsUpdatesById) -> (),
      participantsWithProfiles closureForParticipantsWithProfiles: (inout SubscriptionSettingsUpdatesByProfile) -> (),
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptions(
      forParticipants subscriptionsById: SubscriptionSettingsUpdatesById,
      participantsWithProfiles subscriptionsByProfile: SubscriptionSettingsUpdatesByProfile,
      completion: ((Result<SubscriptionSettingsById, CallClientError>) -> Void)? = nil
    )

    // ...
  }
  ```

- Overloads for `func updateSubscriptionProfiles(…)` of `class CallClient`.

  ```swift
  class CallClient {
    func updateSubscriptionProfiles(
      _ closure: (inout SubscriptionProfileSettingsUpdatesByProfile) -> (),
      completion: ((Result<SubscriptionProfileSettingsByProfile, CallClientError>) -> Void)? = nil
    )
    func updateSubscriptionProfiles(
      _ subscriptionsByProfile: SubscriptionProfileSettingsUpdatesByProfile,
      completion: ((Result<SubscriptionProfileSettingsByProfile, CallClientError>) -> Void)? = nil
    )

    // ...
  }
  ```

- Overloads for `func updateSubscriptionProfiles(…)` of `struct KeyedSettingsUpdate`.

  ```swift
  class CallClient {
    mutating func callAsFunction(
      _ key: Key,
      _ value: Update<Settings>
    )
    mutating func callAsFunction(
      _ key: Key,
      _ value: Settings
    )
    mutating func callAsFunction(
      _ key: Key,
      _ closure: (inout Settings) -> ()
    )
    where
        Settings: ComplexSettingsUpdate

    // ...
  }
  ```

- Protocol `protocol ComplexSettingsUpdate` and conformances.

  ```swift
  protocol ComplexSettingsUpdate {
    init()
  }

  extension /* ... */: ComplexSettingsUpdate {
    // ...
  }
  ```

- Type `enum CallTopology`:

  ```swift
  enum CallTopology {
      // ...
  }
  ```

- Property `topology` in `struct MeetingSession`:

- Before:

  ```swift
  struct MeetingSession {
      let topology: CallTopology

      // ...
  }
  ```

  - After:

    ```swift
    struct MeetingSession {
        // ...
    }
    ```

## [0.6.0] - 2023-01-19

### Added

- Properties on `class CallClient`:

  ```swift
  class CallClient {
      /// The current input settings.
      @Published
      private(set) var inputs: InputSettings

      /// The current publishing settings.
      @Published
      private(set) var publishing: PublishingSettings

      /// The current subscription settings.
      ///
      /// This contains subscription settings for participants which
      /// are already in the call as well as future participants which have been pre-configured.
      @Published
      private(set) var subscriptions: SubscriptionSettingsById

      /// The current subscription profile settings.
      ///
      /// This contains the profiles that are currently configured
      /// in this call. The `base` profile is always configured.
      @Published
      private(set) var subscriptionProfiles: SubscriptionProfileSettingsByProfile

      /// The available devices (e.g. cameras, microphones, …).
      @Published
      private(set) var availableDevices: Devices

      /// The current participants.
      @Published
      private(set) var participants: Participants

      /// The current active speaker.
      @Published
      private(set) var activeSpeaker: Participant?

      /// Get the current call state.
      @Published
      private(set) var callState: CallState

      /// The local participant's username.
      @Published
      var username: String? = nil

      @Published
      private(set) var url: URL? = nil
  }
  ```

- Type `protocol CallClientDelegate`:

  ```swift
  protocol CallClientDelegate: AnyObject {
    /// The call state changed, normally as a consequence of invocations to
    /// `CallClient.join()` or `CallClient.leave()`.
    func callClient(_ callClient: CallClient, callStateUpdated state: CallState)

    /// The input settings are updated, normally as a consequence of invocations to
    /// `CallClient.join()`, `CallClient.updateInputs()` or `CallClient.updatePublishing()`.
    func callClient(_ callClient: CallClient, inputsUpdated inputs: InputSettings)

    /// The publishing settings are updated, normally as a consequence of invocations to
    /// `CallClient.join()` or `CallClient.updatePublishing()`.
    func callClient(_ callClient: CallClient, publishingUpdated publishing: PublishingSettings)

    /// A participant has joined the call.
    func callClient(_ callClient: CallClient, participantJoined participant: Participant)

    /// A participant was updated, normally as a consequence of
    /// a participant's metadata getting updated, or its tracks changing.
    func callClient(_ callClient: CallClient, participantUpdated participant: Participant)

    /// A participant has left the call.
    func callClient(_ callClient: CallClient, participantLeft participant: Participant)

    /// The active speaker has changed.
    func callClient(_ callClient: CallClient, activeSpeakerChanged activeSpeaker: Participant?)

    /// The subscription settings are updated, as a consequence of invocations to
    /// `CallClient.updateSubscriptions()`.
    func callClient(_ callClient: CallClient, subscriptionsUpdated subscriptions: SubscriptionSettingsById)

    /// The subscription profile settings are updated, as a consequence of invocations to
    /// `CallClient.updateSubscriptionProfiles()`.
    func callClient(_ callClient: CallClient, subscriptionProfilesUpdated subscriptionProfiles: SubscriptionProfileSettingsByProfile)

    /// An audio device is plugged or unplugged.
    func callClient(_ callClient: CallClient, availableDevicesUpdated availableDevices: Devices)

    /// An error occurred.
    func callClient(_ callClient: CallClient, error: CallClientError)
  }
  ```

- Property `delegate` in `class CallClient`:

  ```swift
  class CallClient {
    weak var delegate: CallClientDelegate?

    // ...
  }
  ```

- Property `permissions` on `struct ParticipantInfo`:

  ```swift
  struct ParticipantInfo {
    // ...

    /// The participant's in-call permissions, present only upon joining.
    let permissions: ParticipantPermissions?
  }
  ```

- Type `struct ParticipantPermissions`:

  ```swift
  /// A participant's in-call permissions.
  struct ParticipantPermissions: Equatable {
    /// Whether the participant has presence
    /// (i.e. whether they show up in others' participants()).
    let hasPresence: Bool

    /// Which kinds of media a participant is allowed to send.
    let canSend: Set<CanSendPermission>
  }
  ```

- Type `enum CanSendPermission`:

  ```swift
  /// Possible values of the canSend participant permission,
  /// which dictates which kinds of media a participant is allowed to send.
  enum CanSendPermission {
      case camera
      case microphone
      case screenVideo
      case screenAudio
      case customVideo
      case customAudio
  }
  ```

  When the local participant's `canSend` permission is updated by a meeting owner, they may end up losing permission to send a kind of media they were previously sending. When permission to send that media is restored, they will automatically resume sending it (assuming `inputs()` and `publishing()` are both still enabled for that media.)

- Type `enum ParticipantLeftReason`:

  ```swift
  /// The reason a participant appears to have left the call.
  enum ParticipantLeftReason: String, RawRepresentable, CaseIterable, Equatable, Hashable {
      /// The participant has lost presence (i.e. their `hasPresence` permissions has been revoked).
      case hidden
      /// The participant has left the room.
      case leftCall
  }
  ```

- Method `callClient(_:participantLeft:withReason:)` in `protocol CallClientDelegate`:

  ```swift
  protocol CallClientDelegate {
    /// A participant has left the call.
    func callClient(_ callClient: CallClient, participantLeft participant: Participant, withReason reason: ParticipantLeftReason)

    // ...
  }
  ```

- Type `enum MediaState`:

  ```swift
  /// The track's state, representing the complete set of
  /// mutually exclusive observable states a track can be in.
  enum MediaState: Equatable, Hashable {
      /// The track is blocked, i.e. does not have permission.
      case blocked
      /// The track is off, but not blocked.
      case off(reasons: Set<MediaOffReason>)
      /// The track has been published and is available to be received, but hasn't been subscribed to.
      case receivable
      /// The track is loading. It has been subscribed to.
      case loading
      /// The track is ready to be played. It has been subscribed to and has finished loading.
      case playable
      /// The track is currently unexpectedly (and hopefully only temporarily) unplayable.
      case interrupted
  }
  ```

- Type `enum MediaOffReason`:

  ```swift
  /// The reason for why a given media was turned off.
  enum MediaOffReason {
    /// The user explicitly wants the media to be off.
    ///
    /// This occurs for remote media with either `isEnabled` or `isPublishing` set to `false` or
    /// local media with `isEnabled` set to `false`.
    case user
    /// The media has been automatically stopped due to bandwidth concerns.
    ///
    /// This only applies to remote media.
    case bandwidth
    /// The media is off due to the sender lacking proper `canSend` permission.
    ///
    /// This only applies to remote media.
    case sendPermission
  }
  ```

- Method `updateRemoteParticipants(_:)` in `class CallClient`:

  ```swift
  /// Modify things about remote participants that you can control as a meeting owner.
  ///
  /// Fails if you're not a meeting owner.
  ///
  /// Returns once the update request has been sent. To handle the update taking effect, listen to the
  /// corresponding delegate method (i.e. `callClient(_:participantUpdated:)`).
  ///
  /// ```
  /// try! call.updateRemoteParticipants([
  ///     remoteParticipantId: .init(
  ///         permissions: .init(
  ///             hasPresence: true,
  ///             canSend: [.camera, .microphone]
  ///         )
  ///     )
  /// ])
  /// ```
  func updateRemoteParticipants(_ updatesById: RemoteParticipantUpdatesById) throws
  ```

- Type alias `RemoteParticipantUpdatesById`:

  ```swift
  typealias RemoteParticipantUpdatesById = [ParticipantId : RemoteParticipantUpdate]
  ```

- Type `struct RemoteParticipantUpdate`:

  ```swift
  /// A desired update to things about a remote participant that you can control as a meeting owner.
  struct RemoteParticipantUpdate {
      /// A desired update to a remote participant's permissions.
      var permissions: ParticipantPermissionsUpdate?

      // ...
  }
  ```

- Type `struct ParticipantPermissionsUpdate`:

  ```swift
  /// A desired update to a participant's in-call permissions.
  struct ParticipantPermissionsUpdate {
      /// Whether the participant has presence (i.e. whether they show up in others' participants()).
      var hasPresence: Bool?

      /// Which kinds of media a participant is allowed to send.
      var canSend: Set<CanSendPermission>?

      // ...
  }
  ```

### Changed

- Made `func updateInputs(…)` overloads of `class CallClient` asynchronous.

  - Before:

    ```swift
    class CallClient {
      func updateInputs(_ closure: (inout InputSettingsUpdate) -> ()) throws -> InputSettings
      func updateInputs(_ inputs: InputSettingsUpdate) throws -> InputSettings
      func updateInputs(_ inputs: Update<InputSettingsUpdate>) throws -> InputSettings

      // ...
    }
    ```

  - After:

    ```swift
    class CallClient {
      func updateInputs(
          _ closure: (inout InputSettingsUpdate) -> (),
          completion: ((Result<InputSettings, CallClientError>) -> Void)? = nil
      )
      func updateInputs(
        _ inputs: InputSettingsUpdate,
        completion: ((Result<InputSettings, CallClientError>) -> Void)? = nil
      )
      func updateInputs(
        _ inputs: Update<InputSettingsUpdate>,
        completion: ((Result<InputSettings, CallClientError>) -> Void)? = nil
      )

      // ...
    }
    ```

- Made `CallClient` execute on the `@MainActor`.

- Marked properties `username` and `url` of `class CallClient` as `@Published`:

  ```swift
  class CallClient {
      /// The local participant's username.
      @Published
      var username: String? = nil

      /// The room's url.
      @Published
      private(set) var url: URL? = nil
  }
  ```

### Removed

- Property `var events: CallClientEventPublishers` in `class CallClient`.

- Type `struct CallClientEventPublishers`.

- Type `enum Event`.

- Type `enum EventAction`.

- Type `struct CallStateUpdatedEvent`.

- Type `struct InputsUpdatedEvent`.

- Type `struct PublishingUpdatedEvent`.

- Type `struct ParticipantJoinedEvent`.

- Type `struct ParticipantUpdatedEvent`.

- Type `struct ParticipantLeftEvent`.

- Type `struct ActiveSpeakerChangedEvent`.

- Type `struct SubscriptionsUpdatedEvent`.

- Type `struct SubscriptionProfilesUpdatedEvent`.

- Type `struct AvailableDevicesUpdatedEvent`.

- Type `struct ErrorEvent`.

## [0.5.0] - 2022-11-11

### Added

- Type `struct MeetingToken`:

  ```swift
  /// Meeting token for controlling room access and session configuration on a per-user basis.
  struct MeetingToken {
      /// String-representation of the meeting token,
      /// as returned from the Daily REST API.
      let stringValue: String

      /// Creates a meeting token from its string representation,
      /// as returned from the Daily REST API.
      init(stringValue: String)
  }
  ```

### Changed

- Method signature of method `join(url:settings:)` to `join(url:token:settings:)` in `CallClient`:

  - Before:

    ```swift
    class CallClient {
        /// Joins a room with the given `DailyCallClientSettings`.
        func join(
            url: URL,
            settings: ClientSettingsUpdate = .init()
        ) throws
    }
    ```

  - After:

    ```swift
    class CallClient {
        /// Joins a room with the given `DailyCallClientSettings`.
        func join(
            url: URL,
            token: MeetingToken? = nil,
            settings: ClientSettingsUpdate = .init()
        ) throws
    }
    ```

## [0.4.0] - 2022-09-30

### Added

- Type `protocol ComplexSettingsUpdate`:

  ```swift
  protocol ComplexSettingsUpdate {
      init()
  }

  extension ComplexSettingsUpdate {
      mutating func callAsFunction<Value>(
          _ keyPath: WritableKeyPath<Self, Update<Value>?>,
          _ value: Update<Value>
      )

      mutating func callAsFunction<Value>(
          _ keyPath: WritableKeyPath<Self, Update<Value>?>,
          _ value: Value
      )

      mutating func callAsFunction<Value: ComplexSettingsUpdate>(
          _ keyPath: WritableKeyPath<Self, Update<Value>?>,
          _ closure: (inout Value) -> ()
      )
  }
  ```

- Type `struct KeyedSettings<K, V>` and corresponding type-aliases:

  ```swift
  typealias KeyedSettings<Key: Hashable, Settings> = [Key: Settings]

  typealias SubscriptionSettingsById = KeyedSettings<ParticipantId, SubscriptionSettings>
  typealias SubscriptionProfileSettingsByProfile = KeyedSettings<SubscriptionProfile, SubscriptionProfileSettings>
  ```

- Type `struct KeyedSettingsUpdate<K, V>` and corresponding type-aliases:

  ```swift
  struct KeyedSettingsUpdate<Key: Hashable, Settings>: ExpressibleByDictionaryLiteral, Sequence, Collection, Encodable, ComplexSettingsUpdate {
      mutating func callAsFunction(
          _ key: Key,
          _ value: Update<Settings>
      )

      mutating func callAsFunction(
          _ key: Key,
          _ value: Settings
      )

      mutating func callAsFunction(
          _ key: Key,
          _ closure: (inout Settings) -> ()
      )
      where
          Settings: ComplexSettingsUpdate

      // ...
  }

  typealias SubscriptionSettingsUpdatesById = KeyedSettingsUpdate<ParticipantId, SubscriptionSettingsUpdate>
  typealias SubscriptionSettingsUpdatesByProfile = KeyedSettingsUpdate<SubscriptionProfile, SubscriptionSettingsUpdate>
  typealias SubscriptionProfileSettingsUpdatesByProfile = KeyedSettingsUpdate<SubscriptionProfile, SubscriptionProfileSettingsUpdate>
  ```

- Method overloads for `func updateInputs(…)` in `class CallClient`:

  ```swift
  class CallClient {
    /// Enable and/or configure media devices for the call, like a camera and microphone.
    func updateInputs(_ inputs: InputSettingsUpdate) throws -> InputSettings

    /// Enable and/or configure media devices for the call, like a camera and microphone.
    func updateInputs(_ closure: (inout InputSettingsUpdate) -> ()) throws -> InputSettings

    // ...
  }
  ```

- Method overloads for `func updatePublishing(…)` in `class CallClient`:

  ```swift
  class CallClient {
    /// Publish and/or configure quality or bandwidth for different media tracks, like the video and audio tracks.
    func updatePublishing(_ publishing: PublishingSettingsUpdate) throws -> PublishingSettings

    /// Publish and/or configure quality or bandwidth for different media tracks, like the video and audio tracks.
    func updatePublishing(_ closure: (inout PublishingSettingsUpdate) -> ()) throws -> PublishingSettings

    // ...
  }
  ```

- Method overloads for `func updateSubscriptions(…)` in `class CallClient`:

  ```swift
  class CallClient {
      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipants subscriptionsById: SubscriptionSettingsUpdatesById
      ) throws -> SubscriptionSettingsById

      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipants closure: (inout SubscriptionSettingsUpdatesById) -> ()
      ) throws -> SubscriptionSettingsById

      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipantsWithProfiles subscriptionsByProfile: SubscriptionSettingsUpdatesByProfile
      ) throws -> SubscriptionSettingsById

      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipantsWithProfiles closure: (inout SubscriptionSettingsUpdatesByProfile) -> ()
      ) throws -> SubscriptionSettingsById

      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipants subscriptionsById: SubscriptionSettingsUpdatesById,
          participantsWithProfiles subscriptionsByProfile: SubscriptionSettingsUpdatesByProfile
      ) throws -> SubscriptionSettingsById

      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipants closureForParticipants: (inout SubscriptionSettingsUpdatesById) -> (),
          participantsWithProfiles closureForParticipantsWithProfiles: (inout SubscriptionSettingsUpdatesByProfile) -> ()
      ) throws -> SubscriptionSettingsById

      // ...
  }
  ```

- Method `func updateSubscriptionProfiles(…)` in `class CallClient`:

  ```swift
  class CallClient {
      /// Insert or modify subscription media settings which apply to an entire profile.
      func updateSubscriptionProfiles(
          _ subscriptionsById: SubscriptionProfileSettingsUpdatesByProfile
      ) throws -> SubscriptionProfileSettingsByProfile

      /// Insert or modify subscription media settings which apply to an entire profile.
      func updateSubscriptionProfiles(
          _ closure: (inout SubscriptionProfileSettingsUpdatesByProfile) -> ()
      ) throws -> SubscriptionProfileSettingsByProfile

      // ...
  }
  ```

### Fixed

- Mutability of `subscriptionState`/`receiveSettings` properties on `struct CameraSubscriptionSettingsUpdate`:

  - Before:

    ```swift
    struct CameraSubscriptionSettingsUpdate {
        let subscriptionState: Update<SubscriptionState>?
        let receiveSettings: Update<VideoReceiveSettingsUpdate>?

        // ...
    }
    ```

  - After:

    ```swift
    struct CameraSubscriptionSettingsUpdate {
        var subscriptionState: Update<SubscriptionState>?
        var receiveSettings: Update<VideoReceiveSettingsUpdate>?

        // ...
    }
    ```

## [0.3.1] - 2022-07-27

### Fixed

- Added missing version number in framework bundle.

## [0.3.0] - 2022-07-22

### Added

- Property `var username: String?` in `class CallClient` (default: `nil`):

  ```swift
  class CallClient {
      /// The local participant's username.
      var username: String? = nil
      // ...
  }
  ```

- Property `var videoScaleMode` in `class VideoView` (default: `.fill`):

  ```swift
  class VideoView {
      /// The view's video scale mode.
      var videoScaleMode: VideoView.VideoScaleMode = .fill

      // ...
  }
  ```

- Type `enum VideoScaleMode` in `class VideoView`:

  ```swift
  final class VideoView: UIView {
      enum VideoScaleMode {
          case fit
          case fill
      }

      // ...
  }
  ```

- Methods `func updateSubscriptions(…)` in `class CallClient`:

  ```swift
  class CallClient {
      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipants: Update<SubscriptionSettingsUpdatesById>
      ) throws -> SubscriptionSettingsById

      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipantsWithProfiles: Update<SubscriptionSettingsUpdatesByProfile>
      ) throws -> SubscriptionSettingsById

      /// Configure how (or if) to subscribe to remote media tracks.
      func updateSubscriptions(
          forParticipants: Update<SubscriptionSettingsUpdatesById>,
          participantsWithProfiles: Update<SubscriptionSettingsUpdatesByProfile>
      ) throws -> SubscriptionSettingsById

      // ...
  }
  ```

- Method `func updateSubscriptionProfiles(…)` in `class CallClient`:

  ```swift
  class CallClient {
      /// Insert or modify subscription media settings which apply to an entire profile.
      func updateSubscriptionProfiles(
          _: Update<SubscriptionProfileSettingsUpdatesByProfile>
      ) throws -> SubscriptionProfileSettingsByProfile

      // ...
  }
  ```

- Property `var subscriptions` in `class CallClient`:

  ```swift
  class CallClient {
      /// The current subscription settings.
      var subscriptions: SubscriptionSettings

      // ...
  }
  ```

- Property `var subscriptionProfiles` in `class CallClient`:

  ```swift
  class CallClient {
      /// The current subscription profile settings.
      var subscriptionProfiles: SubscriptionProfileSettings

      // ...
  }
  ```

- Property `var remote` in `struct Participants`:

  ```swift
  struct Participants {
      /// Remote participants.
      var remote: [PeerId: Participant] { get }

      // ...
  }
  ```

- Properties `var screenVideo` / `var screenAudio` in `struct Participants`:

  ```swift
  struct ParticipantMedia {
      /// The participant's screen video track and track state.
      let screenVideo: ParticipantVideoInfo
      /// The participant's screen audio track and track state.
      let screenAudio: ParticipantAudioInfo
      // ...
  }
  ```

- Type `struct ActiveSpeakerChangedEvent`:

  ```swift
  /// Event emitted when the active speaker has changed.
  struct ActiveSpeakerChangedEvent {
      let participant: Participant?
  }
  ```

- Variant `.activeSpeakerChanged(_)` in `enum Event`:

  ```swift
  enum Event {
      /// Event emitted when the active speaker has changed.
      case activeSpeakerChanged(ActiveSpeakerChangedEvent)

      // ...
  }
  ```

- Method `activeSpeaker()` in `class CallClient`:

  ```swift
  class CallClient {
      /// The current active speaker.
      func activeSpeaker() -> Participant?

      // ...
  }
  ```

- Initializer `init(_:)` in `struct ClientSettingsUpdate`:

  ```swift
  struct ClientSettingsUpdate {
      init(_ closure: (inout Self) -> ())

      // ...
  }
  ```

### Changed

- Name of `struct VideoEncodingsSettings` type, renaming it to `struct VideoEncodingSettingsByQuality`.

  - Before:

    ```swift
    struct VideoEncodingsSettings {
        // ...
    }
    ```

  - After:

    ```swift
    struct VideoEncodingSettingsByQuality {
        // ...
    }
    ```

- Property `override var intrinsicContentSize: CGSize` in `class VideoView`:

  `VideoView` now returns an intrinsic content size based on its video size.

- Name of `struct PeerId` type, renaming it to `struct ParticipantId`.

  - Before:

    ```swift
    struct PeerId {
        // ...
    }
    ```

  - After:

    ```swift
    struct ParticipantId {
        // ...
    }
    ```

- Getter functions on `class CallClient`, converting them to read-only properties:

  - Before:

    ```swift
    class CallClient {
        /// The current active speaker.
        func inputs() -> InputSettings

        /// The current publishing settings.
        func publishing() -> PublishingSettings

        /// The available devices (e.g. cameras, microphones, …).
        func availableDevices() throws -> Devices

        /// The current participants.
        func participants() -> Participants

        /// The current active speaker.
        func activeSpeaker() -> Participant?

        /// Get the current call state.
        func callState() -> CallState

        // ...
    }
    ```

  - After:

    ```swift
    class CallClient {
        /// The current active speaker.
        var inputs: InputSettings { get }

        /// The current publishing settings.
        var publishing: PublishingSettings { get }

        /// The available devices (e.g. cameras, microphones, …).
        var availableDevices: Devices { get throws }

        /// The current participants.
        var participants: Participants { get }

        /// The current active speaker.
        var activeSpeaker: Participant? { get }

        /// Get the current call state.
        var callState: CallState { get }

        // ...
    }
    ```

- Properties (and corresponding initializer) on `class CallClient`, wrapping them in `Update<…>`

  - Before:

    ```swift
    struct ClientSettingsUpdate {
        /// Settings used to select and configure media inputs.
        var inputs: InputSettingsUpdate

        /// Settings used to select and configure track publishing.
        var publishing: PublishingSettingsUpdate

        init(
            inputs: InputSettingsUpdate = .init(),
            publishing: PublishingSettingsUpdate = .init()
        )

        // ...
    }
    ```

  - After:

    ```swift
    struct ClientSettingsUpdate {
        /// Settings used to select and configure media inputs.
        var inputs: Update<InputSettingsUpdate>?

        /// Settings used to select and configure track publishing.
        var publishing: Update<PublishingSettingsUpdate>?

        init(
            inputs: Update<InputSettingsUpdate>? = nil,
            publishing: Update<PublishingSettingsUpdate>? = nil
        )

        // ...
    }
    ```

### Removed

- Leaked internal type `struct MediaStreamTrackPointer`:

  ```swift
  struct MediaStreamTrackPointer {
      // ...
  }
  ```

- Unused type `enum AudioSendSettingsMaxQuality`:

  ```swift
  enum AudioSendSettingsMaxQuality {
      // ...
  }
  ```

- Unused type `enum DeviceId`:

  ```swift
  enum DeviceId {
      // ...
  }
  ```

- Unused type `enum Error`:

  ```swift
  enum Error {
      // ...
  }
  ```

### Fixed

- A bug where the settings passed to `callClient.join(url:settings:)` were ignored.

## [0.2.0] - 2022-06-14

### Changed

<!-- for changes in existing functionality -->

- Types of properties on `struct InputSettings`, making them non-optional:

  - Before:

    ```swift
    struct InputSettings {
        var camera: CameraInputSettings?
        var microphone: MicrophoneInputSettings?

        // ...
    }
    ```

  - After:

    ```swift
    struct InputSettings {
        var camera: CameraInputSettings
        var microphone: MicrophoneInputSettings

        // ...
    }
    ```

- Types of properties on `struct CameraInputSettings`, making them non-optional:

  - Before:

    ```swift
    struct CameraInputSettings {
        var isEnabled: Bool?
        var settings: VideoMediaTrackSettings?

        // ...
    }
    ```

  - After:

    ```swift
    struct CameraInputSettings {
        var isEnabled: Bool
        var settings: VideoMediaTrackSettings

        // ...
    }
    ```

- Types of properties on `struct MicrophoneInputSettings`, making them non-optional:

  - Before:

    ```swift
    struct MicrophoneInputSettings {
        var isEnabled: Bool?
        var settings: AudioMediaTrackSettings?

        // ...
    }
    ```

  - After:

    ```swift
    struct MicrophoneInputSettings {
        var isEnabled: Bool
        var settings: AudioMediaTrackSettings

        // ...
    }
    ```

- Types of properties on `struct PublishingSettings`, making them non-optional:

  - Before:

    ```swift
    struct PublishingSettings {
        let camera: CameraPublishingSettings?
        let microphone: MicrophonePublishingSettings?

        // ...
    }
    ```

  - After:

    ```swift
    struct PublishingSettings {
        let camera: CameraPublishingSettings
        let microphone: MicrophonePublishingSettings

        // ...
    }
    ```

- Types of properties on `struct CameraPublishingSettings`, making them non-optional:

  - Before:

    ```swift
    struct CameraPublishingSettings {
        let isPublishing: Bool?
        let sendSettings: VideoSendSettings?
        let enableInputOnPublish: Bool?

        // ...
    }
    ```

  - After:

    ```swift
    struct CameraPublishingSettings {
        let isPublishing: Bool
        let sendSettings: VideoSendSettings
        let enableInputOnPublish: Bool

        // ...
    }
    ```

- Types of properties on `struct MicrophonePublishingSettings`, making them non-optional:

  - Before:

    ```swift
    struct MicrophonePublishingSettings {
        let isPublishing: Bool?
        let sendSettings: AudioSendSettings?
        let enableInputOnPublish: Bool?

        // ...
    }
    ```

  - After:

    ```swift
    struct MicrophonePublishingSettings {
        let isPublishing: Bool
        let sendSettings: AudioSendSettings
        let enableInputOnPublish: Bool

        // ...
    }
    ```

- Types of properties on `struct VideoMediaTrackSettings`, making them non-optional:

  - Before:

    ```swift
    struct VideoMediaTrackSettings {
        var width: MediaTrackWidth?
        var height: MediaTrackHeight?
        var frameRate: MediaTrackFrameRate?
        var facingMode: MediaTrackFacingMode?

        // ...
    }
    ```

  - After:

    ```swift
    struct VideoMediaTrackSettings {
        var width: MediaTrackWidth
        var height: MediaTrackHeight
        var frameRate: MediaTrackFrameRate
        var facingMode: MediaTrackFacingMode

        // ...
    }
    ```

- Types of properties on `struct AudioSendSettingsConfig`, making them non-optional:

  - Before:

    ```swift
    struct AudioSendSettingsConfig {
        var channelConfig: AudioSendSettingsChannelConfig?

        // ...
    }
    ```

  - After:

    ```swift
    struct AudioSendSettingsConfig {
        var channelConfig: AudioSendSettingsChannelConfig

        // ...
    }
    ```

- Types of properties on `struct VideoEncodingSettings`, making them non-optional:

  - Before:

    ```swift
    struct VideoEncodingSettings {
        var maxBitrate: UInt32?
        var maxFramerate: Float64?
        var scaleResolutionDownBy: Float64?

        // ...
    }
    ```

  - After:

    ```swift
    struct VideoEncodingSettings {
        var maxBitrate: UInt32
        var maxFramerate: Float64
        var scaleResolutionDownBy: Float64

        // ...
    }
    ```

- Types of properties on `struct VideoSendSettings`, making them non-optional:

  - Before:

    ```swift
    struct VideoSendSettings {
        let maxQuality: VideoSendSettingsMaxQuality?
        let encodings: VideoEncodingsSettings?

        // ...
    }
    ```

  - After:

    ```swift
    struct VideoSendSettings {
        let maxQuality: VideoSendSettingsMaxQuality
        let encodings: VideoEncodingsSettings

        // ...
    }
    ```

- Properties on `struct VideoEncodingsSettings`, replacing dictionary with individual properties per value:

  - Before:

    ```swift
    struct VideoEncodingsSettings {
        typealias Key = VideoSendSettingsMaxQuality
        typealias Value = VideoEncodingSettings
        let settings: [Key: Value]

        // ...
    }
    ```

  - After:

    ```swift
    struct VideoEncodingsSettings {
        let low: VideoEncodingSettings
        let medium: VideoEncodingSettings?
        let high: VideoEncodingSettings?

        // ...
    }
    ```

## [0.1.1] - 2022-04-14

Initial release.
