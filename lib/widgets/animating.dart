import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnimationTypes extends StatefulWidget {
  const AnimationTypes({Key? key}) : super(key: key);

  @override
  State<AnimationTypes> createState() => _AnimationTypesState();
}

class _AnimationTypesState extends State<AnimationTypes> {
  double bottom = -400;
  final state = CrossFadeState.showFirst;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            MaterialButton(
              minWidth: 100,
              height: 50,
            
              onPressed: (){
                if(state==CrossFadeState.showFirst){
                  state==CrossFadeState.showSecond;
                }
                else{
                  state==CrossFadeState.showFirst;
                }
                
                setState(() {
                  
                });
              }, color: Colors.amber,),
              Positioned(
                
                child: AnimatedCrossFade(
                          firstCurve: Curves.easeInBack,
                          secondCurve: Curves.decelerate,
                          crossFadeState: state,
                  firstChild: Container( width: 400, height: 400, color: Colors.red),
                 secondChild: Container( width: 400, height: 400, color: Colors.pink),
                  
                           duration: const Duration(milliseconds: 400)),
              )
          ],
        ),
      ),
    );
  }
}