import 'package:blue_splash/blocs/latest_photo_bloc.dart';
import 'package:blue_splash/models/latest_photo_model.dart';
import 'package:blue_splash/screens/photo_info_screen.dart';
import 'package:blue_splash/screens/user_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Latest extends StatefulWidget {
  const Latest({Key? key}) : super(key: key);

  @override
  State<Latest> createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  late String name;
  final latestPhotoBLoC = LatestPhotosBloCUnsplash();
  final listViewController = ScrollController();
  bool imageUchun = false;

  @override
  void initState() {
    listViewController.addListener(() {
      if (listViewController.offset ==
          listViewController.position.maxScrollExtent) {
        latestPhotoBLoC.actionSink.add(UnsplashActionsLatestPhotos.show);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    setState(() {});
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(428, 926),
      builder: (context, child) {
        return Scaffold(
            body: SafeArea(
                child: Column(
          children: [topContainer(), listView()],
        )));
      },
    );
  }

  Widget topContainer() {
    return Padding(
        padding: EdgeInsets.only(top: 5.h, left: 20.w, bottom: 5.h),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 30.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 18.w,
            ),
            Text(
              "LATEST",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ));
  }

  Widget listView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 121.h,
      child: StreamBuilder<List<GetPhotoLatest>>(
          stream: latestPhotoBLoC.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              latestPhotoBLoC.actionSink.add(UnsplashActionsLatestPhotos.show);
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: listViewController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    double difference = snapshot.data![index].width /
                        snapshot.data![index].height;

                    return Padding(
                      padding: EdgeInsets.only(
                          left: 20.0.w, right: 20.w, top: 10, bottom: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 5.w),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserInfo(
                                            id: snapshot
                                                .data![index].getUser.username),
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image.network(
                                        snapshot.data![index].getUser
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
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                period: const Duration(
                                                    milliseconds: 800),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: Colors.white,
                                                  ),
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserInfo(
                                              id: snapshot.data![index].getUser
                                                  .username),
                                        ));
                                  },
                                  child: Text(
                                    snapshot.data![index].getUser.name,
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.black),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PhotoInfo(id: snapshot.data![index].id),
                                  ));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.network(
                                  snapshot.data![index].getUrl.regular,
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
                                        period:
                                            const Duration(milliseconds: 800),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.white,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              difference,
                                        ),
                                      );
                                    }
                                  },
                                )),
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
