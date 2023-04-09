import 'package:flutter/material.dart';
import 'services/remote_service.dart';
import 'models/post.dart';

import 'package:carousel_slider/carousel_slider.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super (key : key);

  @override
  _HomePageState createState() => _HomePageState();

}



class _HomePageState extends State<HomePage> {

  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if(posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  List<Widget> toListWidget(){
    final widgets = List<Widget>.filled(posts!.length, SizedBox.shrink());


    for(int i=0; i < posts!.length; i++) {
      widgets[i] = new Container(
        child: ListView(
          children: [
            Title(
              color: Colors.blueGrey,
              child: Text(posts![i].title),
            ),
            Image(
              image: NetworkImage(posts![i].thumbnailUrl),
            ),
          ],
        ),
      );
    }
    return widgets;
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Column(
        children:[
          Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: toListWidget(),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Registrar'),
              ),
            ],
          ),
        ],
      ),

    );



  }

}