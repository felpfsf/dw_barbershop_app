enum EmployeeRegisterStateStatus {
  initial,
  success,
  error,
}

class EmployeeRegisterState {
  final EmployeeRegisterStateStatus status;
  final bool registerAdm;
  final List<String> workDays;
  final List<int> workHours;

  EmployeeRegisterState.initial()
      : this(
          registerAdm: false,
          workDays: <String>[],
          workHours: <int>[],
          status: EmployeeRegisterStateStatus.initial,
        );

  EmployeeRegisterState({
    required this.status,
    required this.registerAdm,
    required this.workDays,
    required this.workHours,
  });

  EmployeeRegisterState copyWith({
    EmployeeRegisterStateStatus? status,
    bool? registerAdm,
    List<String>? workDays,
    List<int>? workHours,
  }) {
    return EmployeeRegisterState(
      status: status ?? this.status,
      registerAdm: registerAdm ?? this.registerAdm,
      workDays: workDays ?? this.workDays,
      workHours: workHours ?? this.workHours,
    );
  }
}
