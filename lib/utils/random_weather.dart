String randomWeather({List<String> list = const [
  'assets/img/cloudy.png', 
  'assets/img/full_moon.png',
  'assets/img/midnight.png',
  'assets/img/thunder.png',
  'assets/img/thunderstorm.png',
]}) {
  return (list.toList()..shuffle()).first;
}
