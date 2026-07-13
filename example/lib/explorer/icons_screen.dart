import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';

/// A searchable reference grid of every [GHIconData] in [GHIcons.values],
/// rendered live via [GHHeroIcon].
class IconsScreen extends StatefulWidget {
  const IconsScreen({super.key});

  @override
  State<IconsScreen> createState() => _IconsScreenState();
}

class _IconsScreenState extends State<IconsScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  HeroIconStyle _style = HeroIconStyle.outline;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _label(GHIconData icon) => _titleCase(icon.name.replaceAll('-', ' '));

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final filtered = GHIcons.values.where((icon) => icon.name.toLowerCase().contains(_query.toLowerCase())).toList();

    return ExplorerScaffold(
      title: 'Icons',
      trailing: ExplorerMeta('${filtered.length} icons'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(spacing.md, 0, spacing.md, spacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                  style: context.textStyles.bodyMedium.copyWith(color: colors.onSurface),
                  decoration: InputDecoration(
                    hintText: 'Search icons',
                    hintStyle: context.textStyles.bodyMedium.copyWith(color: colors.onSurfaceVariant),
                    filled: true,
                    fillColor: colors.surface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: context.radii.borderRadiusMd,
                      borderSide: BorderSide(color: colors.outlineVariant),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: context.radii.borderRadiusMd,
                      borderSide: BorderSide(color: colors.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: context.radii.borderRadiusMd,
                      borderSide: BorderSide(color: colors.primary),
                    ),
                  ),
                ),
                SizedBox(height: spacing.sm),
                SegmentedPicker<HeroIconStyle>(
                  options: const [
                    SegmentedPickerOption(value: HeroIconStyle.mini, label: 'Mini'),
                    SegmentedPickerOption(value: HeroIconStyle.outline, label: 'Outline'),
                    SegmentedPickerOption(value: HeroIconStyle.solid, label: 'Solid'),
                  ],
                  selected: _style,
                  onSelected: (value) => setState(() => _style = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No results',
                      style: context.textStyles.bodyMedium.copyWith(color: colors.onSurfaceVariant),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final icon = filtered[index];

                      return Container(
                        padding: EdgeInsets.all(spacing.sm),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: context.radii.borderRadiusMd,
                          border: Border.all(color: colors.outlineVariant),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GHHeroIcon(icon, style: _style, size: 24, color: colors.onSurface),
                            SizedBox(height: spacing.xs),
                            Text(
                              _label(icon),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textStyles.bodySmall.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Converts a space-separated kebab-derived name (e.g. `academic cap`) into a
/// Title Case display label (e.g. `Academic Cap`).
String _titleCase(String words) {
  return words.split(' ').where((word) => word.isNotEmpty).map((word) => '${word[0].toUpperCase()}${word.substring(1)}').join(' ');
}
