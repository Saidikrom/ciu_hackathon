import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '3d.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phone_number = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login(String phone_number, String pass) async {
    var _url = "https://mahbubiym.uz/ifurniture/index.php";
    var response = await http.post(Uri.parse(_url), body: {
      "Phone Number": phone_number,
      "password": pass,
    });
    if (response.statusCode == 200) {
      var loginArr = json.decode(response.body);
      print(loginArr['token']);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w400,
                fontFamily: 'Comfortaa',
                color: Colors.black,
              ),
            ),

            // PHONE NUMBER

            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                // key: _formKey,
                child: TextFormField(
                  validator: (value) => 'Email not valid',
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    hintText: 'PHONE NUMBER',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

//  PASSWORD

            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    hintText: 'PASSWORD',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
            ),

            // LOGIN

            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Object3DScreen()));
                login(phone_number.text, pass.text);
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              height: 55,
              minWidth: 350,
              child: Text(
                "LOGIN",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
