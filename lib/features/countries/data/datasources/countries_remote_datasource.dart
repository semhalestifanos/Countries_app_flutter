import '../../../../core/network/api_client.dart';

class CountriesRemoteDataSource {
  final ApiClient apiClient;

  CountriesRemoteDataSource(this.apiClient);

  Future<List<dynamic>> getAllCountries() async {
    final response = await apiClient.dio.get(
      "all?fields=name,flags,population,cca2",
    );

    return response.data;
  }

  Future<List<dynamic>> searchCountries(String query) async {
    final response = await apiClient.dio.get(
      "name/$query?fields=name,flags,population,cca2",
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getCountryDetail(String code) async {
    try {
      final response = await apiClient.dio.get(
        "alpha/$code?fields=name,flags,population,capital,region,subregion,area,timezones",
      );

      if (response.data is List && response.data.isNotEmpty) {
        return response.data[0];
      }

      return response.data;
    } catch (e) {
      throw Exception("Detail API failed");
    }
  }
}
