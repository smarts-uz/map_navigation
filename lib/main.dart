import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String latitudeData = '';
  String longtitudeData = '';
  String launchUrl =
      'https://www.google.com/maps/dir/41.364485,69.2818311/41.3612512,69.2782154/@';
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      latitudeData = geoposition.latitude.toString();
      longtitudeData = geoposition.longitude.toString();
      launchUrl += '+$latitudeData/$longtitudeData';
    });
  }

  // Future<void> launched;
  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Couldn\'t launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map Navigation'),
        ),
        body: SafeArea(
            child: Center(
                child: Container(
                    child: Column(
          children: [
            Text(latitudeData),
            Text(longtitudeData),
            ElevatedButton(onPressed: getLocation, child: Text('go')),
            ElevatedButton(
                onPressed: () {
                  launchInBrowser(launchUrl);
                },
                child: Text('browse it in google map'))
          ],
        )))));
  }
}
