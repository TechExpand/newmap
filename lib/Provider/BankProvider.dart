import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newmap/Model/Bank.dart';
import 'package:newmap/Model/LGA.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class BankProvider with ChangeNotifier {


  String baseUrl = 'https://api.flutterwave.com/v3/banks/NG';
  String bearer = 'FLWSECK-71230ccbd14863ff68afb87741acdbec-X';

  List<BankInfo> allBankList = [];
  List<LGA> allLga = [];
  BankInfo ?selectedBank;
  LGA ?selectedLga;




  Future<dynamic> getAllBank() async {
    try {
      var response = await http
          .get(Uri.parse(baseUrl)
          , headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $bearer',
      });

      var body1 = json.decode(response.body);
      List body = body1['data'];
      List<BankInfo> bankLists = body.map((data) {
        return BankInfo.fromJson(data);
      }).toList();
      allBankList = bankLists;
      print(allBankList);
      notifyListeners();
    } catch (e) {
      print(e);
      print('na error b tat');
    }
  }

  // changeBank(Bank services) {
  //   selectedService = services;
  //   print(selectedService.service);
  //   notifyListeners();
  // }
  //
  changeSelectedBank(BankInfo bank) {
    selectedBank = bank;
    notifyListeners();
  }


  changeSelectedLga(LGA lga) {
    selectedLga = lga;
    notifyListeners();
  }
}
