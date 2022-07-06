import 'package:blue_splash/blocs/bloc_color.dart';
import 'package:blue_splash/blocs/bloc_orientation.dart';
import 'package:blue_splash/blocs/bloc_quality.dart';
import 'package:blue_splash/blocs/bloc_random_photo.dart';
import 'package:blue_splash/blocs/bloc_search_screen.dart';
import 'package:blue_splash/blocs/bloc_sort_by.dart';
import 'package:blue_splash/models/model_search_screen.dart';
import 'package:blue_splash/screens/photo_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final blocSearchScreen = BlocSearchScreen();
  final textFieldController = TextEditingController();
  final blocColor = BlocColor();
  final blocOrientation = BlocOrientation();
  final blocSortBy = BlocSortBy();
  final blocQuality = BlocQuality();
  final scrollController = ScrollController();
  List<String> colors = [
    "Any",
    "Black and White",
    "Black",
    "White",
    "Yellow",
    "Orange",
    "Red",
    "Purple",
    "Magenta",
    "Green",
    "Teal",
    "Blue",
  ];
  List<String> orientation = [
    "Landscape",
    "Portrait",
    "Squarish",
  ];
  List<String> sortBy = ["Latest", "Relevant"];
  List<String> quality = ["Low", "High"];
  int orienIndex = 0;
  int colorIndex = 0;
  int sortIndex = 1;
  int qualiIndex = 0;
  bool enter = false;
  


  @override
  void initState() {

    setState(() {
      enter = true;
    });
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (colorIndex == 0) {
          blocSearchScreen.eventSink.add(ActionType.updateUnColor);
        } else {
          blocSearchScreen.eventSink.add(ActionType.update);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  
                  children: [
                           Padding(
                             padding: EdgeInsets.only(left: 16.w, top: 20.h), child: InkWell(
                               onTap: () {
                                 Navigator.pop(context);
                               },
                               child: const Icon(Icons.arrow_back_ios))),
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        cursorColor: Colors.black,
                        cursorHeight: 15.h,
                        controller: textFieldController,
                        decoration: InputDecoration(
                            contentPadding:
                                 EdgeInsets.only(top: 20.h, left: 5.w),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Colors.grey[350],
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp),
                            disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 15.w, top: 28.h),
                      child: StreamBuilder<bool>(builder: (context, snapshot) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              enter = false;
                            });
                            if (colorIndex == 0) {
                              blocSearchScreen.params(
                                  textFieldController.text,
                                  orientation[orienIndex].toLowerCase(),
                                  sortBy[sortIndex].toLowerCase(),
                                  quality[qualiIndex].toLowerCase());
                                  blocSearchScreen.eventSink
                                  .add(ActionType.newSearchUnColor);
                            }
                            if (colorIndex != 0) {
                              blocSearchScreen.fullParams(
                                  textFieldController.text,
                                  orientation[orienIndex].toLowerCase(),
                                  colorIndex == 1
                                      ? "black_and_white"
                                      : colors[colorIndex].toLowerCase(),
                                  sortBy[sortIndex].toLowerCase(),
                                  quality[qualiIndex].toLowerCase());
                              
                              blocSearchScreen.eventSink
                                  .add(ActionType.newSearch);
                            }
                          },
                          child:  SizedBox(
                            height: 30.h,
                            width: 30.w,
                            child: const Icon(
                              Icons.search,
                              size: 25,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 22.w, top: 11.5.h),
                  child: const Text(
                    "Orientation",
                    style: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 22.0.w, top: 5.h),
                  child: SizedBox(
                    height: 22.h,
                    child: ListView.builder(
                      itemCount: orientation.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.only(right: 8.w),
                          child: StreamBuilder<int>(
                              initialData: 0,
                              stream: blocOrientation.dataStream,
                              builder: (context, snapshot) {
                                return InkWell(
                                    onTap: () {
                                      blocOrientation.dataSink.add(index);
                                      setState(() {
                                        orienIndex = index;
                                      });

                                      if (colorIndex == 0) {
                                        blocSearchScreen.params(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());

                                       
                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearchUnColor);
                                      }
                                      if (colorIndex != 0) {
                                        blocSearchScreen.fullParams(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            colorIndex == 1
                                                ? "black_and_white"
                                                : colors[colorIndex]
                                                    .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());
                                      
                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearch);
                                      }
                                    },
                                    child: snapshot.data == index
                                        ? chipsFocus(orientation[index])
                                        : chips(orientation[index]));
                              }),
                        );
                      },
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 22.w, top: 10.h, bottom: 5.h),
                  child: const Text(
                    "Color",
                    style: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 22.0.w),
                  child: SizedBox(
                    height: 22.h,
                    child: ListView.builder(
                      itemCount: colors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.only(right: 8.w),
                          child: StreamBuilder<int>(
                              initialData: colorIndex != 0 ? colorIndex :  0,
                              stream: blocColor.dataStream,
                              builder: (context, snapshot) {
                                return InkWell(
                                    onTap: () {
                                      blocColor.dataSink.add(index);
                                      setState(() {
                                        colorIndex = index;
                                      });

                                      if (colorIndex == 0) {
                                        blocSearchScreen.params(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());

                                     

                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearchUnColor);
                                      }
                                      if (colorIndex != 0) {
                                        blocSearchScreen.fullParams(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            colorIndex == 1
                                                ? "black_and_white"
                                                : colors[colorIndex]
                                                    .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());
                                        

                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearch);
                                      }
                                    },
                                    child: snapshot.data == index
                                        ? chipsFocus(colors[index])
                                        : chips(colors[index]));
                              }),
                        );
                      },
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 22.w, top: 10.h, bottom: 5.h),
                  child: const Text(
                    "Sort By",
                    style: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 22.0.w),
                  child: SizedBox(
                    height: 22.h,
                    child: ListView.builder(
                      itemCount: sortBy.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.only(right: 8.w),
                          child: StreamBuilder<int>(
                              initialData: 1,
                              stream: blocSortBy.dataStream,
                              builder: (context, snapshot) {
                                return InkWell(
                                    onTap: () {
                                      blocSortBy.dataSink.add(index);
                                      setState(() {
                                        sortIndex = index;
                                      });
                                      if (colorIndex == 0) {
                                        blocSearchScreen.params(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());

                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearchUnColor);
                                      }
                                      if (colorIndex != 0) {
                                        blocSearchScreen.fullParams(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            colorIndex == 1
                                                ? "black_and_white"
                                                : colors[colorIndex]
                                                    .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());
                                   
                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearch);
                                      }
                                    },
                                    child: snapshot.data == index
                                        ? chipsFocus(sortBy[index])
                                        : chips(sortBy[index]));
                              }),
                        );
                      },
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 22.w, top: 10.h, bottom: 5.h),
                  child: const Text(
                    "Quality",
                    style: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 22.0.w),
                  child: SizedBox(
                    height: 22.h,
                    child: ListView.builder(
                      itemCount: quality.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.only(right: 8.w),
                          child: StreamBuilder<int>(
                              initialData: 0,
                              stream: blocQuality.dataStream,
                              builder: (context, snapshot) {
                                return InkWell(
                                    onTap: () {
                                      blocQuality.dataSink.add(index);
                                      setState(() {
                                        qualiIndex = index;
                                      });
                                      if (colorIndex == 0) {
                                        blocSearchScreen.params(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());

                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearchUnColor);
                                      }
                                      if (colorIndex != 0) {
                                        blocSearchScreen.fullParams(
                                            textFieldController.text,
                                            orientation[orienIndex]
                                                .toLowerCase(),
                                            colorIndex == 1
                                                ? "black_and_white"
                                                : colors[colorIndex]
                                                    .toLowerCase(),
                                            sortBy[sortIndex].toLowerCase(),
                                            quality[qualiIndex].toLowerCase());
                                    
                                        blocSearchScreen.eventSink
                                            .add(ActionType.newSearch);
                                      }
                                    },
                                    child: snapshot.data == index
                                        ? chipsFocus(quality[index])
                                        : chips(quality[index]));
                              }),
                        );
                      },
                    ),
                  ),
                ),
                 SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  height: 520.5.h,
                  child: StreamBuilder<List<ModelSearchScreen>>(
                      stream: blocSearchScreen.dataStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          if (enter) {
                            return Container();
                          } else {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[500]!,
                              highlightColor: Colors.grey[100]!,
                              period: const Duration(milliseconds: 800),
                              child: Container(
                                color: Colors.white,
                                height: 400.h,
                                width: 400.w,
                              ),
                            );
                          }
                        } else {
                          return ListView.builder(
                            controller: scrollController,
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return PhotoInfo(id: snapshot.data![index].id);
                                    },));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: Image.network(
                                      snapshot.data![index].urls.small,          
                                      width: 360.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                )
              ],
            )),
          );
        });
  }

  Widget chips(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: const Color(0xFFEDEDED),
      ),
      child: Text(
        text,
        style:  TextStyle(fontSize: 12.sp, color: Colors.black),
      ),
    );
  }

  Widget chipsFocus(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: const Color(0xFF7300ff)),
      child: Text(
        text,
        style:  TextStyle(fontSize: 12.sp, color: Colors.white),
      ),
    );
  }
}
