
import 'package:blue_splash/blocs/blocforuser.dart';
import 'package:blue_splash/blocs/blockForAnimation.dart';
import 'package:blue_splash/models/tags_photofromapi.dart';
import 'package:blue_splash/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagPhotos extends StatefulWidget {
  final String id;
  final String slug;
  const TagPhotos({Key? key,  required this.id,required this.slug})
      : super(key: key);

  @override
  State<TagPhotos> createState() => TagPhotosState();
}

class TagPhotosState extends State<TagPhotos> {
  var userBlock = UserBlock("");
  int slugCount1 = 0;
  final controller = ScrollController();
  String nom = 'salom';
  final animBlock = AnimationBlock();
  var tagBlock = BlcokForTagPhoto('');
  var slug = '';
  @override
  void initState() {
    super.initState();
    userBlock = UserBlock(widget.id);
    userBlock.eventSink.add(UsersEnum.main);
    tagBlock = BlcokForTagPhoto(widget.id);
    tagBlock.eventSinktag.add(Anim.tag);
    slug = widget.slug;

    print('object');
    controller.addListener(() {
      if (controller.position.pixels > 55) {
        animBlock.eventSink.add(Anim.inc);
      } else {
        animBlock.eventSink.add(Anim.dec);
      }
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        animBlock.eventSink.add(Anim.tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(builder: (
        context,child
      ) {
        return 
     
        Scaffold(
            body: StreamBuilder<List<TagPhotoKatta>>(
              
                stream: tagBlock.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Stack(
                        children: [
                        
                          ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0, bottom: 5),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  slug,
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                ),
                                              ),
                                            ),
                                            userProf(
                                            
                                                snapshot
                                                    .data![index].userTag.name,
                                                snapshot.data![index].userTag
                                                    .profile_image.medium,snapshot.data![index].userTag.username),
                                          ],
                                        )
                                      : userProf(
                                          snapshot.data![index].userTag.name,
                                          snapshot.data![index].userTag
                                              .profile_image.medium,snapshot.data![index].userTag.username),
                                  SizedBox(
                                    height: 220,
                                    width: 350,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        snapshot
                                            .data![index].urlsTagPhoto.regular,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            controller: controller,
                          ),
                          StreamBuilder<double>(
                              stream: animBlock.dataStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return AnimatedContainer(
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      height: snapshot.data!,
                                      child: tepaCon());
                                } else {
                                  return const SizedBox();
                                }
                              })
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No Content',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }));
     
      }),
    );
  }

  Widget userProf(name, image,username) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, bottom: 7, top: 20),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Container(
                  height: 40,
                  width: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return UserInfo(id: username);
                      },));
                    },
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ))),
          const SizedBox(
            width: 8,
          ),
          Text(name)
        ],
      ),
    );
  }

  Widget tepaCon() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(15))),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 59,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 2, bottom: 2, left: 2),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Container(
              alignment: Alignment.center,
              height: 57,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                slug,
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 45,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(15))),
          ),
        ),
      ],
    );
  }
}
