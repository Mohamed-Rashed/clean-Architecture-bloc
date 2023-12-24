import 'package:cleanex/core/network/app_error_message_model.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final ErrorMessageModel authErrorMessageModel;
  const Failure(this.authErrorMessageModel);


  @override
  List<Object> get props => [authErrorMessageModel];
}
