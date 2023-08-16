import 'package:dio/dio.dart';

class DioService {
  Dio dio = Dio();

  Future sendRequest(String filePath, String endPoint) async {
    dio.options.headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final file = await MultipartFile.fromFile(filePath, filename: 'fileName');

    final formData = FormData.fromMap({'file': file});
    print('formData : ${formData}');
    final response = await dio.post(
      'https://melo-mihira-api.onrender.com/demographicsImage',
      data: formData,
    );
    
    // final response = await dio.get(
    //   // 'http://0.0.0.0:8081/demographicsImage',
    //   'http://0.0.0.0:8081/HelloWorld'
    //   // data: formData,
    // );

    return response.data;
  }
}
