import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logo_picker/models/company_logos/data/company_logo_repo_impl.dart';
import 'package:logo_picker/models/company_logos/data/company_logo_service.dart';
import 'package:logo_picker/models/company_logos/domain/use_cases/get_company_logo.dart';
import 'package:logo_picker/models/company_logos/ui/company_logo_state.dart';

final di = GetIt.instance;

Future<void> inject() async {
  // Dio into CompanyLogoService
  final dio = Dio();
  di.registerSingleton<CompanyLogoService>(CompanyLogoService(dio));

  // Service into CompanyLogoRepositoryImpl
  di.registerSingleton<CompanyLogoRepositoryImpl>(CompanyLogoRepositoryImpl(di()));

  // companyLogoRepository into GetCompanyLogo
  di.registerSingleton<GetCompanyLogo>(GetCompanyLogo(di.get<CompanyLogoRepositoryImpl>()));
  
  // getCompanyLogo into CompanyLogoCubit
  di.registerSingleton<CompanyLogoCubit>(CompanyLogoCubit(di.get<GetCompanyLogo>()));
}