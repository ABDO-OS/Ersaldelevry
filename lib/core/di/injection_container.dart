import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/location_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/cubits/auth/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingletonAsync(() => SharedPreferences.getInstance());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );
  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(
      location: sl(),
      httpClient: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Cubits
  sl.registerFactory(
    () => AuthCubit(authRepository: sl()),
  );
}
