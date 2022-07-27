import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './input.dart';
import '../height_factor_alignment.dart';

const _duration = Duration(milliseconds: 150);

enum InputType { error, tips }

extension on InputType {
  bool get isError => this == InputType.error;
}

class InputValidator {
  const InputValidator({
    required this.value,
    required this.rules,
  });

  final String value;
  final List<InputRule> rules;

  InputRule? get invalidRule {
    if (rules.any((rule) => !rule.valid)) {
      return rules.firstWhere((rule) => !rule.valid);
    }

    return null;
  }

  bool get isValid => !rules.any((rule) => !rule.valid);

  @override
  int get hashCode => value.hashCode ^ hashList(rules);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputValidator && other.value == value && listEquals(other.rules, rules);
  }
}

class InputRule {
  const InputRule({required this.helper, required this.valid});

  final String helper;
  final bool valid;

  @override
  int get hashCode => helper.hashCode ^ valid.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputRule && other.helper == helper && other.valid == valid;
  }
}

class ValidatedInput extends StatefulWidget {
  const ValidatedInput({
    Key? key,
    this.controller,
    required this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    required this.onChanged,
    this.onEditingComplete,
    this.label,
    this.hint,
    this.maxLength,
    this.cleanable,
    this.obscure,
    this.fillColor,
    this.contentPadding,
    this.enabled,
    required this.validator,
    this.showWarnings = true,
    this.showSuffix = true,
    this.showSuccess = true,
    this.type = InputType.tips,
    this.autofillHints,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final void Function(String) onChanged;
  final void Function()? onEditingComplete;
  final String? label;
  final String? hint;
  final int? maxLength;
  final bool? cleanable;
  final bool? obscure;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final bool? enabled;
  final InputValidator validator;
  final bool showWarnings;
  final bool showSuffix;
  final bool showSuccess;
  final InputType type;
  final Iterable<String>? autofillHints;

  @override
  _ValidatedInputState createState() => _ValidatedInputState();
}

class _ValidatedInputState extends State<ValidatedInput> with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final AnimationController _animationController;
  Widget? _bottomChild;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _animationController = AnimationController(vsync: this, duration: _duration);

    if (!widget.type.isError) {
      _bottomChild = _Tips(validator: widget.validator, showWarnings: widget.showWarnings);
      widget.focusNode.addListener(_focusNodeListener);
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_focusNodeListener);
    _controller.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ValidatedInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    final value = widget.validator.value;
    if (!widget.focusNode.hasFocus) {
      if (widget.inputFormatters?.isEmpty ?? true) {
        _controller.text = value;
      } else {
        String text = _controller.text;
        for (var inputFormatter in widget.inputFormatters!) {
          final textEditingValue = inputFormatter.formatEditUpdate(
            TextEditingValue(
              selection: const TextSelection.collapsed(offset: 0),
              text: text,
            ),
            TextEditingValue(
              selection: const TextSelection.collapsed(offset: 0),
              text: value,
            ),
          );
          text = textEditingValue.text;
        }

        _controller.text = text;
      }
    }

    final oldValidator = oldWidget.validator;
    final validator = widget.validator;
    if (widget.type.isError) {
      if (oldValidator != validator) {
        if (widget.validator.invalidRule != null) {
          _bottomChild = InputMessage(
            message: widget.validator.invalidRule!.helper,
            status: InputStatus.invalid,
          );
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    } else {
      _bottomChild = _Tips(validator: widget.validator, showWarnings: widget.showWarnings);
    }
  }

  void _focusNodeListener() {
    if (widget.focusNode.hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = (widget.type.isError)
        ? InputStatus.none
        : (widget.validator.isValid && widget.showSuccess)
            ? InputStatus.valid
            : InputStatus.none;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Input.fill(
          controller: _controller,
          focusNode: widget.focusNode,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          label: widget.label,
          hint: widget.hint,
          maxLength: widget.maxLength,
          cleanable: widget.cleanable,
          obscure: widget.obscure,
          fillColor: widget.fillColor,
          contentPadding: widget.contentPadding,
          status: status,
          enabled: widget.enabled,
          showSuffix: widget.showSuffix,
          autofillHints: widget.autofillHints,
        ),
        AnimatedBuilder(
          animation: _animationController,
          child: Padding(padding: const EdgeInsets.only(top: 8.0), child: _bottomChild),
          builder: (_, child) => ClipRect(
            child: HeightFactorAlignment(
              factor: _animationController.value,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _Tips extends StatelessWidget {
  const _Tips({Key? key, required this.validator, this.showWarnings = true}) : super(key: key);

  final InputValidator validator;
  final bool showWarnings;

  @override
  Widget build(BuildContext context) {
    final rules = validator.rules;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < rules.length; i++) ...[
          InputMessage(
            message: rules[i].helper,
            status: (validator.value.isEmpty)
                ? InputStatus.none
                : (rules[i].valid)
                    ? InputStatus.valid
                    : InputStatus.invalid,
            showWarning: showWarnings,
          ),
          if (i < rules.length - 1) const SizedBox(height: 4),
        ],
      ],
    );
  }
}
