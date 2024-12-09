import '../models/lead_model.dart';

class LeadRepository {
  List<Lead> _mockLeads = [
    Lead(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        status: 'New',
        taskIds: ['1', '2']),
    Lead(
        id: '2',
        name: 'Jane Smith',
        email: 'jane.smith@example.com',
        status: 'Contacted',
        taskIds: ['3']),
    Lead(
        id: '3',
        name: 'Alice Johnson',
        email: 'alice.johnson@example.com',
        status: 'Converted',
        taskIds: ['4']),
  ];

  Future<List<Lead>> fetchLeads() async {
    return _mockLeads;
  }

  Future<void> addLead(Lead lead) async {
    _mockLeads.add(lead);
  }

  Future<void> updateLead(Lead lead) async {
    _mockLeads = _mockLeads.map((l) => l.id == lead.id ? lead : l).toList();
  }

  Future<void> deleteLead(String id) async {
    _mockLeads.removeWhere((lead) => lead.id == id);
  }
}
