String hourCheck(int hour) { 
  if(hour < 10) {
    return '0$hour:00';
  }

  return '$hour:00';
}