import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/kept_theme.dart';

export 'package:cupertino_native/cupertino_native.dart'
    show
        CNButton,
        CNButtonStyle,
        CNPopupMenuButton,
        CNPopupMenuItem,
        CNSegmentedControl,
        CNSymbol,
        CNSwitch,
        CNTabBar,
        CNTabBarItem;

/// True when we should host native Liquid Glass / UIKit controls.
bool get keptUsesNativeCupertino =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

/// Share-to-feed style row with [CNSwitch] on iOS, Material elsewhere.
class KeptNativeSwitchTile extends StatelessWidget {
  const KeptNativeSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      color: context.kept.paper,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
    );
    final subtitleStyle = TextStyle(
      color: context.kept.mist,
      fontSize: 12,
      fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
    );

    if (!keptUsesNativeCupertino) {
      return SwitchListTile.adaptive(
        contentPadding: EdgeInsets.zero,
        value: value,
        activeThumbColor: KeptTheme.accent,
        title: Text(title, style: titleStyle),
        subtitle: subtitle == null
            ? null
            : Text(subtitle!, style: subtitleStyle),
        onChanged: onChanged,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: titleStyle),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: subtitleStyle),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          CNSwitch(
            value: value,
            onChanged: onChanged,
            height: 36,
            color: KeptTheme.accent,
          ),
        ],
      ),
    );
  }
}

/// Native [CNButton.icon] on iOS; Material [IconButton] elsewhere.
class KeptNativeIconButton extends StatelessWidget {
  const KeptNativeIconButton({
    super.key,
    required this.symbol,
    required this.onPressed,
    this.size = 44,
    this.materialIcon,
    this.style = CNButtonStyle.glass,
    this.tint = KeptTheme.accent,
    this.tooltip,
  });

  final String symbol;
  final VoidCallback? onPressed;
  final double size;
  final IconData? materialIcon;
  final CNButtonStyle style;
  final Color tint;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    if (keptUsesNativeCupertino) {
      final button = CNButton.icon(
        icon: CNSymbol(symbol, size: size * 0.42),
        onPressed: onPressed,
        enabled: onPressed != null,
        tint: tint,
        size: size,
        style: style,
      );
      if (tooltip == null) return button;
      return Tooltip(message: tooltip!, child: button);
    }

    final icon = Icon(materialIcon ?? Icons.circle, size: size * 0.5);
    final button = IconButton.filled(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: tint,
        foregroundColor: context.kept.void_,
        disabledBackgroundColor: context.kept.line,
      ),
      icon: icon,
      tooltip: tooltip,
    );
    return button;
  }
}
