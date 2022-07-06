import 'package:blue_splash/blocs/collections_photo_bloc.dart';
import 'package:blue_splash/models/collections_photo_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Collections extends StatefulWidget {
  const Collections({Key? key}) : super(key: key);

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  final collectionsBLoC = CollectionsPhotosBloCUnsplash();
  @override
  void initState() {
    collectionsBLoC.actionSink.add(UnsplashActionsCollectionsPhotos.show);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
              child: SizedBox(
            height: 800.h,
            child: Column(
              children: [topContainer(), listView()],
            ),
          )),
        );
      },
    );
  }

  Widget topContainer() {
    return Padding(
        padding: EdgeInsets.only(
          top: 9.h,
          left: 13.w,
          bottom: 9.h,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 26.sp,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(
              width: 14.w,
            ),
            Text(
              "COLLECTIONS",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  Widget listView() {
    return SizedBox(
      height: 756.h,
      child: StreamBuilder<GetAllCollectionsPhotos>(
          stream: collectionsBLoC.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              collectionsBLoC.actionSink
                  .add(UnsplashActionsCollectionsPhotos.show);
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 5.0.w, top: 10.h, right: 5.w, bottom: 10.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(90.r),
                                child: SizedBox(
                                  height: 40.h,
                                  width: 40.w,
                                  child: Image.network(
                                    snapshot.data!.list[index].getUser
                                        .getUserPhoto.userphotoUrlLarge,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          child: Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                255, 222, 222, 222),
                                            highlightColor: Colors.grey[100]!,
                                            period: const Duration(
                                                milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Colors.white,
                                              ),
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                snapshot.data!.list[index].getUser.name,
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          SizedBox(
                            height: 233.h,
                            width: 377.w,
                            child: Image.network(
                              snapshot.data!.list[index].getCoverPhotoUrl
                                  .coverPhoto.regular,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Stack(children: [
                                      child,
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        height: 233.h,
                                        width: 377.w,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                              Colors.transparent,
                                              Colors
                                                  .black // I don't know what Color this will be, so I can't use this
                                            ])),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 170.h,
                                              left: 20.w,
                                              bottom: 20.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data!.list[index].totalPhotos.toString()} Photos",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                snapshot.data!.list[index].title
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
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
                                      height: 233.h,
                                      width: 377.w,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
