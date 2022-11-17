// ignore_for_file: unused_field

import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;
  
  ApiClient({ required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token =AppConstants.TOKEN;
    _mainHeaders={
      'Content-type':'applications/json; multipart/form-data; charset=UTF-8',
      'Authorization': 'Bearer $token',
      // 'Connection': 'Keep-Alive',
    };
  }
  
  void updateHeader(String token){
     _mainHeaders={
      'Content-type':'applications/json; multipart/form-data; charset=UTF-8',
      'Authorization': 'Bearer $token',
      // 'Connection': 'Keep-Alive',
    };
  }
  Future<Response> getData(String uri,) async {
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      // Fluttertoast.showToast(
      //   msg: e.toString(),  // message
      //   toastLength: Toast.LENGTH_SHORT, // length
      //   gravity: ToastGravity.CENTER,    // location
      //   timeInSecForIosWeb: 1               // duration
      //   );
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  
  Future<Response> postData(String uri, dynamic body) async{
    print(body.toString());
    try {
      Response response= await post(uri, body, headers: _mainHeaders);
      print(response.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}