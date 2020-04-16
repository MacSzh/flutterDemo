
import './net_utils.dart';
import 'package:flutter_app_1/api/api.dart';

class DataUtils {

  static Future getShopList(Map<String, String> params) async {
    var response = await NetUtils.get(Api.GET_SHOP_PROJECT, params);
    return response;
  }

  static Future reserveHistory(Map<String, String> params) async {
    var response = await NetUtils.get(Api.RESERVEHISTORY, params);
    return response;
  }

}