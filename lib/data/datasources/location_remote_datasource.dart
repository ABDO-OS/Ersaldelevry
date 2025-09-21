import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<LocationModel> getCurrentLocation();
  Future<LocationModel> getLocationFromAddress(String address);
  Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  });
  Stream<LocationModel> get locationStream;
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final Location _location;
  final http.Client _httpClient;

  const LocationRemoteDataSourceImpl({
    required Location location,
    required http.Client httpClient,
  })  : _location = location,
        _httpClient = httpClient;

  @override
  Future<LocationModel> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          throw const LocationException(message: 'خدمات الموقع غير متاحة');
        }
      }

      // Check location permissions
      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw const LocationException(message: 'تم رفض إذن الموقع');
        }
      }

      // Get current location
      final locationData = await _location.getLocation();

      if (locationData.latitude == null || locationData.longitude == null) {
        throw const LocationException(message: 'فشل في الحصول على الموقع');
      }

      // Get address from coordinates
      final address = await getAddressFromCoordinates(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );

      return LocationModel(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
        address: address,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      if (e is LocationException) rethrow;
      throw LocationException(
          message: 'فشل في الحصول على الموقع: ${e.toString()}');
    }
  }

  @override
  Future<LocationModel> getLocationFromAddress(String address) async {
    try {
      final response = await _httpClient.get(
        Uri.parse(
            '${AppConstants.baseUrl}/search?q=$address&format=json&limit=1'),
        headers: {'Accept-Language': 'ar'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode != 200) {
        throw const LocationException(message: 'فشل في البحث عن العنوان');
      }

      final List<dynamic> data = json.decode(response.body);
      if (data.isEmpty) {
        throw const LocationException(message: 'العنوان غير موجود');
      }

      final locationData = data.first;
      return LocationModel(
        latitude: double.parse(locationData['lat']),
        longitude: double.parse(locationData['lon']),
        address: locationData['display_name'],
        city: locationData['address']?['city'],
        country: locationData['address']?['country'],
        timestamp: DateTime.now(),
      );
    } catch (e) {
      if (e is LocationException) rethrow;
      throw LocationException(
          message: 'فشل في البحث عن العنوان: ${e.toString()}');
    }
  }

  @override
  Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _httpClient.get(
        Uri.parse(
          '${AppConstants.baseUrl}/reverse?lat=$latitude&lon=$longitude&format=jsonv2&accept-language=ar',
        ),
        headers: {'Accept-Language': 'ar'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode != 200) {
        throw const LocationException(message: 'فشل في الحصول على العنوان');
      }

      final data = json.decode(response.body);
      final address = data['address'];

      if (address == null) {
        return 'موقع غير معروف';
      }

      final road = address['road'] ?? '';
      final neighbourhood = address['neighbourhood'] ?? '';
      final city = address['city'] ?? address['town'] ?? '';

      return [road, neighbourhood, city].where((e) => e.isNotEmpty).join(', ');
    } catch (e) {
      if (e is LocationException) rethrow;
      throw LocationException(
          message: 'فشل في الحصول على العنوان: ${e.toString()}');
    }
  }

  @override
  Stream<LocationModel> get locationStream {
    return _location.onLocationChanged.map((locationData) {
      if (locationData.latitude == null || locationData.longitude == null) {
        throw const LocationException(message: 'بيانات الموقع غير صحيحة');
      }

      return LocationModel(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
        timestamp: DateTime.now(),
      );
    });
  }
}
