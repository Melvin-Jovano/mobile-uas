import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';

class AddLocations extends StatefulWidget {
  const AddLocations({super.key});

  @override
  State<AddLocations> createState() => _AddLocationsState();
}

class _AddLocationsState extends State<AddLocations> {
  @override
  Widget build(BuildContext context) {
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
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search location',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic
                              ),
                              suffixIcon: null,
                              enabledBorder: UnderlineInputBorder(
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
                    children: const [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        color: Colors.white10,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text('New York City'),
                                    subtitle: Text('New York, United States'),
                                  ),
                                  Divider(color: Colors.white24, thickness: 1, height: 10,),
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
