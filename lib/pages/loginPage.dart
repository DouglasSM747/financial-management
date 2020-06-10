import 'dart:developer';
import 'package:financial/crud/servicesAuth.dart';
import 'package:financial/crud/servicesCrud.dart';
import 'package:financial/layout/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register_page.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.b612TextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: "Login Screen",
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = new AuthService();
  ServiceCrudFireStore serviceCrudFireStore = new ServiceCrudFireStore();
  var inputEmail = TextEditingController(); //pegar a entrada
  var inputPassword = TextEditingController(); //pegar a entrada

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 60),
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/wallet.png'),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 15,
                        child: this.formText(
                            inputEmail, 'Type your email here', Icons.email),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 15,
                        child: this.formText(inputPassword,
                            'Type your password here', Icons.lock,
                            password: true),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: ButtonStandard(
                    text: "Sign in",
                    voidCallback: () async {
                      if (_formKey.currentState.validate()) {
                        var result =
                            await authService.signInWithEmailAndPassword(
                                inputEmail.text, inputPassword.text);
                        if (result != null) {
                          authService.someMethod().then((value) {
                            serviceCrudFireStore.addUser(
                              {
                                "email": value,
                              },
                            );
                          });
                        } else {
                          print("error");
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Or sign in with",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {},
                      child: Image.asset('assets/images/icon_facebook.png',
                          width: 80, height: 80, fit: BoxFit.contain),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Image.asset('assets/images/icon_google.png',
                          width: 80, height: 80, fit: BoxFit.contain),
                    )
                  ],
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Create here",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField formText(
      TextEditingController textEditingController, String texto, IconData icon,
      {bool password = false}) {
    return TextFormField(
      controller: textEditingController,
      autofocus: false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        hintText: texto,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        hintStyle: TextStyle(color: Colors.green),
      ),
      style: TextStyle(color: Colors.green),
      obscureText: password,
      textAlign: TextAlign.start,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some value';
        }
        return null;
      },
    );
  }
}
