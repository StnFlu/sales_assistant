import 'package:equatable/equatable.dart';
import '../../models/lead_model.dart';

abstract class LeadsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchLeads extends LeadsEvent {}

class AddLead extends LeadsEvent {
  final Lead lead;

  AddLead(this.lead);

  @override
  List<Object?> get props => [lead];
}

class UpdateLead extends LeadsEvent {
  final Lead lead;

  UpdateLead(this.lead);

  @override
  List<Object?> get props => [lead];
}

class DeleteLead extends LeadsEvent {
  final String id;

  DeleteLead(this.id);

  @override
  List<Object?> get props => [id];
}
