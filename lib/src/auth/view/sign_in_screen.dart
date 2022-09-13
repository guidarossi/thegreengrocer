import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thegreengrocer/src/auth/pages/base/base_screen.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';
import 'package:thegreengrocer/src/auth/view/sign_up_screen.dart';
import 'package:thegreengrocer/src/auth/pages_routes/app_pages_routes.dart';

import '../controller/auth_controller.dart';
import '../pages/common_widgets/app_name_widget.dart';
import '../pages/common_widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  //controlador de campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //TAMANHO EXATO DA TELA

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
//Nome do app
                    const AppNameWidget(
                      greenTileColor: Colors.white,
                      textSize: 40,
                    ),

//Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                            pause: Duration.zero,
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText("Frutas"),
                              FadeAnimatedText("Verduras"),
                              FadeAnimatedText("Legumes"),
                              FadeAnimatedText("Carnes"),
                              FadeAnimatedText("Cereais"),
                              FadeAnimatedText("Laticíneos"),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
//FORMULARIO
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset.zero,
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 5,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),

                //widget Form para validacao de formulario
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: (email) {
                          //Se o email é nulo ou vazio
                          if (email == null || email.isEmpty)
                            return "Digite seu email";

                          //Expressao regular do GetX para verificar se o email é valido
                          //"!" para negacao, retorna se o email nao for valido
                          if (!email.isEmail) return "Digite um email valido";

                          return null;
                        },
                      ),

                      //senha
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (password) {
                          if (password == null || password.isEmpty)
                            return "Digite sua senha";

                          if (password.length < 7)
                            return "Digite uma senha com pelo menos 7 caracteres";

                          return null;
                        },
                      ),
//Botao de entrar
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              onPressed:
                              authController.isLoading.value ? null :
                                  () {
                                
                                FocusScope.of(context).unfocus(); // esconde o teclado ao clicar no botao
                                
                                if (_formKey.currentState!.validate()) {
                                  String email = emailController.text;
                                  String password = passwordController.text;

                                  authController.signIn(
                                      email: email, password: password);
                                } else
                                  print("Campos não validos!");

                                //Get.offNamed(PagesRoutes.baseRoute);
                              },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator(
                              )
                                  : const Text(
                                      "Entrar",
                                      style: TextStyle(fontSize: 18),
                                    ),
                            );
                          },
                        ),
                      ),
//Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Esqueceu a senha?",
                            style: TextStyle(
                                color: CustomColors.customContrastColor),
                          ),
                        ),
                      ),
//DIVISOR
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.black12,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
//Botao de novo usuario
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          //cria botao apenas com bordas
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              side: const BorderSide(
                                  width: 2, color: Colors.green)),
                          onPressed: () {
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          child: const Text(
                            "Criar Conta",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
