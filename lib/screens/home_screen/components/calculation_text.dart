import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/calculation_provider.dart';
import '../../../utils/constants.dart';

class CalculationText extends ConsumerWidget {
  const CalculationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculationNotifier = ref.watch(calculationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            calculationNotifier.prevData,
            style: TextStyle(
              fontSize: 32,
              color: kSecondaryColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            calculationNotifier.data,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
