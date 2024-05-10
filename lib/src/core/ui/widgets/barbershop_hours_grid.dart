import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';

class BarbershopHoursGrid extends StatelessWidget {
  final int startTime;
  final int endTime;

  const BarbershopHoursGrid({
    super.key,
    required this.startTime,
    required this.endTime,
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
                label: '${i.toString().padLeft(2, '0')}:00',
              ),
          ],
        ),
      ],
    );
  }
}

class HourButton extends StatelessWidget {
  final String label;

  const HourButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: ColorsTheme.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(label, style: BarbershopTheme.smallWidgetBoxSyle),
        ),
      ),
    );
  }
}
