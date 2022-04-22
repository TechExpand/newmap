import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:newmap/Model/Agents.dart';
import 'package:newmap/Model/Bank.dart';
import 'package:newmap/Model/LGA.dart';
import 'package:newmap/Model/Transaction.dart';
import 'package:newmap/Provider/BankProvider.dart';
import 'package:newmap/Screen/Agent/AgentHome.dart';
import 'package:newmap/Screen/Agent/AgentTab.dart';
import 'package:newmap/Screen/SignUp_Login/SignIn.dart';
import 'package:newmap/Screen/SignUp_Login/SignInUserAgent.dart';
import 'package:newmap/Screen/User/Home/HomeTabs.dart';
import 'package:newmap/Screen/User/Home/Profile.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:provider/provider.dart';

class WebServices extends ChangeNotifier {
  String firstname = "";
  String lastname = "";
  String myemail = "";
  String myphonenumber = "";
  String wallet = "";
  dynamic points;
  dynamic walletpoints;
  int id = 0;
  String token = "";
  String localID = '';
  String image = '';
  String editname = "";
  String editphone = "";
  String userType = '';
  final box = GetStorage();
  var path = '';

  setPath(value) {
    path = value;
    notifyListeners();
  }

  setUserType(value) {
    userType = value;
    notifyListeners();
  }

  setToken(value) {
    token = value;
    notifyListeners();
  }

