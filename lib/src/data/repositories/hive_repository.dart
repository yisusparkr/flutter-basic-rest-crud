import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/src/data/models/company_model.dart';

class HiveRepository {

  static const String companiesBox = 'companies';

  Future<void> initDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CompanyModelAdapter());
    await Hive.openBox<CompanyModel>(companiesBox);
  }

  Future<List<CompanyModel>> getInterviews() async {
    final box = Hive.box<CompanyModel>(companiesBox);
    return box.values.toList();
  }

  Future<int> addInterview() async {
    final box = Hive.box<CompanyModel>(companiesBox);
    final key = await box.add(CompanyModel());
    return key;
  }

  Future<void> modifyInterview( int key, {String? name, String? comment, String? number, String? date } ) async {
    final box = Hive.box<CompanyModel>(companiesBox);
    CompanyModel company = box.get(key)!;
    company.enterprise = name ?? company.enterprise;
    company.comment = comment ?? company.comment;
    company.number = number ?? company.number;
    company.date = date ?? company.date;
    company.state = 'Pending';
    await box.putAt(key, company);
  }

  Future<void> saveInterview( int key ) async {
    final box = Hive.box<CompanyModel>(companiesBox);
    CompanyModel company = box.get(key)!;
    company.state = 'Completed';
    await box.putAt(key, company);
  }

}