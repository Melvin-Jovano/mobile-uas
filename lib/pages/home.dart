
import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';

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
                  const Row(
                    children: [
                      Text('27°', style: TextStyle(
                        fontSize: 44
                      ),),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text('33° / 24°', style: TextStyle(
                            fontSize: 12
                          ),),
                          Text('Mon, 20:44', style: TextStyle(
                            fontSize: 12
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Image.asset('assets/img/full_moon.png')
                ],
              )

              // TODO Continue Here
            ],
          ),
        )
      ),
    );
  }
}
