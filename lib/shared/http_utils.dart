import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  HttpUtil() {
    options = new BaseOptions(
      baseUrl: "http://138.49.101.89:3000/api/v1/",
      connectTimeout: 20000,
      receiveTimeout: 20000,
      responseType: ResponseType.json,
    );
    dio = new Dio(options);
    dio.interceptors.add(CookieManager(CookieJar()));
//    dio.transformer = FlutterTransformer();
  }

  CancelToken cancelToken = new CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = new HttpUtil();
    return instance;
  }

  get(url, {data, options, cancelToken}) async {
    try {
      return dio.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
    }
  }

  post<T>(url, {data, options, cancelToken}) async {
    try {
      return dio.post<T>(url, data: data, options: options, cancelToken: cancelToken);
    } on DioError catch (e) {
      formatError(e);
    }
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }
}