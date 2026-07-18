import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// The Finesse UI Kit this app's design system is derived from.
const _finesseTitle = 'Finesse UI – Figma UI Kit and Design System';
const _finesseSubtitle = 'FREE (Community) · Version 1.0';
final _finesseUrl = Uri.parse(
  'https://www.figma.com/community/file/1227728490805632361',
);

/// Shows the "About" modal bottom sheet describing the app: what it contains,
/// its version, and the Finesse UI Kit it is built on.
Future<void> showAboutAppSheet(BuildContext context) {
  final colors = context.colors;
  final radii = context.radii;
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radii.lg)),
    ),
    builder: (_) => const _AboutSheet(),
  );
}

class _AboutSheet extends StatelessWidget {
  const _AboutSheet();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final radii = context.radii;
    final textStyles = context.textStyles;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          spacing.lg,
          spacing.xs,
          spacing.lg,
          spacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App identity.
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _AppMark(colors: colors, radii: radii),
                SizedBox(width: spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ngh09 UI',
                        style: textStyles.titleLarge.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: spacing.xxs),
                      const _VersionLine(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.lg),

            Text(
              'A design system explorer for the ngh09_ui_kit: a navigable '
              'showcase of the kit\'s components — buttons, inputs, navigation, '
              'feedback, media — and its foundation tokens: colors, typography, '
              'spacing, radii, shadows, breakpoints and durations, all built on '
              'the kit\'s real widgets and theme layer.',
              style: textStyles.bodyMedium.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            SizedBox(height: spacing.lg),

            // Credit / attribution to the Finesse UI Kit.
            _CreditCard(
              colors: colors,
              spacing: spacing,
              radii: radii,
              textStyles: textStyles,
            ),
          ],
        ),
      ),
    );
  }
}

/// The app's "09" brand mark, rendered as a small monogram tile.
class _AppMark extends StatelessWidget {
  const _AppMark({required this.colors, required this.radii});

  final GHAppColors colors;
  final GHAppRadii radii;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: colors.onSurface,
        borderRadius: BorderRadius.circular(radii.md),
      ),
      alignment: Alignment.center,
      child: Text(
        '09',
        style: TextStyle(
          color: colors.surface,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
        ),
      ),
    );
  }
}

/// Reads and displays the app version from the bundle: `v<version> (<build>)`.
class _VersionLine extends StatefulWidget {
  const _VersionLine();

  @override
  State<_VersionLine> createState() => _VersionLineState();
}

class _VersionLineState extends State<_VersionLine> {
  String? _version;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) {
        setState(() => _version = 'v${info.version} (${info.buildNumber})');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    return Text(
      _version ?? 'Design system explorer',
      style: textStyles.bodySmall.copyWith(color: colors.onSurfaceVariant),
    );
  }
}

/// Attribution card linking to the Finesse UI Kit on the Figma community.
class _CreditCard extends StatelessWidget {
  const _CreditCard({
    required this.colors,
    required this.spacing,
    required this.radii,
    required this.textStyles,
  });

  final GHAppColors colors;
  final GHAppSpacing spacing;
  final GHAppRadii radii;
  final GHAppTypography textStyles;

  Future<void> _openFinesse(BuildContext context) async {
    final ok = await launchUrl(_finesseUrl, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: GHSnackbar(
              message: 'Could not open the link.',
              state: GHSnackbarState.error,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.zero,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(spacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(radii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BUILT ON',
            style: textStyles.labelSmall.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: spacing.sm),
          Text(
            '❖ $_finesseTitle',
            style: textStyles.bodyMedium.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spacing.xxs),
          Text(
            _finesseSubtitle,
            style: textStyles.bodySmall.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: spacing.md),
          GHAppButton.outlined(
            label: 'View on Figma Community',
            expanded: true,
            leading: const GHHeroIcon(GHIcons.arrowTopRightOnSquare, size: 18),
            onPressed: () => _openFinesse(context),
          ),
        ],
      ),
    );
  }
}
