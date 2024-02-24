import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_picker/core/data_state.dart';
import 'package:logo_picker/models/company_logos/domain/entities/company_logo_entity.dart';
import 'package:logo_picker/models/company_logos/domain/use_cases/get_company_logo.dart';

abstract class CompanyLogoState {
  final CompanyLogoEntity? state;
  final DioException? exception;
  CompanyLogoState({this.state, this.exception});
}

class CompanyLogoEmptyState extends CompanyLogoState {}

class CompanyLogoLoadingState extends CompanyLogoState {}

class CompanyLogoSuccessState extends CompanyLogoState {
  CompanyLogoSuccessState({super.state});
}

class CompanyLogoFailedState extends CompanyLogoState {
  CompanyLogoFailedState({super.exception});
}

class CompanyLogoClearedState extends CompanyLogoState {
  CompanyLogoClearedState() : super(state: null, exception: null);
}

class CompanyLogoCubit extends Cubit<CompanyLogoState> {
  final GetCompanyLogo _getCompanyLogo;

  CompanyLogoCubit(this._getCompanyLogo) : super(CompanyLogoEmptyState());

  void clear() {
    emit(CompanyLogoClearedState());
  }

  void get(String companyName) async {
      emit(CompanyLogoLoadingState());
    final data = await _getCompanyLogo(companyName);
    if (data is Success) {
      emit(CompanyLogoSuccessState(state: data.data));
    } else {
      emit(CompanyLogoFailedState(exception: data.error));
    }
  }
}
