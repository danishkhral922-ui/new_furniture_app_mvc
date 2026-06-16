import 'package:dio/dio.dart';

class NotificationService {
  final String _baseUrl = 'https://dummyjson.com';
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchNotifications() async {
    try {
      Response response = await _dio.get('$_baseUrl/products?_limit=40');

      if (response.statusCode == 200) {
        return response.data['products'];
      } else {
        throw Exception('Notification not received from the Server');
      }
    } catch (e) {
      throw Exception('API Integration call Failed: $e');
    }
  }

  Future<Map<String, dynamic>> updatenotificationstatus(
    int id,
    bool status,
  ) async {
    try {
      Map<String, dynamic> bodyData = {
        'title': 'This notification status is updated to read',
      };
      Response response = await _dio.put(
        '$_baseUrl/products/$id',
        data: bodyData,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Notifiacation not update on the server');
      }
    } catch (e) {
      throw Exception('Notification PUT API Fail');
    }
  }
}
