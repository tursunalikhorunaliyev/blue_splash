import 'package:blue_splash/blocs/bloc_cakes.dart';
import 'package:blue_splash/blocs/bloc_collections.dart';
import 'package:blue_splash/blocs/bloc_drinks.dart';
import 'package:blue_splash/blocs/bloc_foods.dart';
import 'package:blue_splash/blocs/bloc_fruits.dart';
import 'package:blue_splash/blocs/bloc_latest.dart';
import 'package:blue_splash/blocs/bloc_random_photo.dart';
import 'package:blue_splash/blocs/category_photo_bloc.dart';
import 'package:blue_splash/models/model_cakes.dart';
import 'package:blue_splash/models/model_collections.dart';
import 'package:blue_splash/models/model_drinks.dart';
import 'package:blue_splash/models/model_foods.dart';
import 'package:blue_splash/models/model_fruits.dart';
import 'package:blue_splash/models/model_latest.dart';
import 'package:blue_splash/models/model_random_photo.dart';
import 'package:blue_splash/pageroutes/bottom_slide_page_route.dart';
import 'package:blue_splash/pageroutes/left_slide_page_route.dart';
import 'package:blue_splash/pageroutes/right_slide_page_route.dart';
import 'package:blue_splash/pageroutes/scale_page_route.dart';
import 'package:blue_splash/pageroutes/top_slide_page_route.dart';
import 'package:blue_splash/screens/category_screen.dart';
import 'package:blue_splash/screens/collections_screen.dart';
import 'package:blue_splash/screens/latest_screen.dart';
import 'package:blue_splash/screens/one_collection_screen.dart';
import 'package:blue_splash/screens/photo_info_screen.dart';
import 'package:blue_splash/screens/random_screen.dart';
import 'package:blue_splash/screens/search_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final blocRandomPhoto = BlocRandomPhoto();
  final blocLatest = BlocLatest();
  final blocCollections = BlocCollections();
  final blocFruits = BlocFruits();
  final blocCakes = BlocCakes();
  final blocFoods = BlocFoods();
  final blocDrinks = BlocDrinks();

  @override
  void initState() {
    blocRandomPhoto.eventSink.add(ActionType.view);
    blocLatest.eventSink.add(ActionType.view);
    blocCollections.eventSink.add(ActionType.view);
    blocFruits.eventSink.add(ActionType.view);
    blocCakes.eventSink.add(ActionType.view);
    blocFoods.eventSink.add(ActionType.view);
    blocDrinks.eventSink.add(ActionType.view);

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
                child: ListView(
              children: [
                SizedBox(
                  height: 21.h,
                ),
                top(),
                SizedBox(
                  height: 28.h,
                ),
                random(),
                latest(),
                collections(),
                fruits(),
                cakes(),
                foods(),
                drinks()
              ],
            )),
          );
        });
  }

  Widget top() {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, right: 6.w, left: 6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.menu,
            size: 25,
          ),
          SizedBox(
            width: 5.w,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, SlideTransitionBottom(const SearchScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 10.w),
              alignment: Alignment.centerLeft,
              width: 350.w,
              height: 40.h,
              decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Text(
                "Search",
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          const Icon(
            Icons.bookmark_border,
            size: 25,
          )
        ],
      ),
    );
  }

  Widget random() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: InkWell(
            onTap: () {
              Navigator.push(context, LeftSlideRoute(const RandomScreen()));
            },
            child: Text(
              "Random",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 180.h,
            child: StreamBuilder<RandomMain>(
              stream: blocRandomPhoto.dataStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  blocRandomPhoto.eventSink.add(ActionType.view);
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.list.length,
                    itemBuilder: (contex, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 222, 222, 222),
                            highlightColor: Colors.grey[100]!,
                            period: const Duration(milliseconds: 800),
                            child: Container(
                              height: 160.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PhotoInfo(
                                      id: snapshot.data!.list[index].id);
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 5.w, top: 5.h, bottom: 5.h),
                              width: 260.w,
                              color: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.network(
                                    snapshot.data!.list[index].urls.regular,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget latest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () {
              //   Navigator.push(context, LeftSlideRoute(const Latest()));
            },
            child: InkWell(
              onTap: () {
                Navigator.push(context, RightSlideRoute(const Latest()));
              },
              child: Text(
                "Latest",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 180.h,
            child: StreamBuilder<LatestMain>(
              stream: blocLatest.dataStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  blocLatest.eventSink.add(ActionType.view);
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 222, 222, 222),
                            highlightColor: Colors.grey[100]!,
                            period: const Duration(milliseconds: 800),
                            child: Container(
                              height: 160.h,
                              width: 170.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PhotoInfo(
                                      id: snapshot.data!.list[index].id);
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 5.w, top: 5.h, bottom: 5.h),
                              height: 180.h,
                              width: 180.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.network(
                                    snapshot.data!.list[index].urls.regular,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget collections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () {
              Navigator.push(context, SlideTransitionTop(const Collections()));
            },
            child: Text(
              "Collections",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 180.h,
            child: StreamBuilder<CollectionsMain>(
              stream: blocCollections.dataStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  blocCollections.eventSink.add(ActionType.view);
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 222, 222, 222),
                            highlightColor: Colors.grey[100]!,
                            period: const Duration(milliseconds: 800),
                            child: Container(
                              height: 150.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  ScalePageRoute(OneCollectionScreen(
                                    id: snapshot.data!.list[index].id,
                                    username: snapshot
                                        .data!.list[index].user.username,
                                  )));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 5.w, top: 5.h, bottom: 5.h),
                              height: 180.h,
                              width: 260.w,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: <Color>[
                                      Colors.black,
                                      Colors.white,
                                    ]),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SlideTransitionBottom(OneCollectionScreen(
                                        id: snapshot.data!.list[index].id,
                                        username: snapshot
                                            .data!.list[index].user.username,
                                      )));
                                },
                                child: Opacity(
                                  opacity: 0.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: Image.network(
                                      snapshot.data!.list[index].coverPhoto.urls
                                          .regular,
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
                                            period: const Duration(
                                                milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Colors.white,
                                              ),
                                              height: 180.h,
                                              width: 260.w,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 14,
                            left: 14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.list[index].title,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      snapshot.data!.list[index].totalPhotos
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Photos",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget fruits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  LeftSlideRoute(const Categoryes(
                    categoryAction: UnsplashCategoryAction.fruits,
                    categoryName: "Fruits",
                  )));
            },
            child: Text(
              "Fruits",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 180.h,
            child: StreamBuilder<FruitsMain>(
              stream: blocFruits.dataStream,
              builder: (context, snapshot) {
                print("every");
                if (snapshot.data == null) {
                  blocFruits.eventSink.add(ActionType.view);
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 222, 222, 222),
                            highlightColor: Colors.grey[100]!,
                            period: const Duration(milliseconds: 800),
                            child: Container(
                              height: 160.h,
                              width: 170.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PhotoInfo(
                                      id: snapshot.data!.list[index].id);
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 5.w, top: 5.h, bottom: 5.h),
                              height: 180.h,
                              width: 180.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.network(
                                    snapshot.data!.list[index].urls.regular,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget cakes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  LeftSlideRoute(const Categoryes(
                    categoryAction: UnsplashCategoryAction.pahlava,
                    categoryName: "Cakes",
                  )));
            },
            child: Text(
              "Cakes",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 180.h,
            child: StreamBuilder<CakesMain>(
              stream: blocCakes.dataStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  blocCakes.eventSink.add(ActionType.view);
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 222, 222, 222),
                            highlightColor: Colors.grey[100]!,
                            period: const Duration(milliseconds: 800),
                            child: Container(
                              height: 160.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PhotoInfo(
                                      id: snapshot.data!.list[index].id);
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 5.w, top: 5.h, bottom: 5.h),
                              width: 260.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.network(
                                    snapshot.data!.list[index].urls.regular,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget foods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  LeftSlideRoute(const Categoryes(
                    categoryAction: UnsplashCategoryAction.foods,
                    categoryName: "Foods",
                  )));
            },
            child: Text(
              "Foods",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 180.h,
            child: StreamBuilder<FoodsMain>(
              stream: blocFoods.dataStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  blocFoods.eventSink.add(ActionType.view);
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 222, 222, 222),
                            highlightColor: Colors.grey[100]!,
                            period: const Duration(milliseconds: 800),
                            child: Container(
                              height: 160.h,
                              width: 230.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PhotoInfo(
                                      id: snapshot.data!.list[index].id);
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 5.r, top: 5.h, bottom: 5.h),
                              height: 180.h,
                              width: 240.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.network(
                                    snapshot.data!.list[index].urls.regular,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget drinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  LeftSlideRoute(const Categoryes(
                    categoryAction: UnsplashCategoryAction.drinks,
                    categoryName: "Drinks",
                  )));
            },
            child: Text(
              "Drinks",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 180.h,
            child: StreamBuilder<DrinksMain>(
              stream: blocDrinks.dataStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  blocDrinks.eventSink.add(ActionType.view);
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 222, 222, 222),
                            highlightColor: Colors.grey[100]!,
                            period: const Duration(milliseconds: 800),
                            child: Container(
                              height: 160.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PhotoInfo(
                                      id: snapshot.data!.list[index].id);
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 5.w, top: 5.h, bottom: 5.h),
                              width: 260.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.network(
                                    snapshot.data!.list[index].urls.regular,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
