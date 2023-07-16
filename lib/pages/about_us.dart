import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  static List members = [
    "211111117 - Melvin Jovano Batubara",
    "211111669 - Kevin Frederick Yapiter",
    "211110729 - Muhammad Yusof"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("About Us"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text(
                    "Weather",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 45
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Version 1.6.42.3"
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 310,
                    child: Text(
                      "A weather app is a mobile application that provides users with information about the current weather conditions and forecasts for the upcoming days.",
                      style: TextStyle(
                        color: Colors.white60
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),


              Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 15,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3A3A3A),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25)
                      )
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "Kelompok 7",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),

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
                    onPressed: (){
                      showDialog(
                        context: context, 
                        builder: (context) => showMember(context)
                      );
                    }, 
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Members",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showMember(BuildContext context){
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: const Color(0xFF3A3A3A),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        for(int i = 0; i < members.length; i++)
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10
          ),
          child: Text(
            members[i],
            style: const TextStyle(
              fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}