import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {

  final IconData icon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;


   const CustomTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.isSecret = false,
     this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool textObscure = false;

  //metodo que inicia antes do widget ser carregado na tela
  @override
  void initState() {
    textObscure = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        obscureText: textObscure,
        decoration: InputDecoration(
          prefixIcon:  Icon(widget.icon),
            suffixIcon: widget.isSecret ? IconButton(
                onPressed: (){
                  setState(() {
                    textObscure = !textObscure; //inverte o valor da variavel
                  });
                },
                icon:  Icon( textObscure ? Icons.visibility : Icons.visibility_off)
            )
                : null,
            labelText: widget.label,
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
