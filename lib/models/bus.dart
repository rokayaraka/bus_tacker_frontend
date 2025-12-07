import 'other.dart';

class BusModel {
  final String busNumber;
  final String busName;
  final String licensePlate;
  final String status;
  final int route;
  final int capacity;
  final String lastUpdate;
  final String driver;
  final List<DepartureTimeModel> departures;

  BusModel({
    required this.busNumber,
    required this.busName,
    required this.licensePlate,
    required this.status,
    required this.route,
    required this.capacity,
    required this.lastUpdate,
    required this.driver,
    required this.departures,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      busNumber: json['busNumber'],
      busName: json['busName'],
      licensePlate: json['licensePlate'],
      status: json['status'],
      route: int.parse(json['route'].toString()),
      capacity: json['capacity'],
      lastUpdate: json['lastUpdate'],
      driver: json['driver'].toString(),
      departures: (json['departures'] as List<dynamic>)
          .map((dep) => DepartureTimeModel.fromJson(dep))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'busNumber': busNumber,
        'busName': busName,
        'licensePlate': licensePlate,
        'status': status,
        'route': route,
        'capacity': capacity,
        'lastUpdate': lastUpdate,
        'driver': driver,
        'departures': departures.map((dep) => dep.toJson()).toList(),
      };
}
List<BusModel> busListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => BusModel.fromJson(json)).toList();
}