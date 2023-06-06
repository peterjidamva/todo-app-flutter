String getTimeAgo(String datetimeString) {
    DateTime datetime = DateTime.parse(datetimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(datetime);

    if (difference.inSeconds < 60) {
      return "just now";
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return "$minutes minute${minutes > 1 ? 's' : ''} ago";
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      return "$hours hour${hours > 1 ? 's' : ''} ago";
    } else {
      int days = difference.inDays;
      return "$days day${days > 1 ? 's' : ''} ago";
    }
  }