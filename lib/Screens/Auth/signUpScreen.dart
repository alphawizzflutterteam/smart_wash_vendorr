import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:smartwashvender/Screens/Auth/signin_screen.dart';
import '../../Api Services/allApiscreen.dart';
import '../../Custom Widget/costomTextfield.dart';
import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/getServiceModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var latee;
  var longaa;

  void selectImage() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 250,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Select Any One Option',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        pickImage(ImageSource.gallery);
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('Select From Gallery')),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        pickImage(
                          ImageSource.camera,
                        );
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('Select From Camera')),
                        ),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  File? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50, // You can adjust the image quality here
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  var latitude;
  var longitude;

  Position? currentLocation;

  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
    } else if (status.isGranted) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            latitude = currentLocation?.latitude;
            longitude = currentLocation?.longitude;
            print('long==============${longitude}');
            print('lat==============${latitude}');
          });
      });
      // print("LOCATION===" +currentLocation.toString());
    } else if (status.isPermanentlyDenied) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserCurrentLocation();
    getServices();
  }

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
                  height: 50,
                ),
                // SizedBox(
                //   height: 230,
                //   width: 375,
                //   child: Center(
                //     child: Hero(
                //       tag: 'logo',
                //       child: Image.asset(
                //         'assets/images/logo.png',
                //         height: 150,
                //         width: 195,
                //       ),
                //     ),
                //   ),
                // ),

                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        selectImage();
                      },
                      child:
                          //
                          // Container(
                          //   width:MediaQuery.of(context).size.width,
                          //   child: CircleAvatar(
                          //
                          //     backgroundColor: Color(0xff7F62B0),
                          //     radius: 60,
                          //     child: CircleAvatar(
                          //       backgroundColor: Colors.white,
                          //       radius: 57,
                          //       child: (selectedImage == null)
                          //           ? Center(child: Icon(Icons.person,size: 80,color: Colors.grey.shade400,))
                          //           : CircleAvatar( backgroundImage: FileImage(selectedImage!),radius: 55,),
                          //
                          //
                          //     ),
                          //   ),
                          // ),
                          //

                          CircleAvatar(
                        backgroundColor: AppColors.gray,
                        radius: 50,
                        child: Center(
                          child: selectedImage == null
                              ? ClipOval(
                                  child: Image.network(
                                  "https://cdn2.iconfinder.com/data/icons/lucid-generic/24/User_person_avtar_profile_picture_dp-512.png",
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                  height: 80.0,
                                ))
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: FileImage(selectedImage!),
                                  radius: 45,
                                ),
                        ),
                      ),
                    ),
                    selectedImage == null
                        ? InkWell(
                            onTap: () {
                              selectImage();
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxleanthh: 35,
                          controller: firstname,
                          hintt: 'Enter First Name',
                          validation: 'Please Enter First Name'),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxleanthh: 35,
                          controller: lastname,
                          hintt: 'Enter Last Name',
                          validation: 'Please Enter Last Name'),
                      SizedBox(
                        height: 8,
                      ),

                      TextFormField(
                        maxLength: 40,
                        controller: email,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText: 'Enter Email Id',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please enter an email address';
                          } else if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      //
                      // CustomTextField(
                      //   maxleanthh: 40,
                      //     controller: email,
                      //     hintt: 'Enter Email Id',
                      //     validation: 'Please Enter Email Id'),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: mobile,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText: 'Enter Mobile Number',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Mobile Number';
                          } else if (value.length < 10) {
                            return 'Please Enter Valid Mobile Number';
                          }
                        },
                      ),
                      //
                      // CustomTextField(
                      //   maxleanthh: 10,
                      //     controller: mobile,
                      //     hintt: 'Enter Mobile Number',
                      //     validation: 'Please Enter Mobile Number'),
                      //
                      SizedBox(
                        height: 8,
                      ),

                      //
                      // CustomTextField(
                      //   maxleanthh: 250,
                      //
                      //     controller: address,
                      //     hintt: 'Enter Address',
                      //     validation: 'Please Enter Address'),

                      TextFormField(
                        // readOnly: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                // apiKey:"AIzaSyCBiZkX5n-WccQRkQ_s3yX3gd_QD7yFlrs",
                                apiKey:
                                    "AIzaSyCBiZkX5n-WccQRkQ_s3yX3gd_QD7yFlrs",

                                onPlacePicked: (result) {
                                  print(result.formattedAddress);
                                  setState(() {
                                    address.text =
                                        result.formattedAddress.toString();
                                    latee = result.geometry!.location.lat;
                                    longaa = result.geometry!.location.lng;
                                  });
                                  Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(22.719568, 75.857727),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        controller: address,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText: "Enter Address",
                          suffixIcon: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      // apiKey:"AIzaSyCBiZkX5n-WccQRkQ_s3yX3gd_QD7yFlrs",
                                      apiKey:
                                          "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM",

                                      onPlacePicked: (result) {
                                        print(result.formattedAddress);
                                        setState(() {
                                          address.text = result.formattedAddress
                                              .toString();
                                          latee = result.geometry!.location.lat;
                                          longaa =
                                              result.geometry!.location.lng;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      initialPosition:
                                          LatLng(22.719568, 75.857727),
                                      useCurrentLocation: true,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.location_searching_rounded)),
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Select Address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      CustomTextField(
                          maxleanthh: 15,
                          controller: passwordd,
                          hintt: 'Enter Password',
                          validation: 'Please Enter Password'),

                      SizedBox(
                        height: 8,
                      ),

                      TextFormField(
                        maxLength: 15,
                        controller: passworddConfirm,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText: 'Enter Confirm Password',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Confirm Password';
                          } else if (value != passwordd.text)
                            return 'Your Confirm Password Is Not Match';
                        },
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Select Gender'),
                                controller: gender,
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    gender.text = newValue ?? "";
                                    print("${gender.text}");
                                  });
                                },
                                items: genderList
                                    ?.map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(3)),
                          child: ListTile(
                            title: dateOfBirth == null || dateOfBirth == ''
                                ? Text(
                                    "Please Select Date Of Birth",
                                    style: TextStyle(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                : Text(
                                    dateOfBirth,
                                    style: TextStyle(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                            trailing: Icon(Icons.calendar_month),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      InkWell(
                        onTap: () {
                          selectScreen();
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(3)),
                          child: ListTile(
                            title: comma == null
                                ? Text(
                                    "Please Select Services",
                                    style: TextStyle(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                : Text(
                                    "${comma}",
                                    style: TextStyle(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Select Delivery Type'),
                                controller: servicesp,
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                onChanged: (newValue) {
                                  setState(() {
                                    servicesp.text = newValue ?? "";
                                    print('===========${servicesp.text}');
                                  });
                                },
                                items: services_p
                                    ?.map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['type'],
                                    child: Text(value['type']),
                                    onTap: () {
                                      setState(() {
                                        selectDeliveryTypeId = value['id'];
                                        print(
                                            "DELIVERYtYPE ID===============${selectDeliveryTypeId}");
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ]),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If Already Have An Account? ",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold // Background color
                        ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (gender.text == null || gender.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please Select Gender');
                        } else {
                          if (dateOfBirth == null) {
                            Fluttertoast.showToast(
                                msg: 'Please Select Date Of Birth');
                          } else {
                            if (servicesId == null) {
                              Fluttertoast.showToast(
                                  msg: 'Please Select Service');
                            } else {
                              if (selectDeliveryTypeId == null ||
                                  selectDeliveryTypeId == '') {
                                Fluttertoast.showToast(
                                    msg: 'Please Select Delivery Type');
                              } else {
                                if (selectedImage == null ||
                                    selectDeliveryTypeId == '') {
                                  Fluttertoast.showToast(
                                      msg: 'Please Select Profile Image');
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  SignupApi();
                                  Future.delayed(
                                    Duration(seconds: 5),
                                    () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                    },
                                  );
                                }
                              }
                            }
                          }
                        }
                      }
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: _isLoading == false
                                ? Text('Waiting....')
                                : Text('Sign Up')))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var dateOfBirth;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateOfBirth = DateFormat('dd-MM-yyyy').format(selectedDate);
        print("==================${dateOfBirth}");
      });
  }

  String? selectDeliveryTypeId;

  void selectScreen() {
    setState(() {});

    var result = showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Multiselectrd(
              items: getServicesModel!.data!.services ?? [],
            );
          },
        );
      },
    );
    print('serves raj=============${result}');
    if (result != null) {
      setState(() {
        isSelected = result as dynamic;
      });
    }
  }

  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobile = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController servicesp = TextEditingController();
  TextEditingController services = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController passwordd = TextEditingController();
  TextEditingController passworddConfirm = TextEditingController();

  List<Map<String, dynamic>> services_p = [
    {'type': 'Pickup/Drop', 'id': '1'},
    {'type': 'On Shop', 'id': '2'},
    {'type': 'Both', 'id': '3'},
  ];

  List<String> genderList = [
    'Male',
    'Female',
  ];

  var servicess;

  bool? valueee = false;
  // Option 2

  Future<void> SignupApi() async {
    var headers = {
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6Ik1oQm9zaHhoMWU1cEpLeXk5WkIvaFE9PSIsInZhbHVlIjoiK1pCRHcrWTFDaU4ybGt0dE93Rk1LRTJwZm1DZnZaK1VlNWtZOVZLcTVLNCtzQ2dsbTE5Zk44bUNaV21QbW9MNWdydWFnZUQ4MU50WWVXQ2hac2tjT3Y4dXh5ZmF5ZFJ1bjE4bGM4bTZqb1RzalJXbEVkeUx2SitraGxySk1WSXAiLCJtYWMiOiI2YTE1MjJlNjA0ZTBhMmJmMmQ5MDdhYTliZmZjYjE3YjA0NzNjODg0N2JiZjA2ODIzZGZjM2JmMWUwZjk1MGQyIiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IlRJQ0lkMm8vdkNFUWRmN2hQQVhDOEE9PSIsInZhbHVlIjoiOVJHTEV0U25ZOFZlcGVIdGd1d1pmMVIxSGF2UktrckRMR29ialBSUmFKYkpRdHlPWGpRTVB3clZrTkxjZlp6VG53YXB6MTZqeXk5bndWYkJRVDFlWFRQR0l2eHJTdHRabzIwNlNuUUtGVjgrSmM0ZmhBdmRNZGpzVHdiVmRPS2siLCJtYWMiOiJlNTBhOGE2ZGZiNDkxY2VlMmI2NGVmNGM3NjllYjA1NjcyZTYwNzA0N2VjZjhhYTgyMDU0YzRlZTQzYmU5ODUzIiwidGFnIjoiIn0%3D'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiService.venderRegisterUrl));
    request.fields.addAll({
      "first_name": firstname.text,
      "last_name": lastname.text,
      "email": email.text,
      "mobile": mobile.text,
      "address": address.text,
      "service_p": '${selectDeliveryTypeId}',
      "services[]": '${servicesId}',
      "gender": gender.text,
      "password": passwordd.text,
      "date_of_birth": '${dateOfBirth}',
      'lat': latitude.toString(),
      'lang': longitude.toString()
    });
    request.files.add(await http.MultipartFile.fromPath(
        'profile_photo', "${selectedImage!.path}"));

    print("Signuprequest================${request.fields}");
    print("Signup url================${request.url}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult1 = jsonDecode(result);
      if (finalResult1['message'] == "Registration successfully complete") {
        Fluttertoast.showToast(msg: finalResult1['message']);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      } else {
        Fluttertoast.showToast(msg: finalResult1['message']);
      }
      print("create account success");
    } else {
      print(response.reasonPhrase);
    }
  }

  List<String> postServicesList = [];
  GetServicesModel? getServicesModel;

  Future<void> getServices() async {
    var request =
        http.Request('GET', Uri.parse('${AppConfig.baseUrl1}/services'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = GetServicesModel.fromJson(jsonDecode(result));

      setState(() {
        getServicesModel = finalresult;
        print("get services success");
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}

List<String> isSelected = [];
List<String> selectedId = [];

var comma;
var servicesId;

class Multiselectrd extends StatefulWidget {
  final List<Service>? items;
  const Multiselectrd({super.key, required this.items});

  @override
  State<Multiselectrd> createState() => _MultiselectrdState();
}

class _MultiselectrdState extends State<Multiselectrd> {
  void itmechange(String selectedItem, bool isselectedd) {
    setState(() {
      if (isselectedd) {
        isSelected.add(selectedItem);
        setState(() {
          comma = isSelected.join(',');
        });
        print(isSelected);
        print('==============${comma}');
      } else {
        isSelected.remove(selectedItem);
        setState(() {
          comma = isSelected.join(',');
        });
        print('raj');

        print(isSelected);
        print('=========${comma}');
      }
    });
  }

  void itmeID(String selectedIteMID, bool isselectedd) {
    setState(() {
      if (isselectedd) {
        comma = isSelected.join(',');
        selectedId.add(selectedIteMID);
        print(selectedId);
        servicesId = selectedId.join(',');
        print('selectedid=======================${servicesId}');
      } else {
        selectedId.remove(selectedIteMID);
        print(selectedId);
        servicesId = selectedId.join(',');
        print('selectedid=======================${servicesId}');
      }
    });
  }

  void submit() {
    Navigator.pop(context, selectedId);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Select Services"),
          content: SingleChildScrollView(
            child: ListBody(
              children: widget.items!
                  .map((item) => CheckboxListTile(
                        value: isSelected.contains(item.name),
                        title: Text(item.name.toString()),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isCheck) {
                          itmeID(item.id.toString(), isCheck!);
                          itmechange(item.name.toString(), isCheck!);
                        },
                        // =>
                      ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back')),
            TextButton(
                onPressed: () {
                  submit();
                },
                child: Text('Submit')),
          ],
        );
      },
    );
  }
}
