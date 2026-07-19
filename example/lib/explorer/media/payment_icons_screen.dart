import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';

/// A searchable reference grid of every [GHPaymentMethod] in the payment
/// icon catalog, rendered live via [GHPaymentIcon].
class PaymentIconsScreen extends StatefulWidget {
  const PaymentIconsScreen({super.key});

  @override
  State<PaymentIconsScreen> createState() => _PaymentIconsScreenState();
}

class _PaymentIconsScreenState extends State<PaymentIconsScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  GHPaymentIconSize _size = GHPaymentIconSize.sm;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final filtered = GHPaymentMethod.values.where((method) => method.displayName.toLowerCase().contains(_query.toLowerCase())).toList();

    return ExplorerScaffold(
      title: 'Payment icons',
      trailing: ExplorerMeta('${filtered.length} methods'),
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
                    hintText: 'Search payment methods',
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
                SegmentedPicker<GHPaymentIconSize>(
                  options: const [
                    SegmentedPickerOption(value: GHPaymentIconSize.sm, label: 'Small'),
                    SegmentedPickerOption(value: GHPaymentIconSize.md, label: 'Medium'),
                    SegmentedPickerOption(value: GHPaymentIconSize.lg, label: 'Large'),
                  ],
                  selected: _size,
                  onSelected: (value) => setState(() => _size = value),
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
                      final method = filtered[index];

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
                            GHPaymentIcon(method, size: _size),
                            SizedBox(height: spacing.xs),
                            Text(
                              method.displayName,
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
