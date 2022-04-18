// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vote_app/pages/buttons.dart';
import 'package:vote_app/services/functions.dart';
import 'package:web3dart/web3dart.dart';

import '../constants.dart';

class CanddiateList extends StatefulWidget {
  final Web3Client ethClient;
  const CanddiateList({Key? key, required this.ethClient}) : super(key: key);

  @override
  State<CanddiateList> createState() => _CanddiateListState();
}

class _CanddiateListState extends State<CanddiateList> {
  void showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
          'MINING IN PROGRESS, be patient! ( after few seconds press the reload button and your vote will be added )'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<List>(
              future: getCandidateNum(widget.ethClient),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('eeeeeeeeeeeej');
                  // print(snapshot.data!.length.toString());
                  return const Text('Loading');
                } else {
                  return Column(
                    children: [
                      for (int i = 0; i < snapshot.data![0].toInt(); i++)
                        FutureBuilder<List>(
                            future: candidateInfo(i, widget.ethClient),
                            builder: (context, candidatesnapshot) {
                              if (candidatesnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (candidatesnapshot.hasData) {
                                return ListTile(
                                  title: Text('Name: ' +
                                      candidatesnapshot.data![0][0].toString()),
                                  subtitle: Text('Votes: ' +
                                      candidatesnapshot.data![0][1].toString()),
                                  trailing: ElevatedButton(
                                      onPressed: isAuthorized == true
                                          ? () {
                                              vote(i, widget.ethClient);
                                              showSnackBar();
                                            }
                                          : null,
                                      child: Text('Vote')),
                                );
                              }
                              return const CircularProgressIndicator();
                            }),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
