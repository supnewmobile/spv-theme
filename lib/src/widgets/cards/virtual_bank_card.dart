import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spv_theme/spv_theme.dart';
import 'package:spv_theme/src/theme/supervielle_assets.dart';

enum BankCardBrand { visa, visaDebit, mastercard }

extension on BankCardBrand {
  String getLogo(_LayoutType layoutType) {
    switch (this) {
      case BankCardBrand.visa:
        return SupervielleAssets.visaLogo;
      case BankCardBrand.visaDebit:
        if (layoutType == _LayoutType.big) {
          return SupervielleAssets.visaDebitLogo;
        } else {
          return SupervielleAssets.visaLogo;
        }
      case BankCardBrand.mastercard:
        return SupervielleAssets.mastercardLogo;
    }
  }
}

enum _LayoutType { big, small, list }

class ExpirationDate {
  const ExpirationDate({required this.title, this.month, this.year});

  final String title;
  final int? month;
  final int? year;
}

class CVV {
  const CVV({required this.title, this.number});

  final String title;
  final int? number;
}

class VirtualBankCard extends StatelessWidget {
  const VirtualBankCard._({
    Key? key,
    required this.brand,
    required this.type,
    required this.number,
    this.holder,
    this.expirationDateTitle,
    this.expirationDate,
    this.cvvTitle,
    this.cvv,
    this.footer,
    required this.background,
    this.ofuscate = true,
    required this.layoutType,
    this.onCopy,
    this.onPressed,
  }) : super(key: key);

  factory VirtualBankCard.big({
    Key? key,
    required BankCardBrand brand,
    required String type,
    required int number,
    required String holder,
    required ExpirationDate expirationDate,
    required CVV cvv,
    required Color background,
    bool ofuscate = true,
    required void Function(String number) onCopy,
  }) {
    final cardNumber = '$number'.padLeft(16, '0');
    final formattedNumber = ofuscate
        ? '•••• •••• •••• ${cardNumber.substring(cardNumber.length - 4)}'
        : '${cardNumber.substring(0, 4)} ${cardNumber.substring(4, 8)} ${cardNumber.substring(8, 12)} ${cardNumber.substring(12, 16)}';
    final month = '${expirationDate.month ?? ''}'.padLeft(2, '0');
    final year = '${expirationDate.year ?? ''}'.padLeft(2, '0');
    final formattedExpirationDate = ofuscate ? '••/••' : '$month/${year.substring(year.length - 2)}';
    final formattedCVV = ofuscate ? '•••' : '${cvv.number ?? ''}'.padLeft(3, '0');

    return VirtualBankCard._(
      key: key,
      brand: brand,
      type: type,
      number: formattedNumber,
      holder: holder,
      expirationDateTitle: expirationDate.title,
      expirationDate: formattedExpirationDate,
      cvvTitle: cvv.title,
      cvv: formattedCVV,
      background: background,
      ofuscate: ofuscate,
      layoutType: _LayoutType.big,
      onCopy: onCopy,
    );
  }

  factory VirtualBankCard.small({
    Key? key,
    required BankCardBrand brand,
    required String type,
    required int number,
    String? footer,
    required Color background,
    required void Function() onPressed,
  }) {
    final cardNumber = '$number'.padLeft(16, '0');
    final formattedNumber = '**** ${cardNumber.substring(cardNumber.length - 4)}';

    return VirtualBankCard._(
      key: key,
      brand: brand,
      type: type,
      number: formattedNumber,
      footer: footer,
      background: background,
      layoutType: _LayoutType.small,
      onPressed: onPressed,
    );
  }

  factory VirtualBankCard.list({
    Key? key,
    required BankCardBrand brand,
    required String type,
    required int number,
    required Color background,
    required void Function() onPressed,
  }) {
    final cardNumber = '$number'.padLeft(16, '0');
    final formattedNumber = '•••• ${cardNumber.substring(cardNumber.length - 4)}';

    return VirtualBankCard._(
      key: key,
      brand: brand,
      type: type,
      number: formattedNumber,
      background: background,
      layoutType: _LayoutType.list,
      onPressed: onPressed,
    );
  }

  final BankCardBrand brand;
  final String type;
  final String number;
  final String? holder;
  final String? expirationDateTitle;
  final String? expirationDate;
  final String? cvvTitle;
  final String? cvv;
  final String? footer;
  final Color background;
  final bool ofuscate;
  final _LayoutType layoutType;
  final void Function(String number)? onCopy;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    switch (layoutType) {
      case _LayoutType.big:
        return _BigVirtualBankCard(
          brand: brand,
          type: type,
          number: number,
          holder: holder!,
          expirationDateTitle: expirationDateTitle!,
          expirationDate: expirationDate!,
          cvvTitle: cvvTitle!,
          cvv: cvv!,
          background: background,
          ofuscate: ofuscate,
          onCopy: onCopy!,
        );
      case _LayoutType.small:
        return _SmallVirtualBankCard(
          brand: brand,
          type: type,
          number: number,
          footer: footer,
          background: background,
          onPressed: onPressed!,
        );
      case _LayoutType.list:
        return _ListVirtualBankCard(
          brand: brand,
          type: type,
          number: number,
          background: background,
          onPressed: onPressed!,
        );
    }
  }
}

