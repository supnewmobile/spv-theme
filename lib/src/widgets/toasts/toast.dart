import 'package:flutter/material.dart';
import 'package:spv_theme/spv_theme.dart';


const Duration _duration = Duration(seconds: 3);

class Toast extends SnackBar {
  Toast({
    String? title,
    required String description,
    String? link,
    double? bottomMargin,
    required IconData icon,
    required Color accentColor,
    void Function()? onLinkTap,
  }) : super(
          content: _Content(
            title: title,
            description: description,
            link: link,
            icon: icon,
            accentColor: accentColor,
            onLinkTap: onLinkTap,
          ),
          elevation: 0.0,
          backgroundColor: SupervielleColors.grey900,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(24.0).add(EdgeInsets.only(bottom: bottomMargin ?? 0.0)),
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SupervielleConstants.radiusxs),
            ),
          ),
          duration: _duration,
        );

  Toast.success({
    String? title,
    required String description,
    String? link,
    double? bottomMargin,
    void Function()? onLinkTap,
  }) : super(
          content: _Content(
            title: title,
            description: description,
            link: link,
            icon: SupervielleIcons.check,
            accentColor: SupervielleColors.green200,
            onLinkTap: onLinkTap,
          ),
          elevation: 0.0,
          backgroundColor: SupervielleColors.grey900,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(24.0).add(EdgeInsets.only(bottom: bottomMargin ?? 0.0)),
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SupervielleConstants.radiusxs),
            ),
          ),
          duration: _duration,
        );

  Toast.warning({
    String? title,
    required String description,
    String? link,
    double bottomMargin = 0.0,
    void Function()? onLinkTap,
    TextStyle? colorDescription,
    Color? colorIcon,
  }) : super(
          content: _Content(
            title: title,
            description: description,
            colorDescription: colorDescription,
            link: link,
            icon: SupervielleIcons.alert,
            accentColor: colorIcon != null ? colorIcon : SupervielleColors.yellow200,
            onLinkTap: onLinkTap,
          ),
          elevation: 0.0,
          backgroundColor: SupervielleColors.grey900,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(24.0).add(EdgeInsets.only(bottom: bottomMargin)),
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SupervielleConstants.radiusxs),
            ),
          ),
          duration: _duration,
        );

  Toast.info({
    String? title,
    required String description,
    String? link,
    double? bottomMargin,
    void Function()? onLinkTap,
  }) : super(
          content: _Content(
            title: title,
            description: description,
            link: link,
            icon: SupervielleIcons.info,
            accentColor: SupervielleColors.purple200,
            onLinkTap: onLinkTap,
          ),
          elevation: 0.0,
          backgroundColor: SupervielleColors.grey900,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(24.0).add(EdgeInsets.only(bottom: bottomMargin ?? 0.0)),
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SupervielleConstants.radiusxs),
            ),
          ),
          duration: _duration,
        );

  Toast.error({
    String? title,
    required String description,
    String? link,
    double? bottomMargin,
    void Function()? onLinkTap,
  }) : super(
          content: _Content(
            title: title,
            description: description,
            link: link,
            icon: SupervielleIcons.alert,
            accentColor: SupervielleColors.orange200,
            onLinkTap: onLinkTap,
          ),
          elevation: 0.0,
          backgroundColor: SupervielleColors.grey900,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(24.0).add(EdgeInsets.only(bottom: bottomMargin ?? 0.0)),
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SupervielleConstants.radiusxs),
            ),
          ),
          duration: _duration,
        );
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    this.title,
    required this.description,
    this.colorDescription,
    this.link,
    required this.icon,
    required this.accentColor,
    required this.onLinkTap,
  }) : super(key: key);

  final String? title;
  final String description;
  final TextStyle? colorDescription;
  final String? link;
  final IconData icon;
  final Color accentColor;
  final void Function()? onLinkTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 24.0, //Alto de icono
                    ),
                    child: Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      style: SupervielleTextStyles.s.bold.apply(
                        color: accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                ],
                Text(
                  description,
                  style: colorDescription != null ? colorDescription : SupervielleTextStyles.xs.regular.grey200,
                ),
                if (link != null) ...[
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    child: Text(
                      link!,
                      overflow: TextOverflow.ellipsis,
                      style: SupervielleTextStyles.xs.medium.grey100.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      onLinkTap?.call();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          ActionButton(
            icon: SupervielleIcons.close,
            color: SupervielleColors.grey200,
            radius: 16.0,
            padding: EdgeInsets.zero,
            overlay: SupervielleColors.grey700,
            onTap: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
        ],
      ),
    );
  }
}
