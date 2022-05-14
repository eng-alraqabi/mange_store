import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mange_store/Models/Product.dart';
import 'package:mange_store/Models/ProductBuy.dart';
import 'package:mange_store/Models/ProductSell.dart';
import 'package:mange_store/Models/Suplier.dart';
import 'package:mange_store/PublicDrawer.dart';
import 'package:mange_store/Views/Products_Mange.dart';
import 'package:mange_store/Views/Products_Store.dart';
import 'package:provider/src/provider.dart';
import '../constants.dart';
import 'Castmer_Screen.dart';
import 'Products_Sell.dart';
import 'Supliers_Screen.dart';

class Home_Screen extends StatelessWidget {
  var statuscam ;
  var statusfol ;
  Future<void> getprimiton() async {
    if(await Permission.camera.isDenied ){
      await Permission.camera.request();
    }
    if( await Permission.storage.isDenied){
      await Permission.storage.request();
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getprimiton();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        foregroundColor: Kwhite,
        iconTheme: IconThemeData(color: Colors.lime[400]),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notification_important,
              color: Colors.lime[400],
            ),
            onPressed: () {
              showtost(context, "تصميم : م/ محمد الرقابي");
            },
          ),
          // action button
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.lime[400],
            ),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      drawer: PublicDrawer(),
      body: Column(
        children: [
          Container(
            //fild_apppar whth serch
            width: size.width,
            height: 60,
            child: Stack(children: <Widget>[
              Container(
                //fild_apppar
                width: size.width,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0)),
                  color: Colors.lightGreen[900],
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(blurRadius: 5, color: Colors.white)],
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  //heder
                  child: Stack(
                    children: <Widget>[],
                  ),
                ),
              ),
              Positioned(
                //fild_serch
                bottom: 0,
                left: size.width * 0.1,
                child: Container(
                  width: size.width * 0.8,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.lime,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color:Colors.grey)
                    ],
                  ),
                  child: Text(
                    'تطبيق إدارة المنتجات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.lightGreen[900],
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),

          Expanded(

            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Row(
                    //first Row---------------------------------

                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {

                            Provider.of<ListProducts>(context,listen: false).initial();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Products_Mange()));
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.lightGreen[200],
                            child: Container(
                              child: Image.asset(
                                "images/accont.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<ProductBuy>(context,listen: false).resetlist();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsStore_Screen()));
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.lightGreen[900],
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset("images/buy.jpg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<ListSupliers>(context,listen: false).initial();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Supliers_Screen()));
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.only(left: 5, right: 5),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.lightGreen[900],
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset("images/dayly.jpg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    //secnd Row---------------------------------

                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            //click her
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.lightGreen[900],
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "images/sand.jpg",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<ProductSell>(context,listen: false).initial();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Products_Sell()));
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.lightGreen[900],
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset("images/sell.jpg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Castmers_Screen()));
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.lightGreen[900],
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset("images/rebort.jpg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 200,
                    width: size.width,
                    clipBehavior: Clip.antiAlias,
                    foregroundDecoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(20)) ,
                        color: Kwhite.withOpacity(0.7)
                    ),
                    // child: Image.asset("images/links.jpg",fit: BoxFit.cover,),
                    decoration: BoxDecoration(
                      image:const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/links.jpg"),
                      ) ,
                      border: Border.all(width:1,color: KprimaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.rectangle,
                      boxShadow: [BoxShadow(blurRadius:3, color:Colors.black87)],
                    ),
                    margin: EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,bottom:8),
                  )
                ],
              ),
            ),
          ),


        ],
      ),
     bottomNavigationBar: BottomAppBar(
       shape: CircularNotchedRectangle(),
       notchMargin:3,
       elevation: 5,
       color: KprimaryColor,
       child: Row(
         children: [
           IconButton(
               icon: Icon(Icons.arrow_back),
               color: Colors.white,
               onPressed: () {
               }),
           Spacer(),

           IconButton(
               icon: Icon(Icons.refresh),
               color: Colors.white,
               onPressed: (){}),
           IconButton(
             icon: Icon(Icons.info),
             color: Colors.white,
             onPressed: (){},
           ),
         ],
       ),
     ),
      floatingActionButton: FloatingActionButton(
        splashColor: KaccentColor,
          backgroundColor: KprimaryColor,
          onPressed: (){},
          child: Icon(Icons.home,color:Kwhite ,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  }

