import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/getOrderModel.dart';
import 'orderdetails_screen.dart';

class Orderpage extends StatefulWidget {
  const Orderpage({Key? key}) : super(key: key);

  @override
  State<Orderpage> createState() => _OrderpageState();
}

class _OrderpageState extends State<Orderpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.gold,
          centerTitle: true,
          title: Text('All Orders'),
        ),
        body: getOrderModel?.data?.orders == null ||
                getOrderModel?.data?.orders == ''
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()))
            : Padding(
                padding: const EdgeInsets.all(15),
                child: RefreshIndicator(
                  onRefresh: () async {
                    return Future<void>.delayed(const Duration(seconds: 2));
                  },
                  child: getOrderModel?.data?.orders == null ||
                          getOrderModel?.data?.orders == ''
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator()))
                      : getOrderModel!.data?.orders?.length == 0
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
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
                          : RefreshIndicator(
                              onRefresh: () {
                                return Future.delayed(
                                  Duration(seconds: 2),
                                  () {
                                    getOrder();
                                  },
                                );
                              },
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    getOrderModel?.data?.orders?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailsSreen(
                                                    OrderId: getOrderModel?.data
                                                            ?.orders?[index].id
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                            ),
                ),
              ));
  }

  GetOrderModel? getOrderModel;
  int? VenderIdd;
  Future<void> getOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      venderId = prefs.getString('venderId');
      VenderIdd = int.parse(venderId.toString());
      authToken = prefs.getString('authToken');
    });

    print(
        " token in get order ==================================Bearer ${authToken}============================");

    var headers = {
      'Authorization': 'Bearer ${authToken.toString()}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IktYdnlJZ1BjWmNTUXNtTVV1Tmk0cGc9PSIsInZhbHVlIjoiRVRRVUgxdHp5QjJNcFRoSXdIdXErZXVGczhvS1dMRVRueUlZdDc1Zmp1SExXTkxtOUhVTysrd0lHcmYrL3BKV2JmcHNPMURXNG1KNjdkcnNNb0tLODgvMTM5ZlNBZjE3NjAzSHB0am1xc095eXQxcXl1bUU2elZ0WWY0WW9BK3kiLCJtYWMiOiIyM2FkMjAyMjBhN2UyYjVhNzg0ZTVlZmU5ZmE3NWI1NjY0NDI1MDJjZTM0ZDE3NjkwZjAyMzdjM2QyODEyNTg4IiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IlNZa045Qk9WaWhJZm02Q2xBZUYyMnc9PSIsInZhbHVlIjoiRmVHem5tZmwybHpRV0pWSE42ck91ZU1Qak5YZGxpZFhCb2ppNGp1eStiZlZKUW1UVmlzZVlNN2VFRHFML01yZlg1OTAyL1ordDBUdjQvZ21wQmU2R1Y1NTN3ZzgvWUVSbFlub2FtR09nQThpamZNaW9aYjhHQVZ1YllJWEk2UkUiLCJtYWMiOiJjNjAzYTMwMTU4NzAzZmE5NjJhN2Q5MDRhMjAyMTliMTQ0ZmYwMzcwZGNmMjlhNWViMGUyZDY2OTYxNjBhYTNjIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('GET',
        Uri.parse('${AppConfig.baseUrl}/orders?vendors_id=${VenderIdd}'));

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
  }
}
