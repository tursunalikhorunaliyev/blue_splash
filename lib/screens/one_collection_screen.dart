import 'package:blue_splash/blocs/unsplash_bloc.dart';
import 'package:blue_splash/models/unsplash_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OneCollectionScreen extends StatefulWidget {
  final String id;
  final String username;
  const OneCollectionScreen(
      {Key? key, required this.id, required this.username})
      : super(key: key);

  @override
  State<OneCollectionScreen> createState() => _OneCollectionScreenState();
}

class _OneCollectionScreenState extends State<OneCollectionScreen> {
  var publicColBLoC = PublicColBLoC("");
  var colBLoC = ColBloc("");
  var followersBLoC = FollowersBLoC("");
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    publicColBLoC = PublicColBLoC(widget.id);
    colBLoC = ColBloc(widget.id);
    followersBLoC = FollowersBLoC(widget.username);
    publicColBLoC.eventSink.add(Images.public);
    colBLoC.eventSink.add(Images.getone);
    followersBLoC.eventSink.add(Images.follow);
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        publicColBLoC.eventSink.add(Images.public);
        setState(() {});
      }
    });
  }

  Widget chips(String text) {
    return Container(
      margin: EdgeInsets.only(right: 10.h, top: 6.w),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: const Color(0xFFEDEDED),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 22.sp,
                ),
              ),
              title: Text(
                "COLLECTION PHOTOS",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<OwnCol>(
                              stream: colBLoC.dataStream,
                              builder: (context, snapshot) {
                                return RichText(
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "Title: ",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: const Color(0xff979797),
                                          )),
                                      TextSpan(
                                          text: (snapshot.hasData)
                                              ? snapshot.data!.title
                                              : "Unknown",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color(0xff818181),
                                          )),
                                    ]));
                              }),
                          SizedBox(
                            height: 4.h,
                          ),
                          StreamBuilder<UserFol>(
                              stream: followersBLoC.dataUserStream,
                              builder: (context, snapshot) {
                                return RichText(
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "Collected by: ",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: const Color(0xff979797),
                                          )),
                                      TextSpan(
                                          text: (snapshot.hasData)
                                              ? snapshot.data!.name
                                              : "Unknown",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color(0xffffb800),
                                          )),
                                    ]));
                              }),
                          StreamBuilder<List<String>>(
                              stream: colBLoC.setStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                        height: 30.h,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                120,
                                        child: (snapshot.hasData)
                                            ? ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  return chips(
                                                      snapshot.data![index]);
                                                },
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        ],
                      ),
                      const Spacer(),
                      StreamBuilder<UserFol>(
                          stream: followersBLoC.dataUserStream,
                          builder: (context, snapshot) {
                            return ClipOval(
                                child: (snapshot.hasData)
                                    ? Image.network(
                                        snapshot.data!.userFolImg.large,
                                        height: 60.h,
                                        width: 60.w,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator()));
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  StreamBuilder<List<PublicCol>>(
                      stream: publicColBLoC.dataStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                              child: ListView.builder(
                            controller: scrollController,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data![index];
                              double difference = data.width / data.height;
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            data.publicColUser
                                                .publicColUserImage.medium,
                                            height: 40.h,
                                            width: 40.w,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        const Color.fromARGB(
                                                            255, 222, 222, 222),
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    period: const Duration(
                                                        milliseconds: 800),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
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
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          data.publicColUser.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.network(
                                          data.publicColUrls.regular,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              difference,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Shimmer.fromColors(
                                                baseColor:
                                                    const Color.fromARGB(
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
                                                  width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  height:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          difference,
                                                ),
                                              );
                                            }
                                          },
                                        ))
                                  ],
                                ),
                              );
                            },
                          ));
                        } else {
                          publicColBLoC.eventSink.add(Images.public);
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })
                ],
              ),
            ),
          );
        });
  }
}
