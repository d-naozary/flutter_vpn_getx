import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter_vpn/allModels/vpn_configuration.dart';
import 'package:flutter_vpn/allModels/vpn_status.dart';

class VpnEngine {
  static final String eventChannelVpnStage = "vpnStage";
  static final String eventChannelVpnStatus = "vpnStatus";
  static final String methodChannelVpnControl = "vpnControl";

  // vpn connection stage snapshot
  static Stream<String> snapshotVpnStage() =>
      EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  // vpn connection status snapshot
  static Stream<VpnStatus?> snapshotVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((event) => VpnStatus.fromJson(jsonDecode(event)))
          .cast();

  static Future startVpnNow(VpnConfiguration vpnConfiguration) async {
    return MethodChannel(methodChannelVpnControl).invokeMethod(
      "start",
      {
        "config": vpnConfiguration.config,
        "country": vpnConfiguration.countryName,
        "username": vpnConfiguration.username,
        "password": vpnConfiguration.password,
      },
    );
  }

  static Future stopVpnNow() async {
    return MethodChannel(methodChannelVpnControl).invokeMethod("stop");
  }

  static Future killSwitchOpenNow(){
    return MethodChannel(methodChannelVpnControl).invokeMethod("kill_switch");
  }

  static Future refreshStageNow(){
    return MethodChannel(methodChannelVpnControl).invokeMethod("refresh");
  }

  static Future getStageNow(){
    return MethodChannel(methodChannelVpnControl).invokeMethod("stage");
  }

  static Future<bool> isConnectedNow(){
    return getStageNow().then((value) => value!.toString().toLowerCase() == "connected");
  }

  static const String vpnConnectedNow = "connected";
  static const String vpnDisconnectedNow = "disconnected";
  static const String vpnWaitConnectionNow = "wait_connection";
  static const String vpnAuthenticatingNow = "authenticating";
  static const String vpnReconnectNow = "reconnect";
  static const String vpnNoConnectionNow = "no_connection";
  static const String vpnConnectingNow = "connecting";
  static const String vpnPrepareNow = "prepare";
  static const String vpnDeniedNow = "denied";
}
