import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:jwt_decode/jwt_decode.dart';

extension JwtExtension on Jwt {
  static String getUserId(String token) {
    final decodedToken = Jwt.parseJwt(token);

    if (decodedToken['id'] != null) {
      return decodedToken['id'] as String;
    }

    throw IncorrectKeyException(key: 'id');
  }
}
