import 'dart:convert';

class SyncQueueModel {
  final String id;
  final String operation;
  final Map<String, dynamic> data;

  SyncQueueModel({
    required this.id,
    required this.operation,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'operation': operation,
        'data': jsonEncode(data),
      };

  factory SyncQueueModel.fromJson(Map<String, dynamic> json) => SyncQueueModel(
        id: json['id'],
        operation: json['operation'],
        data: jsonDecode(json['data']),
      );
}
