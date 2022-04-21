import 'dart:io';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:newmap/Model/Bank.dart';
import 'package:newmap/Provider/BankProvider.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Screen/SignUp_Login/finalUserRegister.dart';
import 'package:newmap/Screen/Wallet/AirtimeDetails.dart';
import 'package:newmap/Service/Network.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:provider/provider.dart';

class BankDetails extends StatefulWidget {
  var agent;
  BankDetails({this.agent});
  @override
  _WalletAddCardState createState() => _WalletAddCardState();
}

class _WalletAddCardState extends State<BankDetails> {
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
                Container(
                  width: 200,
                  height: 40,
                  margin:
                  const EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF00A85A),) ,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.transparent,
                  ),
                  child: new FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () async {
                      AddNewCard(context);

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add New Account',
                            style: TextStyle(
                                color: Color(0xFF00A85A),
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(child: Text("No Account Available", style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    height: 1.4,
                    fontWeight: FontWeight.w500)),),
              ],
            ):accounts![0].accountname=='network'?Container(
              child:   Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("No Network Available", style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      height: 1.4,
                      fontWeight: FontWeight.w500)),
                  TextButton.icon(onPressed: (){
                    setState(() {
                      accounts = null;
                      callaccount(context);
                    });
                  }, icon: Icon(Icons.refresh, color: Color(0xFF00A85A),),
                      label: Text('Refresh', style: TextStyle(color: Color(0xFF00A85A)),))
                ],
              ),),
            ):

            ListView(
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
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 190,
                        height: 38,
                        margin:
                        const EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF00A85A),) ,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.transparent,
                        ),
                        child: new FlatButton(
                          padding: EdgeInsets.all(10),
                          onPressed: () async {

                          AddNewCard(context);

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7, right: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add New Account',
                                  style: TextStyle(
                                      color:Color(0xFF00A85A),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  itemCount: accounts!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return AirtimeDetails(bank: true, info: accounts![index], title: null,);
                                },
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),

                            );
                          },
                          child: Card(
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
                                Divider(),

                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(5),
                                        onPressed: () async {
                                          network.deleteAccount(context, accounts![index].id).then((value){
                                            setState(() {
                                              callaccount(context);
                                              print('lll');
                                            });
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 7, right: 7),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Delete Account',
                                                style: TextStyle(
                                                    color:Colors.red,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(5),
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return AirtimeDetails(bank: true, info: accounts![index], title: null, agent: widget.agent);
                                              },
                                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ),

                                          );


                                          //confirmDialog(accounts![index]);

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 7, right: 7),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Choose Account',
                                                style: TextStyle(
                                                    color:Color(0xFF00A85A),
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],
                    );

                  }
                ),
              ],
            );
          }
      ),
    );
  }

  //
  // amountDialog(data){
  //   TextEditingController amount = new TextEditingController();
  //   showModalBottomSheet(
  //       context: context,
  //       backgroundColor: Colors.transparent,
  //       isScrollControlled: true,
  //       builder: (builder){
  //         return ClipRRect(
  //           borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
  //           child: AnimatedPadding(
  //             padding: MediaQuery.of(context).viewInsets,
  //             duration: const Duration(milliseconds: 100),
  //             curve: Curves.decelerate,
  //             child: new StatefulBuilder(
  //                 builder: (context, setState) {
  //                   return new Padding(
  //                       padding: MediaQuery.of(context).viewInsets,
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
  //                         child: Container(
  //                           height: 200,
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.end,
  //                             children: [
  //
  //                               Align(
  //                                     alignment:Alignment.bottomCenter ,
  //                                     child: Container(
  //                                       decoration: BoxDecoration(
  //                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
  //                                           color: Colors.white
  //                                       ),
  //                                       height: 200.0,
  //                                       width: MediaQuery.of(context).size.width,
  //                                       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  //                                       child: Column(
  //                                         children: [
  //                                           Container(
  //                                             height: 6,
  //                                             width: 60,
  //                                             decoration: BoxDecoration(
  //                                                 borderRadius: BorderRadius.circular(9),
  //                                                 color: Color(0xFFE4E8E7)
  //                                             ),
  //                                           ),
  //
  //                                           Container(
  //                                             height: 55,
  //                                             alignment: Alignment.center,
  //                                             padding: const EdgeInsets.only(left: 12),
  //                                             margin:
  //                                             const EdgeInsets.only(bottom: 15, left: 12, right: 12, top: 15),
  //                                             decoration: BoxDecoration(
  //                                                 color: Color(0xFFFFFFFF),
  //                                                 // border: isAppEmpty ? Border.all(color: Colors.red) : null,
  //                                                 boxShadow: [
  //                                                   BoxShadow(
  //                                                       color: Color(0xFFF1F1FD),
  //                                                       blurRadius: 15.0,
  //                                                       offset: Offset(0.3, 4.0))
  //                                                 ],
  //                                                 borderRadius: BorderRadius.all(Radius.circular(7))),
  //                                             child: Row(
  //                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                               children: [
  //                                                 Padding(
  //                                                   padding: const EdgeInsets.only(right: 10),
  //                                                   child: Icon(
  //                                                     Icons.money,
  //                                                     color: Color(0xFF555555),
  //                                                     size: 20,
  //                                                   ),
  //                                                 ),
  //                                                 Expanded(
  //                                                   child: TextFormField(
  //                                                     inputFormatters: [CreditCardNumberInputFormatter()],
  //                                                     keyboardType: TextInputType.number,
  //                                                     style: TextStyle(
  //                                                         fontFamily: 'Firesans',
  //                                                         fontSize: 16,
  //                                                         color: Color(0xFF270F33),
  //                                                         fontWeight: FontWeight.w600),
  //                                                     controller: amount,
  //                                                     decoration: InputDecoration.collapsed(
  //                                                       hintText: 'Enter Amount',
  //                                                       hintStyle: TextStyle(
  //                                                           fontFamily: 'Firesans',
  //                                                           fontSize: 16,
  //                                                           fontWeight: FontWeight.w600),
  //                                                       focusColor: Color(0xFF2B1137),
  //                                                       fillColor: Color(0xFF2B1137),
  //                                                       hoverColor: Color(0xFF2B1137),
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                           Padding(
  //                                             padding: const EdgeInsets.only(top:10.0, left: 20, right:20),
  //                                             child: ElevatedButton(
  //                                               style:  ButtonStyle(
  //                                                   backgroundColor: MaterialStateProperty.all(Color(0xFF00A85A)),
  //                                                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                                                       RoundedRectangleBorder(
  //                                                         borderRadius: BorderRadius.circular(54.0),
  //                                                       )
  //                                                   )
  //                                               ),
  //
  //                                               child: Container(
  //                                                 width: 250,
  //                                                 height: 55,
  //                                                 alignment: Alignment.center,
  //                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
  //                                                 child: Text('Continue'),
  //                                               ),
  //                                               onPressed: () {
  //                                                 Navigator.pop(context);
  //                                                 confirmDialog(data, amount.text);
  //                                               },
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //
  //                                     ),
  //                                   ),
  //                             ],
  //                           ),
  //                         ),
  //                       ));}),
  //           ),
  //         );
  //       }
  //   );
  // }




  confirmDialog(data, amount){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder){
          return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: new StatefulBuilder(
                  builder: (context, setState) {
                    return new Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                          child: Container(
                            height: 250,
                            child: Stack(
                              children: [
                               Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                                      color: Color(0xFF00A85A),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 250.0,
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(data.accountname,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
                                              Text(data.bankname,style: TextStyle( color: Colors.white, fontSize: 20)),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                ),
                                Align(
                                  alignment:Alignment.bottomCenter ,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                                        color: Colors.white
                                    ),
                                    height: 175.0,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 6,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(9),
                                              color: Color(0xFFE4E8E7)
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top:20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top:2.0, ),
                                                child: Container(
                                                  child: Text(data.accountnumber,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black54),),
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:10.0, left: 20, right:20),
                                          child: ElevatedButton(
                                            style:  ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Color(0xFF00A85A)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(54.0),
                                                    )
                                                )
                                            ),

                                            child: Container(
                                              width: 250,
                                              height: 55,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                                              child: Text('Confirm'),
                                            ),
                                            onPressed: () {
                                              var network = Provider.of<WebServices>(context, listen: false);
                                              // network.withdrawBank(data.id, amount).then((value){
                                              //
                                              // });
                                             // Navigator.pop(context);
                                              //
                                            // sendDialog();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));}),
            ),
          );
        }
    );
  }












  sendDialog(){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder){
          return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: new StatefulBuilder(
                  builder: (context, setState) {
                    return new Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                          child: Container(
                            color: Colors.transparent,
                            height: 260,
                            child: Stack(
                              children: [
                                Align(
                                  alignment:Alignment.bottomCenter ,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                                        color: Colors.white
                                    ),
                                    height: 230.0,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // SizedBox(
                                              //   width: MediaQuery.of(context).size.width*0.3,
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(top:25.0,),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width*0.8,
                                                  child: Text('Successful!',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 18,
                                                        color: Colors.black, fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top:20.0, left: 10),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*0.8,
                                            child: Text('Congrats,your account have been credited successfully.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),textAlign: TextAlign.center,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:10.0, left: 20, right:20),
                                          child: ElevatedButton(
                                            style:  ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Color(0xFF00A85A)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(54.0),
                                                    )
                                                )
                                            ),

                                            child: Container(
                                              width: 250,
                                              height: 55,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                                              child: Text('Home'),
                                            ),
                                            onPressed: () {

                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(100),
                                    elevation: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00A85A),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color:Colors.white,width: 10),
                                      ),
                                      height: 70,
                                      width: 70,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.phone , color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));}),
            ),
          );
        }
    );
  }









  List<BankInfo> result = [];
  void searchBank(userInputValue) {
    BankProvider postRequestProvider =
    Provider.of<BankProvider>(context, listen: false);
    result = postRequestProvider.allBankList
        .where((bank) => bank.name.toString()
        .toLowerCase()
        .contains(userInputValue.toLowerCase()))
        .toList();
  }


  bankDialog(ctx, set) {
    BankProvider postRequestProvider =
    Provider.of<BankProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {


              return AlertDialog(
                title: TextFormField(
                  onChanged: (value) {
                    setStates(() {
                      searchBank(value);
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Search Banks',
                    labelStyle: TextStyle(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(new Radius.circular(50.0)),
                  ),
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 500,
                          child: ListView.builder(
                            itemCount:  result.length,
                            itemBuilder: (context, index) {
                              result.sort((a, b) {
                                var ad = a.name;
                                var bd = b.name;
                                var s = ad!.compareTo(bd!);
                                return s;
                              });

                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  postRequestProvider
                                      .changeSelectedBank(result[index]);
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Color(0xFF270F33)
                                        .withOpacity(0.6),
                                    child: Text(
                                        result[index]
                                            .name.toString()
                                            .substring(0, 2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  title: Text('${result[index].name}',  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).then((v) {
      set(() {});
    });
  }




  AddNewCard(context) {
     String accountName = "";
    final formKey = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController();
    final TextEditingController controller1 = TextEditingController();
    WebServices network = Provider.of<WebServices>(context, listen: false);
    BankProvider postRequestProvider =
    Provider.of<BankProvider>(context, listen: false);
    return  showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, set) {
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:4.0,left: 8),
                            child: Icon(Icons.arrow_back_ios_sharp, color: Color(0xFF141414).withOpacity(0.35), size: 18, ),
                          ),
                          Text('Back', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 12, left: 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Add New Account", style: TextStyle(color: Color(0xFF353535),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:12.0, top: 0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Please enter your bank details to complete registration', style: TextStyle(color: Color(0xC2141414), fontSize: 15),)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0, bottom: 10,top:10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Bank'
                              '', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, ),
                        child: InkWell(
                          onTap: (){
                            result = postRequestProvider.allBankList;
                            bankDialog(context, set);
                            // set((){
                            //   print('');
                            // });
                          },
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              cursorColor: Color(0xC2141414),
                              enabled: false,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: postRequestProvider.selectedBank==null?"Select Bank":
                                postRequestProvider.selectedBank!.name,
                                hintStyle: TextStyle(color: Color(0xC2141414)),
                                focusColor: Color(0xC2141414),
                                border: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),

                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
                                ),
                                focusedBorder:UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Account Number', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20,),
                        child: TextFormField(
                          onChanged: (value)async{
                            if(postRequestProvider.selectedBank==null){
                              await showTextToast(
                                text: 'Please Select Bank.',
                                context: context,
                              );
                            }else{
                              if(value.length >= 10){
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                circularCustom(context);
                                network.getAccountName(postRequestProvider.selectedBank!.code, controller1.text, context,).then((value) {
                                  set(() {
                                    if(value == 'error'){
                                      controller1.text = "";
                                      accountName = "";
                                    }else {
                                      accountName = value;
                                    }
                                  });

                                });
                              }
                            }},
                          controller: controller1,
                          enabled: postRequestProvider.selectedBank==null?false:true,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'account number cannot be empty';
                            }
                          },
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          cursorColor: Color(0xC2141414),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: "Enter Destination Account",
                            hintStyle: TextStyle(color: Color(0xC2141414)),
                            focusColor: Color(0xC2141414),
                            border: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),

                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
                            ),
                            focusedBorder:UnderlineInputBorder(
                              borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
                            ),
                          ),
                        )),
                    // Padding(
                    //   padding: const EdgeInsets.only(left:20.0, bottom: 10),
                    //   child: Align(
                    //       alignment: Alignment.bottomLeft,
                    //       child: Text('Account Name', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    // ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20,),
                        child:  accountName.isEmpty
                        ?Container():ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFF270F33)
                                .withOpacity(0.6),
                            child: Text(
                                accountName.toString()
                                    .substring(0, 2),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                          title: Text('${accountName}',  style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:30.0, left: 20, right:20),
                      child: ElevatedButton(
                        style:  ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF00A85A)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(54.0),
                                )
                            )
                        ),

                        child: Container(
                          width: 250,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                          child: Text('Add Account'),
                        ),
                        onPressed: () async{
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (formKey.currentState!.validate()) {
                            if(postRequestProvider.selectedBank==null){
                              await showTextToast(
                                text: 'please select your bank.',
                                context: context,
                              );
                            }else {
                              circularCustom(context);
                              network.AddBank(
                                acccode: postRequestProvider.selectedBank!.code,
                                accname: accountName,
                                context: context,
                                accnum: controller1.text,
                                bankname: postRequestProvider.selectedBank!.name,
                              ).then((value) {
                if(value == 'true'){
                  setState(() {
                    callaccount(context);
                    print('lll');
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                  showTextToast(
                    text: 'Account Added.',
                    context: context,
                  );
                }



                              });
                            }

                          }
                        },
                      ),
                    ),


                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }






}












