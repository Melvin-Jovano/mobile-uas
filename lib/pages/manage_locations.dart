import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/pages/add_locations.dart';
import 'package:mobile_uas/utils/dateformat.dart';
import 'package:mobile_uas/utils/rand_int.dart';
import 'package:mobile_uas/utils/random_weather.dart';

class ManageLocations extends StatefulWidget {
  const ManageLocations({super.key});

  @override
  State<ManageLocations> createState() => _ManageLocationsState();
}

class _ManageLocationsState extends State<ManageLocations> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.primary,
        appBar: AppBar(
          leading: InkWell(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            InkWell(
              child: const Icon(Icons.add),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddLocations()),
                );
              }
            ),
            const SizedBox(width: 7,),
            const Icon(Icons.more_vert),
            const SizedBox(width: 12,),
          ],
          backgroundColor: Colors.transparent,
          title: const Text('Manage Locations'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      SizedBox(width: 19,),
                      Text('Favourite location', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB1B1B1)
                      ),),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    color: Colors.white10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Padang Bulan Selayang Ii', style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 5,),
                                const Text('North Sumatra, Indonesia', style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB1B1B1)
                                ),),
                                const SizedBox(height: 5,),
                                Text(dateformat(format: 'EEE, d MMMM HH:mm'), style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB1B1B1)
                                ),),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(randomWeather(), width: 39,),
                                const SizedBox(width: 8,),
                                Column(
                                  children: [
                                    Text('${randInt(23, 29)}°', style: const TextStyle(
                                      fontSize: 26
                                    ),),
                                    const SizedBox(height: 2,),
                                    Text('${randInt(30, 35)}° / ${randInt(23, 29)}°', style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB1B1B1)
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      SizedBox(width: 19,),
                      Text('Other location', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB1B1B1)
                      ),),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    color: Colors.white10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Padang Bulan Selayang Ii', style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 5,),
                                const Text('North Sumatra, Indonesia', style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB1B1B1)
                                ),),
                                const SizedBox(height: 5,),
                                Text(dateformat(format: 'EEE, d MMMM HH:mm'), style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB1B1B1)
                                ),),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(randomWeather(), width: 39,),
                                const SizedBox(width: 8,),
                                Column(
                                  children: [
                                    Text('${randInt(23, 29)}°', style: const TextStyle(
                                      fontSize: 26
                                    ),),
                                    const SizedBox(height: 2,),
                                    Text('${randInt(30, 35)}° / ${randInt(23, 29)}°', style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB1B1B1)
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
