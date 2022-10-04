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
  bool tryAgain = false;
  String status = 'Getting things ready for you...';
  firstStartUp() async {
    try {
      await Initialization().initializePrayers();
      await Initialization().initializeQuran();
      UC.hive.put(
        kInitializedVersion,
        kCurrentVersion,
      );
      UC.uv = UniversalVariables();
      Navigator.pushReplacementNamed(context, Home.id);
    } catch (e) {
      tryAgain = true;
      status = 'Internet is required for first time.Click Try Again';
      setState(() {});
      showToast(
          context: context, content: Text(e.toString()), color: Colors.red);
    }
  }

  retry() {
    tryAgain = false;
    status = 'Getting things ready for you...';
    setState(() {});
    firstStartUp();
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
            tryAgain
                ? ElevatedButton(
                    onPressed: () {
                      retry();
                    },
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.copyWith(
                          foregroundColor:
                              const MaterialStatePropertyAll<Color>(Colors.red),
                        ),
                    child: const Text(
                        'Internet is Required.Click me to try Again'),
                  )
                : const SizedBox(),
            const LinearProgressIndicator(
              color: Colors.green,
            ),
            Text(
              status,
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
