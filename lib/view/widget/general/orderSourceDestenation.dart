import 'package:flutter/material.dart';

class OrderSourceDestenation extends StatelessWidget {
  const OrderSourceDestenation({
    super.key,
    required this.street,
    required this.fromTo,
    required this.icon,
    required this.haveIcon,
  });
  final String street;
  final String fromTo;
  final IconData icon;
  final bool haveIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            street,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.end,
          ),
        ),
        Text(
          fromTo,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        haveIcon
            ? Icon(
                icon,
                color:Theme.of(context).colorScheme.primary,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}