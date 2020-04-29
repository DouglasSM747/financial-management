import 'package:financial/crud/servicesCrud.dart';
import 'package:financial/layout/button.dart';
import 'package:flutter/material.dart';

class EditCartPage extends StatefulWidget {
  final String idUser;
  final String idCard;
  final int type;
  final int limit;
  final int balance;
  final int limitAtual;
  final int balanceAtual;
  EditCartPage(
      {this.idUser,
      this.idCard,
      this.type,
      this.balanceAtual,
      this.balance,
      this.limit,
      this.limitAtual});
  _EditCartPageState createState() => _EditCartPageState();
}

class _EditCartPageState extends State<EditCartPage> {
  final _controllerBalance = TextEditingController();
  final _controllerBalanceAtual = TextEditingController();
  final _controlleLimit = TextEditingController();
  final _controlleLimitAtual = TextEditingController();
  //Instantiate servico FireStore
  ServiceCrudFireStore serviceCrudFireStore = new ServiceCrudFireStore();
  updateCard() {
    serviceCrudFireStore.updateCardInfo(
      widget.idUser,
      widget.idCard,
      {
        'balance': _controllerBalance.text.isEmpty
            ? widget.balance
            : int.parse(_controllerBalance.text),
        'balance_atual': _controllerBalanceAtual.text.isEmpty
            ? widget.balanceAtual
            : int.parse(_controllerBalanceAtual.text),
        'limit': _controlleLimit.text.isEmpty
            ? widget.limit
            : int.parse(_controlleLimit.text),
        'limit_atual': _controlleLimitAtual.text.isEmpty
            ? widget.limitAtual
            : int.parse(_controlleLimitAtual.text),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.only(top: 120),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Text(
                "Edit card",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(height: 30),
              loadPage(),
              SizedBox(height: 30),
              ButtonStandard(
                text: "Update Card",
                voidCallback: () {
                  updateCard();
                },
                width: MediaQuery.of(context).size.width - 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loadPage() {
    if (widget.type == 2) {
      return Column(
        children: <Widget>[
          formText('Limit: ' + widget.limit.toString(), Icons.money_off,
              _controlleLimit),
          SizedBox(height: 20),
          formText('Limit Atual: ' + widget.limitAtual.toString(),
              Icons.money_off, _controlleLimitAtual),
          SizedBox(height: 20),
          formText('Balance: ' + widget.balance.toString(), Icons.money_off,
              _controllerBalance),
          SizedBox(height: 20),
          formText('Balance Atual: ' + widget.balanceAtual.toString(),
              Icons.money_off, _controllerBalanceAtual)
        ],
      );
    } else if (widget.type == 0) {
      return Column(
        children: <Widget>[
          formText('Balance: ' + widget.limit.toString(), Icons.money_off,
              _controllerBalance),
          SizedBox(height: 20),
          formText('Balance Atual: ' + widget.limit.toString(), Icons.money_off,
              _controllerBalanceAtual)
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          formText('Limit: ' + widget.limit.toString(), Icons.money_off,
              _controlleLimit),
          SizedBox(height: 20),
          formText('Limit Atual: ' + widget.limit.toString(), Icons.money_off,
              _controlleLimitAtual)
        ],
      );
    }
  }

  TextFormField formText(
      String texto, IconData icon, TextEditingController textEditingController,
      {bool password = false}) {
    return TextFormField(
      autofocus: false,
      controller: textEditingController,
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
