import 'package:equatable/equatable.dart';

class SkillParameter extends Equatable{

  final String skillName;
  final String? skillName2;

  SkillParameter({

     required this.skillName,
    this.skillName2

  });

  @override
  // TODO: implement props
  List<Object?> get props => [skillName];

}

class CategoryParameter extends Equatable{
  final int id;


  CategoryParameter({
   required this.id,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
class ProductParameter extends Equatable{
  final int id,price;
  final String title,description;
  final String category;
  final String  image;


  ProductParameter({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.image,
    required this.category
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,price,title,description,image,category
  ];

}