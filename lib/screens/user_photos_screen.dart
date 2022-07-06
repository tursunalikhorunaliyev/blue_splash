import 'package:blue_splash/blocs/users_photo_bloc.dart';
import 'package:blue_splash/models/users_photos_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserPhotos extends StatefulWidget {
  final String username;
  const UserPhotos({Key? key, required this.username}) : super(key: key);

  @override
  State<UserPhotos> createState() => _UserPhotosState();
}

class _UserPhotosState extends State<UserPhotos> {
  var usersPhotoBLoC = UsersPhotosBloCUnsplash("");
  @override
  void initState() {
    usersPhotoBLoC = UsersPhotosBloCUnsplash(widget.username);
    usersPhotoBLoC.actionSink.add(UnsplashActionsPhotos.show);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(phoneSize.width, phoneSize.height),
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
              child: Column(children: [
            topContainer(),
            SizedBox(
              height: MediaQuery.of(context).size.height - 136.h,
              child: StreamBuilder<GetAllUsersPhotos>(
                stream: usersPhotoBLoC.stream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    usersPhotoBLoC = UsersPhotosBloCUnsplash(widget.username);
                    usersPhotoBLoC.actionSink.add(UnsplashActionsPhotos.show);
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.list.length,
                      itemBuilder: (context, index) {
                        double difference = snapshot.data!.list[index].height /
                            snapshot.data!.list[index].width;
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 5.h,
                            top: 5.h,
                            left: 15.w,
                            right: 15.w,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              snapshot.data!.list[index].getUrl.regular,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width *
                                  difference,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Shimmer.fromColors(
                                    baseColor: const Color.fromARGB(
                                        255, 222, 222, 222),
                                    highlightColor: Colors.grey[100]!,
                                    period: const Duration(milliseconds: 800),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              difference,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ])),
        );
      },
    );
  }

  Widget topContainer() {
    return StreamBuilder<GetAllUsersPhotos>(
      stream: usersPhotoBLoC.stream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          usersPhotoBLoC = UsersPhotosBloCUnsplash(widget.username);
          usersPhotoBLoC.actionSink.add(UnsplashActionsPhotos.show);
          return Center(
            child: Container(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
                top: 10.0.h, left: 19.w, right: 19.w, bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: SizedBox(
                        height: 40.h,
                        width: 40.w,
                        child: Image.network(
                            snapshot.data!.list[1].getUser.getUserPhoto
                                .userphotoUrlLarge,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      snapshot.data!.list[1].getUser.name + "'s photos",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Total: ${snapshot.data!.list.length}",
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
