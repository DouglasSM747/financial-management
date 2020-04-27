import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/crud/servicesCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CardClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Card Screen",
      home: CardPage(),
    );
  }
}

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  ServiceCrudFireStore serviceCrudFireStore = new ServiceCrudFireStore();
  QuerySnapshot querySnapshot;
  void getUserCards() {
    //assigning user card data to a list, type QuerySnapshot;
    serviceCrudFireStore.getCardsUser('jseGCXq0n5tJ728Tsypa').then(
      (onValue) {
        setState(
          () {
            querySnapshot = onValue;
          },
        );
      },
    );
  }

  void initState() {
    getUserCards();
  }

  String atualCardName =
      "Cartão VISA"; // stores the name of the card that is appearing on the screen
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 120), child: carregandoInfos()),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartao() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(
        child: Text(
          "Cartão de Teste",
          style: TextStyle(fontSize: 40),
        ),
      ),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }

  Widget carregandoInfos() {
    if (querySnapshot == null) {
      return Center(
        child: Text(
          'Carregando informações... Aguarde',
          style: TextStyle(color: Colors.white, fontSize: 60),
        ),
      );
    } else {
      print('Não é nulo mais');
      return Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: querySnapshot.documents.length,
          itemBuilder: (context, index) =>
              Padding(padding: EdgeInsets.only(right: 20), child: cartao()),
        ),
      );
    }
  }
}
