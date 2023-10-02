import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/auth/providers/auth_state_provider.dart';
import 'package:itsula/state/constants/homepage_side_bar_app_name.dart';
import 'package:itsula/state/homepage/providers/homepage_state_provider.dart';
import 'package:itsula/views/components/dialogs/alert_dialog_model.dart';
import 'package:itsula/views/components/dialogs/logout_dialog.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/constants/strings.dart';
import 'package:itsula/views/homepage/application_list_view.dart';
import 'package:itsula/views/homepage/components/side_menu_tile.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<HomePageView> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePageView>
    with TickerProviderStateMixin {
  late AnimationController _aniController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  @override
  void initState() {
    _aniController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _aniController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scalAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _aniController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _aniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final controller = ref.watch(homePageStateProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.withAlpha(
        150,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 270,
            left: ref.read(homePageStateProvider.notifier).getIsSideMenuHidden()
                ? -270
                : 0,
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              body: Container(
                width: 270,
                height: double.infinity,
                color: AppColors.secondaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SafeArea(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, top: 32, bottom: 16),
                                child: Text(
                                  Strings.appName.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          SideMenutile(
                            title: HomePageSideBarAppName.blogary,
                            press: () {
                              ref
                                  .read(homePageStateProvider.notifier)
                                  .onIndexChange(0);
                              if (ref
                                  .read(homePageStateProvider.notifier)
                                  .getIsSideMenuHidden()) {
                                _aniController.forward();
                              } else {
                                _aniController.reverse();
                              }
                              ref
                                  .read(homePageStateProvider.notifier)
                                  .onSideMenuOpenOrHiddenChange();
                            },
                            isActive: ref
                                    .read(homePageStateProvider.notifier)
                                    .geCurrentIndex() ==
                                0,
                          ),
                          SideMenutile(
                            title: HomePageSideBarAppName.habtrack,
                            press: () {
                              ref
                                  .read(homePageStateProvider.notifier)
                                  .onIndexChange(1);
                              if (ref
                                  .read(homePageStateProvider.notifier)
                                  .getIsSideMenuHidden()) {
                                _aniController.forward();
                              } else {
                                _aniController.reverse();
                              }
                              ref
                                  .read(homePageStateProvider.notifier)
                                  .onSideMenuOpenOrHiddenChange();
                            },
                            isActive: ref
                                    .read(homePageStateProvider.notifier)
                                    .geCurrentIndex() ==
                                1,
                          ),
                          SideMenutile(
                            title: HomePageSideBarAppName.letters,
                            press: () {
                              ref
                                  .read(homePageStateProvider.notifier)
                                  .onIndexChange(2);
                              if (ref
                                  .read(homePageStateProvider.notifier)
                                  .getIsSideMenuHidden()) {
                                _aniController.forward();
                              } else {
                                _aniController.reverse();
                              }
                              ref
                                  .read(homePageStateProvider.notifier)
                                  .onSideMenuOpenOrHiddenChange();
                            },
                            isActive: ref
                                    .read(homePageStateProvider.notifier)
                                    .geCurrentIndex() ==
                                2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 24),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 15,
                          backgroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () async {
                          final result = await const LogoutDialog()
                              .present(context)
                              .then((value) => value ?? false);

                          if (result) {
                            await ref.read(authStateProvider.notifier).logOut();
                            ref.read(homePageStateProvider.notifier).reset();
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 2.0,
                                right: 4.0,
                              ),
                              child: Icon(
                                Icons.logout,
                                color: AppColors.textColor,
                              ),
                            ),
                            Text(
                              Strings.logout,
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  //Container(child:  GestureDetector(child: FormattedTextWidget(),)),
                ),
              ),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              /* offset: Offset(
                  _controller.isSideMenuHiddenRightNow() ? 0.w : 270.w, 0.h),*/
              offset: Offset(animation.value * 264, 0),
              child: Transform.scale(
                scale: scalAnimation
                    .value /*_controller.isSideMenuHiddenRightNow() ? 1 : 0.8*/,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: applicationListView(
                      index: ref
                          .read(homePageStateProvider.notifier)
                          .geCurrentIndex(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: ref.read(homePageStateProvider.notifier).getIsSideMenuHidden()
                ? 0
                : 200,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  if (ref
                      .read(homePageStateProvider.notifier)
                      .getIsSideMenuHidden()) {
                    _aniController.forward();
                    //toastInfo("Animation value: ${animation.value}");
                  } else {
                    _aniController.reverse();
                    //toastInfo("Animation value: ${animation.value}");
                  }
                  ref
                      .read(homePageStateProvider.notifier)
                      .onSideMenuOpenOrHiddenChange();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2, left: 8),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(offset: Offset(0, 3), blurRadius: 8),
                    ],
                  ),
                  child: const Icon(
                    Icons.list_alt,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
