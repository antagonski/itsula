import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itsula/state/constants/homepage_side_bar_app_name.dart';
import 'package:itsula/views/constants/app_colors.dart';

class SideMenutile extends StatelessWidget {
  const SideMenutile({
    super.key,
    required this.press,
    required this.isActive,
    required this.title,
  });

  final VoidCallback press;
  final bool isActive;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 10),
          child: Divider(
            color: AppColors.accentColor,
            height: 1,
          ),
        ),
        //Treba naslov pre app-ova da dodje ovde
        Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 200),
              height: 58,
              width: isActive ? 270 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: _iconDelegate(),
              ),
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ],
    );
  }

  FaIcon _iconDelegate() {
    switch (title) {
      case HomePageSideBarAppName.blogary:
        return const FaIcon(
          FontAwesomeIcons.pencil,
        );
      case HomePageSideBarAppName.habtrack:
        return const FaIcon(
          FontAwesomeIcons.calendar,
        );
      case HomePageSideBarAppName.letters:
        return const FaIcon(
          FontAwesomeIcons.paperPlane,
        );
      default:
        return const FaIcon(
          FontAwesomeIcons.x,
        );
    }
  }
}
