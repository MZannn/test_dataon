import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_dataon/pages/home_page/home_page.dart';
import 'package:test_dataon/pages/profile_page/profile_page.dart';

import 'navigation_view_model.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavigationViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.selectedIndex) {
            case 0:
              return const HomePage();
            case 1:
              return const ProfilePage();
            default:
              return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: Consumer<NavigationViewModel>(
        builder: (context, viewModel, child) {
          return BottomAppBar(
            color: Colors.white,
            padding: EdgeInsets.zero,
            child: Container(
              height: 70,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildNavItem(
                    viewModel,
                    context,
                    Icons.home,
                    "Home",
                    0,
                  ),
                  buildNavItem(
                    viewModel,
                    context,
                    Icons.person,
                    "Profile",
                    1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildNavItem(
    NavigationViewModel viewModel,
    BuildContext context,
    IconData icon,
    String title,
    int index,
  ) {
    return InkWell(
      onTap: () {
        viewModel.updateSelectedIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: viewModel.selectedIndex == index
                ? Colors.deepPurple
                : Colors.grey[300],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: viewModel.selectedIndex == index
                  ? Colors.deepPurple
                  : Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
