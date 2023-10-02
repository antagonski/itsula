import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/constants/homepage_side_bar_app_name.dart';
import 'package:itsula/state/image_upload/constants/constants.dart';
import 'package:itsula/state/image_upload/helpers/image_picker_helper.dart';
import 'package:itsula/state/image_upload/models/file_type.dart';
import 'package:itsula/state/post_settings/providers/post_settings_provider.dart';
import 'package:itsula/views/blog/components/custom_blogary_fab.dart';
import 'package:itsula/views/components/random/dummy_page.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/create_new_post/create_new_post_view.dart';
import 'package:itsula/views/tabs/all_posts/all_posts_view.dart';
import 'package:itsula/views/tabs/search/search_view.dart';
import 'package:itsula/views/tabs/user_posts/user_posts_view.dart';

class BlogaryView extends ConsumerStatefulWidget {
  const BlogaryView({super.key});

  @override
  ConsumerState<BlogaryView> createState() => _BlogViewState();
}

class _BlogViewState extends ConsumerState<BlogaryView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          centerTitle: true,
          title: const Text(HomePageSideBarAppName.blogary),
          actions: [
            IconButton(
              color: AppColors.textColor,
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.info,
              ),
            ),
          ],
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.textColor.withAlpha(
              100,
            ),
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.person_4_outlined,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            SearchView(),
            AllPostsView(),
          ],
        ),
        floatingActionButton: const CustomBlogaryFabView(),
        /* floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.textColor,
          elevation: 20.0,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const DummyPage(),
              ),
            );
          },
        ),*/
      ),
    );
  }
}
