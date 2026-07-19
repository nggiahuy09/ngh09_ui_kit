import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/spec_panel.dart';

enum _AvatarKind { portrait, initials }

enum _StatusKind { none, online, verified, number }

/// A live playground for [GHUserAvatar]: switch between the portrait and
/// [GHUserAvatar.initials] constructors, pick a size, status badge, and
/// interaction state, with a spec string reflecting the choice.
class AvatarPlaygroundScreen extends StatefulWidget {
  const AvatarPlaygroundScreen({super.key});

  @override
  State<AvatarPlaygroundScreen> createState() => _AvatarPlaygroundScreenState();
}

class _AvatarPlaygroundScreenState extends State<AvatarPlaygroundScreen> {
  _AvatarKind _kind = _AvatarKind.portrait;
  GHAvatarVariant _variant = GHAvatarVariant.v01;
  GHAvatarSize _size = GHAvatarSize.md;
  _StatusKind _statusKind = _StatusKind.none;
  bool _isOnline = true;
  GHVerifiedBadgeStyle _verifiedStyle = GHVerifiedBadgeStyle.defaultGreen;
  int _count = 5;
  GHAvatarInteractionState _interactionState = GHAvatarInteractionState.active;
  final _initialsController = TextEditingController(text: 'JD');

  @override
  void dispose() {
    _initialsController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _kind = _AvatarKind.portrait;
      _variant = GHAvatarVariant.v01;
      _size = GHAvatarSize.md;
      _statusKind = _StatusKind.none;
      _isOnline = true;
      _verifiedStyle = GHVerifiedBadgeStyle.defaultGreen;
      _count = 5;
      _interactionState = GHAvatarInteractionState.active;
      _initialsController.text = 'JD';
    });
  }

  String get _initials => _initialsController.text.isEmpty ? 'JD' : _initialsController.text;

  GHAvatarStatus get _status => switch (_statusKind) {
    _StatusKind.none => const GHAvatarStatusNone(),
    _StatusKind.online => GHAvatarStatusOnline(isOnline: _isOnline),
    _StatusKind.verified => GHAvatarStatusVerified(style: _verifiedStyle),
    _StatusKind.number => GHAvatarStatusNumber(count: _count),
  };

  String get _statusSpec => switch (_statusKind) {
    _StatusKind.none => '',
    _StatusKind.online => 'status: GHAvatarStatusOnline(isOnline: $_isOnline)',
    _StatusKind.verified => 'status: GHAvatarStatusVerified(style: ${_verifiedStyle.name})',
    _StatusKind.number => 'status: GHAvatarStatusNumber(count: $_count)',
  };

  String get _spec {
    final parts = <String>['size: ${_size.name}'];
    if (_statusSpec.isNotEmpty) parts.add(_statusSpec);
    if (_interactionState != GHAvatarInteractionState.active) parts.add('interactionState: ${_interactionState.name}');
    return switch (_kind) {
      _AvatarKind.portrait => 'GHUserAvatar(${_variant.name}, ${parts.join(', ')})',
      _AvatarKind.initials => "GHUserAvatar.initials('$_initials', ${parts.join(', ')})",
    };
  }

  Widget get _avatar {
    return switch (_kind) {
      _AvatarKind.portrait => GHUserAvatar(
        _variant,
        size: _size,
        status: _status,
        interactionState: _interactionState,
      ),
      _AvatarKind.initials => GHUserAvatar.initials(
        _initials,
        size: _size,
        status: _status,
        interactionState: _interactionState,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Avatars',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(child: _avatar),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('KIND'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_AvatarKind>(
            selected: _kind,
            onSelected: (v) => setState(() => _kind = v),
            options: const [
              SegmentedPickerOption(value: _AvatarKind.portrait, label: 'Portrait'),
              SegmentedPickerOption(value: _AvatarKind.initials, label: 'Initials'),
            ],
          ),
          SizedBox(height: spacing.lg),
          if (_kind == _AvatarKind.portrait) ...[
            const ExplorerEyebrow('VARIANT'),
            SizedBox(height: spacing.sm),
            GHAppInputDropdown<GHAvatarVariant>(
              searchable: false,
              placeholder: _variant.name,
              onChanged: (v) => setState(() => _variant = v),
              items: [
                for (final v in GHAvatarVariant.values) GHDropdownMenuItem(value: v, label: v.name),
              ],
            ),
          ] else ...[
            const ExplorerEyebrow('INITIALS'),
            SizedBox(height: spacing.sm),
            LabelField(
              controller: _initialsController,
              onChanged: () => setState(() {}),
            ),
          ],
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHAvatarSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: GHAvatarSize.xs, label: 'XS'),
              SegmentedPickerOption(value: GHAvatarSize.sm, label: 'S'),
              SegmentedPickerOption(value: GHAvatarSize.md, label: 'M'),
              SegmentedPickerOption(value: GHAvatarSize.lg, label: 'L'),
              SegmentedPickerOption(value: GHAvatarSize.xl, label: 'XL'),
              SegmentedPickerOption(value: GHAvatarSize.xxl, label: '2XL'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATUS'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_StatusKind>(
            selected: _statusKind,
            onSelected: (v) => setState(() => _statusKind = v),
            options: const [
              SegmentedPickerOption(value: _StatusKind.none, label: 'None'),
              SegmentedPickerOption(value: _StatusKind.online, label: 'Online'),
              SegmentedPickerOption(value: _StatusKind.verified, label: 'Verified'),
              SegmentedPickerOption(value: _StatusKind.number, label: 'Number'),
            ],
          ),
          if (_statusKind == _StatusKind.online) ...[
            SizedBox(height: spacing.sm),
            OptionToggleRow(
              title: 'Is online',
              subtitle: 'Green dot vs grey (offline) dot',
              value: _isOnline,
              onChanged: (v) => setState(() => _isOnline = v),
            ),
          ],
          if (_statusKind == _StatusKind.verified) ...[
            SizedBox(height: spacing.sm),
            SegmentedPicker<GHVerifiedBadgeStyle>(
              selected: _verifiedStyle,
              onSelected: (v) => setState(() => _verifiedStyle = v),
              options: const [
                SegmentedPickerOption(value: GHVerifiedBadgeStyle.twitterBlue, label: 'Twitter Blue'),
                SegmentedPickerOption(value: GHVerifiedBadgeStyle.defaultGreen, label: 'Default Green'),
              ],
            ),
          ],
          if (_statusKind == _StatusKind.number) ...[
            SizedBox(height: spacing.sm),
            SegmentedPicker<int>(
              selected: _count,
              onSelected: (v) => setState(() => _count = v),
              options: const [
                SegmentedPickerOption(value: 1, label: '1'),
                SegmentedPickerOption(value: 5, label: '5'),
                SegmentedPickerOption(value: 42, label: '42'),
                SegmentedPickerOption(value: 99, label: '99'),
              ],
            ),
          ],
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('INTERACTION STATE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHAvatarInteractionState>(
            selected: _interactionState,
            onSelected: (v) => setState(() => _interactionState = v),
            options: const [
              SegmentedPickerOption(value: GHAvatarInteractionState.active, label: 'Active'),
              SegmentedPickerOption(value: GHAvatarInteractionState.hover, label: 'Hover'),
              SegmentedPickerOption(value: GHAvatarInteractionState.focused, label: 'Focused'),
            ],
          ),
        ],
      ),
    );
  }
}
