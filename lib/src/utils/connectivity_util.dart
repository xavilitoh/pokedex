

import 'dart:io';

import 'package:connectivity/connectivity.dart';

import '../models/response.dart';

Future<Response<ConnectivityResult>> checkConnectivity() async {
  try {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return Response(
        isSuccess: false,
        message: 'Por favor encienda su conexión a Internet.',
        result: connectivityResult,
      );
    } else {
      final respStatus = await _checkStatus(connectivityResult);
      if (respStatus.isSuccess) {
        return Response(
          isSuccess: true,
          result: connectivityResult,
        );
      } else {
        return Response(
          isSuccess: false,
          message: respStatus.message,
          result: connectivityResult,
        );
      }
    }
  } catch (e) {
    return Response(
      isSuccess: false,
      message: 'Error inesperado en checkConnectivity',
      result: ConnectivityResult.none,
      otherData: e,
    );
  }
}

Future<Response<ConnectivityResult>> checkConnectivityMobile() async {
  try {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return Response(
        isSuccess: true,
        result: connectivityResult,
      );
    } else {
      return Response(
        isSuccess: false,
        message: 'No está conectado a la red mobile',
        result: connectivityResult,
      );
    }
  } catch (e) {
    return Response(
      isSuccess: false,
      message: 'Error inesperado en checkConnectivityMobile',
      result: ConnectivityResult.none,
      otherData: e,
    );
  }
}

Future<Response<ConnectivityResult>> checkConnectivityWifi() async {
  try {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi) {
      return Response(
        isSuccess: true,
        result: connectivityResult,
      );
    } else {
      return Response(
        isSuccess: false,
        message: 'No está conectado a la red wifi',
        result: connectivityResult,
      );
    }
  } catch (e) {
    return Response(
      isSuccess: false,
      message: 'Error inesperado en checkConnectivityWifi',
      result: ConnectivityResult.none,
      otherData: e,
    );
  }
}

Future<Response> _checkStatus(ConnectivityResult result) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return Response(
        isSuccess: true,
        result: ''
      );
    } else {
      return Response(
        isSuccess: false,
        message: 'Usted no tiene acceso a internet',
        result: ''
      );
    }
  } on SocketException catch (_) {
    return Response(
      isSuccess: false,
      message: 'Usted no tiene acceso a internet',
      result: ''
    );
  }
}
