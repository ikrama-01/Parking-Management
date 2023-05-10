import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String fetched_username = '';

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  var data_load;
  Future login() async {
    var url = Uri.parse('http://localhost/flutter_login_backend/login.php');
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      data_load = false;
    } else {
      data_load = true;
    }
    if (data_load == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    //EMAIL ADDRESS
    final inputemail = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Username',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        controller: user,
      ),
    );

    //PASSWORD
    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        controller: pass,
      ),
    );
    //FORGOT PASSWORD BUTTON
    final ButtonStyle F_PassButton = TextButton.styleFrom(
      primary: Colors.white,
      minimumSize: Size(56, 50),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(
            'LOGIN',
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
          )),
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            inputemail,
            inputPassword,
            //LOGIN BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleElevatedButton(
                  color: Color.fromARGB(255, 9, 95, 153),
                  onPressed: () {
                    setState(() {
                      fetched_username = user.text;
                    });
                    login();
                  },
                  child: const Text('Login'),
                ),
              ],
            ),

            TextButton(
              style: F_PassButton,
              onPressed: () {},
              child: Text('Forgot Password?'),
            )
          ],
        ),
      ),
    ));
    return const MaterialApp();
  }
}
