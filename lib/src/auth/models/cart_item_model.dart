import 'item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;

  CartItemModel({
    required this.item,
    required this.quantity,
  });

  //funcao que retorna o valor total do item no carrinho
  double totalPrice() => item.price * quantity;

}
