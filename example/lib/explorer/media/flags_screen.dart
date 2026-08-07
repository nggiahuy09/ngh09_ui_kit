import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';

enum _FlagSize { small, medium, large }

extension on _FlagSize {
  double get value => switch (this) {
    _FlagSize.small => 24,
    _FlagSize.medium => 32,
    _FlagSize.large => 48,
  };
}

/// A searchable reference grid of every [GHCountry] in the flag catalog, rendered live via [GHCountryFlag].
class FlagsScreen extends StatefulWidget {
  const FlagsScreen({super.key});

  @override
  State<FlagsScreen> createState() => _FlagsScreenState();
}

class _FlagsScreenState extends State<FlagsScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  bool _circular = true;
  _FlagSize _size = _FlagSize.medium;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _displayName(GHCountry country) => _titleCase(country.name);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final filtered = GHCountry.values.where((country) => _displayName(country).toLowerCase().contains(_query.toLowerCase())).toList();

    return ExplorerScaffold(
      title: 'Flags',
      trailing: ExplorerMeta('${filtered.length} countries'),
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
                    hintText: 'Search countries',
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
                Row(
                  children: [
                    Expanded(
                      child: SegmentedPicker<_FlagSize>(
                        options: const [
                          SegmentedPickerOption(value: _FlagSize.small, label: 'Small'),
                          SegmentedPickerOption(value: _FlagSize.medium, label: 'Medium'),
                          SegmentedPickerOption(value: _FlagSize.large, label: 'Large'),
                        ],
                        selected: _size,
                        onSelected: (value) => setState(() => _size = value),
                      ),
                    ),
                    SizedBox(width: spacing.smd),
                    _CircularToggle(value: _circular, onChanged: (value) => setState(() => _circular = value)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text('No results', style: context.textStyles.bodyMedium.copyWith(color: colors.onSurfaceVariant)),
                  )
                : GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final country = filtered[index];

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
                            GHCountryFlag(country, size: _size.value, circular: _circular),
                            SizedBox(height: spacing.xs),
                            Text(
                              _displayName(country),
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

class _CircularToggle extends StatelessWidget {
  const _CircularToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.surface,
      borderRadius: context.radii.borderRadiusMd,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: context.radii.borderRadiusMd,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: context.radii.borderRadiusMd,
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Circular', style: context.textStyles.labelMedium.copyWith(color: colors.onSurfaceVariant)),
              SizedBox(
                height: 24,
                child: Switch(value: value, onChanged: onChanged, activeTrackColor: colors.success),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Converts a camelCase enum name (e.g. `unitedStates`) into a Title Case display label (e.g. `United States`).
String _titleCase(String camelCase) {
  final buffer = StringBuffer();

  for (var i = 0; i < camelCase.length; i++) {
    final char = camelCase[i];

    if (i == 0) {
      buffer.write(char.toUpperCase());
      continue;
    }

    if (char.toUpperCase() == char && char.toLowerCase() != char) buffer.write(' ');

    buffer.write(char);
  }

  return buffer.toString();
}
