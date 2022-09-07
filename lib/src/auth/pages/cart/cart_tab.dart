import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';
import 'package:thegreengrocer/src/auth/models/cart_item_model.dart';
import 'package:thegreengrocer/src/auth/pages/cart/components/cart_tile.dart';
import 'package:thegreengrocer/src/auth/services/utils_services.dart';
import 'package:thegreengrocer/src/auth/config/app_data.dart' as appData;

import '../common_widgets/payment_dialog.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  void removeItemFromCart(CartItemModel cartItem){
    setState(() {
      appData.cartItems.remove(cartItem);
      utilsServices.showToast(message: "${cartItem.item.itemName} removido do carrinho");
    });
  }

  //funcao que retorna valor total do carrinho

  double cartTotalPrice() {

    double total = 0;
    for(var item in appData.cartItems){

      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: Column(
        children: [

          //Lista de itens do carrinho
          Expanded(
            child: ListView.builder(
              itemCount: appData.cartItems.length,
              itemBuilder: (_,index) {
                return CartTile(cartItem: appData.cartItems[index],
                remove: removeItemFromCart,
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset.zero,
                  blurRadius: 10,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Total geral",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  utilsServices.priceToCurrency(
                      cartTotalPrice(),
                  ),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                     bool? reseult = await showOrderConfirmation();
                     if(reseult ?? false){
                       showDialog(context: context, builder: (_){
                         return PaymentDialog(
                           order: appData.orders.first,
                         );
                       },);
                     } else {

                       utilsServices.showToast(message: "Pedido não confirmado", isError: true);
                     }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Concluir pedido",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(context: context, builder: (contex){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Confirmação"),
        content: const Text("Deseja realmente concluir o pedido?"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(contex).pop(false);
          },
              child: Text("Não"),),
          ElevatedButton(onPressed: (){
            Navigator.of(contex).pop(true);
          },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
              child: const Text("Sim"),),
        ],
      );
    },
    );
  }
}
