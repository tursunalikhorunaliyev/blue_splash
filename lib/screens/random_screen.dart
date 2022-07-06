import 'package:blue_splash/blocs/unsplash_bloc.dart';
import 'package:blue_splash/models/unsplash_model.dart';
import 'package:blue_splash/screens/photo_info_screen.dart';
import 'package:blue_splash/screens/user_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({Key? key}) : super(key: key);

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  late String name;
  final randomPhotosBLoC = RandomPhotosBLoC();
  final listViewController = ScrollController();

  @override
  void initState() {
    randomPhotosBLoC.eventSink.add(Images.random);
    listViewController.addListener(() {
      if (listViewController.offset ==
          listViewController.position.maxScrollExtent) {
        randomPhotosBLoC.eventSink.add(Images.random);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              "RANDOM",
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
      child: StreamBuilder<List<RandomPhotos>>(
          stream: randomPhotosBLoC.dataStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              randomPhotosBLoC.eventSink.add(Images.random);
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
                                            id: snapshot.data![index]
                                                .randomPhotoUser.username),
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.network(
                                      snapshot.data![index].randomPhotoUser
                                          .randomPhotoUserPhoto.medium,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserInfo(
                                          id: snapshot.data![index]
                                              .randomPhotoUser.username),
                                    )),
                                child: Text(
                                  snapshot.data![index].randomPhotoUser.name,
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoInfo(id: snapshot.data![index].id),
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.network(
                                snapshot.data![index].randomPhotoUrls.regular,
                                height: MediaQuery.of(context).size.width *
                                    difference,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingBuilder) {
                                  if (loadingBuilder == null) {
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
                                        height:
                                            MediaQuery.of(context).size.width *
                                                difference,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    );
                                  }
                                },
                              ),
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
