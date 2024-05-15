String checkDate(DateTime date) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime inputDateOnly = DateTime(date.year, date.month, date.day);

  // Check if the date is today
  if (inputDateOnly == today) {
    return 'Today';
  }

  // Check if the date is in the previous week
  DateTime startOfCurrentWeek =
      today.subtract(Duration(days: today.weekday - 1));
  DateTime startOfPreviousWeek = startOfCurrentWeek.subtract(Duration(days: 7));
  DateTime endOfPreviousWeek =
      startOfCurrentWeek.subtract(Duration(seconds: 1));
  if (inputDateOnly.isAfter(startOfPreviousWeek) &&
      inputDateOnly.isBefore(endOfPreviousWeek)) {
    return 'Last Week';
  }

  // Check if the date is in the previous month
  DateTime startOfCurrentMonth = DateTime(now.year, now.month, 1);
  DateTime startOfPreviousMonth = DateTime(now.year, now.month - 1, 1);
  DateTime endOfPreviousMonth =
      startOfCurrentMonth.subtract(Duration(seconds: 1));
  if (inputDateOnly.isAfter(startOfPreviousMonth) &&
      inputDateOnly.isBefore(endOfPreviousMonth)) {
    return 'Last Month';
  }

  return 'Other';
}
