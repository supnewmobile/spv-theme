import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spv_theme/spv_theme.dart';


const _period = Duration(milliseconds: 2000);

class SkeletonMask extends StatefulWidget {
  const SkeletonMask({
    Key? key,
    required this.child,
    this.color = SupervielleColors.grey300,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final EdgeInsets margin;

  @override
  _SkeletonMaskState createState() => _SkeletonMaskState();
}

class _SkeletonMaskState extends State<SkeletonMask> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -1, max: 2.0, period: _period);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) => _Shimmer(
        child: child,
        percent: _animationController.value,
        gradient: LinearGradient(
          colors: [
            widget.color,
            widget.color.withOpacity(0.5),
            widget.color,
          ],
        ),
      ),
      child: Padding(padding: widget.margin, child: widget.child),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(SupervielleConstants.radiusxxs)),
      child: SizedBox.fromSize(size: size),
    );
  }
}

class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final Gradient gradient;

  const _Shimmer({
    Widget? child,
    required this.percent,
    required this.gradient,
  }) : super(child: child);

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    return _ShimmerFilter(percent, gradient);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.percent = percent;
    shimmer.gradient = gradient;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  _ShimmerFilter(this._percent, this._gradient);

  Gradient _gradient;
  double _percent;

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final double width = child?.size.width ?? 0.0;
    final double height = child?.size.height ?? 0.0;

    final x = -width + (width * 2) * _percent;
    final rect = Rect.fromLTWH(x, 0.0, width * 1.5, height);

    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }
}
