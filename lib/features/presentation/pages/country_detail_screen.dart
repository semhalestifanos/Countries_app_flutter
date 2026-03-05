import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/countries_bloc.dart';
import '../bloc/countries_event.dart';
import '../bloc/countries_state.dart';
import '../../countries/data/models/country_detail.dart';
import '../widget/app_loader.dart';

class CountryDetailScreen extends StatefulWidget {
  final String code;

  const CountryDetailScreen({
    super.key,
    required this.code,
  });

  @override
  State<CountryDetailScreen> createState() =>
      _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {

  bool _fetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_fetched) {
      context.read<CountriesBloc>().add(
        FetchCountryDetailEvent(widget.code),
      );

      _fetched = true;
    }
  }

  void _goBackHome() {
    final bloc = context.read<CountriesBloc>();

    if (bloc.state is CountryDetailLoaded) {
      bloc.getFavoriteCountries();
      bloc.add(FetchCountriesEvent());
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBackHome,
        ),
        title: BlocBuilder<CountriesBloc, CountriesState>(
          buildWhen: (_, state) => state is CountryDetailLoaded,
          builder: (_, state) {
            if (state is CountryDetailLoaded) {
              return Text(
                state.country.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            }

            return const Text(
              "Country Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
      ),

      body: BlocBuilder<CountriesBloc, CountriesState>(
        buildWhen: (prev, curr) =>
        curr is CountriesLoading ||
            curr is CountriesError ||
            curr is CountryDetailLoaded,

        builder: (_, state) {

          if (state is CountriesLoading ||
              state is CountriesInitial) {
            return const Center(child: AppLoader());
          }

          if (state is CountriesError) {
            return Center(child: Text(state.message));
          }

          if (state is CountryDetailLoaded) {

            final CountryDetail country = state.country;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    width: double.infinity,
                    height: 260,
                    child: Image.network(
                      country.flag,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Key Statistics",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildStat("Area", "${country.area} km²"),
                  _buildStat("Population", country.population.toString()),
                  _buildStat("Region", country.region),
                  _buildStat("Sub Region", country.subregion),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Text(
                              "Timezone",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: country.timezones
                                  .map((tz) => Chip(label: Text(tz)))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: AppLoader());
        },
      ),
    );
  }

  Widget _buildStat(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
