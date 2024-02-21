import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartwashvender/Screens/Auth/signUpScreen.dart';
import '../../Api Services/allApiscreen.dart';
import '../../Custom Widget/costomTextfield.dart';
import '../../Helper/app_colors.dart';
import '../../Model/signinModel.dart';
import 'package:http/http.dart' as http;
import '../homepage/homePageScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 230,
                  width: 375,
                  child: Center(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 150,
                        width: 195,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CustomTextField(
                    maxleanthh: 40,
                    controller: emailAndFone,
                    hintt: 'Enter Email Id',
                    validation: 'Please Enter Email Id'),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    maxleanthh: 15,
                    controller: password,
                    hintt: 'Enter Password',
                    validation: 'Please Enter Password'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.gold // Background color
                        ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = false;
                        });
                        loginApi();
                        Future.delayed(
                          Duration(seconds: 5),
                          () {
                            setState(() {
                              _isLoading = true;
                            });
                          },
                        );
                      }
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: _isLoading == false
                                ? Text('Waiting....')
                                : Text('Login')))),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have An Account? ",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailAndFone = TextEditingController();
  TextEditingController password = TextEditingController();

  SigninModel? signinModel;

  Future<void> loginApi() async {
    print('login api=============================');
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiService.UserLoginApiUrl));
    request.fields
        .addAll({'email': emailAndFone.text, 'password': password.text});
    print('============${request.fields}');
    print('============${request.url}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("result==================${result}");

      var finalResult1 = jsonDecode(result);

      if (finalResult1['message'] == "Log In Successfull") {
        print('login success================');

        var finalResult2 = SigninModel.fromJson(jsonDecode(result));

        setState(() {
          signinModel = finalResult2;
          loopForService();
          if (signinModel?.data.user.serviceP == 1) {
            selectServiceType = 'Pickup/Drop';
          } else if (signinModel?.data.user.serviceP == 2) {
            selectServiceType = 'On Shop';
          } else {
            selectServiceType = 'Both';
          }

          print("services in side api=========${getAllServices}");
          print(
              "image patth=========${signinModel?.data.user.profilePhotoPath}");
          print("selectServiceType in side api=========${selectServiceType}");
          print(
              "dateOfBirth in side api=========${signinModel?.data.user.dateOfBirth}");
          print("token in side api=========${signinModel?.data.access.token}");

          setPreference(
            signinModel?.data.user.id ?? '',
            signinModel?.data.user.firstName ?? '',
            signinModel?.data.user.lastName ?? '',
            signinModel?.data.user.name ?? '',
            signinModel?.data.user.email ?? '',
            signinModel?.data.user.mobile ?? '',
            signinModel?.data.user.gender ?? '',
            signinModel?.data.user.address ?? '',
            signinModel?.data.user.profilePhotoPath ?? '',
            signinModel?.data.user.dateOfBirth ?? '',
            signinModel?.data.access.token ?? '',
            selectServiceType ?? '',
            getAllServices ?? '',
          );
        });
        Fluttertoast.showToast(msg: finalResult1['message']);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        Fluttertoast.showToast(msg: finalResult1['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  var selectServiceType;
  var getAllServices;
  List selectServiceList = [];
  void loopForService() {
    int loop;
    for (loop = 0; loop < signinModel!.data.user.services.length; loop++) {
      setState(() {
        var selectVal = signinModel!.data.user.services[loop].name;
        selectServiceList.add(selectVal);
        // getAllServices=isSelected.join(',');
        getAllServices = selectServiceList.join(',');
        print('raj');
        print(selectServiceList);
        print('==============${getAllServices}');
      });
    }
  }

  Future<void> setPreference(
    String iddd,
    String firstNamee,
    String lastNamee,
    String namee,
    String emaill,
    String mobilee,
    String genderr,
    String addresss,
    String profilePhotoPathh,
    String dateOfBirthh,
    String authToken,
    String serviceTpe,
    String servicess,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('venderId', iddd);
    await prefs.setString('firstName', firstNamee);
    await prefs.setString('lastName', lastNamee);
    await prefs.setString('name', namee);
    await prefs.setString('emait', emaill);
    await prefs.setString('mobileNumber', mobilee);
    await prefs.setString('gender', genderr);
    await prefs.setString('address', addresss);
    await prefs.setString('imageFile', profilePhotoPathh);
    await prefs.setString('dateOfBirth', dateOfBirthh);
    await prefs.setString('authToken', authToken);
    await prefs.setString('serviceType', serviceTpe);
    await prefs.setString('service', servicess);
  }
}
