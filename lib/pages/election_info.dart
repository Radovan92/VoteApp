// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_app/constants.dart';
import 'package:vote_app/pages/buttons.dart';
import 'package:vote_app/pages/candidate_list.dart';
import 'package:vote_app/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class ElectionInfo extends StatefulWidget {
  final Web3Client ethClient;
  final String electionName;

  const ElectionInfo(
      {Key? key, required this.ethClient, required this.electionName})
      : super(key: key);

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  late String valueText;

  void showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
          'MINING IN PROGRESS, be patient! ( after few seconds press the reload button and you will be authorized )'),
    );
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
                    Provider.of<Functions>(context, listen: false)
                        .authorizeVoter(valueText, widget.ethClient);
                    setState(() {
                      isAuthorized = true;
                    });
                    Navigator.pop(context);
                    showSnackBar();
                    setState(() {});
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.replay_outlined),
        onPressed: () {
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Text(widget.electionName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: height,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Broj kandidata :',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FutureBuilder<List>(
                      future: Provider.of<Functions>(context, listen: false)
                          .getCandidateNum(widget.ethClient),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading',
                            style: TextStyle(fontSize: 20),
                          );
                        }
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(fontSize: 20),
                          );
                        }
                        return Text('0', style: TextStyle(fontSize: 20));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Broj glasova :',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    FutureBuilder<List>(
                      future: Provider.of<Functions>(context, listen: false)
                          .getTotalVotes(widget.ethClient),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading',
                            style: TextStyle(fontSize: 20),
                          );
                        }
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(fontSize: 20),
                          );
                        }
                        return Text(
                          '0',
                          style: TextStyle(fontSize: 20),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    dialog('Please enter your public address');
                  },
                  child: Text('Authorization'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green[200])),
                ),
                SizedBox(
                  height: 10,
                ),
                CanddiateList(ethClient: widget.ethClient),
                Buttons(ethClient: widget.ethClient),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
