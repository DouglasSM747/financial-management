import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/crud/servicesCrud.dart';
import 'package:financial/layout/button.dart';
import 'package:financial/pages/editCart.dart';
import 'package:flutter/material.dart';

class CardClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Use the old theme but apply the following three changes
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open_Sans',
            ),
      ),
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
  int _current = 0;
  int quantidadeCards; //verifica se é o ultimo item na lista
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    var i;
    for (i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  editarCart(int index) {
    Map<String, dynamic> map = querySnapshot.documents[index].data;
    if (map['type'] == 0) {
      map['limit'] = 0;
      map['limit_atual'] = 0;
    }
    if (map['type'] == 1) {
      map['balance'] = 0;
      map['balance_atual'] = 0;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditCartPage(
          idUser: "jseGCXq0n5tJ728Tsypa",
          idCard: querySnapshot.documents[index].documentID,
          type: map['type'],
          balance: map['balance'],
          balanceAtual: map['balance_atual'],
          limit: map['limit'],
          limitAtual: map['limit_atual'],
        ),
      ),
    );
  }

  //Instantiate servico FireStore
  ServiceCrudFireStore serviceCrudFireStore = new ServiceCrudFireStore();
  //Variable snapshots return Firestore
  QuerySnapshot querySnapshot;
  DocumentSnapshot doc;
  get loadUserCards {
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
    loadUserCards;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.only(top: 80),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: loadPage(),
        ),
      ),
    );
  }

  //Wiget constructor card
  Widget cartao(String nameCard) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 230),
            child: Image.asset('assets/images/mastercard.png',
                width: 80, height: 80, fit: BoxFit.contain),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset('assets/images/chip.png',
                    width: 40, height: 50, fit: BoxFit.contain),
              ),
              Image.asset('assets/images/connection.png',
                  width: 50, height: 50, fit: BoxFit.contain),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 18),
            child: Text(
              nameCard.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
      decoration: new BoxDecoration(
        color: Colors.purple[900],
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }

  //Widget responsible for waiting to load the cards and check if the user has a card or not
  Widget loadPage() {
    if (querySnapshot == null) {
      return Center(
        child: Text(
          '@Carregando seus cartões... Aguarde',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      );
    } else if (querySnapshot.documents.length == 0) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            child: Text(
              "Hello my friend, it looks like you don't have a card, how about adding it? Just click here below.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: FlatButton(
              child: Image.asset('assets/images/Add.png'),
              onPressed: () {},
            ),
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Text(
            "Selecione o seu cartão",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: querySnapshot.documents.length,
              itemBuilder: (BuildContext context, int itemIndex) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: cartao(
                    querySnapshot.documents[itemIndex].data['nameCard'],
                  ),
                );
              },
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  aspectRatio: 1.9,
                  initialPage: 0,
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              querySnapshot.documents,
              (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonStandard(
            width: MediaQuery.of(context).size.width - 50,
            text: "Acess Cart",
            voidCallback: () {},
          ),
          SizedBox(
            height: 20,
          ),
          ButtonStandard(
            width: MediaQuery.of(context).size.width - 50,
            text: "Edit Cart",
            voidCallback: () {
              editarCart(_current);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ButtonStandard(
            width: MediaQuery.of(context).size.width - 50,
            text: "Add Cart",
            voidCallback: () {},
          )
        ],
      );
    }
  }
}
