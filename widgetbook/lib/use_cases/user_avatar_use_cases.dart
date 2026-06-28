import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHUserAvatar].
WidgetbookComponent buildUserAvatarComponent() {
  return WidgetbookComponent(
    name: 'GHUserAvatar',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(
        name: 'Playground (Initials)',
        builder: _initialsPlaygroundUseCase,
      ),
      WidgetbookUseCase(name: 'All variants', builder: _allVariantsUseCase),
      WidgetbookUseCase(name: 'Sizes', builder: _sizesUseCase),
      WidgetbookUseCase(name: 'Indicators', builder: _indicatorsUseCase),
      WidgetbookUseCase(
        name: 'Interaction states',
        builder: _interactionStatesUseCase,
      ),
    ],
  );
}

// ── Helpers ──────────────────────────────────────────────────────────────────

enum _StatusKnob { none, online, offline, verifiedBlue, verifiedGreen, number }

GHAvatarStatus _resolveStatus(_StatusKnob knob, int count) => switch (knob) {
  _StatusKnob.none => const GHAvatarStatusNone(),
  _StatusKnob.online => const GHAvatarStatusOnline(),
  _StatusKnob.offline => const GHAvatarStatusOnline(isOnline: false),
  _StatusKnob.verifiedBlue => const GHAvatarStatusVerified(style: GHVerifiedBadgeStyle.twitterBlue),
  _StatusKnob.verifiedGreen => const GHAvatarStatusVerified(),
  _StatusKnob.number => GHAvatarStatusNumber(count: count),
};

// ── Use cases

Widget _playgroundUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<GHAvatarVariant>(
    label: 'Variant',
    options: GHAvatarVariant.values,
    initialOption: GHAvatarVariant.v01,
    labelBuilder: (v) => v.name,
  );
  final size = context.knobs.object.dropdown<GHAvatarSize>(
    label: 'Size',
    options: GHAvatarSize.values,
    initialOption: GHAvatarSize.md,
    labelBuilder: (s) => s.name,
  );
  final statusKnob = context.knobs.object.dropdown<_StatusKnob>(
    label: 'Status',
    options: _StatusKnob.values,
    initialOption: _StatusKnob.none,
    labelBuilder: (s) => s.name,
  );
  final badgeCount = context.knobs.int.slider(
    label: 'Badge count',
    initialValue: 3,
    min: 1,
  );
  final state = context.knobs.object.dropdown<GHAvatarInteractionState>(
    label: 'Interaction state',
    options: GHAvatarInteractionState.values,
    initialOption: GHAvatarInteractionState.active,
    labelBuilder: (s) => s.name,
  );

  return Center(
    child: GHUserAvatar(
      variant,
      size: size,
      status: _resolveStatus(statusKnob, badgeCount),
      interactionState: state,
    ),
  );
}

Widget _initialsPlaygroundUseCase(BuildContext context) {
  final initials = context.knobs.string(label: 'Initials', initialValue: 'AB');
  final size = context.knobs.object.dropdown<GHAvatarSize>(
    label: 'Size',
    options: GHAvatarSize.values,
    initialOption: GHAvatarSize.md,
    labelBuilder: (s) => s.name,
  );
  final statusKnob = context.knobs.object.dropdown<_StatusKnob>(
    label: 'Status',
    options: _StatusKnob.values,
    initialOption: _StatusKnob.none,
    labelBuilder: (s) => s.name,
  );
  final badgeCount = context.knobs.int.slider(label: 'Badge count', initialValue: 3, min: 1);
  final state = context.knobs.object.dropdown<GHAvatarInteractionState>(
    label: 'Interaction state',
    options: GHAvatarInteractionState.values,
    initialOption: GHAvatarInteractionState.active,
    labelBuilder: (s) => s.name,
  );

  return Center(
    child: GHUserAvatar.initials(
      initials,
      size: size,
      status: _resolveStatus(statusKnob, badgeCount),
      interactionState: state,
    ),
  );
}

Widget _allVariantsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final v in GHAvatarVariant.values) GHUserAvatar(v, size: GHAvatarSize.lg),
      ],
    ),
  );
}

Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final s in GHAvatarSize.values) GHUserAvatar(GHAvatarVariant.v01, size: s),
      ],
    ),
  );
}

Widget _indicatorsUseCase(BuildContext context) {
  const sizes = GHAvatarSize.values;
  const variants = [GHAvatarVariant.v02, GHAvatarVariant.v03];

  Widget row(String label, GHAvatarStatus status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final s in sizes)
              GHUserAvatar(
                variants[sizes.indexOf(s) % variants.length],
                size: s,
                status: status,
              ),
            for (final s in sizes) GHUserAvatar.initials('AB', size: s, status: status),
          ],
        ),
      ],
    );
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        row('Online', const GHAvatarStatusOnline()),
        const SizedBox(height: 24),
        row('Offline', const GHAvatarStatusOnline(isOnline: false)),
        const SizedBox(height: 24),
        row(
          'Verified — Twitter Blue',
          const GHAvatarStatusVerified(style: GHVerifiedBadgeStyle.twitterBlue),
        ),
        const SizedBox(height: 24),
        row('Verified — Default Green', const GHAvatarStatusVerified()),
        const SizedBox(height: 24),
        row('Number (3)', const GHAvatarStatusNumber(count: 3)),
        const SizedBox(height: 24),
        row('Number (10+)', const GHAvatarStatusNumber(count: 10)),
      ],
    ),
  );
}

Widget _interactionStatesUseCase(BuildContext context) {
  Widget col(GHAvatarInteractionState state) {
    return Column(
      children: [
        Text(state.name, style: const TextStyle(fontSize: 11)),
        const SizedBox(height: 8),
        GHUserAvatar(
          GHAvatarVariant.v04,
          size: GHAvatarSize.xl,
          interactionState: state,
        ),
        const SizedBox(height: 4),
        GHUserAvatar.initials('AB', size: GHAvatarSize.xl, interactionState: state),
      ],
    );
  }

  return Center(
    child: Wrap(
      spacing: 32,
      runSpacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: GHAvatarInteractionState.values.map(col).toList(),
    ),
  );
}
