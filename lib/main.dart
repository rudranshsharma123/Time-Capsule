import 'package:flutter/material.dart';
import 'package:timecapsule/capsule_look.dart';
import 'package:timecapsule/capsule_page.dart';
import 'package:timecapsule/constants.dart';
import 'package:timecapsule/map.dart';
import 'package:timecapsule/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.lightBlue,
      ),
      home: const CapsuleLook(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime date = DateTime(2011);

  String getText() {
    if (date == DateTime(2011)) {
      print("hello");
      return "Select Date";
    } else {
      print("hsdkajhdjkas");

      return '${date.month}/${date.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SimpleText(
              displayText: "Date",
            ),
            MyButton(
              ontap: () => pickDate(context),
              displayText: getText(),
            ),
            const SimpleText(
              displayText: "Time",
            ),
            MyButton(ontap: () {}, displayText: "Select Time"),
            const SimpleText(displayText: "Date Range"),
            Row(
              children: [
                Expanded(child: MyButton(ontap: () {}, displayText: "From")),
                const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                ),
                Expanded(child: MyButton(ontap: () {}, displayText: "To")),
              ],
            )
          ],
        )));
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
}

class SimpleText extends StatelessWidget {
  const SimpleText({Key? key, required this.displayText}) : super(key: key);

  final String displayText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          displayText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final VoidCallback ontap;
  final String displayText;

  const MyButton({Key? key, required this.ontap, required this.displayText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                onPressed: ontap,
                child: Text(displayText),
                style: TextButton.styleFrom(
                    primary: Colors.black, backgroundColor: Colors.white)),
          ),
        ],
      ),
    );
  }
}
