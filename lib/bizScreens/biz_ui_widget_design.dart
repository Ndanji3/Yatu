import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:yatu/models/biz.dart';
import '../brandsScreens/activities_screens.dart';


class BizUIDesignWidget extends StatefulWidget
{
  Biz? model;

  BizUIDesignWidget({this.model,});

  @override
  State<BizUIDesignWidget> createState() => _BizUIDesignWidgetState();
}


class _BizUIDesignWidgetState extends State<BizUIDesignWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        //send user to a seller's brands screen
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ActivitiesScreen(
        model: widget.model,
       )));
      },
      child: Card(
        color: Colors.black54,
        elevation: 20,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 220,
                    fit: BoxFit.fill,
                  ),
                ),

                const SizedBox(height: 1,),

                Text(
                  widget.model!.name.toString(),
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SmoothStarRating(
                  rating: widget.model!.ratings == null ? 0.0 : double.parse(widget.model!.ratings.toString()),
                  starCount: 5,
                  color: Colors.amber,
                  borderColor: Colors.amber,
                  size: 16,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}