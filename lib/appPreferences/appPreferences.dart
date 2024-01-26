import 'dart:convert';

import 'package:flutter_vpn/allModels/vpn_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppPreferences {
  static late Box boxOfData;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    boxOfData = await Hive.openBox("data");
  }

  // saving user choice about theme selection
  static bool get isModeDark => boxOfData.get("isModeDark") ?? false;
  static set isModeDark(bool value) => boxOfData.put("isModeDark", value);

  // for saving single selected vpn details
  static VpnInfo get vpnInfoObj =>
      VpnInfo.fromJson(jsonDecode(boxOfData.get("vpn") ?? "{}"));
  static set vpnInfoObj(VpnInfo value) =>
      boxOfData.put("vpn", jsonEncode(value));

  // for saving all vpn list details
  static List<VpnInfo> get vpnList {
    List<VpnInfo> tempVpnList = [];
    final dataVpn = jsonDecode(boxOfData.get("vpnList") ?? "[]");

    for (var data in dataVpn) {
      tempVpnList.add(VpnInfo.fromJson(data));
    }

    return tempVpnList;
  }

  static set vpnList(List<VpnInfo> valueList) =>
      boxOfData.put("vpnList", jsonEncode(valueList));
}
