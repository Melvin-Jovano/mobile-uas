
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/utils/hour_rotation.dart';
import 'package:mobile_uas/utils/rand_int.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.primary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.menu),
          title: const Row(
            children: [
              Text('Padang Bulan Selayang Ii'),
              SizedBox(width: 10,),
              Icon(Icons.location_pin)
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('27°', style: TextStyle(
                        fontSize: 44
                      ),),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          const Text('33° / 24°', style: TextStyle(
                            fontSize: 12
                          ),),
                          Text(DateFormat('EEEE, HH:mm').format(DateTime.now()), style: const TextStyle(
                            fontSize: 12
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Image.asset('assets/img/full_moon.png')
                ],
              ),

              const SizedBox(height: 10,),

              Container(
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
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
                                  Image.asset('assets/img/full_moon.png', width: 20,),
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
                          semanticsLabel: 'Acme Logo'
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
