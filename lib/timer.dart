import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class Capsule extends StatefulWidget {
  const Capsule({Key? key}) : super(key: key);

  @override
  _CapsuleState createState() => _CapsuleState();
}

class _CapsuleState extends State<Capsule> {
  late Timer _timer;
  String value = "none";
  bool tt = false;
  int _seconds = 100;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
      });
      if (_seconds == 80) {
        setState(() {
          tt = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text('hellow'),
            TextButton(
              onPressed: () => startTimer(),
              child: Text(
                '$_seconds',
                style: TextStyle(color: Colors.black),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            TextButton(
              onPressed: () {
                if (tt == true) {
                  setState(() {
                    value = 'Done';
                  });
                } else {
                  print("not done yet");
                  print(_seconds);
                }
              },
              child: Text(
                value,
                style: const TextStyle(color: Colors.black),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
