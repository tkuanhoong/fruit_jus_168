import 'package:fruit_jus_168/features/menu_details/domain/entities/beverage.dart';

// beverage_utils.dart

class BeverageUtils {
  static String getProductNameWithIceLevel(
      List<BeverageEntity> products, String selectedSize) {
    // Assuming your product list contains the necessary data
    String productName =
        products.isNotEmpty ? products[0].name! : 'Unknown Product';

    String iceLevel = '';
    switch (selectedSize) {
      case 'noIce':
        iceLevel = 'No Ice';
        break;
      case 'normalIce':
        iceLevel = 'Normal Ice';
        break;
      case 'moreIce':
        iceLevel = 'More Ice';
        break;
    }

    return '$productName | $iceLevel';
  }
}
