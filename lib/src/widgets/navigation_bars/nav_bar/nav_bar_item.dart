part of './nav_bar.dart';

class NavBarItem {
  const NavBarItem({
    required this.icon,
    required this.label,
    this.settings,
  });

  final IconData icon;
  final String label;
  final RouteSettings? settings;

  @override
  bool operator ==(other) => other is NavBarItem && (other.icon == icon) && (other.label == label);

  @override
  int get hashCode => icon.hashCode ^ label.hashCode;
}
