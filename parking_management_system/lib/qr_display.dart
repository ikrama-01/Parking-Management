import 'package:flutter/material.dart';
import 'dart:convert';
import 'dashboard.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:io';

class ImageDisplay extends StatefulWidget {
  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  Uint8List? imageData;
  Uint8List? imageBytes;

  Future<void> fetchImageFromServer() async {
    final response = await http.get(Uri.parse(
        'http://localhost/flutter_login_backend/image_fetch.php?username=' +
            fetched_username));

    if (response.statusCode == 200) {
      setState(() {
        String encodedData = response.body;
        imageBytes = base64.decode(encodedData) as Uint8List?;
      });
    } else {
      throw Exception('Failed to fetch image from server');
    }
  }

  Future passvar(String myVariable) async {
    String myVariable = fetched_username;
    var response = await http.post(
        Uri.parse('http://localhost/flutter_login_backend/image_download.py'),
        body: {'myVariable': myVariable});
  }

  void downloadImage() async {
    if (imageBytes != null && imageBytes!.isNotEmpty) {
      String tempImagePath =
          'parking_management_system/assets/images/downloaded_qr_codes/' +
              fetched_username +
              '.jpg';
      await File(tempImagePath).writeAsBytes(imageBytes!);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Download Successful'),
            content: Text('QR Downloaded Successfully'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImageFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'QR Code',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 9, 95, 153),
          leading: IconButton(
            icon: Image.asset('assets/icons/icon.png'),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard())),
          )),
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageBytes != null && imageBytes!.isNotEmpty
                ? Image.memory(
                    imageBytes!,
                    height: 400,
                    width: 400,
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            TextButton(
              style: F_PassButton,
              onPressed: () {
                downloadImage();
              },
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}

final ButtonStyle F_PassButton = TextButton.styleFrom(
  primary: Colors.white,
  backgroundColor: Color.fromARGB(255, 9, 95, 153),
  minimumSize: Size(200, 60),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
);
