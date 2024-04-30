// {
//     "id": 5,
//     "name": "Rodrigo Rahman 1",
//     "email": "rodrigorahman1@gmail.com",
//     "password": "123123",
//     "profile": "ADM",
//     "work_days": [
//         "Seg",
//         "Qua"
//     ],
//     "work_hours": [
//         6,
//         7,
//         8
//     ]
// }

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelADM.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw ArgumentError('Perfil de usuário não encontrado')
    };
  }
}

class UserModelADM extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelADM({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelADM.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": final int id,
        "name": final String name,
        "email": final String email,
      } =>
        UserModelADM(
          id: id,
          email: email,
          name: name,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid JSON data'),
    };
  }
}

class UserModelEmployee extends UserModel {
  final int barberShopId;
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required this.barberShopId,
    required this.workDays,
    required this.workHours,
  });

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": final int id,
        "name": final String name,
        "email": final String email,
        'barber_shop_id': final int barberShopId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        UserModelEmployee(
          id: id,
          email: email,
          name: name,
          avatar: json['avatar'],
          barberShopId: barberShopId,
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid JSON data'),
    };
  }
}
