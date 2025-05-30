import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BarbershopLoader extends StatelessWidget {
  const BarbershopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        size: 60,
        color: Colors.amberAccent,
        secondRingColor: Colors.yellowAccent,
        thirdRingColor: Colors.amber,
      ),
    );
  }
}
