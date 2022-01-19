import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/layout/constant.dart';
import 'package:loginsignup/layout/navigator.dart';
import 'package:loginsignup/screens/signin_admin.dart';
import 'package:loginsignup/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginsignup/screens/timeline.dart';
import 'package:loginsignup/screens/feed.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String errormsg;
  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: whiteshade,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45))),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.09),
                    child: Image.asset("assets/images/login.jpg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Username",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                    child: TextFormField(
                      controller: myController,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter username';
                        return null;
                      },
                      style: new TextStyle(fontSize: 12.0),
                      decoration: new InputDecoration(
                          fillColor: Colors.black26,
                          filled: true,
                          hintText: 'Enter Username',
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 10.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text("Password",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                    child: TextFormField(
                      obscureText: true,
                      controller: myController2,
                      autofocus: false,
                      validator: (value) {
                        RegExp regExp = RegExp(r'^.{8,}$');
                        if (value == null || value.isEmpty)
                          return ("Please enter your password");
                        return null;
                      },
                      style: new TextStyle(fontSize: 12.0),
                      decoration: new InputDecoration(
                          fillColor: Colors.black26,
                          filled: true,
                          hintText: 'Enter Password',
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 10.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CheckerBox(),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: red.withOpacity(0.75),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        MyNavigator.gofeed(context);
                      }
                      print(myController.text);
                      print(myController2.text);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: red,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text.rich(TextSpan(
                          text: "Sign in",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: whiteshade),
                        )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.149,
                        top: MediaQuery.of(context).size.height * 0.01),
                    child: Text.rich(
                      TextSpan(
                          text: "Don't Have An Account? ",
                          style: TextStyle(
                              color: grayshade.withOpacity(0.8), fontSize: 16),
                          children: [
                            TextSpan(
                                text: "Sign Up",
                                style: TextStyle(color: red, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                    print("Sign Up click");
                                  }),
                          ]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.149,
                    ),
                    child: Text.rich(
                      TextSpan(
                          text: "Sign in As Admin",
                          style: TextStyle(color: red, fontSize: 16),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SigninAdmin()));
                              print("Sign Up click");
                            }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckerBox extends StatefulWidget {
  const CheckerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckerBox> createState() => _CheckerBoxState();
}

class _CheckerBoxState extends State<CheckerBox> {
  bool? isCheck;
  @override
  void initState() {
    // TODO: implement initState
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              value: isCheck,
              checkColor: whiteshade, // color of tick Mark
              activeColor: blue,
              onChanged: (val) {
                setState(() {
                  isCheck = val!;
                  print(isCheck);
                });
              }),
          Text.rich(
            TextSpan(
              text: "Remember me",
              style: TextStyle(color: grayshade.withOpacity(0.8), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

