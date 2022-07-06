import 'dart:isolate';
import 'dart:ui';
import 'package:blue_splash/blocs/unsplash_bloc.dart';
import 'package:blue_splash/models/unsplash_model.dart';
import 'package:blue_splash/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoInfo extends StatefulWidget {
  final String id;
 const  PhotoInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<PhotoInfo> createState() => _PhotoInfoState();
}

class _PhotoInfoState extends State<PhotoInfo> {
  var getPhotoStat = GetPhotoStat("");
  /*  ReceivePort port = ReceivePort();
  int progress = 0;
  static void callBack(id, status, progress) {
    final portSender = IsolateNameServer.lookupPortByName('e');
    portSender!.send(progress);
  } */

  /*  Future download(url) async {
    final result = await Permission.storage.request();
    if (result.isGranted) {
      final filePath = await getExternalStorageDirectory();
      FlutterDownloader.enqueue(
          url: url,
          savedDir: filePath!.path,
          openFileFromNotification: true,
          requiresStorageNotLow: true,
          saveInPublicStorage: true,
          showNotification: true);
    }
  } */

  @override
  void initState() {
    super.initState();
    getPhotoStat = GetPhotoStat(widget.id);
    getPhotoStat.eventSink.add(Images.once);
    /*    IsolateNameServer.registerPortWithName(port.sendPort, 'e');
    port.listen((message) {
      setState(() {
        progress = message;
      });
    });
    FlutterDownloader.registerCallback(callBack); */
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: StreamBuilder<PhotoStatMain>(
              stream: getPhotoStat.dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                      // SizedBox(height: 40.h,),
                        SizedBox(
                          width: double.infinity,
                          height: 220.h,
                          child: Image.network(
                            data.photoStatUrls.regular,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 21.w),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        color: const Color(0xff979797),
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(data.exif.model ?? "Unknown",
                                      style:  TextStyle(fontSize: 14.sp)),
                                  SizedBox(height: 19.h),
                                  Text(
                                    "Focal Length",
                                    style: TextStyle(
                                        color: const Color(0xff979797),
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                      (data.exif.focalLength != null)
                                          ? data.exif.focalLength + "mm"
                                          : "Unknown",
                                      style: TextStyle(fontSize: 14.sp)),
                                  SizedBox(height: 19.h),
                                  Text(
                                    "ISO",
                                    style: TextStyle(
                                        color: const Color(0xff979797),
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                      (data.exif.iso != null)
                                          ? data.exif.iso.toString()
                                          : "Unknown",
                                      style: TextStyle(fontSize: 14.sp))
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Aperture",
                                    style: TextStyle(
                                        color: const Color(0xff979797),
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                      (data.exif.aperture != null)
                                          ? "f/" + data.exif.aperture
                                          : "Unknown",
                                      style: TextStyle(fontSize: 14.sp)),
                                  SizedBox(height: 19.h),
                                  Text(
                                    "Shutter Speed",
                                    style: TextStyle(
                                        color: const Color(0xff979797),
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                      (data.exif.exposureTime != null)
                                          ? data.exif.exposureTime + "s"
                                          : "Unknown",
                                      style: TextStyle(fontSize: 14.sp)),
                                  SizedBox(height: 19.h),
                                  Text(
                                    "Dimensions",
                                    style: TextStyle(
                                        color: const Color(0xff979797),
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                      "${data.width} × ${data.height}",
                                      style: TextStyle(fontSize: 14.sp)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20.w, top: 19.h, right: 19.w),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50.h,
                                width: 50.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(90.r),
                                  child: Image.network(
                                    data.photoStatUser.photoStatProfileImage
                                        .large,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Text(
                                data.photoStatUser.name,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff979797)),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return UserInfo(id: snapshot.data!.photoStatUser.username);
                                  },));
                                },
                                child: SizedBox(
                                  child: Text(
                                    "View profile",
                                    style: TextStyle(
                                        color: const Color(0xff24A2E9),
                                        fontSize: 12.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 15.h, left: 20.w, right: 20.w, bottom: 15.h),
                          child: const Divider(
                            thickness: 1,
                            color: Color(0xff979797),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Views",
                                  style: TextStyle(
                                      color: const Color(0xff979797),
                                      fontSize: 12.sp),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  data.views.toString(),
                                  style: TextStyle(fontSize: 14.sp),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Downloads",
                                  style: TextStyle(
                                      color: const Color(0xff979797),
                                      fontSize: 12.sp),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  data.downloads.toString(),
                                  style: TextStyle(fontSize: 14.sp),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Likes",
                                  style: TextStyle(
                                      color: const Color(0xff979797),
                                      fontSize: 12.sp),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  data.likes.toString(),
                                  style: TextStyle(fontSize: 14.sp),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 15.h, left: 15.w, right: 15.w, bottom: 15.h),
                          child: const Divider(
                            thickness: 1,
                            color: Color(0xff979797),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 44.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 25.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // download(data.photoStatLinks.download);
                                },
                                child: SizedBox(
                                  child: Icon(
                                    Icons.download_outlined,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.reply,
                                size: 25.sp,
                              ),
                              Icon(
                                Icons.bookmark_border_outlined,
                                size: 25.sp,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  getPhotoStat.eventSink.add(Images.once);
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
    );
  }
}
