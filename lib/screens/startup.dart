// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/functions/initialization.dart';
import 'package:quran/main.dart';
import 'package:quran/screens/home.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

class StartupScreen extends StatefulWidget {
  static const String id = 'startupScreen';
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen>
    with SingleTickerProviderStateMixin {
  String currentImage = kALLBackgrounds[0];
  late final AnimationController _controller;
  double value = 0.0;
  bool canCall = true;
  int currentImageIndex = 0;
  firstStartUp() async {
    await Initialization().initialized();

    UC.uv = UniversalVariables();
    Navigator.pushReplacementNamed(context, Home.id);
  }

  changeImage() async {
    await Future.delayed(const Duration(seconds: 1));
    if (currentImageIndex < kALLBackgrounds.length) {
      currentImage = kALLBackgrounds[currentImageIndex];
      currentImageIndex = currentImageIndex + 1;
      mounted ? setState(() {}) : null;
    } else {
      currentImage =
          kAladhanImages[Random().nextInt(kAladhanImages.length - 1)];
      mounted ? setState(() {}) : null;
    }
    canCall = true;
  }

  update() {
    if (canCall) {
      canCall = false;
      changeImage();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstStartUp();
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _controller.forward();
    _controller.addListener(() {
      update();
      if (_controller.value == 1.0) {
        _controller.reverse();
      }
      if (_controller.value == 0.0) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn,
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(currentImage),
            ),
          ),
          child: Center(
            child: GlassMorphism(
                start: 0.1,
                end: 0.2,
                child: AutoSizeText(
                  'Getting things ready for you',
                  style: Theme.of(context).textTheme.displaySmall,
                  maxFontSize: 30,
                )),
          ),
        ),
      ),
    );
  }
}
