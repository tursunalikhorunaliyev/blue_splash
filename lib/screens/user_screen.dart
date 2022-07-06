import 'package:blue_splash/blocs/blocforuser.dart';
import 'package:blue_splash/blocs/connection_checker.dart';
import 'package:blue_splash/models/userfromapi.dart';
import 'package:blue_splash/screens/followers_screen.dart';
import 'package:blue_splash/screens/user_collections_screen.dart';
import 'package:blue_splash/screens/user_photos_screen.dart';
import 'package:blue_splash/screens/wallpapers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfo extends StatefulWidget {
  final String id;
  const UserInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  var userBlock = UserBlock("");
  int slugCount1 = 0;
  List<bool> checker = [];
  var connectionBLoC = ConnectionChecker();

  @override
  void initState() {
    super.initState();
    userBlock = UserBlock(widget.id);
    userBlock.eventSink.add(UsersEnum.main);
  }

  Future<int> mainFuture(id, page) async {
    var url =
        'https://api.unsplash.com/topics/$id/photos?client_id=LadkGfS6e_rzmaghTUdTal-0cFcIcXtdJCIdlaiUhSU&page=$page&per_page=20';

    http.Response response = await http.get(Uri.parse(url));

    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 30.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 21.h),
                        child: StreamBuilder<EEEngKattaClass>(
                          stream: userBlock.dataStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.waiting) {
                              checker.add(true);
                              connectionBLoC.dataSink.add(checker);
                            }
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  Text(
                                    snapshot.data!.name,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  (snapshot.data!.location != null)
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              size: 18.sp,
                                              color: const Color(0xffFFC700),
                                            ),
                                            Text(
                                              snapshot.data!.location,
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(fontSize: 10.sp),
                                            ),
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.h, left: 3.w, right: 20.w),
                            child: Row(
                              children: [
                                StreamBuilder<EEEngKattaClass>(
                                  stream: userBlock.dataStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState !=
                                        ConnectionState.waiting) {
                                      checker.add(true);
                                      connectionBLoC.dataSink.add(checker);
                                    }
                                    if (snapshot.hasData) {
                                      print(snapshot.data!.username +
                                          "jjsjjjjjjjjj");
                                      return CircleAvatar(
                                        radius: 45.r,
                                        backgroundImage: NetworkImage(snapshot
                                            .data!.profileImage.medium
                                            .toString()),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<EEEngKattaClass>(
                            stream: userBlock.dataStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                checker.add(true);
                                connectionBLoC.dataSink.add(checker);
                              }
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.w, bottom: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 40.w),
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data!.followers_count
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                                Text(
                                                  'Followers',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xff979797)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 43.w),
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data!.following_count
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                                Text('Following',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xff979797)))
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                snapshot.data!.total_photos
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              ),
                                              Text('Photos',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xff979797)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.w),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 45.w, left: 10.w),
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!.total_collections
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                                Text('Collections',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xff979797)))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 44.w),
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data!.total_likes
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                                Text('Likes',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xff979797)))
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                snapshot.data!.downloads
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              ),
                                              Text('Downloads',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xff979797)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                      StreamBuilder<EEEngKattaClass>(
                          stream: userBlock.dataStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.waiting) {
                              checker.add(true);
                              connectionBLoC.dataSink.add(checker);
                            }
                            if (snapshot.hasData) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Row(
                                  children: [
                                    Text(
                                      'Bio:',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 6.w, top: 2.h),
                                          child: Text(
                                            snapshot.data!.bio ?? "",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                      StreamBuilder<EEEngKattaClass>(
                          stream: userBlock.dataStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.waiting) {
                              checker.add(true);
                              connectionBLoC.dataSink.add(checker);
                            }
                            if (snapshot.hasData) {
                              if (snapshot.data!.badge != null) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Image.asset(
                                        'assets/icons8-badge-100 (2).png',
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.h, left: 5.w),
                                      child: Text(
                                        snapshot.data!.badge!.title,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      SizedBox(
                        height: 75.h,
                        child: StreamBuilder<ListFollower>(
                            stream: userBlock.dataStreamFollower,
                            builder: (context, snapshotFol) {
                              if (snapshotFol.connectionState !=
                                  ConnectionState.waiting) {
                                checker.add(true);
                                connectionBLoC.dataSink.add(checker);
                              }
                              if (snapshotFol.hasData) {
                                if (snapshotFol.data!.list.isNotEmpty) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.h, bottom: 8.h),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: GestureDetector(
                                                onTap: () {
                                                    Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return Followers(username: widget.id);
                                                          },
                                                        ));
                                                },
                                                child: Text(
                                                  'Followers',
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(
                                                          0xff979797)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height: 40.h,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapshotFol.data!.list.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.w),
                                                child: SizedBox(
                                                    height: 40.sp,
                                                    width: 40.sp,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90.r),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return UserInfo(
                                                                  id: snapshotFol
                                                                      .data!
                                                                      .list[
                                                                          index]
                                                                      .username);
                                                            },
                                                          ));
                                                        },
                                                        child: Image.network(
                                                          snapshotFol
                                                              .data!
                                                              .list[index]
                                                              .profile_image
                                                              .medium,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )),
                                              );
                                            },
                                          )),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                      ),
                      StreamBuilder<ListCollection>(
                          stream: userBlock.dataStreamCollect,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.waiting) {
                              checker.add(true);
                              connectionBLoC.dataSink.add(checker);
                            }
                            if (snapshot.hasData) {
                              if (snapshot.data!.list.isNotEmpty) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.sp),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                                Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return UserCollectionM(username: widget.id,);
                                                          },
                                                        ));
                                            },
                                            child: Text(
                                              'Collections',
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: const Color(0xff979797)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height: 150.h,
                                        child: ListView.builder(
                                          primary: false,
                                          reverse: false,
                                          shrinkWrap: false,
                                          addRepaintBoundaries: false,
                                          addAutomaticKeepAlives: false,
                                          itemCount: snapshot.data!.list.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  right: 16.w, top: 8.h),
                                              child: SizedBox(
                                                height: 150.h,
                                                width: 250.w,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                  child: Image.network(
                                                    snapshot
                                                        .data!
                                                        .list[index]
                                                        .cover_photo
                                                        .urls
                                                        .regular,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      SizedBox(
                        height: 70.h,
                        child: StreamBuilder<List<String>>(
                            stream: userBlock.streamUpSource,
                            builder: (context, snapshotA) {
                              if (snapshotA.connectionState !=
                                  ConnectionState.waiting) {
                                checker.add(true);
                                connectionBLoC.dataSink.add(checker);
                              }
                              if (snapshotA.hasData) {
                                if (snapshotA.data!.isNotEmpty) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Tags',
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      const Color(0xff979797)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height: 40.h,
                                          child: ListView.builder(
                                            itemCount: snapshotA.data!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.w),
                                                child: InkWell(
                                                  onTap: () {
                                                    mainFuture(
                                                            snapshotA
                                                                .data![index],
                                                            1)
                                                        .then((status) => {
                                                              if (status == 200)
                                                                {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return TagPhotos(
                                                                        id: snapshotA
                                                                            .data![index],
                                                                        slug: snapshotA
                                                                            .data![index],
                                                                      );
                                                                    },
                                                                  ))
                                                                }
                                                              else
                                                                {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (v) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text("Couldn't find Topic"),
                                                                          actions: [
                                                                            MaterialButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              color: Colors.amber,
                                                                              child: const Text(
                                                                                'Ok',
                                                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        );
                                                                      })
                                                                }
                                                            });
                                                  },
                                                  child: Chip(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 1.h),
                                                    label: Text(snapshotA
                                                        .data![index]
                                                        .toString()),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        5.r),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5.r),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5.r),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                        5.r))),
                                                    labelStyle: TextStyle(
                                                        color: const Color(
                                                            0xff7300FF),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp),
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                      ),
                      Expanded(
                        child: StreamBuilder<ListUserPhotos>(
                            stream: userBlock.dataStreamPhotos,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                checker.add(true);
                                connectionBLoC.dataSink.add(checker);
                              }

                              if (snapshot.hasData) {
                                if (snapshot.data!.list.isNotEmpty) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child:  GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return UserPhotos(username: widget.id);
                                                          },
                                                        ));
                                                      },
                                                      child: Text(
                                                        'Photos',
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: const Color(
                                                                0xff979797)),
                                                      ),
                                                    )
                                                
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.list.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  right: 16.w, bottom: 8.h),
                                              child: SizedBox(
                                                height: 220.h,
                                                width: 280.w,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    snapshot.data!.list[index]
                                                        .urls.regular,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return const Center(
                                    child: Text('No photos'),
                                  );
                                }
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<List<bool>>(
                    initialData: const [],
                    stream: connectionBLoC.dataStream,
                    builder: (context, snapshot) {
                      return Visibility(
                          visible: snapshot.data!.length != 9,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ));
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  AsyncSnapshot<EEEngKattaClass> getSnapshot(
      AsyncSnapshot<EEEngKattaClass> snapshot) {
    return snapshot;
  }
}
