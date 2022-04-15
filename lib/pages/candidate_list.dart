import 'package:flutter/material.dart';
import 'package:vote_app/pages/buttons.dart';
import 'package:vote_app/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class CanddiateList extends StatefulWidget {
  final Web3Client ethClient;
  const CanddiateList({Key? key, required this.ethClient}) : super(key: key);

  @override
  State<CanddiateList> createState() => _CanddiateListState();
}

class _CanddiateListState extends State<CanddiateList> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                      onPressed: () {
                                        vote(i, widget.ethClient);
                                      },
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
