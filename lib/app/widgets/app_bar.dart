import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/constant/collection.dart';

import 'package:sulai/app/view_model/dropdown.dart';
import 'package:sulai/app/view_model/notification.dart';
import 'package:sulai/app/view_model/user_provider.dart';

import '../constant/color.dart';
import '../routes/route.dart';
import '../view_model/order_provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _connectionStatus = "";
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
        _connectionStatus = "Mobile";
        break;
      case ConnectivityResult.ethernet:
        _connectionStatus = "Ethernet";
        break;
      case ConnectivityResult.bluetooth:
        _connectionStatus = "Bluetooth";
        break;
      case ConnectivityResult.wifi:
        _connectionStatus = "Wifi";
        break;
      case ConnectivityResult.none:
        _connectionStatus = "No internet connection";
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "No internet connection",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        // showDialog(
        //   barrierDismissible: false,
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     title: Text("Text"),
        //     content: Text("Cobaaa"),
        //     actions: [
        //       ElevatedButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //           if (_connectionStatus == "None") {
        //             _updateConnectionStatus(result);
        //           }
        //         },
        //         child: Text("Try"),
        //       )
        //     ],
        //   ),
        // );
        // if (_connectivity.onConnectivityChanged != ConnectionState.none) {
        //   Navigator.pop(context);
        // }
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notif = Provider.of<NotificationProvider>(context);

    final order = Provider.of<OrderProvider>(context, listen: false);
    final dropdown = Provider.of<DropDownNotifier>(context, listen: false);
    return SizedBox(
      height: size.height * 0.1,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      dropdown.image = "";
                      dropdown.rasa = "";
                      order.penjualanPerHari = 0;
                      order.orderPerWeek = [];
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.main,
                        (route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.home_rounded,
                      color: MyColor.grey,
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.05,
                width: size.height * 0.17,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: MyCollection.notification
                          .where(
                            "user_id",
                            isEqualTo: context.read<UserProvider>().getUser.id,
                          )
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return const Icon(
                            Icons.notifications_outlined,
                            color: MyColor.grey,
                          );
                        }
                        if (!notif.isOpen) {
                          notif.setCount = snapshot.data!.docs.length;
                          notif.isOpen = true;
                        }
                        if (notif.getCount < snapshot.data!.docs.length) {
                          notif.setActive = true;
                          notif.setCount = snapshot.data!.docs.length;
                        }
                        return Stack(
                          children: [
                            Material(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  notif.setCount = snapshot.data!.docs.length;
                                  notif.setActiveRef = false;
                                  Navigator.pushNamed(
                                    context,
                                    Routes.notification,
                                  );
                                },
                                child: const Icon(
                                  Icons.notifications_outlined,
                                  color: MyColor.grey,
                                ),
                              ),
                            ),
                            notif.getActive
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: Container(
                                      height: size.height * 0.01,
                                      width: size.height * 0.01,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        );
                      },
                    ),
                    Container(
                      height: size.height * 0.03,
                      width: 2,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.orderData),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: MyColor.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.03,
                      width: 2,
                      color: Colors.grey,
                    ),
                    (_connectionStatus == "Wifi")
                        ? const Icon(
                            Icons.wifi_rounded,
                            color: MyColor.blue,
                          )
                        : (_connectionStatus == "Mobile")
                            ? const Icon(
                                Icons.signal_cellular_alt_rounded,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.airplanemode_active_rounded,
                                color: Colors.red,
                              ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
