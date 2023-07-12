import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: const Text("News"),
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
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.white10,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img/newsCover.png")
                      )
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10, 
                      horizontal: 25
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CNN Indonesia • 10h ago",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 13
                          ),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),

                        Text(
                          "Gelombang Panas Landa ASEAN, Vietnam dan Laos Catat Suhu Terpanas",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              margin: EdgeInsets.only(bottom:20),
              color: Colors.white10,
              child: ListTile(
                leading: Image.asset("assets/img/newsCover.png"),
                title: Text("About Weather"),
              ),
            )
          ],
        ),
      ),
    );
  }
}