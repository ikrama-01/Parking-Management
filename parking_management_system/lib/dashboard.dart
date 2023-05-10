import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
import 'login.dart';
import 'qr_display.dart';

class SimpleElevatedButton extends StatelessWidget {
  const SimpleElevatedButton(
      {this.child,
      this.color,
      this.onPressed,
      this.borderRadius = 4,
      this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      Key? key})
      : super(key: key);
  final Color? color;
  final Widget? child;
  final Function? onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: color ?? currentTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed as void Function()?,
      child: child,
    );
  }
}

final ButtonStyle F_PassButton = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(56, 50),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List info = [];

  getAllInfo() async {
    var response = await http.get(Uri.parse(
        "http://localhost/flutter_login_backend/fetchinfo.php?username=" +
            fetched_username));
    if (response.statusCode == 200) {
      setState(() {
        info = json.decode(response.body);
      });
      print(info);
      return info;
    }
  }

  @override
  void initState() {
    super.initState();
    getAllInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'DASHBOARD',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 9, 95, 153),
        leading: IconButton(
          icon: Image.asset('assets/icons/icon.png'),
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home(title: ''))),
        ),
      ),
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: info.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 212, 250, 0),
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Your Information: ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 154, 189, 0),
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        "Name: ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 10, 149, 230),
                        ),
                      ),
                      SizedBox(height: 0),
                      Text(
                        "" + info[index]['name'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        "Vehicle Number: ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 10, 149, 230),
                        ),
                      ),
                      SizedBox(height: 0),
                      Text(
                        "" + info[index]['vehicle'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        "Parking Lot Assigned: ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 10, 149, 230),
                        ),
                      ),
                      SizedBox(height: 0),
                      Text(
                        "" + info[index]['parking_id'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Center(
            child: TextButton(
              style: F_PassButton.copyWith(
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 100)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDisplay(),
                  ),
                );
              },
              child: Text(
                'Generate QR Code',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
