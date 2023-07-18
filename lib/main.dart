import 'dart:async';
import 'dart:ffi';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int milliseconds = 0;
  Timer? timer;

  void start() {
    if (timer == null) {
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          milliseconds += 100;
        });
      });
    }
  }

  void stop() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  void reset() {
    stop();
    setState(() {
      milliseconds = 0;
    });
  }

  String? timeformat(int milliseconds) {
    int hour = (milliseconds ~/ 3600000) % 60;
    int minutes = (milliseconds ~/ 60000) % 60;
    int seconds = (milliseconds ~/ 1000) % 60;
    int centiseconds = (milliseconds ~/ 10) % 100;

    if (hour > 0) {
      return '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${centiseconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stopwatch'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 10.0,
                  percent: ((milliseconds~/1000)%60)/60,
                  center: Text(timeformat(milliseconds)!,style: const TextStyle(fontSize: 48),),
                  progressColor: Colors.cyan,
                ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            start();
                          },
                          child: const Text('Start')),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            stop();
                          },
                          child: const Text('Stop')),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            reset();
                          },
                          child: const Text('Reset')),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
