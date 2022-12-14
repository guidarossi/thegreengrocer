import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';
import 'package:thegreengrocer/src/auth/pages/common_widgets/app_name_widget.dart';

import '../../controller/auth_controller.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().validateToken();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,

        decoration:  BoxDecoration(
          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:  [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade800,
              CustomColors.customSwatchColor.shade600,
              CustomColors.customSwatchColor.shade400,
              CustomColors.customSwatchColor.shade200,

            ],
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
             AppNameWidget(
              greenTileColor: Colors.white,
              textSize: 40,
            ),

            SizedBox(height: 10,),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
