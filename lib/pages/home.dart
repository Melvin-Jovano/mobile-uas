
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile_uas/config/days.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: const Color(0xFF2D2D2D),
          child: Image.asset('assets/img/news.png'),
        ),
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
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
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
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 20),
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
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: const Center(
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

              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
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
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              const Icon(Icons.water_drop, size: 9, color: Colors.white,),
                              const SizedBox(width: 2,),
                              Text('${randInt(30, 80)}%', style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11
                              ),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset('assets/img/thunder.png')
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset('assets/img/thunder.png')
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('${randInt(30, 35)}°${randInt(20, 25)}°', style: const TextStyle(
                            fontWeight: FontWeight.bold
                            ),),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
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
                          Image.asset('assets/img/sunrise.png')
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
                          Image.asset('assets/img/sunset.png')
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
