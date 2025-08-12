import 'package:flutter/material.dart';
import '../itemsScreens/items_screen.dart';
import '../models/activities.dart';



class ActivitiesUiDesignWidget extends StatefulWidget
{
  Activities? model;


  ActivitiesUiDesignWidget({this.model,});

  @override
  State<ActivitiesUiDesignWidget> createState() => _ActivitiesUiDesignWidgetState();
}

class _ActivitiesUiDesignWidgetState extends State<ActivitiesUiDesignWidget>
{


  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(
          model: widget.model,
        )));
      },
      child: Card(
        color: Colors.black,
        elevation: 20,
        shadowColor: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 220,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                const SizedBox(height: 1,),

                Text(
                  widget.model!.activityTitle.toString(),
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
