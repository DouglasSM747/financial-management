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
                this.addCheckbox(creditCard, this.creditCard, "Credit Card"),
                this.addCheckbox(debitCard, this.debitCard, "Debit Card"),
              /* Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Credit Card", style: TextStyle(fontSize: 21, color: Colors.white)),
                  this.checkbox(creditCard, this.creditCard)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Debit card", style: TextStyle(fontSize: 21, color: Colors.white)),
                  this.checkbox(debitCard, this.debitCard)
                ],
              ), */
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
/* 
  Checkbox checkbox(option, bool val){
    return Checkbox(
      value: option,
      activeColor: Colors.green,
      checkColor: Colors.white,
      tristate: false,
      onChanged: (bool value) {
        setState(() {
          val = value;
        });
      }
    );
  } */

  Widget addCheckbox(option, bool val, String text){
    return Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ Transform.scale( 
              scale: 1.5,
              child: Checkbox(
                value: option,
                onChanged: (bool value){setState(() {
                  val = value;
                });},
                activeColor: Colors.green,
                checkColor: Colors.white,
                tristate: false,
              ),
          ), 
 
        Text(text, 
          style: TextStyle(fontSize: 21), 
          textAlign: TextAlign.center,)
 
      ]);
  }


  TextField textField(String text, IconData icon){
    return TextField(
        decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        hintText: text,
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white))
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