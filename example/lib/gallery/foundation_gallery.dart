import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/gallery/badges_showcase.dart';
import 'package:ngh09_ui_kit_example/gallery/buttons_showcase.dart';
import 'package:ngh09_ui_kit_example/gallery/chips_showcase.dart';
import 'package:ngh09_ui_kit_example/gallery/colors_showcase.dart';
import 'package:ngh09_ui_kit_example/gallery/radii_showcase.dart';
import 'package:ngh09_ui_kit_example/gallery/section.dart';
import 'package:ngh09_ui_kit_example/gallery/spacing_showcase.dart';
import 'package:ngh09_ui_kit_example/gallery/typography_showcase.dart';

/// A scrollable gallery showcasing the kit's components and foundation tokens.
class FoundationGallery extends StatelessWidget {
  const FoundationGallery({
    required this.isDark,
    required this.onToggleTheme,
    super.key,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: const Text('ngh09_ui_kit'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
          SizedBox(width: spacing.sm),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spacing.md),
        children: const [
          Section(title: 'Buttons', child: ButtonsShowcase()),
          Section(title: 'Badges', child: BadgesShowcase()),
          Section(title: 'Chips', child: ChipsShowcase()),
          Section(title: 'Colors', child: ColorsShowcase()),
          Section(title: 'Typography', child: TypographyShowcase()),
          Section(title: 'Spacing', child: SpacingShowcase()),
          Section(title: 'Radii', child: RadiiShowcase()),
        ],
      ),
    );
  }
}
