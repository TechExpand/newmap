

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:newmap/Provider/Utils.dart';
import 'package:newmap/Service/Network.dart';
import 'package:newmap/Widget/CustomCircular.dart';
import 'package:provider/provider.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({Key? key}) : super(key: key);

  @override
  _RecyclePageState createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  final TextEditingController weight = TextEditingController();
  final TextEditingController userId = TextEditingController();
 String ?category = '';
  final formKey = GlobalKey<FormState>();


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
                  child: Text("Recycle", style: TextStyle(color: Color(0xFF353535),
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
                padding: const EdgeInsets.only(left:20.0, bottom: 10,),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('Weight in Kg', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,),
                  child: TextFormField(
                  keyboardType  : TextInputType.number,
                    controller: weight,
                    cursorColor: Color(0xC2141414),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Weight cannot be empty';
                      }
                    },
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: "Enter Weight",
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

              Padding(
                padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 30),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('Category', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,),
                child: StatefulBuilder(
                  builder: (context, setStat) {
                    return DropdownButton<String>(
                          items: <String>['Metal', 'Plastic',].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint:   Text(category.toString().isEmpty?'Select Category':category.toString(), style: TextStyle(color: Colors.black),),
                          onChanged: (value) {
                            setStat((){
                              category = value;
                            });
                          },
                        );
                  }
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:20.0, bottom: 10, top: 30),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('User ID', style: TextStyle(color: Color(0xFF141414).withOpacity(0.35),),)),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'User ID cannot be empty';
                      }
                    },
                    controller: userId,
                    keyboardType  : TextInputType.text,
                    cursorColor: Color(0xC2141414),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: "Enter ID",
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
                    child: Text('Next'),
                  ),
                  onPressed: ()async{
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if(formKey.currentState!.validate()){

                      if(category.toString().isEmpty){
                        await showTextToast(
                            text: 'please select a category',
                            context: context,
                        );
                      }else{

                      circularCustom(context);
                      network.confirmUsers(weight.text, userId.text).then((value){
                        Navigator.pop(context);
                        confirmDialog(value);

                      });
                    }}

                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }




  confirmDialog(value){
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
                                                  Text('${value['email']}',style: TextStyle( color: Colors.white)),
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
                                                    child: Text("₦${value['amount']}",
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
                                              network.sendTransaction(category, weight.text, userId.text, context);
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
  }}
