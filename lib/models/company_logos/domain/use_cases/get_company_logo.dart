import 'package:logo_picker/core/data_state.dart';
import 'package:logo_picker/core/usecase.dart';
import 'package:logo_picker/models/company_logos/domain/entities/company_logo_entity.dart';
import 'package:logo_picker/models/company_logos/domain/repositorys/company_logo_repo.dart';

class GetCompanyLogo extends UseCase<DataState<CompanyLogoEntity?>, String> {
  final CompanyLogoRepository _companyLogoRepository;

  GetCompanyLogo(this._companyLogoRepository);

  @override
  Future<DataState<CompanyLogoEntity?>> call(String params) {
    return _companyLogoRepository.getCompanyLogo(params);
  }
}
