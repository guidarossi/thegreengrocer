import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {

  // Formata valor em PT-BR
  String priceToCurrency(double price){

    NumberFormat numberFormat = NumberFormat.simpleCurrency(
      locale: "pt_BR"
    );

    return numberFormat.format(price);
  }

 // Formata a data em PT-BR
 String formatDateTime(DateTime dateTime){

    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd("pt_BR").add_Hm();
    return dateFormat.format(dateTime);
 }


}