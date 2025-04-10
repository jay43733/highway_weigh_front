import 'package:highway_weight/models/stations_model.dart';
import 'package:highway_weight/services/station_service.dart';

class StationRepository {
  final StationService _service = StationService();

  Future<List<StationsModel>> getAll() async {
    try {
      final jsonData = await _service.getAllStations();
      final result =
          jsonData.map((json) => StationsModel.fromJson(json)).toList();
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }
}
