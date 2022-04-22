import 'dart:async';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class DataProvider with ChangeNotifier {
  String email = '';
  String uniqueID = "";
  String name = '';
  String firstname = "";
  String lastname = "";
  String phone = '';
  String lan = '';
  String log = '';
  String address = '';
  String password = '';
}
