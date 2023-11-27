

import 'package:flutter/material.dart';
import 'package:sesi7api/data/categorie_response_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = false;
  List<CategoriesResponseModel> categories = [];

  Future<void>getCategories() async{
    setState(() {
      isloading = true;
    });

    final List<CategoriesResponseModel> model = 
    await CategoryRemoteDatasource().getCategories();
    setState(() {
      categories = model;
    });

    setState(() {
      isloading = false;
    });
  }
  @override
  void initState(){
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP Sesi 9'),
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          :ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16
            ),
            itemBuilder: (context,index){
            final category = categories[index];
          return Card(
            child: ListTile(
              title: Text(category.name),
              subtitle: Image.network(
                category.image,
                height: 100,
                fit: BoxFit.cover,
              )
              ),
            );

        }),
    );
  }
}