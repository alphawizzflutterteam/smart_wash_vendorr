import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PassRecovery extends StatefulWidget {
  const PassRecovery({super.key});

  @override
  State<PassRecovery> createState() => _PassRecoveryState();
}

class _PassRecoveryState extends State<PassRecovery> {
  final _key = GlobalKey<FormState>();
  final TextEditingController ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/top_bg.png',
                ),
              ),
            ),
            height: 230,
          ),
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color(0xFFF7F7F7).withOpacity(0.5),
                  Color(0xFFF7F7F7),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Recover Password",
                      style: TextStyle(
                        color: Color(0xFF001733),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Enter your Email to recover your password.",
                      style: TextStyle(
                        color: Color(0xFF001733),
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: ctrl,
                      decoration: InputDecoration(
                        isDense: false,
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: const TextStyle(
                            color: Color(0xFF001733), fontSize: 16),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(color: Color(0xFF001733)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide:
                              const BorderSide(color: Color(0xFF001733)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide:
                              const BorderSide(color: Color(0xFF001733)),
                        ),
                        hintText: 'Enter Email',
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide:
                              const BorderSide(color: Color(0xFF001733)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email address';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            Fluttertoast.showToast(
                                msg:
                                    'Email has been sent with password reset link');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(double.maxFinite, 40)),
                        child: Text(
                          'Send',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
