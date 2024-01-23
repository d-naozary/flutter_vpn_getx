import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vpn/allModels/vpn_configuration.dart';
import 'package:flutter_vpn/allModels/vpn_info.dart';
import 'package:flutter_vpn/appPreferences/appPreferences.dart';
import 'package:flutter_vpn/vpnEngine/vpn_engine.dart';
import 'package:get/get.dart';

class ControllerHome extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;
  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  void connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVpnConfigurationData.isEmpty) {
      Get.snackbar(
          "Country / Location", "Please select country / Location first.");
      return;
    } else if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn =
          Base64Decoder().convert(vpnInfo.value.base64OpenVpnConfigurationData);
      final configuration = Utf8Decoder().convert(dataConfigVpn);
      final vpnConfiguration = VpnConfiguration(
          username: "vpn",
          password: "vpn",
          countryName: vpnInfo.value.countryLongName,
          config: configuration);

      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;

      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonString {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return "Tap to connect";

      case VpnEngine.vpnConnectedNow:
        return "Disconnect";

      default:
        return "Connecting...";
    }
  }
}
