// {
//   "id": 2,
//   "user_id": "5",
//   "name": "Barbearia X",
//   "email": "barbeariax@gmail.com",
//   "opening_days": [
//       "Seg",
//       "Qua",
//       "Sab"
//   ],
//   "opening_hours": [
//       6,
//       7,
//       8,
//       9,
//       18,
//       19,
//       20,
//       12,
//       13
//   ]
// }

class BarbershopModel {
  BarbershopModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  final int id;
  final String name;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;

  factory BarbershopModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'opening_days': List openingDays,
        'opening_hours': List openingHours,
      } =>
        BarbershopModel(
          id: id,
          name: name,
          email: email,
          openingDays: openingDays.cast<String>(),
          openingHours: openingHours.cast<int>(),
        ),
      _ => throw ArgumentError('Barbearia inválida (json)'),
    };
  }
}
