import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:newmap/Screen/SignUp_Login/SignIn.dart';
import 'package:newmap/Screen/SignUp_Login/finalUserRegister.dart';
import 'package:newmap/Service/Network.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:provider/provider.dart';

class EditUserRegsiter extends StatefulWidget {
  const EditUserRegsiter({Key? key}) : super(key: key);

  @override
  _EditUserRegsiterState createState() => _EditUserRegsiterState();
}

class _EditUserRegsiterState extends State<EditUserRegsiter> {
  String initialCountry = 'NG';
  final formKey = GlobalKey<FormState>();

  // PhoneNumber number = PhoneNumber(isoCode: 'NG', phoneNumber: '098765432');
  @override
  Widget build(BuildContext context) {
    WebServices network = Provider.of<WebServices>(context, listen: false);
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
                child: Text("Edit Account",
                    style: TextStyle(
                        color: Color(0xFF353535),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Name',
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
                  onChanged: (value) {
                    network.editname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name cannot be empty';
                    }
                    network.editname = value;

                  },
                  initialValue: network.firstname,
                  cursorColor: Color(0xC2141414),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: "Name",
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
            // Padding(
            //   padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 30),
            //   child: Align(
            //       alignment: Alignment.bottomLeft,
            //       child: Text('Email', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
            // ),
            // Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 20,),
            //     child: TextFormField(
            //       initialValue: network.myemail,
            //       cursorColor: Color(0xC2141414),
            //       decoration: InputDecoration(
            //         isCollapsed: true,
            //         hintText: "example@gmail.com",
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
              padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 30),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Phone Number'
                    '',
                    style: TextStyle(
                      color: Color(0xFF141414).withOpacity(0.35),
                    ),
                  )),
            ),
            Builder(builder: (context) {
              PhoneNumber number = PhoneNumber(
                  isoCode: 'NG', phoneNumber: network.myphonenumber);
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                    network.editphone = number.phoneNumber!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'phone number cannot be empty';
                    }
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  initialValue: number,

                  formatInput: false,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: InputBorder.none,
                  // inputBorder: UnderlineInputBorder(
                  //             borderSide: const BorderSide(color: Color(0x59141414), width: 2.0),
                  //
                  //           ),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Color(0xC2141414),
                thickness: 0.3,
              ),
            ),
            // Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 20, ),
            //     child: TextFormField(
            //       cursorColor: Color(0xC2141414),
            //       decoration: InputDecoration(
            //         prefixIcon: Card(
            //           margin: const EdgeInsets.only(right: 8.0, bottom: 10),
            //           child: Icon(Icons.credit_card),
            //         ),
            //         prefixIconConstraints: BoxConstraints(
            //                          minHeight: 0,
            //                          minWidth: 0,
            //                        ),
            //         isCollapsed: true,
            //         hintText: "08012345678",
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
            // Padding(
            //   padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 30),
            //   child: Align(
            //       alignment: Alignment.bottomLeft,
            //       child: Text('Password', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
            // ),
            // Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 20,),
            //     child: TextFormField(
            //       initialValue: network.p,
            //       obscureText: true,
            //       cursorColor: Color(0xC2141414),
            //       decoration: InputDecoration(
            //         isCollapsed: true,
            //         hintText: "************",
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(54.0),
                    ))),
                child: Container(
                  width: 250,
                  height: 55,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: Text('Save'),
                ),
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (formKey.currentState!.validate()) {
                    circularCustom(context);
                    network.editUser(
                      context: context,
                      phonenumber: network.editphone,
                      firstname: network.editname,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
