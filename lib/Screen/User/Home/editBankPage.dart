




import 'dart:io';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:newmap/Model/Bank.dart';
import 'package:newmap/Provider/BankProvider.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Screen/SignUp_Login/finalUserRegister.dart';
import 'package:newmap/Service/Network.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:provider/provider.dart';

class EditBankPage extends StatefulWidget {
  @override
  _EditBankPageState createState() => _EditBankPageState();
}

class _EditBankPageState extends State<EditBankPage> {
  TextEditingController cardNo = new TextEditingController();
  TextEditingController expiryDate = new TextEditingController();
  TextEditingController cvvCode = new TextEditingController();
  List<BankInfoUser> ?accounts;



  callaccount(context)async{
    var network = Provider.of<WebServices>(context, listen: false);
    network.getAccountDetails().then((value) {
      setState(() {
        accounts = value ;
      });
    });
  }


  @override
  void initState(){
    super.initState();
    callaccount(context);
    // plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {

    String _getReference() {
      String platform;
      if (Platform.isIOS) {
        platform = 'iOS';
      } else {
        platform = 'Android';
      }
      return 'ChargedFrom${platform}_${DateTime
          .now()
          .millisecondsSinceEpoch}';
    }
    var network = Provider.of<WebServices>(context, listen: false);


//     paymentMethod(context, amount, email)async{
//       Charge charge = Charge()
//         ..amount = amount
// //        ..putMetaData('is_refund', is_refund)
// //        ..putMetaData('artisan_id', signController.currentUser.user.id)
// //        ..putMetaData('start_date', DateTime.now().toString())
//         ..reference = _getReference()
//       // or ..accessCode = _getAccessCodeFrmInitialization()
//         ..email = email;
//       CheckoutResponse response = await plugin.checkout(
//         context,
//         logo: Image.asset(
//           'assets/images/fixme.png',
//           scale: 5,
//         ),
//         method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
//         charge: charge,
//       );
//       if (response.status) {
//         network.validatePayment(response.reference);
//         print(response.reference);
//       }
//     }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Bank Account Details',
            style: TextStyle(
                color: Color(0xFF141414),
                fontSize: 21,
                height: 1.4,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.keyboard_backspace_outlined, color: Color(0xFF141414).withOpacity(0.35),),
        ),
        elevation: 0,
      ),
      body: Builder(
          builder: (context) {
            return accounts==null?Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: Color(0xFF00A85A),),
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A85A)),
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                      //  valueColor: new AlwaysStoppedAnimation<Color>(color: Color(0xFF9B049B)),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Loading',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            )):accounts!.isEmpty?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("No Account Available", style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    height: 1.4,
                    fontWeight: FontWeight.w500)),),
              ],
            ):ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:12.0,bottom: 15),
                      child: Text('Accounts', style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          height: 1.4,
                          fontWeight: FontWeight.w500)),
                    ),

                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: accounts!.length,
                    itemBuilder: (context, index) {
                      return  Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading
                                  : CircleAvatar(
                                backgroundColor: Color(0xFF270F33)
                                    .withOpacity(0.6),
                                child: Text(
                                    accounts![index].bankname.toString()
                                        .substring(0, 1),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              subtitle:  Center(
                                child: Text(accounts![index].accountnumber.toString(),style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                )),
                              ),
                              title:  Column(
                                children: [
                                  Text(accounts![index].accountname.toString().capitalize(),style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                  )),

                                  Text(accounts![index].bankname.toString().capitalize(),style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15
                                  )),
                                ],
                              ),
                              // leading: Text(accounts.toString(),style: TextStyle(
                              //     color: Colors.black,
                              //     fontFamily: 'Firesans',
                              //     fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      );

                    }
                ),
              ],
            );
          }
      ),
    );
  }}