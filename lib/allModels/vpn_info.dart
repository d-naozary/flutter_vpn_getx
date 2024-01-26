class VpnInfo {
  late final String hostName;
  late final String ip;
  late final String ping;
  late final int speed;
  late final String countryLongName;
  late final String countryShortName;
  late final int vpnSessionsNum;
  late final String base64OpenVpnConfigurationData;

  VpnInfo({
    required this.hostName,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.countryLongName,
    required this.countryShortName,
    required this.vpnSessionsNum,
    required this.base64OpenVpnConfigurationData,
  });

  VpnInfo.fromJson(Map<String, dynamic> jsonData) {
    hostName = jsonData["HostName"] ?? "";
    ip = jsonData["IP"] ?? "";
    ping = (jsonData["ping"] ?? 0).toString();
    speed = (jsonData["Speed"] != null) ? int.parse(jsonData["Speed"]) : 0;
    countryLongName = jsonData["CountryLong"] ?? "";
    countryShortName = jsonData["CountryShort"] ?? "";
    vpnSessionsNum = (jsonData["NumVpnSessions"] != null)
        ? int.parse(jsonData["NumVpnSessions"])
        : 0;
    base64OpenVpnConfigurationData =
        jsonData["OpenVPN_ConfigData_Base64"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};

    jsonData["HostName"] = hostName;
    jsonData["IP"] = ip;
    jsonData["Ping"] = ping;
    jsonData["Speed"] = speed;
    jsonData["CountryLong"] = countryLongName;
    jsonData["CountryShort"] = countryShortName;
    jsonData["NumVpnSessions"] = vpnSessionsNum;
    jsonData["OpenVPN_ConfigData_Base64"] = base64OpenVpnConfigurationData;

    return jsonData;
  }
}
