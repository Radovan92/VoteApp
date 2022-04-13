// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            vote(1, widget.ethClient);
          },
        ),
        appBar: AppBar(
          title: Text(widget.electionName),
          centerTitle: true,
        ),
        body: Container(
          // margin: EdgeInsets.all(10),

          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder<List>(
                    future: getCandidateNum(widget.ethClient),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Text(
                        snapshot.data![0].toString(),
                        style: TextStyle(fontSize: 40),
                      );
                    },
                  ),
                  FutureBuilder<List>(
                    future: getTotalVotes(widget.ethClient),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Text(
                        'rasa',
                        style: TextStyle(fontSize: 40),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  Text(
                    'Total Candidates',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Total Votes',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
