import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_uas/common/manage_locations_provider.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/config/provider.dart';
import 'package:mobile_uas/pages/add_locations.dart';
import 'package:mobile_uas/utils/dateformat.dart';
import 'package:mobile_uas/utils/rand_int.dart';
import 'package:mobile_uas/utils/random_weather.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageLocations extends StatefulWidget {
  const ManageLocations({super.key, this.snack, this.city});
  final bool? snack;
  final String? city;

  @override
  State<ManageLocations> createState() => _ManageLocationsState();
}

class _ManageLocationsState extends State<ManageLocations> {

  @override
  void initState() {
    super.initState();
    if(widget.snack == true){
      Future.delayed(Duration.zero, (){
        _showSnackBar();
      });
    }
  }

  void _showSnackBar(){
    ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context));
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MainProvider>(context);
    final manageLocationsProv = Provider.of<ManageLocationsProvider>(context);
    
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: manageLocationsProv.isEditMode 
          ? BottomNavigationBar(
            backgroundColor: Pallete.primary,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Set to Favourite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.delete),
                label: 'Delete',
              ),
            ],
            onTap: (val) async {
              if(manageLocationsProv.manageLocationIds.isEmpty) {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 26, 26, 26),
                    content: const Text('You must select at least 1 location'),
                    actions: [
                      TextButton(
                        child: const Text('Ok', style: TextStyle(
                          color: Colors.white
                        )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
                return;
              }

              if(val == 0) {
                final storage = await SharedPreferences.getInstance();
                final favouriteLocations = prov.favouriteLocations;
                for(final locationId in manageLocationsProv.manageLocationIds) {
                  final findLocationById = favouriteLocations.where((e) => e['id'] == locationId);
                  if(findLocationById.isEmpty) {
                    final favouriteLocations = storage.getStringList('favouriteLocations') ?? [];
                    final findLocation = prov.locations.firstWhere((e) => e['id'] == locationId);
                    prov.setFavouriteLocations = [...prov.favouriteLocations, findLocation];
                    storage.setStringList('favouriteLocations', [...favouriteLocations, jsonEncode(findLocation)]);
                  }
                }
                manageLocationsProv.setManageLocationIds = [].cast<String>();
                manageLocationsProv.setIsEditMode = false;
              } else if(val == 1) {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 26, 26, 26),
                    content: Text('Delete ${manageLocationsProv.manageLocationIds.length} Locations?'),
                    actions: [
                      TextButton(
                        child: const Text('No', style: TextStyle(
                          color: Colors.white
                        )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Yes', style: TextStyle(
                          color: Colors.white
                        )),
                        onPressed: () async {
                          final storage = await SharedPreferences.getInstance();
                          List<Map> allLocations = [];
                          final filteredLocations = (storage.getStringList('locations') ?? []).where((i) => !manageLocationsProv.manageLocationIds.contains(jsonDecode(i)['id'])).toList();
                          storage.setStringList('locations', filteredLocations);
                          for (var element in filteredLocations) {
                            allLocations.add(jsonDecode(element));
                          }
                          prov.setLocations = allLocations;

                          List<Map> allFavouriteLocations = [];
                          final filteredFavouriteLocations = (storage.getStringList('favouriteLocations') ?? []).where((i) => !manageLocationsProv.manageLocationIds.contains(jsonDecode(i)['id'])).toList();
                          storage.setStringList('favouriteLocations', filteredFavouriteLocations);
                          for (var element in filteredFavouriteLocations) {
                            allFavouriteLocations.add(jsonDecode(element));
                          }
                          prov.setFavouriteLocations = allFavouriteLocations;

                          manageLocationsProv.setManageLocationIds = [].cast<String>();
                          manageLocationsProv.setIsEditMode = false;
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    ],
                  ),
                );
              }
            },
          )
          : null,
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
            InkWell(
              onTap: () {
                manageLocationsProv.setIsEditMode = !manageLocationsProv.isEditMode;
              },
              child: const Icon(Icons.more_vert)
            ),
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for(int i = 0; i < prov.favouriteLocations.length; i++)
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        color: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15
                          ),
                          child: Row(
                            children: [
                              if(manageLocationsProv.isEditMode)
                              Checkbox(
                                shape: const CircleBorder(),
                                value: manageLocationsProv.manageLocationIds.contains(prov.favouriteLocations[i]['id']),
                                onChanged: (val) {
                                  if(val!) {
                                    manageLocationsProv.addManageLocationIds = prov.favouriteLocations[i]['id'];
                                    return;
                                  }
                                  manageLocationsProv.removeManageLocationIds = prov.favouriteLocations[i]['id'];
                                }
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(prov.favouriteLocations[i]['city'], style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                    const SizedBox(height: 5,),
                                    Text(prov.favouriteLocations[i]['display'], style: const TextStyle(
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
                    ],
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
                  for(int i = 0; i < prov.locations.length; i++)
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    color: Colors.white10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15
                      ),
                      child: Row(
                        children: [
                          if(manageLocationsProv.isEditMode)
                          Checkbox(
                            shape: const CircleBorder(),
                            value: manageLocationsProv.manageLocationIds.contains(prov.locations[i]['id']),
                            onChanged: (val) {
                              if(val!) {
                                manageLocationsProv.addManageLocationIds = prov.locations[i]['id'];
                                return;
                              }
                              manageLocationsProv.removeManageLocationIds = prov.locations[i]['id'];
                            }
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(prov.locations[i]['city'], style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 5,),
                                Text(prov.locations[i]['display'], style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB1B1B1)
                                ), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 5,),
                                Text(dateformat(format: 'EEE, d MMMM HH:mm', date: DateTime.parse(prov.locations[i]['createdAt'])), style: const TextStyle(
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
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

  showSnackBar(BuildContext global){
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 6),
      content: Text(
        "${widget.city} Added Successfully !"
      ),
      action: SnackBarAction(
        label: "Dismiss",
        textColor: Colors.white,
        onPressed: ()=> ScaffoldMessenger.of(context).removeCurrentSnackBar(),
      ),
    );
  }
}