class _BigVirtualBankCard extends StatelessWidget {
  const _BigVirtualBankCard({
    Key? key,
    required this.brand,
    required this.type,
    required this.number,
    required this.holder,
    required this.expirationDateTitle,
    required this.expirationDate,
    required this.cvvTitle,
    required this.cvv,
    required this.background,
    required this.ofuscate,
    required this.onCopy,
  })  : layoutType = _LayoutType.big,
        super(key: key);

  final BankCardBrand brand;
  final String type;
  final String number;
  final String holder;
  final String expirationDateTitle;
  final String expirationDate;
  final String cvvTitle;
  final String cvv;
  final Color background;
  final bool ofuscate;
  final void Function(String number) onCopy;

  final _LayoutType layoutType;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: const BorderRadius.all(Radius.circular(SupervielleConstants.radiussm)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  brand.getLogo(layoutType),
                  width: 40.0,
                  height: 40.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    type,
                    overflow: TextOverflow.ellipsis,
                    style: SupervielleTextStyles.xs.medium.white,
                  ),
                ),
              ],
            ),
            ThinDivider(
              height: 32.0,
              color: SupervielleColors.overlay,
            ),
            ConstrainedBox(
              //Alto de boton copiar
              constraints: const BoxConstraints(minHeight: 48.0),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        number,
                        style: SupervielleTextStyles.m.medium.white,
                      ),
                    ),
                  ),
                  if (!ofuscate) ...[
                    const SizedBox(width: 8.0),
                    RoundedButton.translucent(
                      icon: SupervielleIcons.copy,
                      foregroundColor: SupervielleColors.white,
                      padding: const EdgeInsets.all(8.0),
                      onPressed: () => onCopy(number.replaceAll(' ', '')),
                    ),
                  ],
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                holder,
                style: SupervielleTextStyles.xs.regular.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expirationDateTitle,
                        overflow: TextOverflow.ellipsis,
                        style: SupervielleTextStyles.xxs.regular.white,
                      ),
                      const SizedBox(height: 4.0),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          expirationDate,
                          style: SupervielleTextStyles.s.regular.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cvvTitle,
                        overflow: TextOverflow.ellipsis,
                        style: SupervielleTextStyles.xxs.regular.white,
                      ),
                      const SizedBox(height: 4.0),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          cvv,
                          style: SupervielleTextStyles.s.regular.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallVirtualBankCard extends StatelessWidget {
  const _SmallVirtualBankCard({
    Key? key,
    required this.brand,
    required this.type,
    required this.number,
    required this.footer,
    required this.background,
    required this.onPressed,
  })  : layoutType = _LayoutType.small,
        super(key: key);

  final BankCardBrand brand;
  final String type;
  final String number;
  final String? footer;
  final Color background;
  final void Function() onPressed;

  final _LayoutType layoutType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.all(Radius.circular(SupervielleConstants.radiusxs)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      type,
                      overflow: TextOverflow.ellipsis,
                      style: SupervielleTextStyles.xxs.bold.white,
                    ),
                    Text(
                      number,
                      style: SupervielleTextStyles.s.medium.white,
                    ),
                    if (footer != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        footer!,
                        overflow: TextOverflow.ellipsis,
                        style: SupervielleTextStyles.xxs.regular.white,
                      ),
                    ],
                  ],
                ),
              ),
              SvgPicture.asset(
                brand.getLogo(layoutType),
                width: 48.0,
                height: 48.0,
              ),
            ],
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}

class _ListVirtualBankCard extends StatelessWidget {
  const _ListVirtualBankCard({
    Key? key,
    required this.brand,
    required this.type,
    required this.number,
    required this.background,
    required this.onPressed,
  })  : layoutType = _LayoutType.list,
        super(key: key);

  final BankCardBrand brand;
  final String type;
  final String number;
  final Color background;
  final void Function() onPressed;

  final _LayoutType layoutType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(SupervielleConstants.radiusxs)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                borderRadius: const BorderRadius.all(Radius.circular(SupervielleConstants.radiusxs)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(
                  brand.getLogo(layoutType),
                  width: 40.0,
                  height: 40.0,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    type,
                    overflow: TextOverflow.ellipsis,
                    style: SupervielleTextStyles.xxs.regular.grey800,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    number,
                    overflow: TextOverflow.ellipsis,
                    style: SupervielleTextStyles.xs.medium.copyWith(color: background),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      overlayColor: MaterialStateProperty.all<Color>(SupervielleColors.overlay),
      onTap: onPressed,
    );
  }
}
