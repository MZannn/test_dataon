class UniversityModel {
  final List<String> webPages;
  final String alphaTwoCode;
  final String stateProvince;
  final String name;
  final List<String> domains;
  final String country;

  UniversityModel({
    required this.webPages,
    required this.alphaTwoCode,
    required this.stateProvince,
    required this.name,
    required this.domains,
    required this.country,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      webPages: List<String>.from(json['web_pages']),
      alphaTwoCode: json['alpha_two_code'],
      stateProvince: json['state-province'] ?? "",
      name: json['name'],
      domains: List<String>.from(json['domains']),
      country: json['country'],
    );
  }
}
