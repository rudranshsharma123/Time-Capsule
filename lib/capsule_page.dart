import 'package:flutter/material.dart';
import 'package:timecapsule/size_config.dart';

class CapsulePage extends StatelessWidget {
  const CapsulePage(
      {Key? key,
      this.width = 140,
      this.aspectRetio = 1.02,
      required this.image,
      required this.textToBeEntered})
      : super(key: key);
  final double width, aspectRetio;
  final Image image;
  final String textToBeEntered;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.lightBlue[100],
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.lightBlue[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textToBeEntered,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
