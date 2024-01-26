import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn/allControllers/controller_home.dart';
import 'package:flutter_vpn/allModels/vpn_status.dart';
import 'package:flutter_vpn/allWidgets/custom_widget.dart';
import 'package:flutter_vpn/allscreens/available_vpn_servers_location_screen.dart';
import 'package:flutter_vpn/appPreferences/appPreferences.dart';
import 'package:flutter_vpn/main.dart';
import 'package:flutter_vpn/vpnEngine/vpn_engine.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(ControllerHome());

  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(() => AvailableVpnServersLocationScreen());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.041),
            color: Colors.redAccent,
            height: 62,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(width: 12),
                Text(
                  "Select Country / Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: homeController.getRoundVpnButtonColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: homeController.getRoundVpnButtonColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: sizeScreen.height * 0.14,
                  width: sizeScreen.width * 0.14,
                  decoration: BoxDecoration(
                    color:
                        homeController.getRoundVpnButtonColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(height: 6),
                      Text(
                        homeController.getRoundVpnButtonString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((state) {
      homeController.vpnConnectionState.value = state;
    });
    sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Free VPN"),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.perm_device_info),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark);
              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
            icon: Icon(Icons.brightness_2_outlined),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "Location"
                          : homeController.vpnInfo.value.countryLongName,
                  subtitleText: "FREE",
                  roundWidgetWithIcon: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.redAccent,
                    child: homeController.vpnInfo.value.countryLongName.isEmpty
                        ? Icon(
                            Icons.flag_circle,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                    backgroundImage: homeController
                            .vpnInfo.value.countryLongName.isEmpty
                        ? null
                        : AssetImage(
                            "assets/flags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png"),
                  ),
                ),
                CustomWidget(
                  titleText: homeController.vpnInfo.value.ping.isEmpty ||
                          homeController.vpnInfo.value.ping == null
                      ? "0 ms"
                      : "${homeController.vpnInfo.value.ping} ms",
                  subtitleText: "PING",
                  roundWidgetWithIcon: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.graphic_eq,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          vpnRoundButton(),
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, datasnapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget(
                    titleText: "${datasnapshot.data?.byteIn ?? 0} kbps",
                    subtitleText: "DOWNLOAD",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.arrow_circle_down_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomWidget(
                    titleText: "${datasnapshot.data?.byteOut ?? 0} kbps",
                    subtitleText: "UPLOAD",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.purple,
                      child: Icon(
                        Icons.arrow_circle_up_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNavigation(context),
    );
  }
}
