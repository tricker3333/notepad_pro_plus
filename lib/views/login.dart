import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notepad_pro_plus/views/forgot.dart';
import 'package:notepad_pro_plus/views/home.dart';
import 'package:notepad_pro_plus/views/signup.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPg extends StatefulWidget {
  const LoginPg({super.key});

  @override
  State<LoginPg> createState() => _LoginPgState();
}

class _LoginPgState extends State<LoginPg> {
  final TextEditingController _emailctrl = TextEditingController();
  final TextEditingController _passctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: 'Login'.text.white.bold.xl2.make(),
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
                child: Lottie.asset('assets/lottieanime/loginanime.json'),
              )),
              TextField(
                controller: _emailctrl,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  suffixIconColor: Colors.indigo,
                  hintText: "Email",
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
                  child: const Text("Verify"),
                  onPressed: () async {
                    var email = _emailctrl.text.toString().trim();
                    var pass = _passctrl.text.toString().trim();
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email,
                        password: pass,
                      );

                      Get.off(() => HomePg());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Account Created Successfully")));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                      } else if (e.code == 'wrong-password') {}
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPg());
                  },
                  child: "Forgot Password".text.make()),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const SignUpPg());
                  },
                  child: const Text('Don \' Have Account')),
            ],
          ),
        ),
      ),
    );
  }
}
