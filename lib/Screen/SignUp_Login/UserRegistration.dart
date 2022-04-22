import 'dart:io';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:newmap/Model/Bank.dart';
import 'package:newmap/Model/LGA.dart';
import 'package:newmap/Provider/BankProvider.dart';
import 'package:newmap/Provider/LGAProvider.dart';
import 'package:newmap/Provider/Provider.dart';
import 'package:newmap/Screen/SignUp_Login/SignInUserAgent.dart';
import 'package:newmap/Service/Location.dart';
import 'package:newmap/Service/Network.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:newmap/Widget/powered.dart';
import 'package:provider/provider.dart';

import 'SignIn.dart';

class UserRegsiter extends StatefulWidget {
  const UserRegsiter({Key? key}) : super(key: key);

  @override
  _UserRegsiterState createState() => _UserRegsiterState();
}

class _UserRegsiterState extends State<UserRegsiter> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final formKey = GlobalKey<FormState>();
  bool accept = false;

  @override
  Widget build(BuildContext context) {
    BankProvider postRequestProvider =
    Provider.of<BankProvider>(context, listen: false);
    LocationService location = Provider.of<LocationService>(context, listen: false);
    DataProvider provide = Provider.of<DataProvider>(context, listen: false);
    WebServices network =
    Provider.of<WebServices>(context, listen: false);
    return Scaffold(body: Stack(
      children: [
        StatefulBuilder(
              builder: (context, set) {
                return  Container(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 50,
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
                        child: Text("Create User Account", style: TextStyle(color: Color(0xFF353535),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:12.0, top: 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                          child: Text('Please enter your details to create account', style: TextStyle(color: Color(0xC2141414), fontSize: 15),)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('First Name', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                     Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: TextFormField(
                        onChanged: (value){
                          provide.firstname = value;
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'First Name cannot be empty';
                          }
                        },
                        cursorColor: Color(0xC2141414),
                         decoration: InputDecoration(
                           isCollapsed: true,
                           hintText: "First Name",
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
 SizedBox(
                      height: 20,
                    ),

                      Padding(
                      padding: const EdgeInsets.only(left:20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Last Name', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: TextFormField(
                        onChanged: (value){
                          provide.lastname = value;
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Last Name cannot be empty';
                          }
                        },
                        cursorColor: Color(0xC2141414),
                         decoration: InputDecoration(
                           isCollapsed: true,
                           hintText: "Last Name",
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
                    Padding(
                      padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 20),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('L.G.A', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, ),
                        child: InkWell(
                          onTap: (){

                            result = postRequestProvider.allLga;
                            lgaDialog(context, set);
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
                                hintText: postRequestProvider.selectedLga==null?"Select L.G.A":
                                postRequestProvider.selectedLga!.name,
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
                      padding: const EdgeInsets.only(left:20.0, bottom: 10, ),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Email', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20,),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value){
                            provide.email = value;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return 'email cannot be empty';
                            }else if(!value.contains('@') || !value.contains('.com')){
                              return 'please enter a valid email';
                            }
                          },
                          cursorColor: Color(0xC2141414),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: "example@gmail.com",
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
                    Padding(
                      padding: const EdgeInsets.only(left:20.0, bottom: 10,top:30),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Phone Number'
                              '', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                          provide.phone = number.phoneNumber.toString();
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        ignoreBlank: false,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'phone number cannot be empty';
                          }
                        },
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: false,
                        keyboardType:
                        TextInputType.numberWithOptions(signed: true, decimal: true),
                        inputBorder: InputBorder.none,
                        // inputBorder: UnderlineInputBorder(
                        //             borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
                        //
                        //           ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: Color(0xC2141414), thickness: 0.3,),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 30),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Password', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20,),
                        child: TextFormField(
                          onChanged: (value){
                            provide.password = value;
                          },
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'password cannot be empty';
                            }else if(value.length <= 5){
                              return 'password length must be greater than 5';
                            }
                          },
                          cursorColor: Color(0xC2141414),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: "************",
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
                          child: Text('Continue'),
                        ),
                        onPressed: () async{
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if(formKey.currentState!.validate()){
                            if(!accept){
                              await showTextToast(
                                text: 'accept our terms and conditions to continue.',
                                context: context,
                              );
                            }else{
                              circularCustom(context);
                              network.registerUser(
                                context: context,
                                firstname: provide.firstname,
                                lastname: provide.lastname,
                                email: provide.email,
                                lga: postRequestProvider.selectedLga!.id.toString(),
                                latitude: location.location_latitude.toStringAsFixed(2),
                                longitude: location.location_longitude.toStringAsFixed(2),
                                password: provide.password,
                                phonenumber: provide.phone,
                              );

                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilder(
                              //     pageBuilder:
                              //         (context, animation, secondaryAnimation) {
                              //       return FinalUserRegsiter();
                              //     },
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       return FadeTransition(
                              //         opacity: animation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            }

                          }
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 20,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: Color(0xFFCCCBCB)),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Checkbox(
                                side: BorderSide(color: Color(0x59141414), width: 1),
                                checkColor: Color(0xFF00A85A),
                                activeColor: Colors.transparent,
                                value: accept,
                                onChanged: (value) {
                                  setState(() {
                                    accept = value!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                },
                                child: Center(
                                    child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                              text: 'By creating an account, you agree to our\n',
                                              style: TextStyle(color: Colors.black26, fontSize: 16)
                                          ),
                                          TextSpan(
                                            text: 'Terms and Conditions',
                                            style: TextStyle(color:  Color(0xFF00A85A),
                                              decoration: TextDecoration.underline,
                                              fontSize: 16,),

                                          )
                                        ])))),
                          ],
                        )),

                    Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 20),
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return SignInUserAgent(status: 'user');
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
                            child: Center(
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'Already have an account? ',
                                          style: TextStyle(color: Colors.black26, fontSize: 16)
                                      ),
                                      TextSpan(
                                          text: 'Sign in',
                                          style: TextStyle(color:  Color(0xFF00A85A), fontSize: 16)
                                      )
                                    ]))))),
                    poweredBy()
                  ],
                ),
              ),
            );
          }
        ),
        Platform.isIOS?Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black)),
        ):Container()
      ],
    ));
  }



  List<LGA> result = [];
  void searchBank(userInputValue) {
    BankProvider postRequestProvider =
    Provider.of<BankProvider>(context, listen: false);
    result = postRequestProvider.allLga
        .where((lga) => lga.name.toString()
        .toLowerCase()
        .contains(userInputValue.toLowerCase()))
        .toList();
  }


  lgaDialog(ctx, set) {
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
                    labelText: 'Search L.G.A',
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
                                      .changeSelectedLga(result[index]);
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

}
