part of './nav_bar.dart';

const Duration _fabDuration = Duration(milliseconds: 300);
const Duration _fabReverseDuration = Duration(milliseconds: 600);
const Curve _fabCurve = Curves.easeInOutBack;

class _NavBarFABButton extends StatefulWidget {
  const _NavBarFABButton({
    Key? key,
    required this.fab,
    required this.shrink,
  }) : super(key: key);

  final NavBarFAB fab;
  final bool shrink;

  @override
  __NavBarFABButtonState createState() => __NavBarFABButtonState();
}

class __NavBarFABButtonState extends State<_NavBarFABButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sizeAnimation;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      reverseDuration: _fabReverseDuration,
      duration: _fabDuration,
      value: (widget.shrink) ? 0.0 : 1.0,
    );

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: _fabCurve,
    );

    _colorAnimation = ColorTween(begin: widget.fab.smallColor, end: widget.fab.bigColor).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _NavBarFABButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldShrink = oldWidget.shrink;
    final newShrink = widget.shrink;
    if (oldShrink != newShrink) {
      if (newShrink) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      child: Text(
        widget.fab.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _labelsTextStyle.apply(
          color: SupervielleColors.grey800,
        ),
      ),
      builder: (_, label) {
        if (_controller.value == 0.0) {
          return _NavBarItemButton(
            item: NavBarItem(
              icon: widget.fab.icon,
              label: widget.fab.label,
            ),
            onChanged: (_) => widget.fab.onPressed(),
          );
        }

        return Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (_, constraints) => OverflowBox(
                  minHeight: 24.0,
                  maxHeight: max(
                    24.0,
                    (constraints.maxHeight + (kFabSize * 0.5)) * _sizeAnimation.value,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: Align(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: SupervielleColors.white,
                              boxShadow: [SupervielleConstants.boxShadow.grey300],
                            ),
                            child: SizedBox.fromSize(
                              size: Size.square(
                                max(
                                  0.0,
                                  kFabSize * _sizeAnimation.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        shape: const CircleBorder(),
                        type: MaterialType.transparency,
                        child: InkResponse(
                          child: Icon(
                            widget.fab.icon,
                            color: _colorAnimation.value,
                            size: lerpDouble(24.0, 32.0, _sizeAnimation.value),
                          ),
                          radius: (kFabSize * 0.5) * _sizeAnimation.value,
                          onTap: widget.fab.onPressed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: lerpDouble(4.0, 8.0, _controller.value)),
            if (label != null) label,
          ],
        );
      },
    );
  }
}
