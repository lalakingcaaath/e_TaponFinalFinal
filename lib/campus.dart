import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

class Campus extends StatefulWidget {
  const Campus({Key? key}) : super(key: key);

  @override
  State<Campus> createState() => _CampusState();
}

class _CampusState extends State<Campus> {

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final databaseRef = FirebaseDatabase.instance.ref();
  final firstBinThreshold = 75;
  final lastBinThreshold = 100;
  final batteryThreshold = 20;
  final batteryPartial = 75;
  final batteryFull = 100;
  bool BinThresholdReached = false;
  bool batteryThresholdReached = false;
  bool batteryPar = false;
  bool batteryFul = false;

  DatabaseReference ref = FirebaseDatabase.instance.ref("ITECH");
  double _batteryPercent1 = 0;
  String _batteryData1 = '';
  double _batteryPercent2 = 0;
  String _batteryData2 = '';
  double _batteryPercent3 = 0;
  String _batteryData3 = '';
  int _batteryPercentage1 = 0;
  int _batteryPercentage2 = 0;
  int _batteryPercentage3 = 0;
  double _bin1 = 0;
  String _databin1 = '';
  double _bin2 = 0;
  String _databin2 = '';
  double _bin3 = 0;
  String _databin3 = '';
  double _bin4 = 0;
  String _databin4 = '';
  double _bin5 = 0;
  String _databin5 = '';
  double _bin6 = 0;
  String _databin6 = '';
  int _binPercent1 = 0;
  int _binPercent2 = 0;
  int _binPercent3 = 0;
  int _binPercent4 = 0;
  int _binPercent5 = 0;
  int _binPercent6 = 0;
  String binDate1 = 'BinDate1';
  String binDate2 = 'BinDate2';
  String binDate3 = 'BinDate3';
  String binDate4 = 'BinDate4';
  String binDate5 = 'BinDate5';
  String binDate6 = 'BinDate6';
  String _token = '';

  final Uri _url = Uri.parse("https://etaponcloud.azurewebsites.net/download_pdf");

