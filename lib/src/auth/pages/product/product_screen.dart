import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';
import 'package:thegreengrocer/src/auth/models/item_model.dart';
import 'package:thegreengrocer/src/auth/services/utils_services.dart';

import '../common_widgets/quantity_widget.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ItemModel item;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          //CONTEUDO
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: item.imgUrl,
                  child: Image.asset(
                    item.imgUrl,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset.zero,
                          blurRadius: 10,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 5)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //nome - quantidade
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.itemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const QuantityWidget(),
                        ],
                      ),

                      //preco
                      Text(
                        utilsServices.priceToCurrency(item.price),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),

                      //descricao
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            child: Text(
                              item.description,
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //botao
                      SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          label: const Text(
                            'Add no carrinho',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
