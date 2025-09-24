class Vehicle {
  final String id;
  final String ownerName;
  final String licensePlate;
  final String type;
  final String color;
  final DateTime lastWashDate;

  Vehicle({
    required this.id,
    required this.ownerName,
    required this.licensePlate,
    required this.type,
    required this.color,
    required this.lastWashDate,
  });

  String get displayInfo => '$ownerName - $licensePlate ($type)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerName': ownerName,
      'licensePlate': licensePlate,
      'type': type,
      'color': color,
      'lastWashDate': lastWashDate.toIso8601String(),
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      ownerName: map['ownerName'],
      licensePlate: map['licensePlate'],
      type: map['type'],
      color: map['color'],
      lastWashDate: DateTime.parse(map['lastWashDate']),
    );
  }
}
