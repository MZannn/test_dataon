import 'package:test_dataon/data/models/university_model.dart';
import 'package:test_dataon/data/services/base_provider.dart';

import '../../constant/string.dart';

class NetworkServices {
  final API api = API();

  Future<List<UniversityModel>> fetchUniversitiesByCountry(
      int limit, int offset) async {
    final response = await api.dio
        .get('/search?country=$country&limit=$limit&offset=$offset');

    if (response.statusCode == 200) {
      final List<UniversityModel> universities = [];
      final List<dynamic> data = response.data;

      for (var element in data) {
        universities.add(UniversityModel.fromJson(element));
      }
      return universities;
    } else {
      throw Exception("Failed to fetch universities");
    }
  }

  Future<List<UniversityModel>> searchUniversityByName(String name) async {
    final response = await api.dio.get('/search?name=$name&country=$country');

    if (response.statusCode == 200) {
      final List<UniversityModel> universities = [];
      final List<dynamic> data = response.data;

      for (var element in data) {
        universities.add(UniversityModel.fromJson(element));
      }

      return universities;
    } else {
      throw Exception("Failed to search university");
    }
  }
}
