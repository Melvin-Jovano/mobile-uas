import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/utils/dateformat.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int newsLength = 17;
  int showed = 5;
  DateTime date = DateTime.now();
  TextEditingController dateController = TextEditingController(
    text: dateformat(date: DateTime.now(), format: 'yyyy-MM-dd')
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              const SizedBox(height: 10,),
              TextField(
                controller: dateController,
                decoration: const InputDecoration( 
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.white
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.white
                    )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                  prefixIcon: Icon(Icons.calendar_month, color: Colors.white,),
                  labelText: "Enter News Date",
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
                readOnly: true,
                onTap: () async {
                  final picker = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101)
                  );

                  if(picker != null) {
                    dateController.text = dateformat(date: picker, format: 'yyyy-MM-dd');
                  }
                }
              ),
              const SizedBox(height: 20,),
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
      ),
    );
  }
}