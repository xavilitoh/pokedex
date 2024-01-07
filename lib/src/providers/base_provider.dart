

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:ladex/src/models/response.dart';

import '../utils/connectivity_util.dart';
import '../utils/constants.dart';

class BaseProvider {
  Future<Response<String>> apiGet({
    required String endPoint,
    String baseUrl = baseAPIUrl,
    String token = '',
    // String body,
    required Map<String, String> headers,
  }) async {
    try {
      final Response<ConnectivityResult> respConn = await checkConnectivity();
      if (!respConn.isSuccess) {
        return Response(
          isSuccess: false,
          message: respConn.message,
          otherData: respConn.otherData,
          result: ''
        );
      }

      final url = Uri.parse('$baseUrl/$endPoint');

      final resp = await http.get(
        url,
        headers: headers,
      );

      if (resp.statusCode >= 200 && resp.statusCode <= 206) {
        return Response(
          isSuccess: true,
          result: resp.body,
          otherData: resp.statusCode,
        );
      } else {
        return Response(
          isSuccess: false,
          message: resp.body,
          otherData: resp.statusCode,
          result: ''
        );
      }
    } catch (e) {
      return Response(
        isSuccess: false,
        message: 'Error inesperdado en apiGet.',
        otherData: e,
        result: ''
      );
    }
  }
}
