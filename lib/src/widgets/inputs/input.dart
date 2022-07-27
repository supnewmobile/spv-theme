import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme.dart';
import '../buttons/action_button.dart';

enum InputStatus { none, valid, invalid }

extension InputStatusExtension on InputStatus {
  bool get isNone => this == InputStatus.none;
  bool get isValid => this == InputStatus.valid;
  bool get isInvalid => this == InputStatus.invalid;
}

class Input extends StatefulWidget {
  const Input({
    Key? key,
    this.controller,
    required this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.label,
    this.labelStyle,
    this.hint,
    this.hintStyle,
    this.style,
    this.maxLength,
    required this.textAlign,
    this.cleanable,
    this.obscure,
    this.fillColor,
    this.contentPadding,
    required this.enabledBorder,
    required this.focusedBorder,
    required this.disabledBorder,
    required this.status,
    required this.enabled,
    this.showSuffix = true,
    this.prefixIcon,
    this.readOnly = false,
    this.secondLabelOption,
    this.autofillHints,
  }) : super(key: key);

  factory Input.underline({
    Key? key,
    TextEditingController? controller,
    required FocusNode focusNode,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    String? label,
    String? hint,
    int? maxLength,
    bool? cleanable,
    bool? obscure,
    EdgeInsets? contentPadding,
    InputStatus status,
    bool? enabled,
    bool? showSuffix,
    Iterable<String>? autofillHints,
  }) = _UnderlineInput;

  factory Input.fill({
    Key? key,
    TextEditingController? controller,
    required FocusNode focusNode,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    String? label,
    String? hint,
    int? maxLength,
    bool? cleanable,
    bool? obscure,
    Color? fillColor,
    EdgeInsets? contentPadding,
    InputStatus status,
    bool? enabled,
    bool? showSuffix,
    Widget? prefixIcon,
    SecondLabelOption secondLabelOption,
    Iterable<String>? autofillHints,
  }) = _FillInput;

  final TextEditingController? controller;
  final FocusNode focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final SecondLabelOption? secondLabelOption;

  // UI
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final int? maxLength;
  final TextAlign textAlign;
  final bool? cleanable;
  final bool? obscure;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final InputBorder enabledBorder;
  final InputBorder focusedBorder;
  final InputBorder disabledBorder;
  final InputStatus status;
  final bool enabled;
  final bool showSuffix;
  final bool readOnly;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late final TextEditingController _controller;

  late final ValueNotifier<bool> _cleanableNotifier;
  late bool? _cleanable;
  late bool? _obscure;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();

    _cleanableNotifier = ValueNotifier<bool>(false);
    _cleanable = widget.cleanable;
    _obscure = widget.obscure;
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    _cleanableNotifier.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Input oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldcleanable = oldWidget.cleanable;
    final cleanable = widget.cleanable;
    final oldObscure = oldWidget.obscure;
    final obscure = widget.obscure;
    if (oldcleanable != cleanable) _cleanable = widget.cleanable;
    if (oldObscure != obscure) _obscure = widget.obscure;

    _cleanableNotifier.value = _controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final edgeInsetPadding =
        widget.secondLabelOption != null ? const EdgeInsets.symmetric(vertical: 16.0) : const EdgeInsets.all(16.0);
    final labelColor = (!widget.enabled) ? SupervielleColors.grey700 : SupervielleColors.grey900;
    final isFilled = widget.fillColor != null;
    final background = (!widget.enabled) ? SupervielleColors.grey200 : widget.fillColor;
    BorderRadiusGeometry? borderRadius;
    final border = widget.enabledBorder;
    if (border is OutlineInputBorder) borderRadius = border.borderRadius;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: (widget.textAlign == TextAlign.left) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        if (widget.label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label!,
                style: widget.labelStyle?.apply(color: labelColor),
              ),
              (widget.secondLabelOption != null)
                  ? _secondLabelOption(
                      widget.secondLabelOption!,
                      SupervielleTextStyles.xs.medium.apply(color: labelColor),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
        Material(
          type: isFilled ? MaterialType.canvas : MaterialType.transparency,
          color: isFilled ? background : null,
          borderRadius: borderRadius,
          child: TextField(
            readOnly: widget.readOnly,
            controller: _controller,
            focusNode: widget.focusNode,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            style: widget.style?.apply(color: SupervielleColors.grey900),
            textAlign: widget.textAlign,
            obscureText: _obscure ?? false,
            maxLength: widget.maxLength,
            autocorrect: false,
            autofillHints: (widget.enabled) ? widget.autofillHints : null,
            decoration: InputDecoration(
              enabled: widget.enabled,
              hintText: widget.hint,
              hintStyle: widget.hintStyle?.apply(color: SupervielleColors.grey700),
              counterText: '',
              contentPadding: widget.contentPadding ?? edgeInsetPadding,
              prefixIcon: widget.prefixIcon,
              suffixIcon: (widget.showSuffix)
                  ? Padding(
                      padding: EdgeInsets.only(right: widget.contentPadding?.right ?? 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.status.isValid)
                            const Padding(
                              // Padding de ActionButton
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                SupervielleIcons.check,
                                color: SupervielleColors.green700,
                              ),
                            ),
                          if (_cleanable != null && _cleanable! && !widget.status.isValid)
                            ValueListenableBuilder<bool>(
                              valueListenable: _cleanableNotifier,
                              child: ActionButton(
                                icon: SupervielleIcons.close_mini,
                                color: SupervielleColors.black,
                                radius: 32.0,
                                onTap: () {
                                  _controller.clear();
                                  widget.onChanged?.call('');
                                  _cleanableNotifier.value = false;
                                },
                              ),
                              builder: (_, value, child) => Visibility(visible: value, child: child!),
                            ),
                          if (_obscure != null)
                            ActionButton(
                              icon: (_obscure!) ? SupervielleIcons.show : SupervielleIcons.hide,
                              radius: 32.0,
                              onTap: () => setState(() => _obscure = !_obscure!),
                            ),
                        ],
                      ),
                    )
                  : null,
              enabledBorder: widget.enabledBorder,
              focusedBorder: widget.focusedBorder,
              disabledBorder: widget.disabledBorder,
            ),
            onChanged: (value) {
              _cleanableNotifier.value = value.isNotEmpty;
              widget.onChanged?.call(value);
            },
            onEditingComplete: widget.onEditingComplete,
          ),
        ),
      ],
    );
  }

  Widget _secondLabelOption(SecondLabelOption option, TextStyle style) {
    return GestureDetector(
      child: Row(
        children: [
          Text(
            option.label,
            style: style,
          ),
          const SizedBox(width: 10),
          option.icon != null
              ? Icon(
                  option.icon,
                  size: style.fontSize,
                  color: style.color,
                )
              : const SizedBox.shrink()
        ],
      ),
      onTap: option.action,
    );
  }
}

