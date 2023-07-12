import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/config/provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MainProvider>(context);
    return Scaffold(
      backgroundColor: Pallete.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Weather Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20
        ),
        child: ListView(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              margin: const EdgeInsets.only(bottom: 20),
              color: Colors.white10,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  children: ListTile.divideTiles(
                    color: Colors.white,
                    context: context,
                    tiles: [
                      ListTile(
                        title: const Text(
                          "Unit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        subtitle: Text(
                          prov.unit,
                          style: const TextStyle(
                            color: Colors.blue
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            barrierColor: Colors.transparent,
                            context: context, 
                            builder: (context) => showUnitDialog(context)
                          );
                        },
                      ),
                      const ListTile(
                        title: Text(
                          "Auto Refresh",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        subtitle: Text(
                          "Every 6 hours",
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        ),
                      ),
                      const ListTile(
                        title: Text(
                          "Notification",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.only(left: 15),
                        title: const Text(
                          "Show Weather on Apps Screen",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        trailing: Switch(
                          inactiveTrackColor: Colors.grey,
                          value: isOn, 
                          onChanged: (val){
                            setState(() {
                              isOn = val;
                            });
                          }
                        ),
                      ),
                      const ListTile(
                        title: Text(
                          "Customisation Service",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        subtitle: Text(
                          "Not in use",
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        ),
                      ),
                    ]
                  ).toList(),
                ),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.only(left: 40, top: 10, bottom: 10),
              child: Text(
                "General"
              ),
            ),

            const Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.white10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  title: Text("About Weather"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showUnitDialog(BuildContext context){
    final prov = Provider.of<MainProvider>(context);
    return SimpleDialog(
      insetPadding: EdgeInsets.only(bottom: 500, right: 75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: Colors.black87,
      children: [
        RadioListTile(
          title: const Text(
            "°C", 
            style: TextStyle(fontSize: 18),
          ),
          value: "°C",
          groupValue: prov.unit,
          onChanged: (val) {
            prov.setUnit = val;
            Navigator.pop(context);
          },
        ),
        RadioListTile(
          title: const Text(
            "°F", style: TextStyle(fontSize: 18),
          ),
          value: "°F",
          groupValue: prov.unit,
          onChanged: (val) {
            prov.setUnit = val;
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}