import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:scent_shop/screens/account_screen/account_screen.dart';
import 'package:scent_shop/screens/auth_ui/home/home.dart';
import 'package:scent_shop/screens/cart_screen/cart_screen.dart';
import 'package:scent_shop/screens/favourtite_screen/favourite_screen.dart';
import 'package:scent_shop/screens/oder_screen/oder_screen.dart';

class CustomBottem extends StatefulWidget {
  const CustomBottem({
    final Key? key,
  }) : super(key: key);

  @override
  State<CustomBottem> createState() => _CustomBottem();
}

class _CustomBottem extends State<CustomBottem> {
  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const Home(),
        const CardScreen(),
        const OrderScreen(),
        const AccountScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Home",
            activeColorPrimary: Colors.black,
            inactiveColorPrimary: Colors.black,
            inactiveColorSecondary: Colors.white),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: "Cart",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_basket),
          title: "Orders",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.people),
          title: "Profile",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: Colors.blue,
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
