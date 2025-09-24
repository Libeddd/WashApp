import 'vehicle.dart';

class Motorcycle extends Vehicle {
  final bool hasSidecar;

  Motorcycle({
    required super.id,
    required super.ownerName,
    required super.licensePlate,
    required super.color,
    required super.lastWashDate,
    required this.hasSidecar,
  }) : super(type: 'Motorcycle');

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['hasSidecar'] = hasSidecar;
    return map;
  }

  factory Motorcycle.fromMap(Map<String, dynamic> map) {
    return Motorcycle(
      id: map['id'],
      ownerName: map['ownerName'],
      licensePlate: map['licensePlate'],
      color: map['color'],
      lastWashDate: DateTime.parse(map['lastWashDate']),
      hasSidecar: map['hasSidecar'],
    );
  }
}