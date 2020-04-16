import 'dart:io';
import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app_1/api/api.dart';

Map<String, dynamic> optHeader = {
  'Accept':'application/json, text/plain, */*',
  'Content-Type':'application/json',
  'jwt':'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1ODMyMTczNzksImV4cCI6MTc0MDg5NzM3OSwiaXNzIjoicmVzdGFwaXVzZXIiLCJpZCI6IjBhOTRhNDI5ZTk4YjQ4OTZhMjE5MmNhOTMwYTE3ZmRjIn0.3hIT82va0HGq8PMN4p4oRW9m3akU6MNvy65ra3duxO0'
};

getHeaders () {
  return {
    'Accept':'application/json, text/plain, */*',
    'Content-Type':'application/json',
    'Authorization':"**",
    'User-Aagent':"4.1.0;android;6.0.1;default;A001",
    "HZUID":"2",
  };
}

var dio = new Dio(BaseOptions(
    baseUrl: Api.BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: optHeader
));

class NetUtils {

  static Future get(String url, [Map<String, dynamic> params]) async {

    var response;

    // 设置代理 便于本地 charles 抓包
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 30.10.24.79:8889";
    //   };
    // };

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;

  }


  static Future post(String url, Map<String, dynamic> params) async {
    // // 设置代理 便于本地 charles 抓包
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 30.10.24.79:8889";
    //   };
    // };
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    var response = await dio.post(url, data: params);
    return response;
  }

}