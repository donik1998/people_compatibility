import 'package:dio/dio.dart';

class UriInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.data['uri'] = response.realUri.toString();
    super.onResponse(response, handler);
  }
}
