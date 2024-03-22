import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/orderDetails.dart';
import '../trackDriver.dart';

class OrderDetailsSreen extends StatefulWidget {
  final String OrderId;
  OrderDetailsSreen({Key? key, required this.OrderId}) : super(key: key);

  @override
  State<OrderDetailsSreen> createState() => _OrderDetailsSreenState();
}

class _OrderDetailsSreenState extends State<OrderDetailsSreen> {
  var items = [
    'pending',
    'order_confirmed',
    'picked_order',
    'processing',
    'cancelled',
    'delivered'
  ];
  String dropdownvalue = 'pending';
  String? dropdowndrivervalue;
  var totalAmountttt;
  var diliverTypee;
  bool activee = false;
  bool Isactivee = false;
  var Statusss;
  var selectDriverr = '';
  var driverId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderDetails();
    getDriver();
    dounloadincoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gold,
        centerTitle: true,
        title: Text('Order Details'),
      ),
      body: getOrderDetailModel?.data?.order == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Customer Details',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Name : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.customer.user.firstName}',
                        style: TextStyle(fontSize: 12),
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
                        'Mobile Number : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.customer.user.mobile}',
                        style: TextStyle(fontSize: 12),
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
                        'Email : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.customer.user.email}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Id : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.id}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Code : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.orderCode}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Order At : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.orderedAt}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deliver Date : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.deliveryDate}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Address : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.address.addressName}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  getOrderDetailModel?.data?.order?.orderStatus ==
                              "Picked your order" &&
                          getOrderDetailModel!.data!.order!.drivers.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            print(
                                getOrderDetailModel?.data?.order?.orderStatus);
                            print(getOrderDetailModel!
                                .data!.order!.drivers.isNotEmpty);
                            print(getOrderDetailModel
                                ?.data?.order?.drivers[0].userId);
                            print(getOrderDetailModel?.data?.order?.lat);
                            print(getOrderDetailModel?.data?.order?.lang);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserMapScreen(
                                    Driverid: getOrderDetailModel
                                        ?.data?.order?.drivers[0].userId,
                                    vendorlat:
                                        getOrderDetailModel?.data?.order?.lat,
                                    vendorlang:
                                        getOrderDetailModel?.data?.order?.lang,
                                  ),
                                ));
                          },
                          child: Card(
                            elevation: 3,
                            child: Container(
                              height: 40,
                              child: Center(
                                  child: Text(
                                'Track To Driver',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      downloadPdf();
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        height: 40,
                        child: Center(
                            child: Text(
                          'Download Invoice',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  diliverTypee == 'Driver Deliver'
                      ? Column(children: [
                          Row(
                            children: [
                              Text(
                                'Assign Driver',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                      child: selectDriverr == ''
                                          // ||
                                          //     selectDriverr == null
                                          ? Text(
                                              'Select Driver',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(
                                              '${selectDriverr}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                ],
                              ),
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  dropdowndrivervalue = newValue["first_name"];
                                  selectDriverr =
                                      dropdowndrivervalue.toString();
                                  driverId = newValue["driver_id"];
                                  print(
                                      "driver id===============================${driverId}");
                                });
                              },
                              items: driverList.map<DropdownMenuItem<dynamic>>(
                                  (dynamic map) {
                                return DropdownMenuItem(
                                  value: map,
                                  child: Text(map["first_name"] ?? ''),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (selectDriverr == '' ||
                                  selectDriverr == null) {
                                Fluttertoast.showToast(
                                    msg: 'Please Select Driver');
                              } else {
                                setState(() {
                                  Isactivee = true;
                                });
                                driverAssignApi();
                              }
                              Future.delayed(
                                Duration(seconds: 5),
                                () {
                                  setState(() {
                                    Isactivee = false;
                                  });
                                },
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: AppColors.gold,
                                  borderRadius: BorderRadius.circular(75)),
                              child: Center(
                                  child: Isactivee == true
                                      ? Text('Waiting...')
                                      : Text('Assign Driver')),
                            ),
                          ),
                        ])
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Update Order Status',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      // value: dropdownvalue,
                      hint: Row(
                        children: [
                          Expanded(
                              child: Statusss == '' || Statusss == null
                                  ? Text(
                                      'Select Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      '${Statusss}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                        ],
                      ),
                      // Array list of items

                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          print(dropdownvalue);
                          Statusss = dropdownvalue;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (Statusss == '' || Statusss == null) {
                        Fluttertoast.showToast(msg: 'Please Select Status');
                      } else {
                        setState(() {
                          activee = true;
                        });
                        UpdateOrder();
                      }
                      Future.delayed(
                        Duration(seconds: 5),
                        () {
                          setState(() {
                            activee = false;
                          });
                        },
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(75)),
                      child: Center(
                          child: activee == true
                              ? Text('Waiting...')
                              : Text('Update Status')),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Product Details',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount:
                        getOrderDetailModel?.data?.order?.products.length,
                    itemBuilder: (context, index) {
                      var item =
                          getOrderDetailModel?.data?.order?.products[index];
                      int qty = quantity['${item?.id}'];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${getOrderDetailModel?.data?.order?.products[index].imagePath}'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${getOrderDetailModel?.data?.order?.products[index].name}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        '${getOrderDetailModel?.data?.order?.products[index].slug}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      )),
                                  Text(
                                    'Quantity : ${qty}',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Item',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.item}',
                        style: TextStyle(fontSize: 12),
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
                        'Order Status',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.orderStatus}',
                        style: TextStyle(fontSize: 12),
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
                        'Deliver Type',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.deliverType}',
                        style: TextStyle(fontSize: 12),
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
                        'Payment Type',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.paymentType}',
                        style: TextStyle(fontSize: 12),
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
                        'Sub Total Amount',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.amount}',
                        style: TextStyle(fontSize: 12),
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
                        'Delivery Charge',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.deliveryCharge}',
                        style: TextStyle(fontSize: 12),
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
                        'Discount',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.discount}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(thickness: 3),
                  Row(
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '${totalAmountttt}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ]),
              ),
            ),
    );
  }

  GetOrderDetailModel? getOrderDetailModel;
  var quantity;
  Future<void> getOrderDetails() async {
    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImxOc2lWRFlNS3p5eGFUeWNQTSs4Qnc9PSIsInZhbHVlIjoiNEdPdDFuYU94QXBCYVlZb3FBQWlVMjlDRnYvaHM1ekFtZzFzZWxSLzNpeVVTYmR4YVk0NCt2RHJNMnFZdGNOeFg4NWZvSHRwSTBpN294YmlrOUxqcnlKUndpU3JVdzlRYUFKZFYzYjJkOTFCTWc5dTBySGZTVDh1RklxekVEUjAiLCJtYWMiOiI3YjU4NzNhM2M1NDNmOTgxMjQzMTYxN2FhY2Y0Mjg0ZmEyZGYzM2RkODE0OTY1MmNlMDg1NGZmMmZhOWQxM2JmIiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IjIvekt2OUFXRDdGeTVKWTBDR0c2SEE9PSIsInZhbHVlIjoiM0d6VXg4bi9FZWxxMmNiMTFlMGQ1Q05xRjBWSWNoVU15NEQ1eTRpU3RrOTRtSkpYYkF6VXgvOVVlbm1kRjMvaWFKb1RrRzRMVjNsNjdHazc0aGhkbllvS1czb2pGc25aQ21Fa0hna2NSdUhlVmlMZUdHUzBvN1ZkV0pnMnVmY24iLCJtYWMiOiI5OTYyZmE1ZGJkYTdhMGI0MGJkMTc2NTZkMmM3NzNmYzgwOGUzZTVlYTNmM2Q3YjcwZTQ1ZGU2YzE0MjY2ZWVkIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET', Uri.parse('${AppConfig.baseUrl}/orders/${widget.OrderId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      log('rsult=============${result}');

      var finalResult1 = jsonDecode(result);
      print(
          'Quantity===========================${finalResult1['data']['order']['quantity']}');
      if (finalResult1['data']['order']['quantity'] != null) {
        quantity = finalResult1['data']['order']['quantity'];
      }
      var finalResult = GetOrderDetailModel.fromJson(finalResult1);
      setState(() {
        getOrderDetailModel = finalResult;

        diliverTypee = getOrderDetailModel?.data?.order?.deliverType;
        print('DELIVERTTYPE=====================${diliverTypee}');

        if (getOrderDetailModel?.data?.order?.deliveryCharge == 0 &&
            getOrderDetailModel?.data?.order?.discount == 0) {
          setState(() {
            totalAmountttt = getOrderDetailModel?.data?.order?.totalAmount;
          });
        } else {
          setState(() {
            var totalamount =
                int.parse(getOrderDetailModel!.data!.order!.amount);
            var deliverycharge =
                int.parse(getOrderDetailModel!.data!.order!.deliveryCharge);
            var discount =
                int.parse(getOrderDetailModel!.data!.order!.discount);
            totalAmountttt = totalamount + deliverycharge - discount;
          });
        }
        print("get order details success");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> UpdateOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    authToken = prefs.getString('authToken');
    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InVvV1p5WjRGZnhhVm5HOFZKaVNkblE9PSIsInZhbHVlIjoiMWdMNjRzR2wyWlhFYzZIeUdCdEowT1dVd2g2Q3hpMEYySG9vbzZOY1ZaM1EvdXFzWTE2MWFFOTI1RWhuN3lHRGVvL1l3V0FHeXhtcUpCY2Eza3cwYkIvS1BYRnkwRVR0TjRTaUpRTWlGdC9ITDA1cEVXTUQ1eDdUZy9ocmgxengiLCJtYWMiOiIzOWJkNGVmYWNkNTA0MThhZTMzYWU0NjVlZDk4N2JjZTJkNDA0YjU0NjZlNGE4Y2I3ZGY3YTU1YjE5MDg1NGNkIiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6Ijh3OTlSVWVtYlkzQXNPdUZFaWovTGc9PSIsInZhbHVlIjoicVVhMTYrLytBS3NhU1RUWlR5bTFXTm1XQnR5K3FxNTlIc29QdEVFeXJrUjRRTWZuYVFsZEFzUXQ0M0NLa0hZN0FCS1Q2UEJQSE44eVd0VGp0ajkzbXl1Wk1SMFB2S3VvRDNKcGtwTEEwTGQ3NEJnT1R1cjZ1Mk9wNmx2UDhqN0YiLCJtYWMiOiIxZmYyM2MzOWVkZDkxYWY1ODAzZGNiNjI5Y2UxZDI0ZTBhMDI4OTUzMDkwYjc3MmJlZTg1N2YyMDMxOTRmMzAyIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.baseUrl}/orders/${widget.OrderId}/update-status?status=${dropdownvalue.toString()}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('raj');
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(msg: 'Status Update Success');
      getOrderDetails();
      // Navigator.pop(context);
      print('order status update success');
    } else {
      print('raj2');

      print(response.reasonPhrase);
    }
  }

  List driverList = [];

  Future<void> getDriver() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    authToken = prefs.getString('authToken');
    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IktzOHZnWEEwV2ROUTdEaW5YN3k1eFE9PSIsInZhbHVlIjoia0pXQmU4N0R0RTJ0SndLazlhRklwS0dyZnZxRWg4QmxJc0wxd1RhT3pVSndGdlNPSk5ZdUJxeFZobDY0eWRjYzQwcE9QeHlJRFIzbmtRdWlWbFNEZmFzOE1MM2lkTGxlZlhTRnNUY01vWmJHQ0dDaEg3WUZ6eWJmRCtWWHhZUUkiLCJtYWMiOiJmYWJjY2NlZDQ3ZGNkMWM0MGU3YjNmYzNkNzJmODQ1Njg3MDA4N2UxZmQxZWE3OWNmOTU5YTYzNTFlOGU4NTdiIiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IkdnNzRKd1oxOHQ1aUkwZDRsYW5yQlE9PSIsInZhbHVlIjoiUmpMK1J2dDNNeUVEKzgxNTRsSzlER3lmcG93dTE2V0VVVmw0Nnp5R29tNURKS0UrRnV5QWc5UnUxck44WkM1THhTeWJmVHNjZkVpMHZwS2tnb2h0dDdrZGl3V2RCN2Z1emd0Z0hqd2lCMlEzbVhJa09wbFZkTGRheVBISWxDblEiLCJtYWMiOiIxYjEwYzYzZDQ5NzQ2NGNmNzYwNTNlODY5OGZmZWY3ODdkYjU4NzhjOTJmNjFkMTBmOGNjNzlhNDRjMjU3ZDFhIiwidGFnIjoiIn0%3D'
    };
    var request =
        http.Request('GET', Uri.parse('${AppConfig.baseUrl}/drivers'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);

      setState(() {
        driverList = finalresult['data']['order'];
        print('driver=============${driverList}');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> driverAssignApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    authToken = prefs.getString('authToken');
    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IlBoeWFzYStoRlUrRmE1dk1meXkvNmc9PSIsInZhbHVlIjoiaHlpSEthcFlMZlF5QmV3YmFIbytxdHZ1YnN5dHJ6aTZKYmVFZVZudW9OazlHYzl5OUlYUy8zUVlIZlAvUk9xbmZKUHY1Qy9tYjBaYmNsc3dVeUlTT2FtSVJLWFVOeVpQdnJLVWhxVzNaZGZvTFBpUjJaUGR4cXQ1ZUEwOVhJR0MiLCJtYWMiOiIxY2JmZTQxZTcyMGY5ZTVjOWQ5NmFhYmI1NGI4YWY2NTBlMmU3MDE4NDUzZWZjOWQzMDM2ZjNjNzM2NDU3MjM4IiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IjJEY2g0aWFJdHRIRjc0UWlxKzVOcUE9PSIsInZhbHVlIjoiRmZCZnh0ZFNoNStZcjJhME41SE4wV3Z6TlFxZkhJb0FkNm9xWmU3cTBFMkdjcnVVUlJaRjhsRFNwcTQ2YWwrZm90OU0vZGNDcXRPanorRGN0WktQVVd3WENESjc4dFU4YlpFNlNjaGRPYkUzQTQwS2ovYXUvK1V0Z3JpZnhmTmciLCJtYWMiOiJjOGJhNDg0ZWUxOGYyZTBmNDUxZmUwMWZjYzQyN2U3ZDZmMTYyZDk1NWI1NWU1MTUxNTA4NjNlODU3M2U1MTU4IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.baseUrl}/drivers-assign/${widget.OrderId}/${driverId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request.body);
    print(request.url);

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['message'] == "Driver Is Already Assigned") {
        Fluttertoast.showToast(msg: finalresult['message']);
      } else {
        getOrderDetails();
        Fluttertoast.showToast(msg: finalresult['message']);
        // Navigator.pop(context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  var urlpdg;
  Future<void> dounloadincoice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    authToken = prefs.getString('authToken');
    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
    };
    var request = http.Request('POST',
        Uri.parse('${AppConfig.baseUrl1}/getinvoice/${widget.OrderId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);

      setState(() {
        urlpdg = finalresult['pdf_url'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Directory? dir;
  downloadPdf() async {
    Dio dio = Dio();
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        String fileName = urlpdg.toString().split('/').last;
        print("FileName: $fileName");
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir!.exists()) dir = await getExternalStorageDirectory();
        String path = "${dir?.path}$fileName";
        await dio.download(
          urlpdg.toString(),
          path,
          onReceiveProgress: (recivedBytes, totalBytes) {
            print(recivedBytes);
          },
          deleteOnError: true,
        ).then((value) async =>
            await Share.shareXFiles([XFile(path)], text: fileName));
      } else {
        launch(urlpdg.toString());
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }
}
