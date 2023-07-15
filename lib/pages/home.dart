import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile_uas/config/days.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/config/provider.dart';
import 'package:mobile_uas/pages/manage_locations.dart';
import 'package:mobile_uas/pages/news.dart';
import 'package:mobile_uas/pages/settings.dart';
import 'package:mobile_uas/utils/dateformat.dart';
import 'package:mobile_uas/utils/hour_rotation.dart';
import 'package:mobile_uas/utils/rand_int.dart';
import 'package:mobile_uas/utils/random_weather.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    initSelectedLocation();
    initLocations();
    super.initState();
  }

  initFavouriteLocations() async {
    final storage = await SharedPreferences.getInstance();
    List<Map> favouriteLocations = [];
    final otherLocation = storage.getStringList('favouriteLocations');

    if(otherLocation != null) {
      for (var element in otherLocation) {
        favouriteLocations.add(jsonDecode(element));
      }
    }

    if(context.mounted) {
      Provider.of<MainProvider>(context, listen: false).setFavouriteLocations = favouriteLocations;
    }
  }

  initLocations() async {
    final storage = await SharedPreferences.getInstance();
    List<Map> allLocations = [];
    final otherLocation = storage.getStringList('locations');

    if(otherLocation != null) {
      for (var element in otherLocation) {
        allLocations.add(jsonDecode(element));
      }
    }

    if(context.mounted) {
      Provider.of<MainProvider>(context, listen: false).setLocations = allLocations;
    }
  }

  initSelectedLocation() async {
    final storage = await SharedPreferences.getInstance();
    final selectedLocation = storage.getString('selectedLocation');

    if(context.mounted) {
      if(selectedLocation != null) {
        Provider.of<MainProvider>(context, listen: false).setSelectedLocation = selectedLocation;
        return;
      }

      Provider.of<MainProvider>(context, listen: false).setSelectedLocation = {
        'city': 'Padang Bulan Selayang Ii',
        'display': 'Medan, Indonesia',
        'id': '7c518ade-d340-4561-a766-cc8b8bd6b1a3',
        'createdAt': DateTime.now().toIso8601String()
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MainProvider>(context);

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)),
          ),
          backgroundColor: const Color(0xFF202020),
          child: Container(
            padding: const EdgeInsets.all(25),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (_)=> const SettingsScreen()
                        )
                      );
                    }, 
                    icon: const Icon(
                      Icons.settings, 
                      color: Color(0xFFA6A6A6)
                    )
                  )
                ),
                const SizedBox(height: 10,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.blue),
                        SizedBox(width: 7,),
                        Text('Favourite location', style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    Icon(Icons.info_outline, color: Color(0xFFA6A6A6),)
                  ],
                ),
                const SizedBox(height: 30,),
                for(int i = 0; i < prov.favouriteLocations.length; i++)
                Row(
                  children: [
                    const SizedBox(width: 25,),
                    const Icon(Icons.location_pin, color: Colors.white, size: 16,),
                    const SizedBox(width: 1,),
                    Expanded(child: Text(prov.favouriteLocations[i]['city'], style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ), maxLines: 1, overflow: TextOverflow.ellipsis,),),
                    const SizedBox(width: 2,),
                    Image.asset(randomWeather(), fit: BoxFit.fill, height: 30,),
                    const SizedBox(width: 4,),
                    Text('${randInt(23, 29)}°', style: const TextStyle(
                      fontSize: 18
                    )),
                  ],
                ),

                const Divider(color: Colors.white24, thickness: 1, height: 50,),

                const Row(
                  children: [
                    Icon(Icons.add_location_outlined, color: Color(0xFFA6A6A6)),
                    SizedBox(width: 7,),
                    Text('Other location', style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                const SizedBox(height: 10,),
                for(int i = 0; i < prov.locations.length; i++)
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 33,),
                        Expanded(child: Text(prov.locations[i]['city'], style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ), maxLines: 1, overflow: TextOverflow.ellipsis,),),
                        const SizedBox(width: 2,),
                        Image.asset(
                          randomWeather(),
                          fit: BoxFit.fill, 
                          height: 30,
                        ),
                        const SizedBox(width: 4,),
                        Text('${randInt(23, 29)}°', style: const TextStyle(
                          fontSize: 18
                        )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                    ),
                    backgroundColor: const MaterialStatePropertyAll(Color(0xFF3A3A3A))
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageLocations()),
                    );
                  },
                  child: const Text('Manage locations', style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                ),
                const Divider(color: Colors.white24, thickness: 1, height: 40,),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFFA6A6A6),),
                    SizedBox(width: 8,),
                    Text('Report wrong location', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ))
                  ],
                ),
                const SizedBox(height: 25,),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.headphones_sharp, color: Color(0xFFA6A6A6),),
                    SizedBox(width: 8,),
                    Text('Contact us', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ))
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (_) => const NewsPage()
              )
            );
          },
          backgroundColor: const Color(0xFF2D2D2D),
          child: Image.asset('assets/img/news.png', height: 60,),
        ),
        backgroundColor: Pallete.primary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Text(prov.selectedLocation['city'] ?? 'Loading...'),
              const SizedBox(width: 10,),
              const Icon(Icons.location_pin)
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20
          ),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('${randInt(23, 29)}°', style: const TextStyle(
                          fontSize: 44
                        ),),
                        const SizedBox(width: 10,),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Text('${randInt(30, 35)}° / ${randInt(23, 29)}°', style: const TextStyle(
                              fontSize: 12
                            ),),
                            Text(dateformat(), style: const TextStyle(
                              fontSize: 12
                            ),),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(randomWeather(), width: 56)
                  ],
                ),
              ),

              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 20),
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int index = 0; index < 11; index++)
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(hourRotation(
                                      int.parse(DateFormat('H').format(DateTime.now())),
                                      index+1
                                    ), style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white54
                                    ),),
                                    const SizedBox(height: 10,),
                                    Image.asset(randomWeather(), width: 20,),
                                    const SizedBox(height: 10,),
                                    Text('${randInt(23, 29)}°', style: const TextStyle(
                                      fontSize: 12,
                                    ),),
                                  ],
                                ),
                                if(index != 10)
                                const SizedBox(width: 12,)
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.5,
                            vertical: 20
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/line_temp.svg',
                          ),
                        ),
                        Row(
                          children: [
                            for(int index = 0; index < 11; index++)
                            Row(
                              children: [
                                const Icon(Icons.water_drop, color: Colors.white, size: 8,),
                                const SizedBox(width: 2,),
                                Text('${randInt(40, 100)}%', style: const TextStyle(
                                  fontSize: 9
                                ),),
                                if(index != 10)
                                const SizedBox(width: 12,),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: EdgeInsets.only(bottom: 20),
                color: Colors.white10,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text('Six Hour Storm Outlook', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),),
                        SizedBox(height: 10,),
                        Text('Storms ending around 09:00 pm', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB1B1B1)
                        ),),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle, color: Colors.white, size: 10,),
                            SizedBox(width: 10,),
                            Icon(Icons.circle, color: Color(0xFF6B6B6B), size: 10,),
                            SizedBox(width: 10,),
                            Icon(Icons.circle, color: Color(0xFF6B6B6B), size: 10,),
                            SizedBox(width: 10,),
                            Icon(Icons.circle, color: Color(0xFF6B6B6B), size: 10,),
                          ],
                        )
                      ],
                    )
                  ),
                ),
              ),

              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 20),
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Yesterday', style: TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.bold
                          ),),
                          Text('${randInt(30, 35)}°${randInt(20, 25)}°', style: const TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      for(int i = 0; i < 7; i++)
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(i == DateTime.now().weekday-1 ? 'Today' : days[i], style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.water_drop, size: 9, color: Colors.white,),
                              const SizedBox(width: 2,),
                              Text('${randInt(30, 80)}%', style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11
                              ),),
                            ],
                          ),
                          const SizedBox(width: 25,),
                          Image.asset(randomWeather(), width: 20,),
                          const SizedBox(width: 25,),
                          Image.asset(randomWeather(), width: 20,),
                          const SizedBox(width: 25, height: 30,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('${randInt(30, 35)}°${randInt(20, 25)}°', style: const TextStyle(
                            fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom: 20),
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Sunrise', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),),
                            const SizedBox(height: 10,),
                            const Text('06:14', style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                            const SizedBox(height: 20,),
                            Image.asset('assets/img/sunrise.png', width: 61,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Sunset', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),),
                            const SizedBox(height: 10,),
                            const Text('18:30', style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                            const SizedBox(height: 20,),
              
                            Image.asset('assets/img/sunset.png', width: 61,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
