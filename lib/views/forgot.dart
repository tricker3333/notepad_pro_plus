import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notepad_pro_plus/views/login.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPg extends StatefulWidget {
  const ForgotPg({super.key});

  @override
  State<ForgotPg> createState() => _ForgotPgState();
}

class _ForgotPgState extends State<ForgotPg> {
  TextEditingController _emailctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: 'Forgot Password'.text.white.bold.xl2.make(),
        actions: [Icon(Icons.more_vert_rounded)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Image.asset('assets/lottieanime/mode1.png'),
              SizedBox(
                  child: Padding(
                padding: const EdgeInsets.all(40),
                child: Lottie.asset('assets/lottieanime/forgot.json'),
              )),
              TextField(
                controller: _emailctrl,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CupertinoButton.filled(
                  child: Text("Send Reset"),
                  onPressed: () async{
                    var _email = _emailctrl.text.toString().trim();
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _email)
                          .then((value) => {
                                ScaffoldMessenger(
                                    child: SnackBar(
                                  content: Text('We have Sent the Reset mail'),
                                )),
                               print("Email Reset Sent"),
                                Get.off(() => LoginPg()),
                              });
                    } on FirebaseAuthException catch (e) {
                      print('Error $e');
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    print('Don\'t Have Account tab Pressed');
                  },
                  child: Text('Don \' Have Account')),
            ],
          ),
        ),
      ),
    );
  }
}
