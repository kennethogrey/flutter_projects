import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/bloc/weather_bloc.dart';
import 'package:weather_app_api/presentation/widgets/additional_info_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(WeatherFetched());
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherFailure) {
            return Center(child: Text(state.error));
          }

          if (state is! WeatherSuccess) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          final data = state.weatherModel;
          final currentTemp = (data.currentTemp - 273.15).toStringAsFixed(2);
          final currentSky = data.currentSky;
          final currentPressure = data.currentPressure;
          final currentHumidity = data.currentHumidity;
          final currentWindSpeed = data.currentWindSpeed;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '$currentTemp°C',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Icon(
                                      currentSky == 'Clouds' ||
                                              currentSky == 'Rain'
                                          ? Icons.cloud
                                          : Icons.sunny,
                                      size: 64,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      currentSky,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // SizedBox(
                //   height: 120,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       final hourlyForecast = data['list'][index + 1];
                //       final hourlySky =
                //           data['list'][index + 1]['weather'][0]['main'];
                //       final time = DateTime.parse(hourlyForecast['dt_txt']);
                //       return HourlyForecastItem(
                //         time: DateFormat.j().format(time),
                //         temperature: hourlyForecast['main']['temp'].toString(),
                //         icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                //             ? Icons.cloud
                //             : Icons.sunny,
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 20),
                Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
