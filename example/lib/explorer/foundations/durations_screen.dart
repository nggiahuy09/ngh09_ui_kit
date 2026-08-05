import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';

class _DurationStep {
  const _DurationStep(this.name, this.value);

  final String name;
  final Duration value;
}

/// A static reference display of the kit's animation durations, read live from [DurationTokens]. Tap a row to replay a short animated demo at that duration so the different speeds can be felt, not just read.
class DurationsScreen extends StatelessWidget {
  const DurationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    final steps = [
      const _DurationStep('fast', DurationTokens.fast),
      const _DurationStep('normal', DurationTokens.normal),
      const _DurationStep('slow', DurationTokens.slow),
    ];

    return ExplorerScaffold(
      title: 'Durations',
      trailing: const ExplorerMeta('3 tokens'),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        itemCount: steps.length,
        separatorBuilder: (context, index) => SizedBox(height: spacing.sm),
        itemBuilder: (context, index) => _DurationDemoCard(step: steps[index]),
      ),
    );
  }
}

class _DurationDemoCard extends StatefulWidget {
  const _DurationDemoCard({required this.step});

  final _DurationStep step;

  @override
  State<_DurationDemoCard> createState() => _DurationDemoCardState();
}

class _DurationDemoCardState extends State<_DurationDemoCard> {
  bool _atEnd = false;

  void _replay() {
    setState(() => _atEnd = false);
    Future.delayed(const Duration(milliseconds: 16), () {
      if (mounted) setState(() => _atEnd = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    return Material(
      color: colors.surface,
      borderRadius: context.radii.borderRadiusMd,
      child: InkWell(
        onTap: _replay,
        borderRadius: context.radii.borderRadiusMd,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.smd),
          decoration: BoxDecoration(
            borderRadius: context.radii.borderRadiusMd,
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.step.name,
                    style: context.textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.step.value.inMilliseconds}ms',
                    style: GoogleFonts.jetBrainsMono(fontSize: 12, color: colors.onSurfaceVariant),
                  ),
                  SizedBox(width: spacing.sm),
                  Icon(Icons.replay, size: 16, color: colors.onSurfaceVariant),
                ],
              ),
              SizedBox(height: spacing.smd),
              SizedBox(
                height: 12,
                child: Stack(
                  children: [
                    Container(
                      height: 4,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(color: colors.surfaceVariant, borderRadius: BorderRadius.circular(2)),
                    ),
                    AnimatedAlign(
                      duration: widget.step.value,
                      curve: Curves.easeInOut,
                      alignment: _atEnd ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(color: colors.onSurface, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
