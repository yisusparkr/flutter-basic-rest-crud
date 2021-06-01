import 'package:hive/hive.dart';
part 'company_model.g.dart';

@HiveType(typeId: 0)
class CompanyModel extends HiveObject{

  @HiveField(0)
  late String? enterprise;

  @HiveField(1)
  late String? number;

  @HiveField(2)
  late String? comment;

  @HiveField(3)
  late String? date;

  @HiveField(4)
  late String? state;

  CompanyModel({
    this.enterprise, 
    this.number, 
    this.comment, 
    this.date,
    this.state
  });

}