class ReminderModel {
  final String id;
  final String name;
  final DateTime date;
  final String relation;
  final String memory;
  final bool isLoss;
  final String tributeMessage;
  final DateTime? lastVisited;

  ReminderModel({
    required this.id,
    required this.name,
    required this.date,
    required this.relation,
    required this.memory,
    required this.isLoss,
    this.tributeMessage = '',
    this.lastVisited,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'relation': relation,
      'memory': memory,
      'isLoss': isLoss,
      'tributeMessage': tributeMessage,
      'lastVisited': lastVisited?.toIso8601String(),
    };
  }

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      date: DateTime.parse(json['date']),
      relation: json['relation'] ?? '',
      memory: json['memory'] ?? '',
      isLoss: json['isLoss'] ?? false,
      tributeMessage: json['tributeMessage'] ?? '',
      lastVisited: json['lastVisited'] != null 
          ? DateTime.parse(json['lastVisited']) 
          : null,
    );
  }

  ReminderModel copyWith({
    String? id,
    String? name,
    DateTime? date,
    String? relation,
    String? memory,
    bool? isLoss,
    String? tributeMessage,
    DateTime? lastVisited,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      relation: relation ?? this.relation,
      memory: memory ?? this.memory,
      isLoss: isLoss ?? this.isLoss,
      tributeMessage: tributeMessage ?? this.tributeMessage,
      lastVisited: lastVisited ?? this.lastVisited,
    );
  }
}
