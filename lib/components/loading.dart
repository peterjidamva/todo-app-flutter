import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.cyan, // Customize the color of the animation
          size: 70.0, // Customize the size of the animation
        ),
      ),
    );
  }
}
