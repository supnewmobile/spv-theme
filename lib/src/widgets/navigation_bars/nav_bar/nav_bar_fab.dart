part of './nav_bar.dart';

class NavBarFAB {
  const NavBarFAB({
    required this.icon,
    required this.bigColor,
    required this.smallColor,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final Color bigColor;
  final Color smallColor;
  final String label;
  final void Function() onPressed;
}
