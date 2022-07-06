import 'package:blue_splash/blocs/scroll_bloc.dart';
import 'package:flutter/material.dart';

class ScrollUp extends StatefulWidget {
  const ScrollUp({Key? key}) : super(key: key);

  @override
  State<ScrollUp> createState() => _ScrollUpState();
}

class _ScrollUpState extends State<ScrollUp> {
  final scroollController = ScrollController();
  final scrollBloc = ScrollBloC();
  @override
  void initState() {
    scroollController.addListener(() {
      print(scroollController.position.pixels);
      if(scroollController.position.pixels<100 && scroollController.position.pixels>0){
        scrollBloc.pixelSink.add(scroollController.position.pixels);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            StreamBuilder<double>(
                initialData: 200.0,
                stream: scrollBloc.pixelStream,
                builder: (context, snapshot) {
                  return Padding(
                    padding:  EdgeInsets.only(left: (110-snapshot.data!)),
                    child: Container(
                      width: 200-snapshot.data!,
                      height: 200-snapshot.data!,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  );
                }),
            Expanded(
              child: ListView.builder(
                controller: scroollController,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.purple,
                      width: 200,
                      height: 200,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
