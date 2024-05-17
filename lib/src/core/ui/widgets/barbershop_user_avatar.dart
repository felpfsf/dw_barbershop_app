import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class BarbershopUserAvatar extends StatelessWidget {
  final bool hideUploadButton;
  const BarbershopUserAvatar({
    super.key,
    this.hideUploadButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(children: [
        Container(
          width: 90,
          height: 90,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.avatar),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Offstage(
            offstage: hideUploadButton,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: ColorsTheme.brown),
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                BarbershopIcons.addEmployee,
                color: ColorsTheme.brown,
                size: 25,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