  Future<void> _launchUrl() async {
    if(!await launchUrl(_url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(),
    )) {
      throw Exception("Could not launch $_url");
    }
  }

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.getToken().then((token) {
      print('onMessage: $token');
      setState(() {
        _token = token!;
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageL $message");
    });

    _database.ref().child('ITECH/battery1').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _batteryData1 = value.toString();
        _batteryPercent1 = double.parse(_batteryData1)/100;
        _batteryPercentage1 = (_batteryPercent1 * 100).toInt();
        if(_batteryPercent1> 1) _batteryPercent1 = 1;
        if(_batteryPercent1 < 0) _batteryPercent1 = 0;
        setState(() {
        });
      }
      else{
        _batteryData1 = '';
        _batteryPercent1 = 0;
      }
    });

    _database.ref().child('ITECH/battery2').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _batteryData2 = value.toString();
        _batteryPercent2 = double.parse(_batteryData2)/100;
        _batteryPercentage2 = (_batteryPercent2 * 100).toInt();
        if(_batteryPercent2> 1) _batteryPercent2 = 1;
        if(_batteryPercent2 < 0) _batteryPercent2 = 0;
        setState(() {
        });
      }
      else{
        _batteryData2 = '';
        _batteryPercent2 = 0;
      }
    });

    _database.ref().child('ITECH/battery3').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _batteryData3 = value.toString();
        _batteryPercent3 = double.parse(_batteryData3)/100;
        _batteryPercentage3 = (_batteryPercent3 * 100).toInt();
        if(_batteryPercent3> 1) _batteryPercent3 = 1;
        if(_batteryPercent3 < 0) _batteryPercent3 = 0;
        setState(() {
        });
      }
      else{
        _batteryData3 = '';
        _batteryPercent3 = 0;
      }
    });

    _database.ref().child('ITECH/bin1').onValue.listen((event) async {
      var value = event.snapshot.value;
      if(value != null) {
        _databin1 = value.toString();
        _bin1 = double.parse(_databin1)/100;
        _binPercent1 = (_bin1 * 100).toInt();
        if(_binPercent1 > 100){
          _binPercent1 = 100;
        }
        if(_bin1 > 1) _bin1 = 1;
        if(_bin1 < 0) _bin1 = 0;
        setState(() {
        });
      }
      else{
        _databin1 = '';
        _bin1 = 0;
      }
    });

    _database.ref().child('ITECH/bin2').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _databin2 = value.toString();
        _bin2 = double.parse(_databin2)/100;
        _binPercent2 = (_bin2 * 100).toInt();
        if(_binPercent2 > 100){
          _binPercent2 = 100;
        }
        if(_bin2 > 1) _bin2 = 1;
        if(_bin2 < 0) _bin2 = 0;
        setState(() {
        });
      }
      else{
        _databin2 = '';
        _bin2 = 0;
      }
    });

    _database.ref().child('ITECH/bin3').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _databin3 = value.toString();
        _bin3 = double.parse(_databin3)/100;
        _binPercent3 = (_bin3 * 100).toInt();
        if(_bin3 > 1) _bin3 = 1;
        if(_bin3 < 0) _bin3 = 0;
        setState(() {
        });
      }
      else{
        _databin3 = '';
        _bin3 = 0;
      }
    });

    _database.ref().child('ITECH/bin4').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _databin4 = value.toString();
        _bin4 = double.parse(_databin4)/100;
        _binPercent4 = (_bin4 * 100).toInt();
        if(_bin4 > 1) _bin4 = 1;
        if(_bin4 < 0) _bin4 = 0;
        setState(() {
        });
      }
      else{
        _databin4 = '';
        _bin4 = 0;
      }
    });

    _database.ref().child('ITECH/bin5').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _databin5 = value.toString();
        _bin5 = double.parse(_databin5)/100;
        _binPercent5 = (_bin5 * 100).toInt();
        if(_bin5 > 1) _bin5 = 1;
        if(_bin5 < 0) _bin5 = 0;
        setState(() {
        });
      }
      else{
        _databin3 = '';
        _bin3 = 0;
      }
    });

    _database.ref().child('ITECH/bin6').onValue.listen((event) {
      var value = event.snapshot.value;
      if(value != null) {
        _databin6 = value.toString();
        _bin6 = double.parse(_databin6)/100;
        _binPercent6 = (_bin6 * 100).toInt();
        if(_bin6 > 1) _bin6 = 1;
        if(_bin6 < 0) _bin6 = 0;
        setState(() {
        });
      }
      else{
        _databin6 = '';
        _bin6 = 0;
      }
    });

    var initializationSettingsAndroid =
    AndroidInitializationSettings("@drawable/ic_stat_logo");
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    Timer.periodic(Duration(seconds: 1), (_) {
      checkTreshold();
    });
  }

  void checkTreshold() {
    if(_bin1*100 >= firstBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin1*100 >= lastBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin2*100 >= firstBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin2*100 >= lastBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin3*100 >= firstBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin3*100 >= lastBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin4*100 >= firstBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin4*100 >= lastBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin5*100 >= firstBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin5*100 >= lastBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin6*100 >= firstBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    else if(_bin6*100 >= lastBinThreshold && !BinThresholdReached){
      BinThresholdReached = true;
      _showNotification();
    }
    if(_batteryPercent1*100 == batteryThreshold && !batteryThresholdReached){
      batteryThresholdReached = true;
      _showNotification();
    }
    else if(_batteryPercent2*100 == batteryThreshold && !batteryThresholdReached){
      batteryThresholdReached = true;
      _showNotification();
    }
    else if(_batteryPercent3*100 == batteryThreshold && !batteryThresholdReached){
      batteryThresholdReached = true;
      _showNotification();
    }
    else if(_batteryPercent1*100 == batteryPartial && !batteryPar){
      batteryPar = true;
      _showNotification();
    }
    else if(_batteryPercent1*100 == batteryFull && !batteryFul){
      batteryFul = true;
      _showNotification();
    }
    else if(_batteryPercent2*100 == batteryPartial && !batteryPar){
      batteryPar = true;
      _showNotification();
    }
    else if(_batteryPercent2*100 == batteryFull && !batteryFul){
      batteryFul = true;
      _showNotification();
    }
    else if(_batteryPercent3*100 == batteryPartial && !batteryPar){
      batteryPar = true;
      _showNotification();
    }
    else if(_batteryPercent3*100 == batteryFull && !batteryFul){
      batteryFul = true;
      _showNotification();
    }
  }

  void _showNotification() async {
    var message = '';
    if(_bin1*100 == firstBinThreshold){
      message = 'Garbage Bin 1 is now ${_bin1*100}% full!';
    }
    else if(_bin1*100 == lastBinThreshold){
      message = 'Garbage Bin 1 is now 100% full!';
    }
    else if(_bin2*100 == firstBinThreshold){
      message = 'Garbage Bin 2 is now ${_bin2*100}% full!';
    }
    else if(_bin2*100 == lastBinThreshold){
      message = 'Garbage Bin 2 is now 100%% full!';
    }
    else if(_bin3*100 == firstBinThreshold){
      message = 'Garbage Bin 3 is now ${_bin3*100}% full!';
    }
    else if(_bin3*100 == lastBinThreshold){
      message = 'Garbage Bin 3 is now 100% full!';
    }
    else if(_bin4*100 == firstBinThreshold){
      message = 'Garbage Bin 4 is now ${_bin4*100}% full!';
    }
    else if(_bin4*100 == lastBinThreshold){
      message = 'Garbage Bin 4 is now 100% full!';
    }
    else if(_bin5*100 == firstBinThreshold){
      message = 'Garbage Bin 5 is now ${_bin5*100}% full!';
    }
    else if(_bin5*100 == lastBinThreshold){
      message = 'Garbage Bin 5 is now 100% full!';
    }
    else if(_bin6*100 == firstBinThreshold){
      message = 'Garbage Bin 6 is now ${_bin6*100}% full!';
    }
    else if(_bin6*100 == lastBinThreshold){
      message = 'Garbage Bin 6 is now 100% full!';
    }
    if(_batteryPercent1*100 == batteryThreshold){
      message = '20% remaining on battery 1. Please charge battery soon.';
    }
    else if(_batteryPercent2*100 == batteryThreshold){
      message = '20% remaining on battery 2. Please charge battery soon';
    }
    else if(_batteryPercent3*100 == batteryThreshold){
      message = '20% remaining on battery 3. Please charge battery soon';
    }
    else if(_batteryPercent1*100 == batteryPartial){
      message = 'Battery is 75% and partially charged!';
    }
    else if(_batteryPercent1*100 == batteryFull){
      message = 'Battery is 100% full! Please remove the charger.';
    }
    else if(_batteryPercent2*100 == batteryPartial){
      message = 'Battery is 75% and partially charged!';
    }
    else if(_batteryPercent2*100 == batteryFull){
      message = 'Battery is 100% full! Please remove the charger.';
    }
    else if(_batteryPercent3*100 == batteryPartial){
      message = 'Battery is 75% and partially charged!';
    }
    else if(_batteryPercent3*100 == batteryFull){
      message = 'Battery is 100% full! Please remove the charger.';
    }


    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "Channel ID",
        "Channel Name",
        channelDescription: "Channel Description",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.show(
        0,
        'E-Tapon',
        message,
        platformChannelSpecifics,
        payload: 'item x'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Ground Floor',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              var now = DateTime.now();
                              var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
                              String formattedDate = formatter.format(now);
                              databaseRef.child(binDate1).push().set({
                                'Date': formattedDate,
                              });
                              databaseRef.child('ITECH').update({
                                'bin1': _bin1 = 0
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:
                                Text("Bin 1 has been collected!"),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset('images/trash.png',
                                  height: 50,
                                ),

                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _bin1,
                            center: Text('$_binPercent1%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              var now = DateTime.now();
                              var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
                              String formattedDate = formatter.format(now);
                              databaseRef.child(binDate2).push().set({
                                'Date': formattedDate,
                              });
                              databaseRef.child('ITECH').update({
                                'bin2': _bin2 = 0
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:
                                Text("Bin 2 has been collected!"),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset('images/trash.png',
                                  height: 50,
                                ),

                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _bin2,
                            center: Text('$_binPercent2%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'images/battery.png',
                            height: 50,
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _batteryPercent1,
                            center: Text('$_batteryPercentage1%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Second Floor",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              var now = DateTime.now();
                              var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
                              String formattedDate = formatter.format(now);
                              databaseRef.child(binDate3).push().set({
                                'Date': formattedDate,
                              });
                              databaseRef.child('ITECH').update({
                                'bin3': _bin3 = 0
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:
                                Text("Bin 3 has been collected!"),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset('images/trash.png',
                                  height: 50,
                                ),

                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _bin3,
                            center: Text('$_binPercent3%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              var now = DateTime.now();
                              var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
                              String formattedDate = formatter.format(now);
                              databaseRef.child(binDate4).push().set({
                                'Date': formattedDate,
                              });
                              databaseRef.child('ITECH').update({
                                'bin4': _bin4 = 0
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:
                                Text("Bin 4 has been collected!"),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset('images/trash.png',
                                  height: 50,
                                ),

                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _bin4,
                            center: Text('$_binPercent4%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'images/battery.png',
                            height: 50,
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _batteryPercent2,
                            center: Text('$_batteryPercentage2%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Third Floor",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              var now = DateTime.now();
                              var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
                              String formattedDate = formatter.format(now);
                              databaseRef.child(binDate5).push().set({
                                'Date': formattedDate,
                              });
                              databaseRef.child('ITECH').update({
                                'bin5': _bin5 = 0
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:
                                Text("Bin 5 has been collected!"),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset('images/trash.png',
                                  height: 50,
                                ),

                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _bin5,
                            center: Text('$_binPercent5%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              var now = DateTime.now();
                              var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
                              String formattedDate = formatter.format(now);
                              databaseRef.child(binDate6).push().set({
                                'Date': formattedDate,
                              });
                              databaseRef.child('ITECH').update({
                                'bin6': _bin6 = 0
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:
                                Text("Bin 6 has been collected!"),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset('images/trash.png',
                                  height: 50,
                                ),

                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _bin6,
                            center: Text('$_binPercent6%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'images/battery.png',
                            height: 50,
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.75,
                            lineHeight: 20,
                            animation: true,
                            animationDuration: 2000,
                            progressColor: Colors.green,
                            percent: _batteryPercent3,
                            center: Text('$_batteryPercentage3%'),
                            barRadius: const Radius.circular(16),
                          ),
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: _launchUrl,
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  )
                              )
                          ),
                          child: Text("Generate Logs"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            FlutterClipboard.copy(_token);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  )
                              )
                          ),
                          child: Text("Get Token"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
