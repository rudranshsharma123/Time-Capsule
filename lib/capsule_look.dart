import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timecapsule/capsule_page.dart';

import 'constants.dart';

class CapsuleLook extends StatefulWidget {
  const CapsuleLook({Key? key}) : super(key: key);

  @override
  State<CapsuleLook> createState() => _CapsuleLookState();
}

class _CapsuleLookState extends State<CapsuleLook> {
  @override
  void initState() {
    addBasicItems();
    super.initState();
  }

  late String _searchText;
  late String _searchText2;

  File? _image;
  TextEditingController? controller;
  TextEditingController? controller2;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick an image');
    }
  }

  Marker? _marker;

  void _addMarker(LatLng pos) {}

  static const _initCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );
  Widget buildDiaglogBox() {
    GoogleMapController? _googleMapController;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return SingleChildScrollView(
        child: Dialog(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller,
                    obscureText: false,
                    onChanged: (value) {
                      _searchText = value;
                      print(value);
                      // print(_email);
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kBorderColor,
                            width: 5.0,
                            style: BorderStyle.solid),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kBorderColor,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Enter the title of your capsule",
                      labelStyle: TextStyle(color: kBorderColor),
                      focusColor: kButtonColor,
                      fillColor: Colors.red,
                      hoverColor: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller2,
                    obscureText: false,
                    onChanged: (value) {
                      _searchText2 = value;
                      print(value);
                      // print(_email);
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kBorderColor,
                            width: 5.0,
                            style: BorderStyle.solid),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kBorderColor,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Enter the text for your capsule",
                      labelStyle: TextStyle(color: kBorderColor),
                      focusColor: kButtonColor,
                      fillColor: Colors.red,
                      hoverColor: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: const Text(
                            "Tap to Choose an image",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            // pickImage();
                            final ImagePicker _picker = ImagePicker();
                            XFile file = await _picker.pickImage(
                                    source: ImageSource.gallery) ??
                                XFile('');

                            setState(() {
                              _image = File(file.path);
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    child: _image != null
                        ? Image.file(
                            _image!,
                            width: 100,
                            height: 100,
                          )
                        : const Text(
                            'No Image is Selected',
                          ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  // width: 100,
                  child: GoogleMap(
                    markers: {_marker ?? Marker(markerId: MarkerId('test'))},
                    initialCameraPosition: _initCameraPosition,
                    onLongPress: (LatLng pos) {
                      setState(() {
                        _marker = Marker(
                          markerId: const MarkerId('marker'),
                          infoWindow: const InfoWindow(title: 'Origin'),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueAzure),
                          position: pos,
                        );
                      });
                    },
                    zoomControlsEnabled: false,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextButton(
                          onPressed: () => pickDate(context),
                          child: const Text(
                            "Pick Date",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextButton(
                          onPressed: () {
                            addListItems(_image!, _searchText2);
                            Navigator.pop(context);
                            _image = null;
                          },
                          child: const Text(
                            "Add The Capsule",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  final padding2 = const Padding(
    padding: EdgeInsets.only(top: 300.0, left: 8, right: 8),
    child: Align(
      alignment: Alignment.center,
      child: Center(child: Text('Try pressing the plus button to get started')),
    ),
  );
  void addBasicItems() {
    children = [
      padding2,
    ];
  }

  DateTime date = DateTime.now();
  List<bool> isDoneList = [];
  String value = "none";
  bool isDone = false;
  List<Widget> children = [];
  void addListItems(File image, String textToBeAdded) {
    bool isDone = false;
    isDoneList.add(isDone);

    setState(() {
      if (children.contains(padding2)) {
        children.remove(padding2);
      }
      children.add(
        Row(
          children: [
            CapsuleCard(
              route: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CapsulePage(
                              image: Image.file(
                                image,
                                height: 200,
                                width: 200,
                              ),
                              textToBeEntered: textToBeAdded,
                            )));
              },
              title: _searchText,
              startDate: DateTime.now(),
              endDate: date,
            ),
          ],
        ),
      );
    });
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date == DateTime(2011) ? initialDate : date,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return buildDiaglogBox();
                });
          },
          child: Icon(Icons.add_outlined),
        ),
        appBar: AppBar(
          title: Text("Add Capsules"),
          leading: Icon(Icons.ac_unit),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}

class CapsuleCard extends StatefulWidget {
  const CapsuleCard({
    Key? key,
    // required this.tap,
    required this.title,
    required this.route,
    // required this.isDone,
    required this.startDate,
    required this.endDate,
    // required this.route,
  }) : super(key: key);

  // final VoidCallback tap;
  final String title;
  final VoidCallback route;
  // final bool isDone;
  final DateTime startDate;
  final DateTime endDate;
  // final Widget route;

  @override
  State<CapsuleCard> createState() => _CapsuleCardState();
}

class _CapsuleCardState extends State<CapsuleCard> {
  bool done = false;
  late int timeRemaining;
  late Timer _timer;
  late int timeInMins, timeInHours, timeInDays, timeInMonths, timeInYears;
  void startTimer(double timeRemaing) {}

  @override
  void initState() {
    timeRemaining =
        (widget.endDate.difference(widget.startDate).inSeconds / 1000 + 60)
            .round();
    const Duration seconds = Duration(seconds: 1);
    timeInMins = (timeRemaining / 60).round();
    timeInHours = (timeInMins / 60).round();
    timeInDays = (timeInHours / 24).round();
    timeInMonths = (timeInDays / 30).round();
    timeInYears = (timeInMonths / 12).round();

    // Timer timer;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _timer = Timer.periodic(seconds, (timer) {
        setState(() {
          timeRemaining--;
          timeInMins = (timeRemaining / 60).floor();
          timeInHours = (timeInMins / 60).floor();
          timeInDays = (timeInHours / 24).floor();
          timeInMonths = (timeInDays / 30).floor();
          timeInYears = (timeInMonths / 12).floor();
          print(timeInMins);

          if (timeRemaining <= 0) {
            // done = true;
            done = true;
            timer.cancel();
          }
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
      // _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  timeInHours.toString() +
                      "/" +
                      timeInMins.toString() +
                      "/" +
                      timeRemaining.toString(),
                  style: TextStyle(fontSize: 16)),
            ),
            title: Text(widget.title),
            trailing: done == false
                ? Icon(Icons.lock)
                : Icon(Icons.face_unlock_outlined),
            onTap: done ? widget.route : () {},
            tileColor: Colors.pinkAccent[100],
          ),
        ),
      ),
    );
  }
}
