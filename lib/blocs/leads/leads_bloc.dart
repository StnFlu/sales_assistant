import 'package:bloc/bloc.dart';
import 'leads_event.dart';
import 'leads_state.dart';
import '../../models/lead_model.dart';
import '../../repositories/lead_repository.dart';

class LeadsBloc extends Bloc<LeadsEvent, LeadsState> {
  final LeadRepository leadRepository;

  LeadsBloc(this.leadRepository) : super(LeadsInitial()) {
    on<FetchLeads>(_onFetchLeads);

    on<AddLead>((event, emit) async {
      if (state is LeadsLoaded) {
        try {
          await leadRepository.addLead(event.lead);
          final updatedLeads = List<Lead>.from((state as LeadsLoaded).leads)
            ..add(event.lead);
          emit(LeadsLoaded(updatedLeads));
        } catch (e) {
          emit(LeadsError('Failed to add lead.'));
        }
      }
    });

    on<UpdateLead>((event, emit) async {
      if (state is LeadsLoaded) {
        try {
          await leadRepository.updateLead(event.lead);
          final updatedLeads = (state as LeadsLoaded).leads.map((lead) {
            return lead.id == event.lead.id ? event.lead : lead;
          }).toList();
          emit(LeadsLoaded(updatedLeads));
        } catch (e) {
          emit(LeadsError('Failed to update lead.'));
        }
      }
    });

    on<DeleteLead>((event, emit) async {
      if (state is LeadsLoaded) {
        try {
          await leadRepository.deleteLead(event.id);
          final updatedLeads = (state as LeadsLoaded)
              .leads
              .where((lead) => lead.id != event.id)
              .toList();
          emit(LeadsLoaded(updatedLeads));
        } catch (e) {
          emit(LeadsError('Failed to delete lead.'));
        }
      }
    });
  }

  Future<void> _onFetchLeads(FetchLeads event, Emitter<LeadsState> emit) async {
    emit(LeadsLoading());
    try {
      final leads = await leadRepository.fetchLeads();
      emit(LeadsLoaded(leads));
    } catch (e) {
      emit(LeadsError('Failed to fetch leads.'));
    }
  }
}
