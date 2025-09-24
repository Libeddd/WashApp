import 'vehicle.dart';

class Car extends Vehicle {
  final int numberOfDoors;

  Car({
    required super.id,
    required super.ownerName,
    required super.licensePlate,
    required super.color,
    required super.lastWashDate,
    required this.numberOfDoors,
  }) : super(type: 'Car');

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['numberOfDoors'] = numberOfDoors;
    return map;
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'],
      ownerName: map['ownerName'],
      licensePlate: map['licensePlate'],
      color: map['color'],
      lastWashDate: DateTime.parse(map['lastWashDate']),
      numberOfDoors: map['numberOfDoors'],
    );
  }
}
