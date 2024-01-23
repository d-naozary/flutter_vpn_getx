class IPInfo {
  late final String country;
  late final String regionName;
  late final String city;
  late final String zipCode;
  late final String timezone;
  late final String isp;
  late final String query;

  IPInfo(
      {required this.country,
      required this.regionName,
      required this.city,
      required this.zipCode,
      required this.timezone,
      required this.isp,
      required this.query});

  IPInfo.fromJson(Map<String, dynamic> jsonData) {
    country = jsonData["country"];
    country = jsonData["regionName"] ?? '';
    country = jsonData["city"] ?? '';
    country = jsonData["zip"] ?? '';
    country = jsonData["timezone"] ?? 'Unknown';
    country = jsonData["isp"] ?? 'Unknown';
    country = jsonData["query"] ?? 'Not available';
  }
}
