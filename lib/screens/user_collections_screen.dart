import 'package:blue_splash/blocs/unsplash_bloc.dart';
import 'package:blue_splash/models/unsplash_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserCollectionM extends StatefulWidget {
  final String username;
  const UserCollectionM({Key? key, required this.username}) : super(key: key);

  @override
  State<UserCollectionM> createState() => _UserCollectionState();
}

class _UserCollectionState extends State<UserCollectionM> {
  var ownColBLoC = OwnColBLoC("");
  var followersBLoC = FollowersBLoC("");

  @override
  void initState() {
    super.initState();
    ownColBLoC = OwnColBLoC(widget.username);
    followersBLoC = FollowersBLoC(widget.username);
    followersBLoC.eventSink.add(Images.follow);
    ownColBLoC.eventSink.add(Images.own);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, snapshot) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
            child: StreamBuilder<ListOwnCol>(
                stream: ownColBLoC.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final data = snapshot.data!;
                    return StreamBuilder<UserFol>(
                        stream: followersBLoC.dataUserStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              (snapshot.hasData)
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 50.w,
                                          height: 50.h,
                                          child: ClipOval(
                                            child: Image.network(
                                                snapshot.data!.userFolImg.large,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          snapshot.data!.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Total: ${(data.listOwnCol.isEmpty) ? 0 : data.listOwnCol.length}",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: const Color(0xff979797)),
                                        )
                                      ],
                                    )
                                  : Container(
                                      height: 40.h,
                                    ),
                               SizedBox(
                                height: 10.h,
                              ),
                              (data.listOwnCol.isEmpty)
                                  ?  Padding(
                                      padding: EdgeInsets.only(top: 80.h),
                                      child: Center(
                                        child: Text(
                                          "This user not collected photos",
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 14.sp),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                      itemCount: data.listOwnCol.length,
                                      itemBuilder: (context, index) {
                                        final list = data.listOwnCol[index];
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15.w),
                                          height: 211.h,
                                          width: double.infinity,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10.r),
                                                  child: Image.network(
                                                    list.coverOwnCol
                                                        .urlCoverOwnCol.regular,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: Opacity(
                                                  opacity: 0.5,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                          Colors.transparent,
                                                          Colors.black
                                                        ])),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 24.w),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${list.totalPhotos} Photos",
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(list.title,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16.sp,
                                                          color: Colors.white,
                                                        )),
                                                    SizedBox(height: 16.h),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                            ],
                          );
                        });
                  } else {
                    ownColBLoC.eventSink.add(Images.own);
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        );
      }
    );
  }
}
