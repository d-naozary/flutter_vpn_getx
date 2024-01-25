import 'package:flutter_vpn/allModels/vpn_info.dart';
import 'package:flutter_vpn/apiVpnGate/api_vpn_gate.dart';
import 'package:flutter_vpn/appPreferences/appPreferences.dart';
import 'package:get/get.dart';

class ControllerVPNLocation extends GetxController {
  List<VpnInfo> vpnServersList = AppPreferences.vpnList;
  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInformation() async {
    isLoadingNewLocations.value = true;

    vpnServersList.clear();
    vpnServersList = await ApiVpnGate.retrieveAllAvailableFreeVpnSerevers();

    isLoadingNewLocations.value = false;
  }
}
