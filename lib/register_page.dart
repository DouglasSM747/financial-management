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
  final _formKey = GlobalKey<FormState>();

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
                      child: this.formText("Name", Icons.account_box),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      child: this.formText("Email", Icons.email),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      child: this.formText("Password", Icons.lock),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      child: this.formText("Confirm password", Icons.lock),
                      width: MediaQuery.of(context).size.width - 15,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: RaisedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.
                            }
                          },
                          /*  */
                          child: Text('Sign Up'),
                        ))
                    /*  */
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

  TextFormField formText(String texto, IconData icon, {bool password = false}) {
    return TextFormField(
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
