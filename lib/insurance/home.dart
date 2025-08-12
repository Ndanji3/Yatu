import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yatu/Camera/camera.dart';
import 'package:yatu/widgets/my_drawer.dart';



class Insurance extends StatelessWidget
{

  const Insurance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              toolbarHeight: 100,
              backgroundColor: Colors.greenAccent,

              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset("images/fox.png"),
                title: Text('Safe Pastures',style: TextStyle(color:  Colors.white)),

              ),
            ),

            SliverAppBar(
              expandedHeight: 110,
              toolbarHeight: 110,
              floating: true,
              backgroundColor: Colors.white70,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column( //continue at 4:35
                            children: [
                              Text('Safe Pastures AI Camera', style: TextStyle(fontSize:25, fontWeight: FontWeight.bold, color: Colors.brown[600]),),
                              SizedBox(height: 4,),
                            ]
                          ),
                          IconButton(onPressed: ()
                          {
                           
                          },
                              icon: Icon(Icons.camera_alt_outlined, color: Colors.greenAccent,size: 25,))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverAppBar(
              backgroundColor: Colors.deepPurpleAccent,
              expandedHeight: 150,
              toolbarHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                centerTitle: false,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Policy Number', style: TextStyle( color:  Colors.white70, fontSize: 25,),),
                    Text('45 777 888', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),)

                  ],
                ),

                title: Text('Premuim amuont due: \k55,270.00 ', style: TextStyle(color: Colors.white70, fontSize: 16,)),
              ),
            ),

            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 140,
              toolbarHeight: 140,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Coverages', style: TextStyle(color: Colors.black45, fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildQuickAction(icon: Icons.add_business_outlined, label: 'Livestock'),
                          _buildQuickAction(icon: Icons.receipt, label: 'Crop'),
                          _buildQuickAction(icon: Icons.add_box_outlined, label: 'Other'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Recent Transaction,',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),

            SliverList(delegate: SliverChildBuilderDelegate((context,index){
            return _buildTransactionTile(title: 'Transaction $index', subtitle: 'Details of transaction $index', amount: (index.isEven ? '+' : '-') + '\$${(index + 1) *10}', isPositive: index.isEven);

            }, childCount: 10)),

            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_circle_outlined, size: 55,color: Colors.deepPurple),
                  SizedBox(height: 16,),
                  Text('Livestock Insurance Policy ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),),

                  SizedBox(height: 8,),
                  Text('Explore Safe Pastures', style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text(
                      'Policy',
                          style: TextStyle(color: Colors.white)
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
Widget _buildQuickAction({required IconData icon,required String label}){
  return Column(
      children: [
        CircleAvatar(
  radius: 30,
  backgroundColor: Colors.deepPurple.withOpacity(0.1),
  child: Icon(icon,color: Colors.deepPurple,size: 30,),
  ),
  SizedBox(height: 8,),
  Text(label,style: TextStyle(fontSize: 14),),
  ],
      );
}
  Widget _buildTransactionTile({required String title, required String subtitle, required String amount, required isPositive}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurpleAccent.withOpacity(0.1),
            child: Icon(
              isPositive? Icons.arrow_upward: Icons.arrow_downward,
               color: isPositive? Colors.green: Colors.redAccent, //8.29
            ),
          ),
          title: Text(title,style:TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text(subtitle ),
          trailing: Text(amount, style: TextStyle(color: isPositive ? Colors.green :Colors.red)),

        ),
      ),
    );
  }
}