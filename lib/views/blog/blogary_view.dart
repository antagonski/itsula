import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itsula/state/constants/homepage_side_bar_app_name.dart';
import 'package:itsula/views/blog/components/custom_blogary_fab.dart';
import 'package:itsula/views/constants/app_colors.dart';
import 'package:itsula/views/tabs/all_blogs/all_blogs_view.dart';
import 'package:itsula/views/tabs/search/search_view.dart';
import 'package:itsula/views/tabs/user_blogs/user_blogs_view.dart';

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
            UserBlogsView(),
            SearchView(),
            AllBlogsView(),
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