  Future<dynamic> sendTransaction(category, weight, userId, context) async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/vendorsapi/userdetails/${userId.toString()}/${weight.toString()}/'),
          body: jsonEncode(<String, String>{
            'weight': weight.toString(),
            'category': category.toString(),
            'theid': userId.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print('gooodddd');
        Navigator.pop(context);
        sendDialog(context, agent: 'agent');
      } else {
        print(body);
        Navigator.pop(context);
        await showTextToast(
          text: 'unable to create transaction.',
          context: context,
        );
      }
    } catch (e) {
      print('wronggg');
      Navigator.pop(context);
      await showTextToast(
        text: 'a problem has occured. try again',
        context: context,
      );
    }
  }

  Future<dynamic> giftPoint(agent, userid, amount, context) async {
    try {
      var response = await http.post(
          Uri.parse(agent == 'agent'
              ? "https://frankediku.pythonanywhere.com/vendorsapi/transfervendorpoints/"
              : 'https://frankediku.pythonanywhere.com/vendorsapi/transferpoints/'),
          body: jsonEncode(<String, String>{
            'userid': userid.toString(),
            'amount': amount.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          });
      print(response.body);
      print(response.body);
      // var body = jsonDecode(response.body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        sendDialog(context, agent: agent);
      } else {
        var body = jsonDecode(response.body);
        Navigator.pop(context);
        await showTextToast(
          text: body['message'],
          context: context,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      await showTextToast(
        text: 'a problem has occured. try again',
        context: context,
      );
    }
  }

  Future<dynamic> getAccountName(bankCode, accountNumber, context) async {
    try {
      var response = await http
          .post(Uri.parse('https://api.flutterwave.com/v3/accounts/resolve'),
              body: jsonEncode(<String, String>{
                'account_number': accountNumber.toString(),
                'account_bank': bankCode.toString(),
              }),
              headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'Bearer FLWSECK-71230ccbd14863ff68afb87741acdbec-X',
          });
      print(response.body);
      var body = jsonDecode(response.body);
      if (response.statusCode >= 200) {
        if (body['status'] == 'success') {
          Navigator.pop(context);
          showTextToast(
            text: body['message'].toString(),
            context: context,
          );
          return body['data']['account_name'];
        } else {
          Navigator.pop(context);
          showTextToast(
            text: body['message'].toString(),
            context: context,
          );
          return 'error';
        }
      } else {
        var body = jsonDecode(response.body);
        Navigator.pop(context);
        await showTextToast(
          text: body['message'].toString(),
          context: context,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      await showTextToast(
        text: 'a problem has occured. try again',
        context: context,
      );
    }
  }

  Future<dynamic> registerUser(
      {context,
      firstname,
      lastname,
      email,
      phonenumber,
      password,
      latitude,
      lga,
      longitude}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/accountapi/createuser/'),
          body: jsonEncode(<String, String>{
            'firstname': firstname.toString(),
            "lastname": lastname.toString(),
            'email': email.toString(),
            'phonenumber': phonenumber.toString(),
            'local_govt': lga,
            'password': password.toString(),
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //  'Authorization': 'Bearer $bearer',
          });

      print(response.statusCode);
      print(response.statusCode);
      print(response.statusCode);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return SignInUserAgent(
                status: 'user',
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      } else {
        Map message = body['message'];
        if (message['non_field_errors'].toString() == '[Email Already Exist]') {
          Navigator.pop(context);
          await showTextToast(
            text: 'Email Already Exist.',
            context: context,
          );
        } else if (message['phonenumber'].toString() ==
            '[Ensure this field has no more than 15 characters.]') {
          Navigator.pop(context);
          await showTextToast(
            text: 'Ensure this field has no more than 15 characters.',
            context: context,
          );
        } else {
          Navigator.pop(context);
          await showTextToast(
            text: 'A Problem was Encountered.',
            context: context,
          );
        }
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }

  Future<dynamic> registerAgent(
      {context,
      fullname,
      email,
      phonenumber,
      password,
      latitude,
      lga,
      address,
      longitude,
      uniqueID}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/vendorsapi/createvendor/'),
          body: jsonEncode(<String, String>{
            'fullname': fullname.toString(),
            'email': email.toString(),
            'address': address.toString(),
            'phonenumber': phonenumber.toString(),
            'password': password.toString(),
            'local_govt': lga,
            'uniqueid': uniqueID.toString(),
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //  'Authorization': 'Bearer $bearer',
          });

      print(response.body);
      print(response.body);
      print(response.body);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        Navigator.pop(context);
        print('gpppp');
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              //  setUserType('agent');
              return SignInUserAgent(
                status: 'agent',
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      } else if (body['message']['non_field_errors'][0] ==
          'Email Already Exist') {
        Navigator.pop(context);
        await showTextToast(
          text: 'Email Already Exist.',
          context: context,
        );
      } else {
        print(body);
        Navigator.pop(context);
        await showTextToast(
          text: 'A problem was encountered or you entered a used unique-id.',
          context: context,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      await showTextToast(
        text: 'A problem was encountered or you entered a used unique-id.',
        context: context,
      );
      print(e);
    }
  }

  Future<dynamic> uploadImage({context, imagePath}) async {
    var upload = http.MultipartRequest(
        'PATCH',
        Uri.parse(
            'https://frankediku.pythonanywhere.com/accountapi/edituser/'));
    var file = await http.MultipartFile.fromPath('image', imagePath);
    upload.files.add(file);
    upload.headers['authorization'] = 'Token $token';

    final stream = await upload.send();
    var resp = await http.Response.fromStream(stream);
    // var body = jsonDecode(resp.body);
    // print(body.toString());

    // if (resp.statusCode == 200 ||
    //     resp.statusCode == 201 ||
    //     resp.statusCode == 202) {
    //   await showTextToast(
    //     text: 'changed successfully.',
    //     context: context,
    //   );
    // } else {
    //   print('lalallala');
    //
    //   await showTextToast(
    //     text: 'Failed to edit.',
    //     context: context,
    //   );
    // }
    image = imagePath;
    path = 'path';
    notifyListeners();
    showTextToast(
      text: 'changed successfully.',
      context: context,
    );
  }

  Future<dynamic> editUser({context, phonenumber, firstname}) async {
    try {
      var response = await http.patch(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/accountapi/edituser/'),
          body: jsonEncode(<String, String>{
            'phonenumber': phonenumber.toString(),
            'firstname': firstname.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        firstname = body['message']['firstname'];
        lastname = body['message']['lastname'];
        myphonenumber = body['message']['phonenumber'];

        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        print('lalallala');
        Navigator.pop(context);
        await showTextToast(
          text: 'Failed to edit.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }

  Future<dynamic> updateLocation({lan, log}) async {
    var response = await http.post(
        Uri.parse(
            'https://frankediku.pythonanywhere.com/vendorsapi/updatevendorlocation/'),
        body: jsonEncode(<String, String>{
          'longitude': log.toString(),
          'latitude': lan.toString(),
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        });

    // var body = jsonDecode(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print('goooood');
    } else {}
    notifyListeners();
  }

  Future<dynamic> LoginAgent({context, email, password}) async {
    try {
      var response = await http.post(
          Uri.parse('https://frankediku.pythonanywhere.com/vendorsapi/login/'),
          body: jsonEncode(<String, String>{
            'email': email.toString(),
            'password': password.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //  'Authorization': 'Bearer $bearer',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        firstname = body['firstname'];
        lastname = body['lastname'];
        myemail = body['email'];
        myphonenumber = body['phonenumber'];
        wallet = body['wallet'];
        walletpoints = body['walletpoints'];
        points = body['weight'];
        token = body['token'];
        id = body['id'];
        box.write('token', token);
        box.write('type', 'agent');

        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return AgentTab();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      } else if (body['message']['user'] == 'Invalid Login Details') {
        print('mamamama');
        Navigator.pop(context);
        await showTextToast(
          text: 'Invalid Login Details.',
          context: context,
        );
      } else if (body['message'].containsKey('non_field_errors')) {
        print(body);
        Navigator.pop(context);
        await showTextToast(
          text: body['message']['non_field_errors'][0].toString(),
          context: context,
        );
      } else {
        print(body);
        Navigator.pop(context);
        await showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      print('jaaa $e');
      Navigator.pop(context);
      await showTextToast(
        text: 'Invalid Login Details.',
        context: context,
      );
    }
  }

  Future<dynamic> LoginUser({context, email, password}) async {
    try {
      var response = await http.post(
          Uri.parse('https://frankediku.pythonanywhere.com/accountapi/login/'),
          body: jsonEncode(<String, String>{
            'email': email.toString(),
            'password': password.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //  'Authorization': 'Bearer $bearer',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        firstname = body['firstname'];
        lastname = body['lastname'];
        myemail = body['email'];
        myphonenumber = body['phonenumber'];
        wallet = body['wallet'];
        points = body['weight'];
        walletpoints = body['walletpoints'];
        token = body['token'];
        id = body['id'];
        box.write('token', token);
        box.write('type', 'user');

        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return HomePageTab();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      } else if (body['message']['user'] == 'Invalid Login Details') {
        print('mamamama');
        Navigator.pop(context);
        await showTextToast(
          text: 'Invalid Login Details.${body['message']}',
          context: context,
        );
      } else {
        print('lalallala');
        Navigator.pop(context);
        await showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      print(e);
      Navigator.pop(context);
      await showTextToast(
        text: 'Unable to proceed',
        context: context,
      );
    }
  }

  Future<dynamic> deleteAccount(context, id) async {
    try {
      var response = await http.delete(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/accountapi/usersbanks/'),
          body: jsonEncode(<String, String>{
            'bankid': id.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        showTextToast(
          text: 'Account Deleted.',
          context: context,
        );
      } else {
        print('lalallala');
        await showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      await showTextToast(
        text: e.toString(),
        context: context,
      );
      print('jaaa');

      print(e);
    }
  }

  Future<dynamic> AddBank({context, accname, accnum, acccode, bankname}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/accountapi/usersbanks/'),
          body: jsonEncode(<String, String>{
            'bankname': bankname.toString(),
            'accountnumber': accnum.toString(),
            'accountname': accname.toString(),
            'code': acccode.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        return 'true';
      } else {
        Navigator.pop(context);
        print('lalallala');
        showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      print('jaaa');

      print(e);
    }
  }

  Future withdrawBank(agent, id, amount, context) async {
    var response = await http.post(
        Uri.parse(agent == 'agent'
            ? "https://frankediku.pythonanywhere.com/vendorsapi/withdraw/"
            : "https://frankediku.pythonanywhere.com/accountapi/withdraw/"),
        body: jsonEncode(<String, String>{
          'bankid': id.toString(),
          'amount': amount.toString(),
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        });

    print(response.body.toString());
    print(response.body.toString());
    print(response.statusCode.toString());
    var body = json.decode(response.body);
    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print('goooddddd');
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return agent == 'agent' ? AgentTab() : HomePageTab();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        (route) => false,
      );

      await showTextToast(
        text: 'Your Account have been credited Successfully',
        context: context,
      );
      return 'body';
    } else {
      Navigator.pop(context);
      await showTextToast(
        text: body['message'].toString(),
        context: context,
      );
      print('failed');
      return 'Not found';
    }
  }

  Future withdrawAirtime(agent, networkID, amount, category, getTranref,
      mobileNumber, context) async {
    var response = await http.post(
        Uri.parse(agent == 'agent'
            ? "https://frankediku.pythonanywhere.com/vendorsapi/purchasevendorairtime/"
            : "https://frankediku.pythonanywhere.com/vendorsapi/purchaseairtime/"),
        body: jsonEncode(<String, String>{
          'amount': amount.toString(),
          'network': category.toString(),
          'networkid': networkID.toString(),
          'transref': getTranref.toString(),
          'mobile_number': mobileNumber.toString(),
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        });

    print(response.statusCode.toString());
    print(response.statusCode.toString());
    print(response.statusCode.toString());

    notifyListeners();
    if (response.statusCode < 400) {
      print('goooddddd');
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return agent == 'agent' ? AgentTab() : HomePageTab();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        (route) => false,
      );

      await showTextToast(
        text: 'You have been credited Successfully',
        context: context,
      );
      return 'body';
    } else {
      var body = json.decode(response.body);
      Navigator.pop(context);
      await showTextToast(
        text: body['message'],
        context: context,
      );
      print('failed');
      return 'Not found';
    }
  }

  Future confirmUsers(weight, userId) async {
    var response = await http.get(
        Uri.parse(
            "https://frankediku.pythonanywhere.com/vendorsapi/userdetails/$userId/$weight/"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        });
    var body = json.decode(response.body);
    print(body);
    print(body);

    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return body;
    } else {
      print('failed');
      return 'Not found';
    }
  }

  Future getUserInfo() async {
    //https://frankediku.pythonanywhere.com/accountapi/getuser/
    // 'https://frankediku.pythonanywhere.com/vendorsapi/getuser/'
    var response = await http.get(
        Uri.parse('https://frankediku.pythonanywhere.com/accountapi/getuser/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        }).timeout(Duration(seconds: 20));
    print(response.body);
    print(response.body);
    var body = json.decode(response.body);
    // List body1 = body;
    // List<Transaction> UsertransLists = body1.map((data) {
    //   return Transaction.fromJson(data);
    // }).toList();
    print(body);
    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      firstname = body['firstname'];
      lastname = body['lastname'];
      myemail = body['email'];
      myphonenumber = body['phonenumber'];
      wallet = body['wallet'];
      points = body['weight'];
      walletpoints = body['walletpoints'];
      id = body['id'];
      localID = body['local_gov_code'];
      image = body['image'] == null ? '' : body['image'];
      return body;
    } else {
      print('failed');
    }
  }

  Future getVendorInfo() async {
    //https://frankediku.pythonanywhere.com/accountapi/getuser/
    // 'https://frankediku.pythonanywhere.com/vendorsapi/getuser/'
    var response = await http.get(
        Uri.parse('https://frankediku.pythonanywhere.com/vendorsapi/getuser/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        }).timeout(Duration(seconds: 20));
    print(response.body);
    print(response.body);
    var body = json.decode(response.body);
    // List body1 = body;
    // List<Transaction> UsertransLists = body1.map((data) {
    //   return Transaction.fromJson(data);
    // }).toList();
    print(body);
    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      firstname = body['firstname'];
      lastname = body['lastname'];
      myemail = body['email'];
      myphonenumber = body['phonenumber'];
      wallet = body['wallet'];
      points = body['weight'];
      walletpoints = body['walletpoints'];
      id = body['id'];
      localID = body['local_gov_code'];
      image = body['image'] == null ? '' : body['image'];
      return body;
    } else {
      print('failed');
    }
  }

  Future getUserTransaction() async {
    try {
      var response = await http.get(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/accountapi/transactionhistory/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          }).timeout(Duration(seconds: 20));
      var body = json.decode(response.body);
      List body1 = body;
      List<Transaction> UsertransLists = body1.map((data) {
        return Transaction.fromJson(data);
      }).toList();

      notifyListeners();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        if (UsertransLists.isEmpty) {
          List<Transaction> defaul = [];
          return defaul;
        } else {
          print(UsertransLists);
          return UsertransLists;
        }
      } else {
        print('failed');
      }
    } on TimeoutException catch (e) {
      List<Transaction> defaul = [Transaction(amount: 'network')];
      return defaul;
    } on SocketException catch (e) {
      List<Transaction> defaul = [Transaction(amount: 'network')];
      print('Socket Error: $e');
      return defaul;
    } on Error catch (e) {
      List<Transaction> defaul = [Transaction(amount: 'network')];
      print('General Error: $e');
      return defaul;
    }
  }

  Future getVendorTransaction() async {
    try {
      var response = await http.get(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/vendorsapi/transactionhistory/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          }).timeout(Duration(seconds: 20));
      var body = json.decode(response.body);
      List body1 = body;
      List<Transaction> UsertransLists = body1.map((data) {
        return Transaction.fromJson(data);
      }).toList();

      notifyListeners();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        if (UsertransLists.isEmpty) {
          List<Transaction> defaul = [];
          return defaul;
        } else {
          print(UsertransLists);
          return UsertransLists;
        }
      } else {
        print('failed');
      }
    } on TimeoutException catch (e) {
      List<Transaction> defaul = [Transaction(amount: 'network')];
      return defaul;
    } on SocketException catch (e) {
      List<Transaction> defaul = [Transaction(amount: 'network')];
      print('Socket Error: $e');
      return defaul;
    } on Error catch (e) {
      List<Transaction> defaul = [Transaction(amount: 'network')];
      print('General Error: $e');
      return defaul;
    }
  }

  Future getAccountDetails() async {
    try {
      var response = await http.get(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/accountapi/usersbanks/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          }).timeout(Duration(seconds: 20));
      var body = json.decode(response.body);
      List body1 = body;
      List<BankInfoUser> UserAccLists = body1.map((data) {
        return BankInfoUser.fromJson(data);
      }).toList();

      notifyListeners();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        if (UserAccLists.isEmpty) {
          List<BankInfoUser> defaul = [];
          return defaul;
        } else {
          print(UserAccLists);
          return UserAccLists;
        }
      } else {
        print('failed');
      }
    } on TimeoutException catch (e) {
      List<BankInfoUser> defaul = [BankInfoUser(accountname: 'network')];
      return defaul;
    } on SocketException catch (e) {
      List<BankInfoUser> defaul = [BankInfoUser(accountname: 'network')];
      print('Socket Error: $e');
      return defaul;
    } on Error catch (e) {
      List<BankInfoUser> defaul = [BankInfoUser(accountname: 'network')];
      print('General Error: $e');
      return defaul;
    }
  }

  Future getLGA(context) async {
    var response = await http.get(
        Uri.parse(
            'https://frankediku.pythonanywhere.com/accountapi/getlocalgovt/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
    var body = json.decode(response.body);
    List body1 = body['localgovt'];
    List<LGA> lga = body1.map((data) {
      return LGA.fromJson(data);
    }).toList();

    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      BankProvider postRequestProvider =
          Provider.of<BankProvider>(context, listen: false);
      postRequestProvider.allLga = lga;
      if (lga.isEmpty) {
        List<LGA> defaul = [];
        return defaul;
      } else {
        return lga;
      }
    } else {
      print(body);
    }
  }

  Future getAgents(lan, log) async {
    try {
      var response = await http.get(
          Uri.parse(
              'https://frankediku.pythonanywhere.com/vendorsapi/getvendordistance/$lan/$log/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          }).timeout(Duration(seconds: 20));
      var body = json.decode(response.body);
      print(body);
      print(body);
      List body1 = body['message'];
      List<Agents> AgentLists = body1.map((data) {
        return Agents.fromJson(data);
      }).toList();

      notifyListeners();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        if (AgentLists.isEmpty) {
          List<Agents> defaul = [];
          return defaul;
        } else {
          print(AgentLists);
          return AgentLists;
        }
      } else {
        print('failed');
      }
    } on TimeoutException catch (e) {
      List<Agents> defaul = [Agents(fullname: 'network')];
      return defaul;
    } on SocketException catch (e) {
      List<Agents> defaul = [Agents(fullname: 'network')];
      print('Socket Error: $e');
      return defaul;
    } on Error catch (e) {
      List<Agents> defaul = [Agents(fullname: 'network')];
      print('General Error: $e');
      return defaul;
    }
  }
}

class NetworkError {
  String network;
  NetworkError({required this.network});
}
