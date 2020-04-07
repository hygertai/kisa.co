import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kisaco/screens/dashboard_screen.dart';
import 'package:kisaco/screens/analytics_screen.dart';
import 'package:kisaco/screens/constants.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;

  CustomBottomNav({
    @required this.selectedIndex,
  });
  @override
  State<StatefulWidget> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
              gap: 8,
              color: Colors.grey[800],
              activeColor: kLightPurpleColor,
              iconSize: 24,
              tabBackgroundColor: kDarkestPurpleColor.withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 1000),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.archive,
                  text: 'Archive',
                ),
                GButton(
                  icon: Icons.map,
                  text: 'Map',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profile',
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      {
                        // Navigate to Dashboard
                        Navigator.pushNamed(context, DashboardScreen.id);
                      }
                      break;
                    case 1:
                      {
                        // Map
                        Navigator.pushNamed(context, AnalyticsScreen.id);
                      }
                      break;
                    default:
                      {
                        Navigator.pushNamed(context, DashboardScreen.id);
                      }
                      break;
                  }
                });
              }),
        ),
      ),
    );
  }
}
