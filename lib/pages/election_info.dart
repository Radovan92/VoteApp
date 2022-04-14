// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
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
        child: Container(
          height: height,
          width: 500,
          margin: EdgeInsets.only(left: 100, top: 40),
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
                    future: getCandidateNum(widget.ethClient),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                  )
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
                    future: getTotalVotes(widget.ethClient),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading',
                          style: TextStyle(fontSize: 20),
                        );
                      }
                      if (snapshot.hasData) {
                        return Text(snapshot.data![0].toString());
                      }
                      return Text(
                        '0',
                        style: TextStyle(fontSize: 20),
                      );
                    },
                  )
                ],
              ),
              Buttons(
                ethClient: widget.ethClient,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Spisak kandidata ${widget.electionName}:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              CandidateList(ethClient: widget.ethClient),
            ],
          ),
        ),
      ),
    );
  }
}
