import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/pages/common_widgets/custom_text_field.dart';
import 'package:thegreengrocer/src/auth/config/app_data.dart' as appData;

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //email
          CustomTextField(
            icon: Icons.email,
            label: "Email",
            initialValue: appData.user.email,
            readOnly: true,
          ),

          //nome
          CustomTextField(
            icon: Icons.person,
            label: "Nome",
            initialValue: appData.user.name,
            readOnly: true,
          ),

          //Celular
          CustomTextField(
            icon: Icons.phone,
            label: "Celular",
            initialValue: appData.user.phone,
            readOnly: true,
          ),

          //CPF
          CustomTextField(
            icon: Icons.file_copy,
            label: "CPF",
            isSecret: true,
            initialValue: appData.user.cpf,
            readOnly: true,
          ),

          //Botao para atualizar senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () {
                updatePassword();
              },
              child: const Text(
                "Atualizar senha",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Text(
                          "Atualização de senha",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //senha atual
                      const CustomTextField(
                        isSecret: true,
                        icon: Icons.lock,
                        label: "Senha atual",
                      ),

                      //nova senha
                      const CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: "Nova senha",
                      ),

                      //confirmacao nova senha
                      const CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: "Confirmar nova senha",
                      ),

                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Atualizar"),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
