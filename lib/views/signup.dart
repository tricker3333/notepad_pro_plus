import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notepad_pro_plus/views/login.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpPg extends StatefulWidget {
  const SignUpPg({super.key});

  @override
  State<SignUpPg> createState() => _SignUpPgState();
}

class _SignUpPgState extends State<SignUpPg> {
  final TextEditingController _emailctrl = TextEditingController();
  final TextEditingController _phonectrl = TextEditingController();
  final TextEditingController _userctrl = TextEditingController();
  final TextEditingController _passctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: 'Note Pro Plus'.text.white.bold.xl4.make(),
        actions: const [Icon(Icons.more_vert_rounded)],
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
                child: Lottie.asset('assets/lottieanime/signup.json'),
              )),
              TextField(
                controller: _userctrl,
                decoration: const InputDecoration(
                  hintText: "UserName",
                  suffixIcon: Icon(Icons.supervised_user_circle_sharp),
                  suffixIconColor: Colors.indigo,
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailctrl,
                decoration: const InputDecoration(
                  hintText: "Email",
                  suffixIcon: Icon(Icons.email),
                  suffixIconColor: Colors.indigo,
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _phonectrl,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  suffixIcon: Icon(Icons.call),
                  suffixIconColor: Colors.indigo,
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passctrl,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.remove_red_eye),
                    suffixIconColor: Colors.indigo,
                    border: UnderlineInputBorder(),
                    hintText: "Passoward"),
              ),
              const SizedBox(
                height: 30,
              ),
              CupertinoButton.filled(
                  child: const Text("Sign In"),
                  onPressed: () async {
                    var userName = _userctrl.text.toString().trim();
                    var userEmail = _emailctrl.text.toString().trim();
                    var userPhone = _phonectrl.text.toString().trim();
                    var userPass = _passctrl.text.toString().trim();

                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: userEmail,
                        password: userPass,
                      );
                      
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                      } else if (e.code == 'email-already-in-use') {
                      }
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const LoginPg());
                  },
                  child: const Text('Already Have Account')),
            ],
          ),
        ),
      ),
    );
  }
}
