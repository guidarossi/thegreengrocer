import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/models/cart_item_model.dart';
import 'package:thegreengrocer/src/auth/models/order_model.dart';
import 'package:thegreengrocer/src/auth/services/utils_services.dart';

import '../../common_widgets/payment_dialog.dart';
import 'order_status_widget.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ), //retirar as bordas

        child: ExpansionTile(
          initiallyExpanded: order.status == "pending_payment",
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pedido ${order.id}",
              ),
              Text(
                utilsServices.formatDateTime(order.createdDateTime),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  //Lista de produtos
                  Expanded(
                    flex: 3, //espacamento
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        children: order.items.map((orderItem) {
                          //funcao que retorna dados do pedido
                          return _OrderItemWidget(
                            utilsServices: utilsServices,
                            orderItem: orderItem,
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  //Divisao
                  const VerticalDivider(
                    color: Colors.black12,
                    thickness: 2,
                    width: 8,
                  ),

                  //Status do pedido
                  Expanded(
                    flex: 2, //espacamento
                    child: OrderStatusWidget(
                      isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                      //compara a data do pedido com a data atual
                      status: order.status,
                    ),
                  ),
                ],
              ),
            ),

            //Total
            Text.rich(
              TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  children: [
                    const TextSpan(
                      text: "Total  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: utilsServices.priceToCurrency(order.total),
                    ),
                  ]),
            ),

            //Botao pagamento
            Visibility(
              visible: order.status == "pending_payment", //se verdadeiro apresenta o botao
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
                onPressed: () {
                  showDialog(context: context, builder: (_){
                    return PaymentDialog(
                      order: order,
                    );
                  });
                },
                label: const Text(
                  "Ver QR Code Pix",
                ),
                icon: Image.asset("assets/fruits/pix.png",height: 18,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "${orderItem.quantity} ${orderItem.item.unit}  ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(
            utilsServices.priceToCurrency(
              orderItem.totalPrice(),
            ),
          ),
        ],
      ),
    );
  }
}
