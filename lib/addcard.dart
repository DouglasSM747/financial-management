import 'package:financial/crud/servicesCrud.dart';
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
  // final String _idUser;
  // AddCardPage(this._idUser);
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  ServiceCrudFireStore serviceCrudFireStore = new ServiceCrudFireStore();
  void addCards() {
    var record;
    if (creditCard && debitCard) {
      record = {
        "balance": this._controllerBalance,
        "balance_atual": this._controllerBalanceAtual,
        "limit": this._controlleLimit,
        "limit_atual": this._controlleLimitAtual,
        "nameCard": this._controllerNameCard,
        "type": 2
      };
    } else if (creditCard) {
      record = {
        "limit": this._controlleLimit,
        "limit_atual": this._controlleLimitAtual,
        "nameCard": this._controllerNameCard,
        "type": 1
      };
    } else {
      record = {
        "balance": this._controllerBalance,
        "balance_atual": this._controllerBalanceAtual,
        "nameCard": this._controllerNameCard,
        "type": 0
      };
    }
    this.serviceCrudFireStore.addCard("MaNagOx8OJr6NKhmOkmC", record);
  }

  bool creditCard = false;
  bool debitCard = false;

  final _controllerBalance = TextEditingController();
  final _controllerBalanceAtual = TextEditingController();
  final _controlleLimit = TextEditingController();
  final _controlleLimitAtual = TextEditingController();
  final _controllerNameCard = TextEditingController();
  int type = 0;

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
            color: Colors.black,
            padding: EdgeInsets.only(top: 60),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: textField("Card name", Icons.card_giftcard,
                      this._controllerNameCard),
                  width: MediaQuery.of(context).size.width - 15,
                ),
                this.addCheckbox(this.creditCard, "Credit Card"),
                this.addCheckbox(this.debitCard, "Debit Card"),
                SizedBox(
                  child: this.infoCards(this.creditCard, "Limit", "Atual limit",
                      this._controlleLimit, this._controlleLimitAtual),
                  width: MediaQuery.of(context).size.width - 15,
                ),
                SizedBox(height: 10),
                SizedBox(
                  child: this.infoCards(
                      this.debitCard,
                      "Balance",
                      "Atual balance",
                      this._controllerBalance,
                      this._controllerBalanceAtual),
                  width: MediaQuery.of(context).size.width - 15,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: RaisedButton(
                      child: Text(
                        "Add card",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.grey[700],
                      onPressed: () {
                        print("Deu certo");
                        this.addCards();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addCheckbox(bool val, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 3.0, color: Colors.white),
              left: BorderSide(width: 3.0, color: Colors.white),
              right: BorderSide(width: 3.0, color: Colors.white),
              bottom: BorderSide(width: 3.0, color: Colors.white),
            ),
          ),
          child: Transform.scale(
            scale: 1.7,
            child: Checkbox(
              value: val,
              onChanged: (bool value) {
                if (text == "Credit Card") {
                  setState(() {
                    creditCard = value;
                  });
                }
                if (text == "Debit Card") {
                  setState(() {
                    debitCard = value;
                  });
                }
              },
              focusColor: Colors.white,
              hoverColor: Colors.white,
              activeColor: Colors.green,
              checkColor: Colors.white,
            ),
          ),
        ),
        Text(text,
            style: TextStyle(fontSize: 21, color: Colors.white),
            textAlign: TextAlign.center),
      ],
    );
  }

  TextField textField(
      String text, IconData icon, TextEditingController textEditingController) {
    return TextField(
        controller: textEditingController,
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
            prefixIcon: Icon(icon, color: Colors.white)),
        style: TextStyle(color: Colors.green));
  }

  Widget infoCards(bool type, String text1, String text2,
      TextEditingController valor1, TextEditingController valor2) {
    if (type) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this.textField(text1, Icons.monetization_on, valor1),
          SizedBox(height: 10),
          this.textField(text2, Icons.monetization_on, valor2)
        ],
      );
    } else {
      return null;
    }
  }
}
