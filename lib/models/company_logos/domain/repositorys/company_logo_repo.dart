import 'package:logo_picker/core/data_state.dart';
import 'package:logo_picker/models/company_logos/domain/entities/company_logo_entity.dart';

abstract class CompanyLogoRepository {
  Future<DataState<CompanyLogoEntity?>> getCompanyLogo(String name);
}