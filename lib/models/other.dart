class RouteModel {
  final int routeID;
  final String routeName;
  final double distance;
  final String estimatedTime;

  RouteModel({
    required this.routeID,
    required this.routeName,
    required this.distance,
    required this.estimatedTime,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routeID: int.parse(json['routeID'].toString()), // handle string or int
      routeName: json['routeName'],
      distance: (json['distance'] as num).toDouble(),
      estimatedTime: json['estimatedTime'].toString(), // handle int/double as string
    );
  }

  Map<String, dynamic> toJson() => {
        'routeID': routeID,
        'routeName': routeName,
        'distance': distance,
        'estimatedTime': estimatedTime,
      };
}

class DepartureTimeModel {
  final int timeID;
  final String departureTime;

  DepartureTimeModel({
    required this.timeID,
    required this.departureTime,
  });

  factory DepartureTimeModel.fromJson(Map<String, dynamic> json) {
    return DepartureTimeModel(
      timeID: json['timeID'],
      departureTime: json['departureTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'timeID': timeID,
        'departureTime': departureTime,
      };
}
List<RouteModel> routeListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => RouteModel.fromJson(json)).toList();
}

List<DepartureTimeModel> departureTimeListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => DepartureTimeModel.fromJson(json)).toList();
}