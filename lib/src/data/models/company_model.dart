import 'package:hive/hive.dart';
part 'company_model.g.dart';

@HiveType(typeId: 0)
class CompanyModel extends HiveObject{

  @HiveField(0)
  late int? key;

  @HiveField(1)
  late String? enterprise;

  @HiveField(2)
  late String? number;

  @HiveField(3)
  late String? comment;

  @HiveField(4)
  late DateTime? date;

  @HiveField(5)
  late String? state;

  CompanyModel({
    this.key,
    this.enterprise, 
    this.number, 
    this.comment, 
    this.date,
    this.state
  });

}