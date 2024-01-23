import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn/allModels/ip_info.dart';
import 'package:flutter_vpn/allModels/vpn_info.dart';
import 'package:flutter_vpn/appPreferences/appPreferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiVpnGate {
  static Future<List<VpnInfo>> retrieveAllAvailableFreeVpnSerevers() async {
    final List<VpnInfo> vpnServersList = [];

    try {
      final responseFromApi =
          await http.get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      final csvString = responseFromApi.body.split("#")[1].replaceAll("*", "");

      List<List<dynamic>> listData = CsvToListConverter().convert(csvString);

      final headers = listData[0];

      for (var counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};
        for (var innerCounter = 0;
            innerCounter < headers.length;
            innerCounter++) {
          jsonData.addAll({
            headers[innerCounter].toString():
                listData[counter][innerCounter].toString()
          });
        }
        VpnInfo.fromJson(jsonData);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(0.8));
    }

    vpnServersList.shuffle();
    if (vpnServersList.isNotEmpty) AppPreferences.vpnList = vpnServersList;
    return vpnServersList;
  }

  static Future<void> retrieveIPDetails(
      {required Rx<IPInfo> ipInformation}) async {
    try {
      final responseFrpmApi =
          await http.get(Uri.parse("http://ip-api.com/json/"));
      final dataFromApi = jsonDecode(responseFrpmApi.body);

      ipInformation.value = IPInfo.fromJson(dataFromApi);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
