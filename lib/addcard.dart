import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Acess Page',
      home: AddCardPage(),
    );
  }
}

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {

  bool creditCard = false;
  bool debitCard = false;

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
                SizedBox(
                  child : this.textField("Card name", Icons.card_giftcard),
                  width: MediaQuery.of(context).size.width - 15,
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Credit Card"),
                  this.checkbox(creditCard, this.creditCard)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Debit card"),
                  this.checkbox(debitCard, this.debitCard)
                ],
              ),
              SizedBox(
                child: this.infoCards(this.creditCard, "Limit"),
                width: MediaQuery.of(context).size.width - 15,
              ),
              SizedBox(
                child: this.infoCards(this.debitCard, "Balance"),
                width: MediaQuery.of(context).size.width - 15,
              )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Checkbox checkbox(option, bool val){
    return Checkbox(
      value: option,
      onChanged: (bool value) {
        setState(() {
          val = value;
        });
      }
    );
  }

  TextField textField(String text, IconData icon){
    return TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        hintText: text,
        prefixIcon: Icon(icon))
    );
  }

  Widget infoCards(bool type, String text){
    if(type){
      return Container(
        child : this.textField(text, Icons.monetization_on),
        width: MediaQuery.of(context).size.width - 15,
      );
    }
  }
}