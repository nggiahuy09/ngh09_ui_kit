import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/buttons/app_button.dart';
import 'package:ngh09_ui_kit/src/components/buttons/button_variant.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/components/icons/heroicon_style.dart';
import 'package:ngh09_ui_kit/src/components/navigation/pagination_type.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A page-navigation control with "Previous"/"Next" actions and, in [PaginationType.numbered] mode, tappable page-number chips — per the Finesse UI Kit spec.
///
/// Long page ranges collapse to a "…" around the current page. The collapsing window is controlled by [siblingCount] (pages shown on either side of the current page) and [boundaryCount] (pages always shown at each end) — the same "sibling + boundary" algorithm used by most web pagination components, which keeps the control's width constant as the user moves between pages.
///
/// ```dart
/// GHPagination(
///   currentPage: page,
///   totalPages: 10,
///   onPageChanged: (p) => setState(() => page = p),
/// );
///
/// GHPagination(
///   currentPage: page,
///   totalPages: 10,
///   onPageChanged: (p) => setState(() => page = p),
///   type: PaginationType.simple,
///   showNavLabels: false,
/// );
/// ```
class GHPagination extends StatelessWidget {
  /// Creates a pagination control for [totalPages] pages, currently on [currentPage] (1-indexed).
  const GHPagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.type = PaginationType.numbered,
    this.showNavLabels = true,
    this.siblingCount = 1,
    this.boundaryCount = 1,
    super.key,
  }) : assert(totalPages > 0, 'GHPagination needs at least one page.'),
       assert(currentPage >= 1 && currentPage <= totalPages, 'currentPage must be within [1, totalPages].');

  /// The active page, 1-indexed.
  final int currentPage;

  /// The total number of pages.
  final int totalPages;

  /// Called with the new page number when "Previous", "Next", or a page chip is tapped.
  final ValueChanged<int> onPageChanged;

  /// Whether to show individual page-number chips or a "Page X of Y" label. See [PaginationType].
  final PaginationType type;

  /// Whether the "Previous"/"Next" controls show their text label.
  ///
  /// When `false`, they render as bare arrow icons — a compact layout for tight spaces.
  final bool showNavLabels;

  /// Pages shown adjacent to the current page before collapsing to "…".
  ///
  /// Only used when [type] is [PaginationType.numbered].
  final int siblingCount;

  /// Pages always shown at the start and end of the range.
  ///
  /// Only used when [type] is [PaginationType.numbered].
  final int boundaryCount;

  bool get _hasPrevious => currentPage > 1;
  bool get _hasNext => currentPage < totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: context.spacing.sm,
      children: [
        _NavButton(
          direction: _NavDirection.previous,
          showLabel: showNavLabels,
          onPressed: _hasPrevious ? () => onPageChanged(currentPage - 1) : null,
        ),
        if (type == PaginationType.simple)
          Text(
            'Page $currentPage of $totalPages',
            style: context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: context.colors.onSurface),
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: context.spacing.xs,
            children: [
              for (final page in paginationRange(current: currentPage, total: totalPages, siblingCount: siblingCount, boundaryCount: boundaryCount))
                page == null
                    ? const _PageEllipsis()
                    : _PageNumber(page: page, active: page == currentPage, onTap: page == currentPage ? null : () => onPageChanged(page)),
            ],
          ),
        _NavButton(
          direction: _NavDirection.next,
          showLabel: showNavLabels,
          onPressed: _hasNext ? () => onPageChanged(currentPage + 1) : null,
        ),
      ],
    );
  }
}

/// Computes the page numbers a [GHPagination] should render, using `null` as an ellipsis marker.
///
/// Mirrors the standard "sibling + boundary" collapsing algorithm used by most pagination components (e.g. MUI's `usePagination`): the sibling window is extended near either boundary so the total item count — and therefore the control's width — stays constant across positions.
List<int?> paginationRange({required int current, required int total, required int siblingCount, required int boundaryCount}) {
  final totalVisible = boundaryCount * 2 + siblingCount * 2 + 3;
  if (total <= totalVisible) return List<int?>.generate(total, (i) => i + 1);

  final startPages = List<int>.generate(boundaryCount, (i) => i + 1);
  final endPages = List<int>.generate(boundaryCount, (i) => total - boundaryCount + i + 1);

  final siblingsStart = math.max(math.min(current - siblingCount, total - boundaryCount - siblingCount * 2 - 1), boundaryCount + 2);
  final siblingsEnd = math.min(
    math.max(current + siblingCount, boundaryCount + siblingCount * 2 + 2),
    endPages.isNotEmpty ? endPages.first - 2 : total - 1,
  );

  return [
    ...startPages,
    if (siblingsStart > boundaryCount + 2) null else if (boundaryCount + 1 < siblingsStart) boundaryCount + 1,
    for (var page = siblingsStart; page <= siblingsEnd; page++) page,
    if (siblingsEnd < total - boundaryCount - 1) null else if (total - boundaryCount > siblingsEnd) total - boundaryCount,
    ...endPages,
  ];
}

enum _NavDirection { previous, next }

/// The "Previous"/"Next" control at either end of a [GHPagination].
class _NavButton extends StatelessWidget {
  const _NavButton({required this.direction, required this.showLabel, required this.onPressed});

  final _NavDirection direction;
  final bool showLabel;
  final VoidCallback? onPressed;

  bool get _isPrevious => direction == _NavDirection.previous;

  @override
  Widget build(BuildContext context) {
    final icon = GHHeroIcon(_isPrevious ? GHIcons.arrowLeft : GHIcons.arrowRight, style: HeroIconStyle.mini, size: 18);

    if (showLabel) {
      return GHAppButton.secondaryGrey(
        label: _isPrevious ? 'Previous' : 'Next',
        size: ButtonSize.small,
        onPressed: onPressed,
        leading: _isPrevious ? icon : null,
        trailing: _isPrevious ? null : icon,
      );
    }

    final color = onPressed != null ? context.colors.onSurface : context.colors.outline;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: _isPrevious ? 'Previous page' : 'Next page',
      onTap: onPressed,
      child: MouseRegion(
        cursor: onPressed != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: ExcludeSemantics(
            child: SizedBox(
              width: 32,
              height: 32,
              child: Center(
                child: IconTheme.merge(
                  data: IconThemeData(color: color),
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A single tappable page-number chip.
class _PageNumber extends StatelessWidget {
  const _PageNumber({required this.page, required this.active, required this.onTap});

  final int page;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: active ? colors.onPrimary : colors.onSurface);

    final chip = Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: active ? colors.primary : null, borderRadius: context.radii.borderRadiusMd),
      child: Text('$page', style: style),
    );

    return Semantics(
      button: true,
      enabled: onTap != null,
      selected: active,
      label: 'Page $page',
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: ExcludeSemantics(child: chip),
        ),
      ),
    );
  }
}

/// The "…" collapse marker between page-number chips.
class _PageEllipsis extends StatelessWidget {
  const _PageEllipsis();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 32,
    height: 32,
    child: Center(
      child: Text(
        '...',
        style: context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: context.colors.onSurfaceVariant),
      ),
    ),
  );
}
