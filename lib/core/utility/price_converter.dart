class PriceConverter {
  static int fromDouble(double price) {
    return price * 100 ~/ 1;
  }

  static String fromInt(int integerPrice) {
    return (integerPrice / 100).toStringAsFixed(2);
  }
}
