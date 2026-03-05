import '../datasources/countries_remote_datasource.dart';
import '../models/country_detail.dart';
import '../models/country_summary_model.dart';
import 'countries_repository.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource remoteDataSource;

  CountriesRepositoryImpl(this.remoteDataSource);

  @override
  Future<CountryDetail> getCountryDetail(String code) async {
    final data = await remoteDataSource.getCountryDetail(code);
    return CountryDetail.fromJson(data);
  }

  @override
  Future<List<CountrySummary>> getCountries() async {
    final data = await remoteDataSource.getAllCountries();
    return data.map((e) => CountrySummary.fromJson(e)).toList();
  }

  @override
  Future<List<CountrySummary>> searchCountries(String query) async {
    final data = await remoteDataSource.searchCountries(query);
    return data.map((e) => CountrySummary.fromJson(e)).toList();
  }
}
