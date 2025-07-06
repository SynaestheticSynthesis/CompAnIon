class ReminderModel {
  final String id;
  final String name;
  final DateTime date;
  final String relation;
  final String memory;
  final bool isLoss;

  ReminderModel({
    required this.id,
    required this.name,
    required this.date,
    required this.relation,
    required this.memory,
    this.isLoss = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'date': date.toIso8601String(),
    'relation': relation,
    'memory': memory,
    'isLoss': isLoss,
  };

  static ReminderModel fromJson(Map<String, dynamic> json) => ReminderModel(
    id: json['id'],
    name: json['name'],
    date: DateTime.parse(json['date']),
    relation: json['relation'],
    memory: json['memory'],
    isLoss: json['isLoss'] ?? false,
  );
}
