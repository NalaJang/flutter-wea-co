import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/presentation/user_page/component/feed_grid/feed_grid_deleted_user_widget.dart';
import 'package:weaco/presentation/user_page/component/feed_grid/feed_grid_empty_widget.dart';
import 'package:weaco/presentation/user_page/component/user_profile/user_profile_deleted_widget.dart';
import 'package:weaco/presentation/user_page/component/user_profile/user_profile_widget.dart';
import 'package:weaco/presentation/user_page/user_page_view_model.dart';

class UserPageScreen extends StatefulWidget {
  const UserPageScreen({super.key});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  @override
  Widget build(BuildContext context) {
    UserPageViewModel userPageViewModel = context.watch<UserPageViewModel>();

    final UserProfile? userProfile = userPageViewModel.userProfile;
    final List<Feed> userFeedList = userPageViewModel.userFeedList;
    final bool isPageLoading = userPageViewModel.isPageLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
      ),
      body: isPageLoading || userProfile == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                children: [
                  userProfile.deletedAt == null
                      ? UserProfileWidget(userProfile: userProfile)
                      : UserProfileDeletedWidget(userProfile: userProfile),
                  const Divider(),
                  userProfile.deletedAt != null
                      ? const FeedGridDeletedUserWidget()
                      : userFeedList.isEmpty
                          ? const FeedGridEmptyWidget()
                          : NotificationListener<UserScrollNotification>(
                              onNotification:
                                  (UserScrollNotification notification) {
                                if (notification.direction ==
                                        ScrollDirection.reverse &&
                                    notification.metrics.maxScrollExtent *
                                            0.85 <
                                        notification.metrics.pixels) {
                                  userPageViewModel.fetchFeed();
                                }

                                return false;
                              },
                              child: Expanded(
                                child: GridView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: userFeedList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 3 / 4,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        RouterStatic.goToOotdDetail(
                                          context,
                                          id: userFeedList[index].id ?? '',
                                          imagePath:
                                              userFeedList[index].imagePath,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: Image(
                                          image: NetworkImage(
                                              userFeedList[index].imagePath),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                ],
              ),
            ),
    );
  }
}
