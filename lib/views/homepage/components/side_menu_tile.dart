import 'package:flutter/material.dart';

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
        const Padding(
          padding: EdgeInsets.only(left: 24, right: 10),
          child: Divider(
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
                  color: Colors.green.shade700,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: const SizedBox(
                height: 34,
                width: 34,
                child: Center(
                  child: Icon(
                    Icons.back_hand,
                    size: 30,
                  ),
                ),
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
}
