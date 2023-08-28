import 'package:flutter/material.dart';
import 'package:test_dataon/data/models/university_model.dart';
import 'package:test_dataon/data/services/network_services.dart';

class HomeViewModel extends ChangeNotifier {
  final NetworkServices networkService = NetworkServices();
  List<UniversityModel> universities = [];
  List<UniversityModel> searchResults = [];

  int offset = 0;
  int limit = 20;
  bool isLoading = false;

  Future<void> fetchUniversities({bool reset = false}) async {
    if (reset) {
      offset = 0;
      universities.clear();
    }

    isLoading = true;

    final data = await networkService.fetchUniversitiesByCountry(limit, offset);
    universities.addAll(data);
    isLoading = false;
    offset += data.length;

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  void searchUniversities(String query) {
    if (query.isEmpty) {
      searchResults = [];
    } else {
      searchResults = universities
          .where((university) =>
              university.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
