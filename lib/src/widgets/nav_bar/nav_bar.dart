import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../spv_theme.dart';

part './nav_bar_fab.dart';
part './nav_bar_fab_button.dart';
part './nav_bar_item.dart';
part './nav_bar_item_button.dart';

const _navigatorBarHeight = 72.0;
const kFabSize = 64.0;
const Duration _duration = Duration(milliseconds: 300);

final _labelsTextStyle = SupervielleTextStyles.xxs.regular;

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.items,
    required this.fab,
    this.currentIndex,
    required this.onIndexChanged,
    this.onSettingsChanged,
    this.forceShrink = false,
    this.forceSelectedItemTap = false,
  }) : super(key: key);

  final List<NavBarItem> items;
  final NavBarFAB fab;
  final int? currentIndex;
  final void Function(int) onIndexChanged;
  final void Function(RouteSettings?)? onSettingsChanged;
  final bool forceShrink;
  final bool forceSelectedItemTap;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxWidth = mediaQuery.size.width;
    const itemFlex = 3;
    const fabFlex = 4;
    final indicatorWidth = maxWidth / (items.length * itemFlex + fabFlex) * itemFlex;
    final fabWidth = maxWidth / (items.length * itemFlex + fabFlex) * fabFlex;
    final bottomPadding = mediaQuery.padding.bottom;
    final currentItem = (currentIndex == null) ? null : items[currentIndex!];

    return SizedBox(
      height: _navigatorBarHeight + bottomPadding,
      child: Material(
        color: SupervielleColors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (currentIndex != null)
              AnimatedPositioned(
                top: 0.0,
                left: (currentIndex! >= items.length * 0.5)
                    ? indicatorWidth * currentIndex! + fabWidth
                    : indicatorWidth * currentIndex!,
                duration: _duration,
                width: indicatorWidth,
                height: 1.0,
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: SupervielleColors.red700),
                ),
              ),
            Positioned.fill(
              // 14.0 porque arriba tiene 12.0, entonces no queda centrado
              bottom: 14.0 + bottomPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: items.fold<List<Widget>>(
                  [],
                  (children, item) {
                    final isHalf = (children.length * 2) == items.length;

                    return children
                      ..addAll(
                        [
                          if (isHalf)
                            Expanded(
                              flex: fabFlex,
                              child: _NavBarFABButton(
                                fab: fab,
                                shrink: forceShrink || currentIndex != 0,
                              ),
                            ),
                          Expanded(
                            flex: itemFlex,
                            child: _NavBarItemButton(
                              item: item,
                              current: currentItem == item,
                              forceSelectedItemTap: forceSelectedItemTap,
                              onChanged: (item) {
                                final index = items.indexOf(item);
                                onIndexChanged(index);
                                onSettingsChanged?.call(item.settings);
                              },
                            ),
                          ),
                        ],
                      );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
