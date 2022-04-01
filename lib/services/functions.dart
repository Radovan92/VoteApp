import 'package:flutter/services.dart';
import 'package:vote_app/constants.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAdress = contractAdressSolidity;

  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Election'),
      EthereumAddress.fromHex(contractAdress));
  return contract;
}

Future<String> callFunction(String functionName, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(functionName);
  final result = ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args));
  return result;
}

Future<String> startElection(String name, Web3Client ethClient) async {
  var response =
      await callFunction('startElection', [name], ethClient, myAccountKey);
  print('Election start successfully');

  return response;
}

Future<String> addCanddiate(String name, Web3Client ethClient) async {
  var response =
      await callFunction('addCandidate', [name], ethClient, myAccountKey);
  print('Candidate added successfully');

  return response;
}

Future<String> authorizeVoter(String address, Web3Client ethClient) async {
  var response = await callFunction('authorizedVoter',
      [EthereumAddress.fromHex(address)], ethClient, myAccountKey);
  print('Voter authorized successfully');

  return response;
}

Future<List> getCandidateNum(Web3Client ethClient) async {
  List<dynamic> result = await ask('getNumCandidates', [], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String functionName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(functionName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);

  return result;
}
