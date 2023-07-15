import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_uas/common/city.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/config/provider.dart';
import 'package:mobile_uas/pages/manage_locations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddLocations extends StatefulWidget {
  const AddLocations({super.key});

  @override
  State<AddLocations> createState() => _AddLocationsState();
}

class _AddLocationsState extends State<AddLocations> {
  bool isActive = false;
  List<City> cities = [];
  Timer? _debounce;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MainProvider>(context);
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.primary,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            onChanged: (val) async {
                              if(_debounce?.isActive ?? false) _debounce?.cancel();
                                _debounce = Timer(const Duration(milliseconds: 1000), () async {
                                if(val.isNotEmpty) {
                                  setState(() {
                                    cities = [];
                                    isActive = true;
                                  });
                                  final q = await Dio().get('https://nominatim.openstreetmap.org/search?format=json&addressdetails=1&namedetails=1&q=$val');
                                  q.data.forEach((c) {
                                    if(c['namedetails'] != null && c['display_name'] != null) {
                                      setState(() {
                                        cities.add(City(
                                          city: c['namedetails']['name'],
                                          display: c['display_name'], 
                                        ));
                                      });
                                    }
                                  });
                                  return;
                                }
                                
                                setState(() {
                                  isActive = false;
                                  cities = [];
                                });
                              });
                            },
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: 'Search location',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic
                              ),
                              suffixIcon: isActive 
                                ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      controller.text = '';
                                      isActive = false;
                                      cities = [];
                                    });
                                  },
                                  child: const Icon(Icons.close)
                                )
                                : null ,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey, 
                                  width: 0.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      if(cities.isNotEmpty)
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        color: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  for(int i = 0; i < cities.length; i++)
                                  Column(
                                    children: [
                                      ListTile(
                                        onTap: () async {
                                          final storage = await SharedPreferences.getInstance();
                                          final selectedLocation = {
                                            'city': cities[i].city,
                                            'display': cities[i].display,
                                            'id': const Uuid().v4(),
                                            'createdAt': DateTime.now().toIso8601String()
                                          };
                                          final locationsStored = storage.getStringList('locations');
                                          if(locationsStored != null && locationsStored.isNotEmpty) {
                                            storage.setStringList('locations', [...locationsStored, jsonEncode(selectedLocation)]);
                                          } else {
                                            storage.setStringList('locations', [jsonEncode(selectedLocation)]);
                                          }

                                          if(context.mounted) {
                                            List<Map> allLocations = [];
                                            final otherLocation = storage.getStringList('locations');

                                            if(otherLocation != null) {
                                              for (var element in otherLocation) {
                                                allLocations.add(jsonDecode(element));
                                              }
                                            }

                                            prov.setLocations = allLocations;

                                            Navigator.pushReplacement(
                                              context, 
                                              MaterialPageRoute(
                                                builder: (_)=> const ManageLocations()
                                              )
                                            );
                                          }
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(cities[i].city, style: const TextStyle(
                                          fontSize: 18
                                        ),),
                                        subtitle: Text(cities[i].display, style: const TextStyle(
                                          color: Color(0xFFB1B1B1),
                                          fontSize: 12
                                        ), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                      ),
                                      const Divider(color: Colors.white24, thickness: 1, height: 5,),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
