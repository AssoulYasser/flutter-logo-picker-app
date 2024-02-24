import 'package:dio/dio.dart';
import 'package:logo_picker/core/data_state.dart';
import 'package:logo_picker/models/company_logos/data/company_logo_model.dart';
import 'package:logo_picker/models/company_logos/data/company_logo_service.dart';
import 'package:logo_picker/models/company_logos/domain/repositorys/company_logo_repo.dart';

class CompanyLogoRepositoryImpl extends CompanyLogoRepository {
  final CompanyLogoService service;

  CompanyLogoRepositoryImpl(this.service);

  @override
  Future<DataState<CompanyLogoModel?>> getCompanyLogo(String name) async {
    try {
      final response = await service.getCompanyLogo(name);
      return Success(response);
    } on DioException catch (e) {
      return Failed(e);
    }
  }
}
