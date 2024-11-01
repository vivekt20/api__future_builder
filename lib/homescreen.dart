import 'dart:convert';



import 'package:api_future_builder/recipes_model.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
  super.initState();

}
ProductModelApi ?dataFromApi;
   Future<ProductModelApi?> getData()async{
    try{
    String url="https://dummyjson.com/recipes" ;
    http.Response res=await http.get(Uri.parse(url));
    if(res.statusCode==200){
      dataFromApi=ProductModelApi.fromJson(json.decode(res.body));
      return dataFromApi;
      
    }
  }catch(e){
    debugPrint(e.toString());
  }
    
   }
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Example"),
        ),
         body: FutureBuilder<ProductModelApi?>(
      future: getData(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text("Error:${snapshot.error}");
        }else if(snapshot.hasData){
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount: dataFromApi!.recipes.length,itemBuilder: (context,index){
      
      return Container(
       height: 30,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10.0),
         border: Border.all(
           color: Colors.black,
           width: 2,
         ),
         boxShadow: [
           BoxShadow(
             color: Color.fromARGB(255, 243, 242, 242),
             blurRadius: 0,
             spreadRadius: 1,
           )
         ]
       ),
       margin: EdgeInsets.all(8.0),
       padding: EdgeInsets.all(8.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image.network(Recipe.image,
           width: 100,height: 100,
           ),
            SizedBox(height: 10),
           Text(Recipe.name),
           SizedBox(height: 5),
           Row(
             children: [
               Text(Recipe.cuisine),
               SizedBox(width: 25),
         ],
         
           
       ),
       
         ]
            ));
      

    });
    
        }
        else{

        return Text('no data found');
        }
      

      },
    )


     
  
  );
}



    
  
}





  



   

