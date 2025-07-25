class ReminderModel {
  final String id;
  final String name;
  final DateTime date;
  final String relation;
  final String memory;
  final bool isLoss;
  final String? tributeMessage; // A message or memory the user leaves
  final DateTime? lastVisited;   // When the user last "visited" this memory

  ReminderModel({
    required this.id,
    required this.name,
    required this.date,
    required this.relation,
    required this.memory,
    this.isLoss = false,
    this.tributeMessage,
    this.lastVisited,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'date': date.toIso8601String(),
    'relation': relation,
    'memory': memory,
    'isLoss': isLoss,
    'tributeMessage': tributeMessage,
    'lastVisited': lastVisited?.toIso8601String(),
  };

  static ReminderModel fromJson(Map<String, dynamic> json) => ReminderModel(
    id: json['id'],
    name: json['name'],
    date: DateTime.parse(json['date']),
    relation: json['relation'],
    memory: json['memory'],
    isLoss: json['isLoss'] ?? false,
    tributeMessage: json['tributeMessage'],
    lastVisited: json['lastVisited'] != null ? DateTime.parse(json['lastVisited']) : null,
  );
}
