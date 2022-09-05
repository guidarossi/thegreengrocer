import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset.zero,
              blurRadius: 10,
              blurStyle: BlurStyle.normal,
              spreadRadius: 2)
        ],
      ),
      child: Row(
        children: [

          _QuantityButton(
            icon: Icons.remove,
            color: Colors.grey,
            onPressed: (){},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6,),
            child: const Text("1kg",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),),
          ),
          _QuantityButton(
            icon: Icons.add,
            color: CustomColors.customSwatchColor,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {

  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon,
          color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
