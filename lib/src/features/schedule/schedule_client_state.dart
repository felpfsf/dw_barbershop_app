import 'package:flutter/material.dart';

enum ScheduleStateStatus { initial, success, error }

class ScheduleState {
  final ScheduleStateStatus status;
  final int? scheduledHour;
  final DateTime? scheduleDate;

  ScheduleState.initial() : this(status: ScheduleStateStatus.initial);

  ScheduleState({
    required this.status,
    this.scheduledHour,
    this.scheduleDate,
  });

  ScheduleState copyWith({
    ScheduleStateStatus? status,
    ValueGetter<int?>? scheduledHour,
    ValueGetter<DateTime?>? scheduleDate,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      scheduledHour:
          scheduledHour != null ? scheduledHour() : this.scheduledHour,
      scheduleDate: scheduleDate != null ? scheduleDate() : this.scheduleDate,
    );
  }
}
