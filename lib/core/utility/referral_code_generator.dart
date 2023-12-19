import 'dart:math';

class ReferralCodeGenerator {
  // random characters allowed
  static const randomCharactersAllowed = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  // generate referral code with userName param
  static String getReferralCode(String userName, int length) {
    String userFirstThreeLetters = userName.substring(0, 3).toUpperCase();
    String referralCode = userFirstThreeLetters + getRandomString(length);
    return referralCode;
  }

  // generate Random String
  static String getRandomString(int length) {
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length,
        (_) => randomCharactersAllowed
            .codeUnitAt(rnd.nextInt(randomCharactersAllowed.length))));
  }
}
