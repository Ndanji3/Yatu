import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatu/bizScreens/home_screen.dart';
import 'package:yatu/global/global.dart';
import 'package:yatu/insurance/home.dart';
import 'package:yatu/insurance/claim.dart';
import 'package:yatu/insurance/apply.dart';
import 'package:yatu/searchScreen/search_screen.dart';
import 'package:yatu/splashScreen/my_splash_screen.dart';

import '../chat/message_page.dart';
import '../insurance/policy.dart';


class MyDrawer extends StatefulWidget
{
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer>
{
  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      backgroundColor: Colors.black45,
      child: ListView(
        children: [

          //header
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                //user profile image
                Container(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),

                const SizedBox(height: 12,),

                //user name
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12,),

              ],
            ),
          ),

          //body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [

                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //home
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.grey,),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> Insurance()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //search
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.grey,),
                  title: const Text(
                    "Search",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

               //my orders
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.grey,),
                  title: const Text(
                    "Insurance",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                ListTile(
                  leading: const Icon(Icons.send_to_mobile_outlined, color: Colors.grey,),
                  title: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> ProposalFormScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                ListTile(
                  leading: const Icon(Icons.real_estate_agent_outlined, color: Colors.grey,),
                  title: const Text(
                    "Cliam",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> Claim()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),


                //Chat
                ListTile(
                  leading: const Icon(Icons.message_outlined, color: Colors.grey,),
                  title: const Text(
                    "Talk To Vet",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomePage()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //search
                ListTile(
                  leading: const Icon(Icons.receipt_outlined, color: Colors.grey,),
                  title: const Text(
                    "Policy",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> Policy()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),



                //logout
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.grey,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: ()
                  {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

