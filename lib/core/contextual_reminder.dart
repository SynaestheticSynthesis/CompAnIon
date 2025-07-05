import 'dart:async';

void scheduleContextualReminder(Duration interval, String message, void Function()? onReminder) {
  Timer(interval, () {
    // You can replace this with a UI notification or callback
    print('Reminder: $message');
    if (onReminder != null) onReminder();
  });
}
