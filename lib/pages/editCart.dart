import 'package:flutter/material.dart';

class EditCart extends StatelessWidget {
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
      title: "Edit Card Screen",
      home: EditCartPage(),
    );
  }
}

class EditCartPage extends StatefulWidget {
  @override
  _EditCartPageState createState() => _EditCartPageState();
}

class _EditCartPageState extends State<EditCartPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
