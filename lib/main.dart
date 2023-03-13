import 'package:flutter/material.dart';
import 'package:e_taponfinal/campus.dart';
import 'package:e_taponfinal/about.dart';
import 'package:e_taponfinal/terms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Request notification permission
  var status = await Permission.notification.status;

  if (status.isDenied) {
    //Handle the denied permission
    openAppSettings();
  } else if (status.isGranted) {
    //Show notification
    print("Notification is allowed");
  } else {
    status = await Permission.notification.request();
    if (status.isGranted) {
      //show notification
    } else {
      //Handle denied permission
      openAppSettings();
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Tapon",
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String _bin1Date = "";
  String _bin1Time = "";
  String _bin2Date = "";
  String _bin2Time = "";
  String _bin3Date = "";
  String _bin3Time = "";
  String _bin4Date = "";
  String _bin4Time = "";
  String _bin5Date = "";
  String _bin5Time = "";
  String _bin6Date = "";
  String _bin6Time = "";

  @override
  void initState() {
    super.initState();

    _database.ref().child("ITECH/bin1Date").onValue.listen((event) {
      setState(() {
        _bin1Date = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin1Time").onValue.listen((event) {
      setState(() {
        _bin1Time = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin2Date").onValue.listen((event) {
      setState(() {
        _bin2Date = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin2Time").onValue.listen((event) {
      setState(() {
        _bin2Time = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin3Date").onValue.listen((event) {
      setState(() {
        _bin3Date = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin3Time").onValue.listen((event) {
      setState(() {
        _bin3Time = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin4Date").onValue.listen((event) {
      setState(() {
        _bin4Date = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin4Time").onValue.listen((event) {
      setState(() {
        _bin4Time = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin5Date").onValue.listen((event) {
      setState(() {
        _bin5Date = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin5Time").onValue.listen((event) {
      setState(() {
        _bin5Time = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin6Date").onValue.listen((event) {
      setState(() {
        _bin6Date = event.snapshot.value.toString();
      });
    });
    _database.ref().child("ITECH/bin6Time").onValue.listen((event) {
      setState(() {
        _bin6Time = event.snapshot.value.toString();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('E-Tapon'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.green[700],
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Row(
              children: [
                Image.asset('images/logobin.png', fit: BoxFit.cover,),
                Text("E-Tapon", style: TextStyle(fontSize: 25, color: Colors.white),
                )
              ],
            ),
              decoration: BoxDecoration(color: Colors.green.shade500),
            ),
            const SizedBox(
              height: 40,
            ),
            buildItemMenu(
              text: "Go Back",
              icon: Icons.arrow_back,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 16,
            ),
            buildItemMenu(
              text: "Campus",
              icon: Icons.school_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 16,
            ),
            buildItemMenu(
              text: "About",
              icon: Icons.announcement_outlined,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 16,
            ),
            buildItemMenu(
              text: "Terms",
              icon: Icons.event_note_outlined,
              onClicked: () => selectedItem(context, 4),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('images/homepage.png'),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text(
                  "Ground Flr.",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('images/trash.png',
                  height: 70,
                ),
                Image.asset('images/trash.png',
                  height: 70,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Smart Bin 1",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Smart Bin 2",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Date Checked: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Date Checked: ",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$_bin1Date",
                  style: TextStyle(fontSize: 20),
                ),
                Text("$_bin2Date",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Time: $_bin1Time",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Time: $_bin2Time",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text(
                  "Second Flr.",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('images/trash.png',
                  height: 70,
                ),
                Image.asset('images/trash.png',
                  height: 70,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Smart Bin 3",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Smart Bin 4",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Date Checked: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Date Checked: ",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$_bin3Date",
                  style: TextStyle(fontSize: 20),
                ),
                Text("$_bin4Date",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Time: $_bin3Time",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Time: $_bin4Time",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text(
                  "Third Flr.",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('images/trash.png',
                  height: 70,
                ),
                Image.asset('images/trash.png',
                  height: 70,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Smart Bin 5",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Smart Bin 6",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Date Checked: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Date Checked: ",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$_bin5Date",
                  style: TextStyle(fontSize: 20),
                ),
                Text("$_bin6Date",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Time: $_bin5Time",
                  style: TextStyle(fontSize: 20),
                ),
                Text("Time: $_bin6Time",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildItemMenu({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;

  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Campus(),
      ));
  }

  switch (index) {
    case 3:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => About(),
      ));
  }
  switch (index) {
    case 4:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Terms(),
      ));
  }
}