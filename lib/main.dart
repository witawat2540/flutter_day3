import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp_day2/Pags2.dart';
import 'package:myapp_day2/Tap1.dart';
import 'package:myapp_day2/mywidget.dart';
import 'package:myapp_day2/splashscreen.dart';
import 'package:myapp_day2/tab3.dart';
import 'package:toast/toast.dart';

import 'mydrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Sriracha',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
        routes: {
          '/page2': (context) => Page2(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List litem = ["1", "2", "3", "4"];
  TabController _tabController;
  bool showFab = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String msg;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  sendNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '10000',
      'FLUTTER_NOTIFICATION_CHANNEL',
      'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      ticker: 'ticker',
      channelShowBadge: debugInstrumentationEnabled,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        111, 'Witawatd', 'การแจ้งเตือนเบื้องต้น', platformChannelSpecifics,
        payload: 'ทดสอบ');
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        setState(() {
          showFab = true;
        });
      } else {
        setState(() {
          showFab = false;
        });
      }
    });
    super.initState();

    msg = 'No message';
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
          return null;
        },
        defaultPresentAlert: true,
        defaultPresentSound: true,
        requestSoundPermission: true);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      setState(() {
        msg = payload;
      });
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: mydrawer(
        email: "test@gmail.com",
        name: "name",
      ),
      appBar: AppBar(
        title: Text("My App"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: "ค้นหาแผนที่",
              icon: Icon(Icons.map),
            ),
            Tab(
              text: "รูปภาพ",
              icon: Icon(Icons.picture_in_picture),
            ),
            Tab(
              text: "video",
              icon: Icon(Icons.camera),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [Tap1(), Page2(), Tab3()],
      ),
//      body: GridView.count(
//        crossAxisCount: 4,
//        children: List.generate(100, (index) {
//          return Container(
//            color: Colors.blueGrey,
//            margin: EdgeInsets.all(5.0),
//            child: Center(
//              child: Text("Item ${index + 1}"),
//            ),
//          );
//        }),
//      ),
//      body: SafeArea(
//        child: RaisedButton(
//          child: Text("Click Show Dialog"),
//          onPressed: () {
//            showDialog(
//              context: context,
//              builder: (_) => AlertDialog(
//                title: Text("ทดสอบแจ้งเตือน"),
//                content: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: [
//                    TextFormField(
//                      decoration: InputDecoration(
//                          labelText: "Name",
//                          filled: true,
//                          prefixIcon: Icon(Icons.account_box)),
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    TextFormField(
//                      decoration: InputDecoration(
//                          labelText: "LastName",
//                          filled: true,
//                          prefixIcon: Icon(Icons.account_box)),
//                    )
//                  ],
//                ),
//                actions: [
//                  RaisedButton(
//                    onPressed: () {
//                      Navigator.pop(context);
//                      print(true);
//                    },
//                    child: Text("Ok"),
//                    color: Colors.blue,
//                  ),
//                  RaisedButton(
//                    onPressed: () {
//                      Navigator.pop(context);
//                    },
//                    child: Text("Close"),
//                    color: Colors.red,
//                  )
//                ],
//              ),
//            );
//          },
//          textColor: Colors.white,
//          color: Colors.pinkAccent,
//        ),
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendNotification();
        },
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.build),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
