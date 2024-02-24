import 'package:logo_picker/models/company_logos/domain/entities/company_logo_entity.dart';

class CompanyLogoModel extends CompanyLogoEntity {
  CompanyLogoModel({required super.name, required super.ticker, required super.image});
  
  factory CompanyLogoModel.fromJson(Map<String, dynamic> json) {
    return CompanyLogoModel(
      name: json['name'],
      ticker: json['ticker'],
      image: json['image'],
    );
  }
}