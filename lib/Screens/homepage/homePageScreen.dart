import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Api Services/allApiscreen.dart';
import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/getDashBoardModel.dart';
import '../../Model/getOrderModel.dart';
import '../Auth/signin_screen.dart';
import '../order/orderdetails_screen.dart';
import '../order/orderscreen.dart';
import '../profile/venderprofile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
      Duration(seconds: 4),
      () async {
        await getdata();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.gold,
          centerTitle: true,
          title: Text('DashBoard'),
        ),
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.gold,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.gray,
                        radius: 50,
                        child: Center(
                          child: ClipOval(
                              child: Image.network(
                            "${imageFile}",
                            fit: BoxFit.cover,
                            width: 80.0,
                            height: 80.0,
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                        ),
                        onPressed: () async {
                          imageFile = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProfile(),
                              )).then((value) {
                            if (value) {
                              getdata();
                            }
                          });
                          print('================$imageFile}');
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      name == null
                          ? Text(
                              '',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              '${name}',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.home_filled),
                  SizedBox(
                    width: 10,
                  ),
                  const Text('DashBoard'),
                ],
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10,
                  ),
                  const Text('LogOut'),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text("Logout"),
                        onPressed: () {
                          // removeSession();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                      ),
                    ],
                    title: Text(
                      "Are you sure you want \nto Logout?",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 2),
              () {
                getdata();
              },
            );
          },
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(children: [
                    //
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //
                    //
                    //     Card(
                    //       elevation: 5,
                    //
                    //       child: Container(
                    //
                    //         height: 60,
                    //         width: MediaQuery.of(context).size.width/2.4,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(5),
                    //           child: Column(
                    //
                    //             children: [
                    //
                    //               Text('Total Service',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    //               SizedBox(height: 8,),
                    //               Text('${getDashBoardModel?.data?.services??'0'}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                    //
                    //
                    //             ],
                    //
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Card(
                    //       elevation: 5,
                    //
                    //       child: Container(
                    //
                    //         height: 60,
                    //         width: MediaQuery.of(context).size.width/2.4,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(5),
                    //           child: Column(
                    //
                    //             children: [
                    //
                    //               Text('Total Custmer',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    //               SizedBox(height: 8,),
                    //               Text('${getDashBoardModel?.data?.customers??'0'}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                    //
                    //
                    //             ],
                    //
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //
                    //
                    //   ],),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 5,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Order Today',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${getDashBoardModel?.data?.todayOrders ?? '0'}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Total Services',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${getDashBoardModel?.data?.services ?? '0'}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Orders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Orderpage(),
                                  ));
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.gold),
                            )),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    getOrderModel?.data?.orders == null ||
                            getOrderModel?.data?.orders == ''
                        ? Container(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()))
                        : getOrderModel!.data?.orders!.length == 0
                            ? Container(
                                width: 150,
                                height: 200,
                                child: Center(
                                  child: Text(
                                    'No Order Found',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      getOrderModel!.data!.orders!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderDetailsSreen(
                                                      OrderId: getOrderModel
                                                              ?.data
                                                              ?.orders?[index]
                                                              .id
                                                              .toString() ??
                                                          ''),
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Order Id : ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                          '${getOrderModel?.data?.orders?[index].orderCode}'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Order Date : ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ),
                                                      Text(
                                                        '${getOrderModel?.data?.orders?[index].orderedAt}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Deliver Date : ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ),
                                                      Text(
                                                        '${getOrderModel?.data?.orders?[index].deliveryDate}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Address : ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.7,
                                                          child: Text(
                                                            '${getOrderModel?.data?.orders?[index].address.addressName},${getOrderModel?.data?.orders?[index].address.area}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10),
                                                            maxLines: 4,
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                  ]),
                ),
              );
            },
          ),
        ));
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
      dateofBirth = prefs.getString('dateOfBirth');
      authToken = prefs.getString('authToken');
      selectServiceType = prefs.getString('serviceType');
      getAllServices = prefs.getString('service');

      print('in get token===============${authToken}====================');
      print(
          'in get token=====imagefile=from get preference=========${imageFile}====================');

      Future.delayed(
        Duration(seconds: 4),
        () {
          if (authToken != null) {
            getDashBoard();

            getOrder();
          }
        },
      );
    });
  }

  GetDashBoardModel? getDashBoardModel;

  Future<void> getDashBoard() async {
    print(
        " token in get dashboard ==================================Bearer ${authToken}===================");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    authToken = prefs.getString('authToken');
    log(authToken.toString());
    var headers = {
      'Authorization': 'Bearer ${authToken}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InVvV1p5WjRGZnhhVm5HOFZKaVNkblE9PSIsInZhbHVlIjoiMWdMNjRzR2wyWlhFYzZIeUdCdEowT1dVd2g2Q3hpMEYySG9vbzZOY1ZaM1EvdXFzWTE2MWFFOTI1RWhuN3lHRGVvL1l3V0FHeXhtcUpCY2Eza3cwYkIvS1BYRnkwRVR0TjRTaUpRTWlGdC9ITDA1cEVXTUQ1eDdUZy9ocmgxengiLCJtYWMiOiIzOWJkNGVmYWNkNTA0MThhZTMzYWU0NjVlZDk4N2JjZTJkNDA0YjU0NjZlNGE4Y2I3ZGY3YTU1YjE5MDg1NGNkIiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6Ijh3OTlSVWVtYlkzQXNPdUZFaWovTGc9PSIsInZhbHVlIjoicVVhMTYrLytBS3NhU1RUWlR5bTFXTm1XQnR5K3FxNTlIc29QdEVFeXJrUjRRTWZuYVFsZEFzUXQ0M0NLa0hZN0FCS1Q2UEJQSE44eVd0VGp0ajkzbXl1Wk1SMFB2S3VvRDNKcGtwTEEwTGQ3NEJnT1R1cjZ1Mk9wNmx2UDhqN0YiLCJtYWMiOiIxZmYyM2MzOWVkZDkxYWY1ODAzZGNiNjI5Y2UxZDI0ZTBhMDI4OTUzMDkwYjc3MmJlZTg1N2YyMDMxOTRmMzAyIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('GET',
        Uri.parse('${AppConfig.baseUrl}/dashboard?vendor_id=${venderId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);

      var finnalResult = GetDashBoardModel.fromJson(jsonDecode(result));
      setState(() {
        getDashBoardModel = finnalResult;
        print('get dashboadr success');
      });
    } else {
      print(response.reasonPhrase);
    }

    // var headers = {
    //   'Authorization':'Bearer ${authToken.toString()}',
    // };
    // var request = http.Request('GET', Uri.parse(ApiService.getDashBoardUrl));
    //
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //
    //   var result =await response.stream.bytesToString();
    //
    //
    //   var finnalResult=GetDashBoardModel.fromJson(jsonDecode(result));
    //   setState(() {
    //     getDashBoardModel =finnalResult;
    //     print('get dashboadr success');
    //   });
    // }
    // else {
    // print(response.reasonPhrase);
    // }
  }

  Future<void> removeSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('venderId');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('name');
    await prefs.remove('emait');
    await prefs.remove('mobileNumber');
    await prefs.remove('gender');
    await prefs.remove('address');
    await prefs.remove('imageFile');
    await prefs.remove('dateOfBirth');
    await prefs.remove('authToken');
    await prefs.remove('serviceType');
    await prefs.remove('service');
  }

  GetOrderModel? getOrderModel;
  Future<void> getOrder() async {
    print(
        " token in get order ==================================Bearer ${authToken}============================");
    print(
        " venderId ==================================Bearer ${venderId}============================");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    authToken = prefs.getString('authToken');

    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IktYdnlJZ1BjWmNTUXNtTVV1Tmk0cGc9PSIsInZhbHVlIjoiRVRRVUgxdHp5QjJNcFRoSXdIdXErZXVGczhvS1dMRVRueUlZdDc1Zmp1SExXTkxtOUhVTysrd0lHcmYrL3BKV2JmcHNPMURXNG1KNjdkcnNNb0tLODgvMTM5ZlNBZjE3NjAzSHB0am1xc095eXQxcXl1bUU2elZ0WWY0WW9BK3kiLCJtYWMiOiIyM2FkMjAyMjBhN2UyYjVhNzg0ZTVlZmU5ZmE3NWI1NjY0NDI1MDJjZTM0ZDE3NjkwZjAyMzdjM2QyODEyNTg4IiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IlNZa045Qk9WaWhJZm02Q2xBZUYyMnc9PSIsInZhbHVlIjoiRmVHem5tZmwybHpRV0pWSE42ck91ZU1Qak5YZGxpZFhCb2ppNGp1eStiZlZKUW1UVmlzZVlNN2VFRHFML01yZlg1OTAyL1ordDBUdjQvZ21wQmU2R1Y1NTN3ZzgvWUVSbFlub2FtR09nQThpamZNaW9aYjhHQVZ1YllJWEk2UkUiLCJtYWMiOiJjNjAzYTMwMTU4NzAzZmE5NjJhN2Q5MDRhMjAyMTliMTQ0ZmYwMzcwZGNmMjlhNWViMGUyZDY2OTYxNjBhYTNjIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET', Uri.parse('${AppConfig.baseUrl}/orders?vendors_id=${venderId}'));
    print("=========orderget api=======${request.url}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetOrderModel.fromJson(jsonDecode(result));
      setState(() {
        getOrderModel = finalResult;
        print("get order success");
      });
    } else {
      print(response.reasonPhrase);
    }

//   var headers = {
//     'Authorization':'Bearer ${authToken.toString()}',
//   };
//   var request = http.Request('GET', Uri.parse(ApiService.getOrderdUrl));
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     var result=await response.stream.bytesToString();
//     var finalResult=GetOrderModel.fromJson(jsonDecode(result));
//     setState(() {
//       getOrderModel=finalResult;
//       print("get order success");
//     });
//   }
//   else {
//   print(response.reasonPhrase);
//   }
//
//
  }
}
