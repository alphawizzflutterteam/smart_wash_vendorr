import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api Services/allApiscreen.dart';
import '../../Custom Widget/costomTextfield.dart';
import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/getProfileModel.dart';
import '../../Model/getServiceModel.dart';
import '../../Model/profilePhotoModel.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServices();
    getdata();
  }

  var latee;
  var longaa;

  @override
  void dispose() {
    // TODO: implement dispose
    getdata();

    Navigator.pop(context, imageFile);
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
                  height: 60,
                ),
                Stack(children: [
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
                                "${imageFile}",
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
                  Positioned(
                      top: 60,
                      left: 80,
                      right: 60,
                      child: Icon(Icons.camera_alt))
                ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxleanthh: 35,
                          controller: firstnameController,
                          hintt: 'Enter First Name',
                          validation: 'Please Enter First Name'),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxleanthh: 35,
                          controller: lastnameController,
                          hintt: 'Enter Last Name',
                          validation: 'Please Enter Last Name'),
                      SizedBox(
                        height: 8,
                      ),

                      TextFormField(
                        maxLength: 40,
                        controller: emailController,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText: 'Enter Email Id',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email Id';
                          }
                          return null;
                        },
                      ),
                      // CustomTextField(
                      //     maxleanthh: 40,
                      //     controller: emailController,
                      //     hintt: 'Enter Email Id',
                      //     validation: 'Please Enter Email Id'),
                      SizedBox(
                        height: 8,
                      ),

                      TextFormField(
                        maxLength: 10,
                        controller: mobileController,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText: 'Enter Mobile Number',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Mobile Number';
                          }
                        },
                      ),
                      // CustomTextField(
                      //     maxleanthh: 10,
                      //     controller: mobileController,
                      //     hintt: 'Enter Mobile Number',
                      //     validation: 'Please Enter Mobile Number'),

                      SizedBox(
                        height: 8,
                      ),

                      // CustomTextField(
                      //
                      //     maxleanthh: 250,
                      //     controller: addressController,
                      //     hintt: 'Enter Address',
                      //     validation: 'Please Enter Address'),

                      TextFormField(
                        readOnly: true,
// onTap: () {
//
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PlacePicker(
//         // apiKey:"AIzaSyBl2FY2AnfX6NwR4LlOOlT9dDve0VwQLAA",
//         apiKey:"AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM",
//
//         onPlacePicked: (result) {
//           print(result.formattedAddress);
//           setState(() {
//             addressController.text =
//                 result.formattedAddress.toString();
//             latee = result.geometry!.location.lat;
//             longaa = result.geometry!.location.lng;
//
//           });
//           Navigator.of(context).pop();
//         },
//         initialPosition: LatLng(
//             22.719568,75.857727),
//         useCurrentLocation: true,
//       ),
//     ),
//   );
//
//
// },
                        controller: addressController,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText: "Enter Address",
                          suffixIcon: IconButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => PlacePicker(
                                //       // apiKey:"AIzaSyBl2FY2AnfX6NwR4LlOOlT9dDve0VwQLAA",
                                //       apiKey:"AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM",
                                //
                                //       onPlacePicked: (result) {
                                //         print(result.formattedAddress);
                                //         setState(() {
                                //           addressController.text =
                                //               result.formattedAddress.toString();
                                //           latee = result.geometry!.location.lat;
                                //           longaa = result.geometry!.location.lng;
                                //
                                //         });
                                //         Navigator.of(context).pop();
                                //       },
                                //       initialPosition: LatLng(
                                //           22.719568,75.857727),
                                //       useCurrentLocation: true,
                                //     ),
                                //   ),
                                // );
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
                            title: dateOfBirth == null
                                ? Text(
                                    "Please Select Date Of Birth",
                                    style: TextStyle(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                : Text(
                                    "${dateOfBirth}",
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
                                controller: genderController,
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    genderController.text = newValue ?? "";
                                    print("${genderController.text}");
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
                          selectScreen();
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(3)),
                          child: ListTile(
                            title: SelectServiceString == null
                                ? Text(
                                    "Please Select Services",
                                    style: TextStyle(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                : Text(
                                    "${SelectServiceString}",
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
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Select Delivery Type'),
                                controller: servicespController,
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                onChanged: (newValue) {
                                  setState(() {
                                    servicespController.text = newValue ?? "";
                                    print(
                                        '===========${servicespController.text}');
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
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = false;
                      });

                      UpdateApi();

                      Future.delayed(
                        Duration(seconds: 5),
                        () {
                          setState(() {
                            _isLoading = true;
                          });
                        },
                      );
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: _isLoading == false
                              ? Text('Waiting....')
                              : Text('Update Profile'),
                        ))),
                SizedBox(
                  height: 70,
                ),
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
      firstDate: DateTime(1910),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateOfBirth = DateFormat('dd-MM-yyyy').format(selectedDate);
        print("==================${dateOfBirth}");
      });
  }

  Future<void> removeSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('name');
    await prefs.remove('emait');
    await prefs.remove('mobileNumber');
    await prefs.remove('gender');
    await prefs.remove('address');
    await prefs.remove('dateOfBirth');
    await prefs.remove('serviceType');
    await prefs.remove('service');

    print("remove success");
  }

  Future<void> setImage(String image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('imageFile');

    await prefs.setString('imageFile', image);
  }

  Future<void> setPreference(
    String firstNamee,
    String lastNamee,
    String namee,
    String emaill,
    String mobilee,
    String genderr,
    String addresss,
    String dateOfBirthh,
    String serviceTpe,
    String servicess,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNamee);
    await prefs.setString('lastName', lastNamee);
    await prefs.setString('name', namee);
    await prefs.setString('emait', emaill);
    await prefs.setString('mobileNumber', mobilee);
    await prefs.setString('gender', genderr);
    await prefs.setString('address', addresss);
    await prefs.setString('dateOfBirth', dateOfBirthh);
    await prefs.setString('serviceType', serviceTpe);
    await prefs.setString('service', servicess);
  }

  List<String> selectServiceList = [];
  var setAllService;
  void loopForService() {
    int loop;
    for (loop = 0;
        loop < getProfileModel!.data!.user!.services!.length;
        loop++) {
      var selectVal = getProfileModel!.data!.user!.services![loop].name;
      selectServiceList.add(selectVal!);
      setAllService = selectServiceList.join(',');
      print(setAllService);
      print(
          'all services for set preference>>>>>>>>>>>==============${setAllService}');
    }
  }

  Future<void> getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      venderId = prefs.getString('venderId');
      firstname = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
      name = prefs.getString('name');
      email = prefs.getString('emait');
      mobile = prefs.getString('mobileNumber');
      gender = prefs.getString('gender');
      address = prefs.getString('address');
      imageFile = prefs.getString('imageFile');
      var dob = prefs.getString('dateOfBirth');
      if (dob == null || dob == "null" || dob == "") {
        dateofBirth = "";
      } else {
        setState(() {
          dateofBirth = dob.toString();
        });
      }
      authToken = prefs.getString('authToken');
      selectServiceType = prefs.getString('serviceType');
      getAllServices = prefs.getString('service');

      print("image file==================${imageFile}");
      print("servicesalll==================${getAllServices}");
      print("selectServiceType==================${selectServiceType}");
      print("dateofBirth==================${dateofBirth}");

      firstnameController.text = firstname.toString();
      lastnameController.text = lastName.toString();
      emailController.text = email.toString();
      mobileController.text = mobile.toString();
      genderController.text = gender.toString();
      addressController.text = address.toString();
      servicespController.text = selectServiceType.toString();
      dateOfBirth = dateofBirth.toString();
      SelectServiceString = getAllServices.toString();
    });
    print("get data success");
  }

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
                          child: Center(child: Text('Take a Photo')),
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
        updateProfilePhoto();
      });
    }
  }

  String? selectDeliveryTypeId;

  void selectScreen() {
    var result = showDialog(
      context: context,
      builder: (context) {
        return Multiselectrd(
          items: getServicesModel!.data!.services ?? [],
        );
      },
    );

    if (result != null) {
      setState(() {
        isSelectedServicelist = result as dynamic;
      });
    }
  }

  ProfilePhotoModel? profilePhotoModel;
  Future<void> updateProfilePhoto() async {
    print("image variable file type =============== ${selectedImage!.path}");

    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IkR0RFhSTUdla0tUTWh6SjRFbW5HTVE9PSIsInZhbHVlIjoiUmRKd0lRb2tENWxIT0tyRkRRY2FNZVdwS3BGc1A2UEdPMUtyN1dOcmxpMHIwQ3FZREZDYldwUUVNT0Zzemp6Ylk2TEYzSTB1V0FIQ0Zya2lUUWhMVzdQWDBPaTQvNmYxZFM5OWhDTzU1RWZvV2JvbUUvOFBFUWNudFB5L2FCenAiLCJtYWMiOiI2NjI4OWVmZWRiMGI3OTE5N2NjOWUzNmYxMjMxMTQ1MmI3MTRkNTZjZTFlMzg5ODEzOWJkNzgyOGIzMmI5MGI3IiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6Ik5WQW9NY3N4cERCRHBhRmJWcmFhUWc9PSIsInZhbHVlIjoiQ2lIZlpNNEFaL3c0TnVTSDF4T1QrbHkxY291YjJTTHRwRXdhU2NlZUg3ODdUNmhuYXZqUk5oamkyV0xvaE1xdnhuRjZNU1owM0d0dTJmSzJxWUNsZHJqa0Irb0lYRStVYXpreDhlbXV4b2Z6c1ZQOUNRV0ZEUWV4WFhFOW1xUVIiLCJtYWMiOiIyNDY0OWU1MTgzZGQ5ZTY5MjY4ZDVhY2IwOTU4Y2YzMjM0ZGM3ODFmMjAzNTk4ODc2NGNhM2Y2Mzg3YzRkMWMxIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiService.updateProfilephotoUrl));
    request.files.add(await http.MultipartFile.fromPath(
        'profile_photo', "${selectedImage!.path}"));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      var finalresult = jsonDecode(result);
      var finalResult2 = ProfilePhotoModel.fromJson(jsonDecode(result));

      setState(() {
        profilePhotoModel = finalResult2;

        print('${profilePhotoModel?.data?.user?.profilePhotoPath}');
        setImage('${profilePhotoModel?.data?.user?.profilePhotoPath}');
        print('update profile photo Success');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController servicespController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passworddController = TextEditingController();
  TextEditingController passworddConfirmController = TextEditingController();

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
  GetProfileModel? getProfileModel;
  Future<void> UpdateApi() async {
    print("in update api services id list ${selectedServiceIdlist}");
    print("in update api both/ id list ${selectDeliveryTypeId}");
    print("in update api date of birth id list ${dateOfBirth}");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6Iit2aW9oMUhZZTR6ZGRINzJvWk9LR0E9PSIsInZhbHVlIjoiOTZBMGhvbWVuVXdVU01iNUh6MmVNdVhDSHVGOFdtOGZ0eUZGR1krWG1nZzJkU3JmSGxEWUxjM3dWZlZiSUF6ZlJoVVEzb09HR0hUWVpyV1hzb2hwYUNoV20rWWErcHdwTE1YZklsSlYxTEZSWmlGNXBxN1IwQmJZTjJJNU8rSnQiLCJtYWMiOiJkYmJlZjVlMGQ5NjkwNDljNmEzZjliZjdkMmQ3MzljYzY5YWQyNGUyNzg4Y2RkMDNmZThjMjcyNzFhN2U4NGNlIiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IkFtbS9RdlhIc0ltREEzRkVvWUJNcmc9PSIsInZhbHVlIjoid1RGRkF4L1F4dGV6RDlTYkZPVUxrKzl0MXozQ3phMmcrcUVkU3lweVVOYUord2JBTDJ5Q1I1eHhMK29nT200cHh5TTlkWG9halBObUozYjdxVUI3em5IVStidGdRbXZiT1o4d2lVZWhzczZqalk4TE13M3RiMmdrZXZPakxDclEiLCJtYWMiOiJjMzIyZTM5M2JlM2Q1MjkwM2Q1NGNiOTM3Zjg0YzhkMmUxYmIzMDI5N2Q0NWI3OTBjZDIyMzkxNjAwNGZjMDU3IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('POST', Uri.parse(ApiService.updateProfileUrl));
    request.body = json.encode({
      "first_name": firstnameController.text,
      "last_name": lastnameController.text,
      "mobile": mobileController.text,
      "email": emailController.text,
      "services": selectedServiceIdlist,
      "date_of_birth": dateOfBirth,
      "address": addressController.text,
      "gender": genderController.text,
      "service_p": selectDeliveryTypeId,
      "user_id": "${venderId}"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalll = jsonDecode(result);
      print("=====================${finalll}");
      var finalResult = GetProfileModel.fromJson(jsonDecode(result));
      setState(() {
        getProfileModel = finalResult;

        //  removeSession();

        loopForService();

        if (getProfileModel?.data?.user?.serviceP == '1') {
          selectServiceType = 'Pickup/Drop';
        } else if (getProfileModel?.data?.user?.serviceP == '2') {
          selectServiceType = 'On Shop';
        } else {
          selectServiceType = 'Both';
        }

        print('in set services in side api=======${setAllService}');
        print('in set type of delevery in side api=======${selectServiceType}');
        print(
            'in set type of date of birth in side api=======${getProfileModel?.data?.user?.dateOfBirth}');

        setPreference(
          getProfileModel?.data?.user?.firstName ?? '',
          getProfileModel?.data?.user?.lastName ?? '',
          getProfileModel?.data?.user?.name ?? '',
          getProfileModel?.data?.user?.email ?? '',
          getProfileModel?.data?.user?.mobile ?? '',
          getProfileModel?.data?.user?.gender ?? '',
          getProfileModel?.data?.user?.address ?? '',
          getProfileModel?.data?.user?.dateOfBirth ?? '',
          selectServiceType ?? '',
          setAllService.toString(),
        );
        Fluttertoast.showToast(msg: finalll['message']);
      });
      Navigator.pop(context,true);
      print("update success");

      //getdata();
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

List<String> isSelectedServicelist = [];
List<String> selectedServiceIdlist = [];
var SelectServiceString;
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
        isSelectedServicelist.add(selectedItem);
        SelectServiceString = isSelectedServicelist.join(',');
        print(
            "selected dervice item list isSelectedServicelist==============${isSelectedServicelist}");
        print(
            'selected dervice item variable  SelectServiceString==============${SelectServiceString}');
      } else {
        isSelectedServicelist.remove(selectedItem);
        print(
            "selected dervice item list  isSelectedServicelist==============${isSelectedServicelist}");
        print(
            'selected dervice item variable  SelectServiceString ==============${SelectServiceString}');
      }
    });
  }

  void itmeID(String selectedIteMID, bool isselectedd) {
    setState(() {
      if (isselectedd) {
        selectedServiceIdlist.add(selectedIteMID);
        print(
            'service id List  selectedServiceIdlist==========${selectedServiceIdlist}');
        servicesId = selectedServiceIdlist.join(',');
        print(
            'servicesId without list  servicesId=======================${servicesId}');
      } else {
        selectedServiceIdlist.remove(selectedIteMID);
        print(
            'service id List  selectedServiceIdlist==========${selectedServiceIdlist}');

        servicesId = selectedServiceIdlist.join(',');
        print(
            'servicesId without list  servicesId=======================${servicesId}');
      }
    });
  }

  void submit() {
    Navigator.pop(context, servicesId);
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
                        value: isSelectedServicelist.contains(item.name),
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
