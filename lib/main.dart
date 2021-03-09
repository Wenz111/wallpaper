import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:unsplash_client/unsplash_client.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper/model.dart';

void main() {
  debugPrint('Start of Main Activity');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Wallpaper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create API
  final baseUrl = "https://api.unsplash.com/photos/";
  final authorizationId = "3O-0lx3tK8EB-5FUQnneiHneMwC0waml_N4jrNvv2pQ";

  Future<Unsplash> getUnsplashApi() async {
    Dio dio = new Dio();
    debugPrint(dio.toString());
    var response = await dio.get(baseUrl,
        options:
            Options(headers: {"Authorization": "Client-ID $authorizationId"}
            ));

    final jsonUnsplash = jsonDecode(response.data);

    return Unsplash.fromJson(jsonUnsplash);
  }

  // Future<dynamic> showPhotoDetails;
  //
  // Future<dynamic> getRandomPhoto() async {
  //   // Unsplash Client
  //   final client = UnsplashClient(
  //     settings: ClientSettings(
  //         credentials: AppCredentials(
  //       accessKey: '3O-0lx3tK8EB-5FUQnneiHneMwC0waml_N4jrNvv2pQ',
  //       secretKey: 'dO460Olac7h3zdOGPZZeOlUlkP_JPeMMutlSNBm4bnw',
  //     )),
  //   );
  //
  //   // Get Random Photos
  //   final photos = await client.photos.random(count: 1).goAndGet();
  //   final photo = photos.first;
  //
  //   debugPrint('Show Photo Details: ${photo.id.toString()}');
  //   return photo;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: () async {
                // Fetch Random Photo
                debugPrint('Fetch Random Photo');
                await getUnsplashApi().then((value) {
                  debugPrint(value.results.first.id);
                });
              },
              icon: Icon(Icons.photo_rounded),
              label: Text('Get Random Photo'),
            ),
            FutureBuilder<Unsplash>(
                future: getUnsplashApi(),
                builder: (context, snapshot) {
              if (snapshot.hasData) {
                final photo = snapshot.data;
                debugPrint('Future Builder Photo Details: ${photo.results.first.id}');
                return Text('Get Data: ${photo.results.first.id}');
              } else {
                debugPrint('Future Builder: Snapshot Error');
                return Text(snapshot.error.toString());
              }
            }),
          ],
        ),
      ),
    );
  }
}
