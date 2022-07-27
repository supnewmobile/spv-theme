part of './nav_bar.dart';

class _NavBarItemButton extends StatelessWidget {
  const _NavBarItemButton({
    Key? key,
    required this.item,
    this.current = false,
    required this.onChanged,
    this.forceSelectedItemTap = false,
  }) : super(key: key);

  final NavBarItem item;
  final bool current;
  final void Function(NavBarItem) onChanged;
  final bool forceSelectedItemTap;

  @override
  Widget build(BuildContext context) {
    final color = current ? SupervielleColors.red700 : SupervielleColors.grey800;

    return InkResponse(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, color: color),
          const SizedBox(height: 4.0),
          Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _labelsTextStyle.apply(color: color),
          ),
        ],
      ),
      overlayColor: MaterialStateProperty.all<Color>(SupervielleColors.overlay),
      onTap: current && !forceSelectedItemTap ? null : () => onChanged(item),
    );
  }
}
