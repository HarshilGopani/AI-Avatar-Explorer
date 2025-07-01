import 'package:ai_avatar_explorer_app/utilts/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../theme/theme.dart';
import 'pages.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  static final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottomBarProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsValue.textfildBorder,
        elevation: Dimens.twenty,
        currentIndex: navProvider.currentIndex,
        onTap: (index) => navProvider.setIndex(index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorsValue.appColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetConstants.ic_home,
              height: Dimens.twentyFive,
              width: Dimens.twentyFive,
            ),
            activeIcon: SvgPicture.asset(
              AssetConstants.ic_home,
              height: Dimens.twentyFive,
              width: Dimens.twentyFive,
              colorFilter: ColorFilter.mode(
                ColorsValue.appColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetConstants.ic_search,
              height: Dimens.twentyFive,
              width: Dimens.twentyFive,
            ),
            activeIcon: SvgPicture.asset(
              AssetConstants.ic_search,
              height: Dimens.twentyFive,
              width: Dimens.twentyFive,
              colorFilter: ColorFilter.mode(
                ColorsValue.appColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Search",
          ),
        ],
      ),
      body: _screens[navProvider.currentIndex],
    );
  }
}
