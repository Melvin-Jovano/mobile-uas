import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int newsLength = 17;
  int showed = 5;
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
              margin: const EdgeInsets.only(bottom: 20),
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

            for(int i = 0; i < showed; i++)...[
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.only(bottom:20),
                color: Colors.white10,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  visualDensity: const VisualDensity(vertical: 4),
                  title: Row(
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/img/smallNewsCover.png")
                          )
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 10)
                      ),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CNN Indonesia • 1d ago",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 13
                              ),
                            ),
                            Text(
                              "8 Daerah di Aceh Terendam Banjir Akibat Hujan Deras dan Angin Kencang",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
            if(showed < newsLength)
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
              onPressed: () {
                setState(() {
                  showed += 5;
                  if(showed > newsLength){
                    showed = newsLength;
                  }
                });
              },
              child: const Text('Load More', style: TextStyle(
                fontWeight: FontWeight.bold
              )),
            ),
          ],
        ),
      ),
    );
  }
}