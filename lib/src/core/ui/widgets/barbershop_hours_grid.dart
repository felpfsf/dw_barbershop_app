import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';

class BarbershopHoursGrid extends StatelessWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;

  const BarbershopHoursGrid({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horários de atendimentosss',
          style: BarbershopTheme.mediumBodyStyle,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              HourButton(
                hour: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                onHourPressed: onHourPressed,
              ),
          ],
        ),
      ],
    );
  }
}

class HourButton extends StatefulWidget {
  final String hour;
  final int value;
  final ValueChanged<int> onHourPressed;

  const HourButton({
    super.key,
    required this.hour,
    required this.value,
    required this.onHourPressed,
  });

  @override
  State<HourButton> createState() => _HourButtonState();
}

class _HourButtonState extends State<HourButton> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsTheme.grey;
    var buttonBgColor = selected ? ColorsTheme.brown : Colors.white;
    var buttonBorderColor = selected ? ColorsTheme.brown : ColorsTheme.grey;

    return InkWell(
      onTap: () {
        widget.onHourPressed(widget.value);
        setState(() {
          selected = !selected;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: buttonBorderColor),
          color: buttonBgColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.hour,
            style: BarbershopTheme.smallWidgetBoxSyle.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