class _UnderlineInput extends Input {
  _UnderlineInput({
    Key? key,
    required FocusNode focusNode,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    String? label,
    String? hint,
    int? maxLength,
    bool? cleanable,
    bool? obscure,
    TextEditingController? controller,
    EdgeInsets? contentPadding,
    InputStatus status = InputStatus.none,
    bool? enabled,
    bool? showSuffix,
    Iterable<String>? autofillHints,
  }) : super(
          key: key,
          focusNode: focusNode,
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          label: label,
          labelStyle: SupervielleTextStyles.m.bold,
          hint: hint,
          hintStyle: SupervielleTextStyles.xxl.semibold,
          style: SupervielleTextStyles.xxl.semibold,
          maxLength: maxLength,
          textAlign: TextAlign.center,
          cleanable: cleanable,
          obscure: obscure,
          contentPadding: contentPadding,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: (status.isNone)
                  ? SupervielleColors.grey700
                  : (status.isValid)
                      ? SupervielleColors.green700
                      : SupervielleColors.orange700,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: (status.isNone)
                  ? SupervielleColors.grey700
                  : (status.isValid)
                      ? SupervielleColors.green700
                      : SupervielleColors.orange700,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: SupervielleColors.grey300,
            ),
          ),
          status: status,
          enabled: enabled ?? true,
          showSuffix: showSuffix ?? true,
          autofillHints: autofillHints,
        );
}

class _FillInput extends Input {
  _FillInput({
    Key? key,
    TextEditingController? controller,
    required FocusNode focusNode,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    String? label,
    String? hint,
    int? maxLength,
    bool? cleanable,
    bool? obscure,
    Color? fillColor,
    EdgeInsets? contentPadding,
    InputStatus status = InputStatus.none,
    bool? enabled,
    bool? showSuffix,
    Widget? prefixIcon,
    SecondLabelOption? secondLabelOption,
    Iterable<String>? autofillHints,
  }) : super(
          key: key,
          controller: controller,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          label: label,
          labelStyle: (secondLabelOption != null) ? SupervielleTextStyles.xs.grey800 : SupervielleTextStyles.xs.bold,
          hint: hint,
          hintStyle: SupervielleTextStyles.s.regular,
          style: SupervielleTextStyles.s.regular,
          maxLength: maxLength,
          textAlign: TextAlign.left,
          cleanable: cleanable,
          obscure: obscure,
          fillColor: fillColor ?? SupervielleColors.white,
          contentPadding: contentPadding,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                SupervielleConstants.radiusxs,
              ),
            ),
            borderSide: BorderSide(
              color: (status.isNone) ? SupervielleColors.grey300 : SupervielleColors.green700,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                SupervielleConstants.radiusxs,
              ),
            ),
            borderSide: BorderSide(
              color: (status.isNone) ? SupervielleColors.grey700 : SupervielleColors.green700,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                SupervielleConstants.radiusxs,
              ),
            ),
            borderSide: BorderSide(
              color: SupervielleColors.grey300,
            ),
          ),
          status: status,
          enabled: enabled ?? true,
          showSuffix: showSuffix ?? true,
          prefixIcon: prefixIcon,
          secondLabelOption: secondLabelOption,
          autofillHints: autofillHints,
        );
}

class SecondLabelOption {
  final String label;
  final IconData? icon;
  final VoidCallback? action;

  const SecondLabelOption({
    required this.label,
    this.icon,
    this.action,
  });
}

class InputMessage extends StatelessWidget {
  const InputMessage({
    Key? key,
    required this.message,
    required this.status,
    this.showWarning = true,
  }) : super(key: key);

  final String message;
  final InputStatus status;
  final bool showWarning;

  @override
  Widget build(BuildContext context) {
    final icon = (status.isNone)
        ? SupervielleIcons.bullet
        : (status.isValid)
            ? SupervielleIcons.check
            : showWarning
                ? SupervielleIcons.alert
                : SupervielleIcons.bullet;
    final color = (status.isNone)
        ? SupervielleColors.grey800
        : (status.isValid)
            ? SupervielleColors.green700
            : showWarning
                ? SupervielleColors.orange900
                : SupervielleColors.grey800;

    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: color,
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            message,
            style: SupervielleTextStyles.xs.regular.grey800,
          ),
        ),
      ],
    );
  }
}
