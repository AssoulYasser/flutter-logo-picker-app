import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:logo_picker/models/company_logos/data/company_logo_model.dart';
import 'package:logo_picker/models/company_logos/data/constants.dart';

class CompanyLogoService {
  final Dio _dio;
  final String _endPoint = '/v1/logo';

  CompanyLogoService(this._dio);

  Future<CompanyLogoModel> getCompanyLogo(String name) async {
    final response = await _dio.get(
      baseUrl + _endPoint,
      queryParameters: {'name': name},
      options: Options(
        headers: {apiKeyHeaderName: apiKeyValue},
      ),
    );
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! > 299 ||
        response.data == null ||
        response.data is! List<dynamic> ||
        (response.data as List<dynamic>).isEmpty) {
      throw DioException(
          requestOptions: response.requestOptions,
          error: 'No Data Has Been Received',
          response: response,
          type: DioExceptionType.badResponse);
    }
    final data = CompanyLogoModel.fromJson(response.data[0]!);
    return data;
  }
}
