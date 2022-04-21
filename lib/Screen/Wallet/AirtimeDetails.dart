import 'dart:io';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Screen/Agent/AgentTab.dart';
import 'package:newmap/Screen/User/Home/HomeTabs.dart';
import 'package:newmap/Service/Network.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:provider/provider.dart';

class AirtimeDetails extends StatefulWidget {
  var bank;
  var info;
  var title;
  var gift;
  var agent;
  AirtimeDetails({this.bank, this.title, this.info, this.gift, this.agent});

  @override
  _AirtimeState createState() => _AirtimeState();
}

class _AirtimeState extends State<AirtimeDetails> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController userId = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  String? category = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    checkNetworkID(value) {
      if (value == 'MTN') {
        return 1;
      } else if (value == 'GLO') {
        return 2;
      } else if (value == '9MOBILE') {
        return 3;
      } else if (value == 'AIRTEL') {
        return 4;
      }
    }

    String _getReference() {
      String platform;
      if (Platform.isIOS) {
        platform = 'iOS';
      } else {
        platform = 'Android';
      }
      return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
    }

    return Scaffold(
      body: Container(
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
                onTap: () {
                  Navigator.pop(context);
                },
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, left: 8),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Color(0xFF141414).withOpacity(0.35),
                        size: 18,
                      ),
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Color(0xFF141414).withOpacity(0.35),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 12, left: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      "${widget.bank == true ? "Bank Withdraw" :widget.gift ==true?"Gift Point": "Airtime Withdraw"}",
                      style: TextStyle(
                          color: Color(0xFF353535),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left:20.0, bottom: 10),
              //   child: Align(
              //       alignment: Alignment.bottomLeft,
              //       child: Text('Item', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
              // ),
              // Container(
              //     margin: const EdgeInsets.symmetric(horizontal: 20,),
              //     child: TextFormField(
              //       cursorColor: Color(0xC2141414),
              //       decoration: InputDecoration(
              //         isCollapsed: true,
              //         hintText: "Item",
              //         hintStyle: TextStyle(color: Color(0xC2141414)),
              //         focusColor: Color(0xC2141414),
              //         border: UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //
              //         ),
              //         focusedErrorBorder: UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //         ),
              //         focusedBorder:UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //         ),
              //       ),
              //     )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 10,
                ),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Amount',
                      style: TextStyle(
                        color: Color(0xFF141414).withOpacity(0.35),
                      ),
                    )),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amount,
                    cursorColor: Color(0xC2141414),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Amount cannot be empty';
                      }
                    },
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(color: Color(0xC2141414)),
                      focusColor: Color(0xC2141414),
                      border: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x59141414), width: 2.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x59141414), width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x59141414), width: 2.0),
                      ),
                    ),
                  )),

              widget.gift != true
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 10, top: 30),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'User ID',
                            style: TextStyle(
                              color: Color(0xFF141414).withOpacity(0.35),
                            ),
                          )),
                    ),
              widget.gift != true
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: userId,
                        cursorColor: Color(0xC2141414),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'User ID cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "Enter User ID",
                          hintStyle: TextStyle(color: Color(0xC2141414)),
                          focusColor: Color(0xC2141414),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                        ),
                      )),

              widget.bank != true && widget.gift != true
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 10, top: 30),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Phone Number',
                            style: TextStyle(
                              color: Color(0xFF141414).withOpacity(0.35),
                            ),
                          )),
                    )
                  : Container(),
              widget.bank != true && widget.gift != true
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: mobileNumber,
                        cursorColor: Color(0xC2141414),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "Enter Phone Number",
                          hintStyle: TextStyle(color: Color(0xC2141414)),
                          focusColor: Color(0xC2141414),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x59141414), width: 2.0),
                          ),
                        ),
                      ))
                  : Container(),
              // Padding(
              //   padding: const EdgeInsets.only(left:20.0, bottom: 10,top:30),
              //   child: Align(
              //       alignment: Alignment.bottomLeft,
              //       child: Text('Worth in Naira'
              //           '', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
              // ),
              // Container(
              //     margin: const EdgeInsets.symmetric(horizontal: 20, ),
              //     child: TextFormField(
              //       enabled: false,
              //       cursorColor: Color(0xC2141414),
              //       decoration: InputDecoration(
              //         isCollapsed: true,
              //         hintText: "₦20,000",
              //         hintStyle: TextStyle(color: Color(0xC2141414)),
              //         focusColor: Color(0xC2141414),
              //         border: UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //
              //         ),
              //         focusedErrorBorder: UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //         ),
              //         focusedBorder:UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //         ),
              //       ),
              //     )),

              widget.bank != true && widget.gift != true
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 10, top: 30),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Network',
                            style: TextStyle(
                              color: Color(0xFF141414).withOpacity(0.35),
                            ),
                          )),
                    )
                  : Container(),
              widget.bank != true && widget.gift != true
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: StatefulBuilder(builder: (context, setStat) {
                        return DropdownButton<String>(
                          items: <String>[
                            'MTN',
                            'AIRTEL',
                            'GLO',
                            '9MOBILE',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            category.toString().isEmpty
                                ? 'Select Network'
                                : category.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          onChanged: (value) {
                            setStat(() {
                              category = value;
                            });
                          },
                        );
                      }),
                    )
                  : Container(),

              // Padding(
              //   padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 30),
              //   child: Align(
              //       alignment: Alignment.bottomLeft,
              //       child: Text('User ID', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
              // ),
              // Container(
              //     margin: const EdgeInsets.symmetric(horizontal: 20,),
              //     child: TextFormField(
              //       validator: (value){
              //         if(value!.isEmpty){
              //           return 'User ID cannot be empty';
              //         }
              //       },
              //       controller: userId,
              //       keyboardType  : TextInputType.number,
              //       cursorColor: Color(0xC2141414),
              //       decoration: InputDecoration(
              //         isCollapsed: true,
              //         hintText: "Enter ID",
              //         hintStyle: TextStyle(color: Color(0xC2141414)),
              //         focusColor: Color(0xC2141414),
              //         border: UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //
              //         ),
              //         focusedErrorBorder: UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //         ),
              //         focusedBorder:UnderlineInputBorder(
              //           borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
              //         ),
              //       ),
              //     )),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF00A85A)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(54.0),
                        ))),
                    child: Container(
                      width: 250,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40)),
                      child: Text('Next'),
                    ),
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      if (formKey.currentState!.validate()) {
                        if (widget.bank != true) {
                          if (widget.gift == true) {
                            print('bdbdbdd');
                            WebServices network = Provider.of<WebServices>(context, listen: false);
                            circularCustom(context);
                            network.confirmUsers(amount.text, userId.text).then((value){
                              Navigator.pop(context);
                              confirmDialog(value,amount.text );

                            });
                          } else {
                            if (category.toString().isEmpty) {
                              await showTextToast(
                                text: 'please select a category',
                                context: context,
                              );
                            } else {
                              if (int.parse(amount.text.toString()) < 100) {
                                await showTextToast(
                                  text: 'Minimum amount to recharge is NGN 100',
                                  context: context,
                                );
                              } else {
                                var getNetworkID = checkNetworkID(category);
                                var network = Provider.of<WebServices>(context,
                                    listen: false);
                                var getTranref = _getReference();
                                 circularCustom(context);
                                // sendDialogs(context);
                                network.withdrawAirtime(
                                  widget.agent,
                                    getNetworkID,
                                    amount.text,
                                    category,
                                    getTranref,
                                    mobileNumber.text,
                                    context);
                                //   Navigator.pop(context);
                                //   confirmDialog(value);
                                //
                                // });
                              }
                            }
                          }
                        }else {
                        if (int.parse(amount.text.toString()) < 100) {
                          await showTextToast(
                            text: 'Minimum amount to withdraw is NGN 100',
                            context: context,
                          );
                        } else {
                          var network =
                              Provider.of<WebServices>(context, listen: false);
                          print('jsjjs');
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          circularCustom(context);
                          network.withdrawBank(
                              widget.agent,
                              widget.info.id, amount.text, context);
                        }
                      }
                    }}),
              ),
            ],
          ),
        ),
      ),
    );
  }





  confirmDialog(value, amount){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled:value=='Not found'?false: true,
        builder: (builder){
          return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: new StatefulBuilder(
                  builder: (conte, setState) {
                    return new Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                          child: value=='Not found'? Align(
                            alignment:Alignment.bottomCenter ,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                                  color: Colors.white
                              ),
                              height: 150.0,
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
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only( left: 10),
                                          child: Container(
                                            child: Text("No User Match",
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),


                                ],
                              ),

                            ),
                          ):Container(
                            height: 250,
                            child: Stack(
                              children: [
                                Align(
                                  alignment:Alignment.bottomCenter ,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                                      color: Color(0xFF00A85A),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 250.0,
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(value['fullname'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                              Text(value['email'], style: TextStyle( color: Colors.white),),
                                            //  Text('ID ${value['id']}',style: TextStyle( color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right:5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white54,
                                                  borderRadius: BorderRadius.circular(100)),
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: (){
                                                    var datas = Provider.of<Utils>(context, listen: false);
                                                    datas.makePhoneCall(value['phonenumber']);
                                                  },
                                                  icon: Icon(Icons.phone , color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only( left: 10),
                                                child: Container(
                                                  child: Text("₦$amount",
                                                    style: TextStyle(
                                                        fontSize: 35,
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
                                              Navigator.pop(context);
                                             circularCustom(context);
                                             WebServices network = Provider.of<WebServices>(context, listen: false);
                                             network.giftPoint(widget.agent,userId.text, amount,  context);
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
}
