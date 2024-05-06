import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';

List<String> weekdays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];

class BarbershopWeekdaysGrid extends StatelessWidget {
  const BarbershopWeekdaysGrid({super.key});

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
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var weekday in weekdays) WeekdayButton(weekday: weekday),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class WeekdayButton extends StatelessWidget {
  const WeekdayButton({
    super.key,
    required this.weekday,
  });

  final String weekday;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorsTheme.grey,
        ),
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          weekday,
          style: BarbershopTheme.smallWidgetBoxSyle,
        ),
      ),
    );
  }
}
