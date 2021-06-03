import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/src/data/models/company_model.dart';

class HiveRepository {

  Future<void> initDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CompanyModelAdapter());
  }

  Future<void> openBox( String boxName ) async {
    await Hive.openBox<CompanyModel>(boxName);
  }

  Future<List<CompanyModel>> getInterviews( String boxName ) async {
    final box = Hive.box<CompanyModel>(boxName);
    List<CompanyModel> interviews = box.values.toList();
    interviews.sort( (a,b) {
      if ( a.date != null && b.date != null ) {
        return b.date!.compareTo(a.date!);
      } 
      return 0;
    });
    return interviews;
  }

  Future<int> addInterview( String boxName ) async {
    final box = Hive.box<CompanyModel>(boxName);
    final key = await box.add(CompanyModel());
    CompanyModel interview = box.get(key)!;
    interview.key = key;
    await box.put(key, interview);
    return key;
  }

  Future<void> deleteInterview( int key, String boxName ) async {
    final box = Hive.box<CompanyModel>(boxName);
    await box.delete(key);
  }

  Future<void> modifyInterview( int key, String boxName, {String? name, String? comment, String? number, DateTime? date } ) async {
    final box = Hive.box<CompanyModel>(boxName);
    CompanyModel company = box.get(key)!;
    company.enterprise = name ?? company.enterprise;
    company.comment = comment ?? company.comment;
    company.number = number ?? company.number;
    company.date = date ?? company.date;
    company.state = 'Pending';
    await box.put(key, company);
  }

  Future<void> saveInterview( int key, String boxName ) async {
    final box = Hive.box<CompanyModel>(boxName);
    CompanyModel company = box.get(key)!;
    company.state = 'Completed';
    await box.put(key, company);
  }

  Future<void> deleteCompletedInterviews( String boxName ) async {
    final box = Hive.box<CompanyModel>(boxName);
    box.values.map((interview) async {
      if ( interview.state == 'Completed' ) {
        await box.delete(interview.key);
      }
    }).toList();
  }

  bool hasCompletedInterviews( String boxName ) {
    final box = Hive.box<CompanyModel>(boxName);
    final interviews = box.values.toList();
    bool hasCompleted = false;
    
    for( final interview in interviews ) {
      if ( interview.state == 'Completed' ) {
        hasCompleted = true;
        break;
      }
    }

    return hasCompleted;
  }

}