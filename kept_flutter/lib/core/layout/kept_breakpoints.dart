import 'package:flutter/material.dart';

/// Layout breakpoints based on available window width (not device type).
abstract final class KeptBreakpoints {
  static const double compact = 600;
  static const double medium = 900;
  static const double expanded = 1200;

  static const double contentMax = 720;
  static const double contentWide = 960;
  static const double railWidth = 88;
  static const double railExtendedWidth = 220;
}

extension KeptBreakpointContext on BuildContext {
  double get keptWidth => MediaQuery.sizeOf(this).width;

  bool get keptIsCompact => keptWidth < KeptBreakpoints.compact;

  bool get keptIsMedium =>
      keptWidth >= KeptBreakpoints.compact &&
      keptWidth < KeptBreakpoints.expanded;

  bool get keptIsWide => keptWidth >= KeptBreakpoints.compact;

  bool get keptUseNavigationRail => keptWidth >= KeptBreakpoints.compact;
}

/// Centers children and caps width so feeds/forms don't stretch on desktop web.
class KeptContentWidth extends StatelessWidget {
  const KeptContentWidth({
    super.key,
    required this.child,
    this.maxWidth = KeptBreakpoints.contentMax,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Cap Instagram-style media height on wide screens.
double keptFeedMediaHeight(BuildContext context, {double ratio = 0.92}) {
  final width = MediaQuery.sizeOf(context).width;
  final contentW = width > KeptBreakpoints.contentMax
      ? KeptBreakpoints.contentMax
      : width;
  final h = contentW * ratio;
  return h.clamp(220.0, 520.0);
}
