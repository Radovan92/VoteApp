// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vote_app/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class Buttons extends StatefulWidget {
  final Web3Client ethClient;
  const Buttons({Key? key, required this.ethClient}) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  late String valueText;

  void showSnackBar(){
    final snackBar = SnackBar(content: Text('MINING IN PROGRESS, be patient! ( after few seconds press the reload button and you candidate will be added )'), );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<dynamic> dialog(String name) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(name),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    addCanddiate(valueText.toString(), widget.ethClient);
                    Navigator.pop(context);
                    showSnackBar();
                    setState(() {
                      
                    });
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: Column(children: [
        SizedBox(
          height: 50,
          width: 160,
          child: ElevatedButton(
            onPressed: () async {
              setState(() {});
              dialog('Unesite naziv kandidata');
            },
            child: Text('Dodajte kandidata'),
          ),
        ),
        SizedBox(height: 20),
        
      ]),
    );
  }
}
