import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool showEmployeeFilter;
  const HomeHeader({super.key}) : showEmployeeFilter = true;
  const HomeHeader.withoutEmployeeFilter({super.key})
      : showEmployeeFilter = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getMyBarbershopProvider);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(Assets.bgChairImage),
          fit: BoxFit.cover,
          opacity: .5,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          barbershop.maybeWhen(
            data: (barbershop) {
              return Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      barbershop.name,
                      overflow: TextOverflow.ellipsis,
                      style: BarbershopTheme.boldBodyStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'editar',
                      style: BarbershopTheme.smallMdBodyStyle,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(homeAdmVmProvider.notifier).logout();
                    },
                    icon: const Icon(
                      BarbershopIcons.exit,
                      color: ColorsTheme.brown,
                      size: 32,
                    ),
                  ),
                ],
              );
            },
            orElse: () => const BarbershopLoader(),
          ),
          const SizedBox(height: 24),
          Text(
            'Bem vindo(a)',
            style:
                BarbershopTheme.smallTitleStyle.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(
            'Agende um cliente',
            style: BarbershopTheme.largeTitleStyle.copyWith(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Offstage(
            offstage: !showEmployeeFilter,
            child: const SizedBox(height: 24),
          ),
          Offstage(
            offstage: !showEmployeeFilter,
            child: SizedBox(
              height: 42,
              child: TextFormField(
                decoration: InputDecoration(
                  label: Text(
                    'Buscar colaborador',
                    style: BarbershopTheme.mediumBodyStyle
                        .copyWith(color: ColorsTheme.grey),
                  ),
                  hintText: 'Nome',
                  suffixIcon: const Icon(
                    BarbershopIcons.search,
                    color: ColorsTheme.brown,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
