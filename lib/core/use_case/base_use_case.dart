import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../error/failure.dart';
import '../utils/constrant.dart';

abstract class BaseUseCase<T,Parameters>{
  Future<Either<Failure,T>> call(Parameters parameter);
}
class NoParameters extends Equatable{
  const NoParameters();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
