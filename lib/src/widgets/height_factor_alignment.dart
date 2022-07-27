import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HeightFactorAlignment extends SingleChildRenderObjectWidget {
  const HeightFactorAlignment({
    Key? key,
    this.alignment = Alignment.bottomCenter,
    required this.factor,
    Widget? child,
  }) : super(key: key, child: child);

  final Alignment alignment;
  final double factor;

  @override
  _RenderHeightFactorAlignment createRenderObject(BuildContext context) {
    return _RenderHeightFactorAlignment(
      alignment: alignment,
      factor: factor,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderHeightFactorAlignment renderObject) {
    renderObject
      ..alignment = alignment
      ..factor = factor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(DoubleProperty('factor', factor));
  }
}

class _RenderHeightFactorAlignment extends RenderPositionedBox {
  _RenderHeightFactorAlignment({
    RenderBox? child,
    required double factor,
    required AlignmentGeometry alignment,
    TextDirection? textDirection,
  })  : _factor = factor,
        super(child: child, alignment: alignment, textDirection: textDirection);

  double get factor => _factor;
  double _factor;
  set factor(double factor) {
    assert(factor >= 0.0);
    if (_factor == factor) return;
    _factor = factor;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    if (child != null) {
      child!.layout(constraints.loosen(), parentUsesSize: true);
      size = constraints.constrain(
        Size(
          child!.size.width,
          child!.size.height * _factor,
        ),
      );

      alignChild();
    } else {
      size = constraints.constrain(const Size(double.infinity, 0.0));
    }
  }

  @override
  double getMaxIntrinsicHeight(double width) => super.getMaxIntrinsicHeight(width) * _factor;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('factor', factor));
  }
}
