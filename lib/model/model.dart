import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject{
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? description;
  DataModel({this.title,this.description});
}