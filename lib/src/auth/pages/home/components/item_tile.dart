import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/config/custom_colors.dart';
import 'package:thegreengrocer/src/auth/models/item_model.dart';
import 'package:thegreengrocer/src/auth/pages/product/product_screen.dart';
import 'package:thegreengrocer/src/auth/services/utils_services.dart';

class ItemTile extends StatefulWidget {
  final void Function(GlobalKey) cartAnimationMethod;
  final ItemModel item;

  const ItemTile({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();

  final UtilsServices utilsServices = UtilsServices();

  IconData tileIcon = Icons.add_shopping_cart_outlined;


  //funcao que muda o icone de add no carrinho temporariamente
  Future<void> switchIcon() async{

    setState(() {
      tileIcon = Icons.check;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      tileIcon = Icons.add_shopping_cart_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (c) {
              return ProductScreen(item: widget.item);
            }));
          },
          child: Card(
            elevation: 5,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //imagem
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Image.asset(
                        widget.item.imgUrl,
                        key: imageGk,
                      ),
                    ),
                  ),
                  //nome
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //preco - unidade
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        "/${widget.item.unit}",
                        style: const TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        //botao de add no carrinho
        Positioned(
          top: 4,
          right: 4,
          //ClipRRect realiza um reporte sobre seus filhos
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                highlightColor: Colors.green,
                onTap: () {
                  widget.cartAnimationMethod(imageGk);
                  switchIcon();
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                  ),
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
