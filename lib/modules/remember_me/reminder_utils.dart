import 'reminder_model.dart';

/// Builds a human-readable reminder message for today's special dates
String buildHumanReminder(ReminderModel reminder) {
  if (reminder.isLoss) {
    return "Today we remember ${reminder.name}, ${reminder.relation}. "
           "${reminder.memory.isNotEmpty ? reminder.memory : 'Their love continues to guide us.'}";
  } else {
    return "Today is a special day for ${reminder.name}, ${reminder.relation}! "
           "${reminder.memory.isNotEmpty ? reminder.memory : 'Let them know you\'re thinking of them.'}";
  }
}

/// Checks if a reminder is happening today
bool isReminderToday(ReminderModel reminder) {
  final today = DateTime.now();
  return reminder.date.month == today.month && reminder.date.day == today.day;
}

/// Gets upcoming reminders within the next 7 days
List<ReminderModel> getUpcomingReminders(List<ReminderModel> reminders) {
  final today = DateTime.now();
  final oneWeekFromNow = today.add(const Duration(days: 7));
  
  return reminders.where((reminder) {
    // Create this year's version of the reminder date
    final thisYearsDate = DateTime(today.year, reminder.date.month, reminder.date.day);
    return thisYearsDate.isAfter(today) && thisYearsDate.isBefore(oneWeekFromNow);
  }).toList();
}
