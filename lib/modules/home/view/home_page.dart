import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/custom_button.dart';
import 'package:weather_app/common/custom_input_decoration.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/app_keys.dart';
import 'package:weather_app/modules/home/view_model/view_model.dart';
import 'package:weather_app/constants/app_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _placeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getCity();
    super.initState();
  }

  getCity() async {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    var box = await Hive.openBox(AppKeys.weather);
    var city = box.get(AppKeys.city, defaultValue: 0);
    _placeController.text = city;
    if (city != null) {
      viewModel.getDetail(city, context);
    }
  }

  @override
  void dispose() {
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        title: const Text(
          AppStrings.appTitle,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _placeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.placeEmptyError;
                  }
                  saveCity(value);
                  return null;
                },
                decoration: inputDecorationWithBorder(
                  color: Colors.black,
                  hintText: AppStrings.placeHint,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                height: 55,
                borderRadius: 10,
                width: double.infinity,
                text: AppStrings.checkWeatherButtonText,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.getDetail(_placeController.text, context);
                  }
                },
              ),
              const SizedBox(height: 20),
              if (viewModel.weather != null)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.weatherDetailsTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        _buildDetailRow(
                          icon: Icons.location_city,
                          label: AppStrings.cityLabel,
                          value: viewModel.weather?.name ?? '-',
                        ),
                        _buildDetailRow(
                          icon: Icons.thermostat,
                          label: AppStrings.temperatureLabel,
                          value: '${viewModel.weather?.main?.temp ?? '-'}°C',
                        ),
                        _buildDetailRow(
                          icon: Icons.air,
                          label: AppStrings.windSpeedLabel,
                          value: '${viewModel.weather?.wind?.speed ?? '-'} m/s',
                        ),
                        _buildDetailRow(
                          icon: Icons.speed,
                          label: AppStrings.pressureLabel,
                          value:
                              '${viewModel.weather?.main?.pressure ?? '-'} hPa',
                        ),
                        _buildDetailRow(
                          icon: Icons.water_drop,
                          label: AppStrings.humidityLabel,
                          value: '${viewModel.weather?.main?.humidity ?? '-'}%',
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.blueGrey,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void saveCity(value) async {
    var box = await Hive.openBox(AppKeys.weather);
    await box.put(AppKeys.city, value);
  }
}
