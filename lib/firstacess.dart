import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class FirstAcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Acess Page',
      home: FirstAcessPage(),
    );
  }
}

class FirstAcessPage extends StatefulWidget {
  @override
  _FirstAcessPageState createState() => _FirstAcessPageState();
}

class _FirstAcessPageState extends State<FirstAcessPage> {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}