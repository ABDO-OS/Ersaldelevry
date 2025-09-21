import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/location_remote_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingletonAsync(() => SharedPreferences.getInstance());

  // Data sources
  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(
      location: sl(),
      httpClient: sl(),
    ),
  );
}
