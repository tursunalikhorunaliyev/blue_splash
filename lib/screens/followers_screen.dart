import 'package:blue_splash/blocs/unsplash_bloc.dart';
import 'package:blue_splash/models/unsplash_model.dart';
import 'package:blue_splash/pageroutes/left_slide_page_route.dart';
import 'package:blue_splash/screens/user_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Followers extends StatefulWidget {
  final String username;
  const Followers({Key? key, required this.username}) : super(key: key);

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  final scrollController = ScrollController();
  final sliverBloc = SliverBLoC();
  var followersBLoC = FollowersBLoC("");
  @override
  void initState() {
    super.initState();
    followersBLoC = FollowersBLoC(widget.username);
    followersBLoC.eventSink.add(Images.follow);
    scrollController.addListener(() {
      print(scrollController.offset);
    });
  }

  bool get isSliverAppBarExpanded {
    return scrollController.hasClients && scrollController.offset > 180;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: StreamBuilder<UserFol>(
              stream: followersBLoC.dataUserStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Column(
                    children: [
                      SizedBox(
                        height: 48.h,
                      ),
                      Center(
                        child: SizedBox(
                          height: 120.h,
                          width: 120.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90.r),
                            child: Image.network(data.userFolImg.large,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        "${data.name}'s\nFollowers",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      StreamBuilder<ListFollowers>(
                          stream: followersBLoC.dataFollowerStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: snapshot.data!.followers.length,
                                  itemBuilder: (context, index) {
                                    final data =
                                        snapshot.data!.followers[index];
                                    return ListTile(
                                      tileColor: Colors.white,
                                      leading: GestureDetector(
                                        onTap: () {},
                                        child: GestureDetector(
                                          onTap: () {
                                            print("SALOM");
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(90.r),
                                            child: Image.network(
                                              data.followerProfileImage.medium,
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: GestureDetector(
                                        onTap: () {},
                                        child: SizedBox(
                                          child: Text(
                                            data.name,
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                      subtitle: InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                          child: Text(
                                            data.username,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: 100.h,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${data.totalPhotos}\nPhotos",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            GestureDetector(
                                                onTap: () {},
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        LeftSlideRoute(UserInfo(
                                                            id: snapshot
                                                                .data!
                                                                .followers[
                                                                    index]
                                                                .username)));
                                                  },
                                                  child: SizedBox(
                                                    child: Image.asset(
                                                        "assets/linking.png",
                                                        height: 15.h,
                                                        width: 15.w),
                                                  ),
                                                )),
                                            SizedBox(width: 21.w)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              followersBLoC.eventSink.add(Images.follow);
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })
                    ],
                  );
                } else {
                  followersBLoC.eventSink.add(Images.follow);
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }
}
