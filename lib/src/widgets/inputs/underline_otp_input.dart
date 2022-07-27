import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './input.dart';
import '../../theme/theme.dart';
import '../height_factor_alignment.dart';

const _duration = Duration(milliseconds: 150);

class UnderlineOTPInput extends StatefulWidget {
  const UnderlineOTPInput({
    Key? key,
    required this.length,
    this.spacing = 8.0,
    required this.status,
    required this.onStatusChange,
    required this.onChanged,
  }) : super(key: key);

  final int length;
  final double spacing;
  final InputStatus status;
  final String Function(InputStatus status) onStatusChange;
  final void Function(String value) onChanged;

  @override
  _UnderlineOTPInputState createState() => _UnderlineOTPInputState();
}

class _UnderlineOTPInputState extends State<UnderlineOTPInput> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late String _otp;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  late InputStatus _status;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: _duration);

    _otp = List.generate(widget.length, (_) => ' ').join();
    _controllers = List.generate(widget.length, (i) => TextEditingController());
    _focusNodes = List.generate(widget.length, (i) => FocusNode());

    _status = widget.status;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant UnderlineOTPInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    _status = widget.status;
    if (!widget.status.isNone) {
      _animationController.forward();
    } else {
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            widget.length * 2 - 1,
            (i) {
              if (i % 2 != 0) return SizedBox(width: widget.spacing);

              final index = i ~/ 2;

              return Expanded(
                child: _OTPIndividualInput(
                  controller: _controllers[index],
                  previousFocusNode: (index == 0) ? null : _focusNodes[index - 1],
                  focusNode: _focusNodes[index],
                  nextFocusNode: (index == widget.length - 1) ? null : _focusNodes[index + 1],
                  status: _status,
                  autofillHints: (index == 0) ? [AutofillHints.oneTimeCode] : null,
                  onChanged: (value) async {
                    final char = _otp[index];
                    if (char != value) {
                      _otp = _otp.replaceRange(index, index + 1, value);
                      widget.onChanged(_otp.replaceAll(' ', ''));
                    }

                    if (_status != InputStatus.none) {
                      await _animationController.reverse();
                      setState(() => _status = InputStatus.none);
                    }
                  },
                  onCodeEntered: (code) async {
                    if (_controllers.length == code.length) {
                      for (var i = 0; i < code.length; i++) {
                        final controller = _controllers[i];
                        controller.value = TextEditingValue(text: code[i]);
                      }

                      _otp = code;
                      widget.onChanged(code);

                      if (_status != InputStatus.none) {
                        await _animationController.reverse();
                        setState(() => _status = InputStatus.none);
                      }
                    }
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12.0),
        AnimatedBuilder(
          animation: _animationController,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Icon(
                  (widget.status.isValid) ? SupervielleIcons.check : SupervielleIcons.alert,
                  size: 16.0,
                  color: (widget.status.isValid) ? SupervielleColors.green700 : SupervielleColors.orange900,
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    (widget.status.isNone) ? '' : widget.onStatusChange(widget.status),
                    style: (widget.status.isValid)
                        ? SupervielleTextStyles.xs.regular.green700
                        : SupervielleTextStyles.xs.regular.orange900,
                  ),
                ),
              ],
            ),
          ),
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

class _OTPIndividualInput extends StatelessWidget {
  const _OTPIndividualInput({
    Key? key,
    required this.controller,
    required this.status,
    required this.previousFocusNode,
    required this.focusNode,
    required this.nextFocusNode,
    required this.autofillHints,
    required this.onChanged,
    required this.onCodeEntered,
  }) : super(key: key);

  final TextEditingController controller;
  final InputStatus status;
  final FocusNode? previousFocusNode;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final Iterable<String>? autofillHints;
  final void Function(String) onChanged;
  final void Function(String) onCodeEntered;

  @override
  Widget build(BuildContext context) {
    return Input.underline(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [
        _DetectAutoFillCodeFormatter(onCodeEntered: onCodeEntered),
        _ReplaceNumberFormatter(),
      ],
      autofillHints: autofillHints,
      keyboardType: TextInputType.number,
      textInputAction: (nextFocusNode == null) ? TextInputAction.done : TextInputAction.next,
      contentPadding: const EdgeInsets.only(bottom: 16.0),
      status: status,
      showSuffix: false,
      maxLength: 1,
      onChanged: (value) {
        if (value.isEmpty) {
          previousFocusNode?.requestFocus();
        } else if (nextFocusNode == null) {
          focusNode.unfocus();
        } else {
          nextFocusNode?.requestFocus();
        }

        final realValue = (value.isEmpty) ? ' ' : value;
        onChanged(realValue);
      },
    );
  }
}

// Workaround para saber cuando llega un codigo, ya sea por autocompletado o
// lo pego el usuario
class _DetectAutoFillCodeFormatter extends TextInputFormatter {
  _DetectAutoFillCodeFormatter({required this.onCodeEntered});

  final void Function(String) onCodeEntered;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 6) {
      onCodeEntered(newValue.text);
    }

    return newValue;
  }
}

class _ReplaceNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final oldText = oldValue.text;
    String newText = newValue.text;

    // Detecto backspace
    if (oldText.length > newText.length) return const TextEditingValue();

    // Filtro numeros solamente
    newText = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (newText.isEmpty) return oldValue;
    if (oldText.isEmpty) return TextEditingValue(text: newText);

    // Detecto si es el mismo numero que habia
    final matches = oldText.allMatches(newText);
    if (oldText.length < matches.length) return oldValue;

    // Detecto si no ingreso un numero nuevo
    newText = newText.replaceAll(oldText, '');
    if (newText.isEmpty) return oldValue;

    return TextEditingValue(text: newText);
  }
}
