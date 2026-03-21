import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/city_model.dart';
import '../models/delicacy_model.dart';

class DatabaseService {
  final _supabase = Supabase.instance.client;

  // FETCH ALL CITIES (For the Pins)
  Future<List<City>> fetchCities() async {
    final response = await _supabase.from('cities').select();
    return (response as List).map((map) => City.fromMap(map)).toList();
  }

  // FETCH SPECIFIC CITY INFO (For the Bottom Sheet)
  Future<City?> fetchCityByName(String cityName) async {
    final response = await _supabase
        .from('cities')
        .select()
        .eq('name', cityName)
        .maybeSingle();
    return response != null ? City.fromMap(response) : null;
  }

  // FETCH FOOD FOR A CITY (For CityDetailPage)
  Future<List<Delicacy>> fetchDelicaciesByCity(String cityName) async {
    final response = await _supabase
        .from('delicacies')
        .select()
        .eq('city_id', cityName);
    return (response as List).map((map) => Delicacy.fromMap(map)).toList();
  }

  // FETCH STORES FOR A FOOD (For DelicacyInfoPage)
  Future<List<Map<String, dynamic>>> fetchStoresForDelicacy(String delicacyName) async {
  final response = await _supabase
      .from('stores')
      .select()
      .eq('delicacy_id', delicacyName);
  return List<Map<String, dynamic>>.from(response);
}
}