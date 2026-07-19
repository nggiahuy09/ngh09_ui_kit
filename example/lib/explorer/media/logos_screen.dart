import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';

/// A searchable reference grid of every [GHCompany] in the logo catalog,
/// rendered live via [GHCompanyLogo].
class LogosScreen extends StatefulWidget {
  const LogosScreen({super.key});

  @override
  State<LogosScreen> createState() => _LogosScreenState();
}

class _LogosScreenState extends State<LogosScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  double _height = 24;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _displayName(GHCompany company) => _titleCase(company.name);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final filtered = GHCompany.values.where((company) => _displayName(company).toLowerCase().contains(_query.toLowerCase())).toList();

    return ExplorerScaffold(
      title: 'Logos',
      trailing: ExplorerMeta('${filtered.length} companies'),
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
                    hintText: 'Search companies',
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
                SegmentedPicker<double>(
                  options: const [
                    SegmentedPickerOption(value: 20, label: '20px'),
                    SegmentedPickerOption(value: 24, label: '24px'),
                    SegmentedPickerOption(value: 32, label: '32px'),
                  ],
                  selected: _height,
                  onSelected: (value) => setState(() => _height = value),
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
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final company = filtered[index];

                      return Container(
                        padding: EdgeInsets.all(spacing.smd),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: context.radii.borderRadiusLg,
                          border: Border.all(color: colors.outlineVariant),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GHCompanyLogo(company, height: _height),
                            SizedBox(height: spacing.xs),
                            Text(
                              _displayName(company),
                              textAlign: TextAlign.center,
                              maxLines: 1,
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

/// Converts a camelCase enum name (e.g. `activeCampaign`) into a Title Case
/// display label (e.g. `Active Campaign`).
String _titleCase(String camelCase) {
  final buffer = StringBuffer();

  for (var i = 0; i < camelCase.length; i++) {
    final char = camelCase[i];

    if (i == 0) {
      buffer.write(char.toUpperCase());
      continue;
    }

    if (char.toUpperCase() == char && char.toLowerCase() != char) {
      buffer.write(' ');
    }

    buffer.write(char);
  }

  return buffer.toString();
}
