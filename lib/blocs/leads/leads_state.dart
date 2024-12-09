import 'package:equatable/equatable.dart';
import '../../models/lead_model.dart';

abstract class LeadsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeadsInitial extends LeadsState {}

class LeadsLoading extends LeadsState {}

class LeadsLoaded extends LeadsState {
  final List<Lead> leads;

  LeadsLoaded(this.leads);

  @override
  List<Object?> get props => [leads];
}

class LeadsError extends LeadsState {
  final String message;

  LeadsError(this.message);

  @override
  List<Object?> get props => [message];
}
