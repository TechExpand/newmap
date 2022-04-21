import 'dart:async';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';




class Utils with ChangeNotifier {
  String randomNum = '';
  bool isExpanded = false;
  String fcmToken = '';
  bool isExpanded1 = true;
  bool list = false;



  // static DateTime toDateTime(Timestamp value) {
  //   if (value == null) return null;
  //
  //   return value.toDate();
  // }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    randomNum = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return randomNum;
  }

  setFCMToken(value) {
    fcmToken = value;
    notifyListeners();
  }

  setList(value) {
    list = value;
    notifyListeners();
  }



  compareDate(DateTime date) {
    if (date.difference(DateTime.now()).inHours.abs() <= 24) {
      var value = formatTime(date);
      return value;
    } else if (date.difference(DateTime.now()).inHours.abs() >= 24 &&
        date.difference(DateTime.now()).inHours.abs() <= 48) {
      return 'yesterday';
    } else {
      var value = formatYear(date);
      return value;
    }
  }




  formatDate(DateTime now) {
    final DateFormat formatter = DateFormat('yyyy-MMMM-dd hh:mm');
    final String formatted = formatter.format(now);
    notifyListeners();
    return formatted;
  }

  formatDate2(DateTime now) {
    final DateFormat formatter = DateFormat('dd MMMM');
    final String formatted = formatter.format(now);
    notifyListeners();
    return formatted;
  }


  formatDateprofile(DateTime now) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formatted = formatter.format(now);
    notifyListeners();
    return formatted;
  }


  static formatTime(DateTime now) {
    final DateFormat formatter = DateFormat().add_jm();
    final String formatted = formatter.format(now);
    return formatted;
  }

  formatYear(DateTime now) {
    final DateFormat formatter = DateFormat('yyyy/MMMM/dd');
    final String formatted = formatter.format(now);
    return formatted;
  }


  makeEmailCall(mail) async {
    var url = 'mailto:$mail';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  makePhoneCall(tel) async {
    var url = 'tel:$tel';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  makeOpenUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  opeLink(link) async {
    var url = '$link';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  onExpansionChanged(bool val) {
    isExpanded = val;
  }

  onExpansionChanged1(bool val) {
    isExpanded1 = val;
    print(val);
  }

// Future storeData(String name, String data) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(name, data);
// }
//
// Future getData(String name) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String data = prefs.getString(name);
//   return data;
// }
}


String formatCurrency(String country, double number) =>
    NumberFormat.simpleCurrency(name: country, decimalDigits: 2).format(number);

String formatDecimal(double number) =>
    NumberFormat('#########0.0').format(number);

String currencySymbol(String currencyCode) =>
    NumberFormat().simpleCurrencySymbol(currencyCode);



extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
