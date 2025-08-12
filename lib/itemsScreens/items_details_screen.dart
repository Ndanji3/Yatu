import 'package:flutter/material.dart';
import '../models/items.dart';




class ItemsDetailsScreen extends StatefulWidget
{
  Items? model;

  ItemsDetailsScreen({this.model,});

  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}



class _ItemsDetailsScreenState extends State<ItemsDetailsScreen>
{
  int counterLimit = 1;

  get data => null;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors:
                [
                  Colors.cyan,
                  Colors.cyan,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: const Text(
          "Safe Pastures",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,

      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: ()
          {
          /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chatpage(email: '',

                  ),
                ),
            ); */
          },
          label: const Text(
            "Contact Us"
          ),
        icon: const Icon(
          Icons.forum,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.network(
              widget.model!.thumbnailUrl.toString(),
            ),

            //implement the item counter

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                widget.model!.itemTitle.toString() + ":",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.cyan,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.model!.price.toString() + "ZMW",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.cyan,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 320.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.cyan,
              ),
            ),

            const SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }
}
