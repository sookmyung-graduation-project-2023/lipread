import 'package:dio/dio.dart';
import 'package:lipread/services/interceptor.dart';

class API {
  static const String baseURL =
      'https://kjs7fnngz2.execute-api.ap-northeast-2.amazonaws.com';

  static const String websocktURL =
      'wss://xbg8dpf1x4.execute-api.ap-northeast-2.amazonaws.com/production';

  static final dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(
        minutes: 5,
      ),
      responseType: ResponseType.bytes,
    ),
  )..interceptors.add(TokenInterceptors());
}

class Paths {
  static const String refresh = 'refresh';
  static const String login = 'login';
  static const String roleplayList = 'roleplayList';
  static const String roleplay = 'roleplay';
  static const String official = 'official';
  static const String personal = 'personal';
  static const String newTopic = 'newTopic';
  static const String usedTopic = 'usedTopic';
  static const String chatList = 'chatList';
  static const String checkChat = 'checkChat';
  static const String learningRecord = 'learningRecord';
  static const String user = 'user';
  static const String learningData = 'learningData';
  static const String monthlyData = "monthlyData";
}
