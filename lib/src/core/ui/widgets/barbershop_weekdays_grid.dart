import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';

List<String> weekdays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];

class BarbershopWeekdaysGrid extends StatelessWidget {
  const BarbershopWeekdaysGrid({
    super.key,
    required this.onDayPressed,
    this.enabledDays,
  });

  final ValueChanged<String> onDayPressed;
  final List<String>? enabledDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os dias da semana',
          style: BarbershopTheme.mediumBodyStyle,
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var weekday in weekdays)
                WeekdayButton(
                  weekday: weekday,
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
            ],
          ),
        )
      ],
    );
  }
}

class WeekdayButton extends StatefulWidget {
  const WeekdayButton({
    super.key,
    required this.weekday,
    required this.onDayPressed,
    this.enabledDays,
  });

  final String weekday;
  final ValueChanged<String> onDayPressed;
  final List<String>? enabledDays;

  @override
  State<WeekdayButton> createState() => _WeekdayButtonState();
}

class _WeekdayButtonState extends State<WeekdayButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final WeekdayButton(:enabledDays, :weekday, :onDayPressed) = widget;

    final disabledDay = enabledDays != null && !enabledDays.contains(weekday);

    final textColor = selected ? Colors.white : ColorsTheme.grey;
    var buttonBgColor = selected ? ColorsTheme.brown : Colors.white;
    var buttonBorderColor = selected ? ColorsTheme.brown : ColorsTheme.grey;

    if (disabledDay) {
      buttonBgColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: disabledDay
            ? null
            : () {
                onDayPressed(weekday);
                setState(() {
                  selected = !selected;
                });
              },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: buttonBorderColor,
            ),
            color: buttonBgColor,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              weekday,
              style: BarbershopTheme.smallWidgetBoxSyle.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
