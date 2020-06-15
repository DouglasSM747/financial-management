import 'package:financial/crud/servicesAuth.dart';
import 'package:financial/crud/servicesCrud.dart';
import 'package:financial/layout/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tela Cadastro',
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService authService = new AuthService();
  ServiceCrudFireStore serviceCrudFireStore = new ServiceCrudFireStore();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPass = TextEditingController();

  void _dialogErrorRegister() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error Register"),
          content: Text("'Password' not equals 'Confirm Passord'"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              SizedBox(
                child: Image.asset(
                  'assets/images/wallet.png',
                ),
                width: MediaQuery.of(context).size.width - 180,
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: this.formText(_name, "Name", Icons.account_box),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      child: this.formText(_email, "Email", Icons.email),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      child: this.formText(_password, "Password", Icons.lock),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      child: this.formText(
                          _confirmPass, "Confirm password", Icons.lock),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      child: ButtonStandard(
                        text: "Sign Up",
                        voidCallback: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            if (_password.text == _confirmPass.text) {
                              // add user to app (name, email)
                              authService
                                  .createUserWithEmailAndPassword(
                                      _email.text, _password.text, _name.text)
                                  .then(
                                (value) {
                                  if (value != null && value.isNotEmpty) {
                                    serviceCrudFireStore.addUser({
                                      "email": _email.text,
                                      "name": _name.text
                                    });
                                  }
                                },
                              );
                            } else {
                              _dialogErrorRegister();
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 60),
        ),
      ),
    );
  }

  TextFormField formText(
      TextEditingController textEditingController, String text, IconData icon,
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
        hintText: text,
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
        if (text == "Email") {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);

          if (emailValid == true) {
            return null;
          }
          return "invalid email";
        }
        if (value.isEmpty) {
          return 'Please enter some value';
        }
        return null;
      },
    );
  }
}
