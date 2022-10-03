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

class _StartupScreenState extends State<StartupScreen> {
  String currentImage = kALLBackgrounds[0];

  firstStartUp() async {
    await Initialization().initialized();

    UC.uv = UniversalVariables();
    Navigator.pushReplacementNamed(context, Home.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstStartUp();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: kALLBackgrounds
                    .map((e) => CachedNetworkImage(
                          imageUrl: e,
                          fit: BoxFit.fill,
                        ))
                    .toList(),
              ),
            ),
            const LinearProgressIndicator(
              color: Colors.green,
            ),
            Text(
              'Getting things ready for you...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const LinearProgressIndicator(
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
