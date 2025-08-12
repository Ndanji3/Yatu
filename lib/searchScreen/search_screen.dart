import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yatu/models/biz.dart';
import '../bizScreens/biz_ui_widget_design.dart';



class SearchScreen extends StatefulWidget
{

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}




class _SearchScreenState extends State<SearchScreen>
{
  String sellerNameText = "";
  Future<QuerySnapshot>? storesDocumentsList;

  initializeSearchingStores(String textEnteredbyUser)
  {
    storesDocumentsList = FirebaseFirestore.instance
        .collection("Biz")
        .where("name", isGreaterThanOrEqualTo: textEnteredbyUser)
        .get();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors:
                [
                  Colors.greenAccent,
                  Colors.greenAccent,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        automaticallyImplyLeading: true,
        title: TextField(
          onChanged: (textEntered)
          {
            setState(() {
              sellerNameText = textEntered;
            });

            initializeSearchingStores(sellerNameText);
          },
          decoration: InputDecoration(
            hintText: "Search Places here...",
            hintStyle: const TextStyle(color: Colors.white54),
            suffixIcon: IconButton(
              onPressed: ()
              {
                initializeSearchingStores(sellerNameText);
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: storesDocumentsList,
        builder: (context, AsyncSnapshot snapshot)
        {
          if(snapshot.hasData)
          {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index)
              {
                Biz model = Biz.fromJson(
                  snapshot.data.docs[index].data() as Map<String, dynamic>
                );

                return BizUIDesignWidget(
                  model: model,
                );
              },
            );
          }
          else
          {
            return const Center(
              child: Text(
                "No record found."
              ),
            );
          }
        },
      ),
    );
  }
}
