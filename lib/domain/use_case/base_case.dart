import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';

abstract class BaseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
