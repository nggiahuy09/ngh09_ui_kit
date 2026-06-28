/// Interaction state that controls the box-shadow ring on [GHUserAvatar].
///
/// In a production interactive widget, drive this from a [MouseRegion] or
/// [FocusNode] callback. In Widgetbook or tests, set it directly to preview
/// each state without requiring user interaction.
enum GHAvatarInteractionState {
  /// No shadow — default resting state.
  active,

  /// Cursor-over state: adds a subtle 1 dp grey outline via spread shadow.
  hover,

  /// Keyboard-focus state: adds a 4 dp grey halo around the avatar.
  focused,
}
