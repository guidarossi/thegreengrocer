import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:thegreengrocer/src/auth/models/order_model.dart';
import 'package:thegreengrocer/src/auth/services/utils_services.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //CONTEUDO
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //TITULO
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10),
                  child:  Text(
                    "Pagamento com Pix",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                //QR CODE
                QrImage(
                  data: "1234567890dfd5555",
                  version: QrVersions.auto,
                  size: 200.0,
                ),

                //VENCIMENTO
                Text(
                  "Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),

                //TOTAL
                Text(
                  "Total: ${utilsServices.priceToCurrency(order.total)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //BOTAO COPIA E COLA
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy,
                    size: 15,
                  ),
                  label: const Text(
                    "Copiar código Pix",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
