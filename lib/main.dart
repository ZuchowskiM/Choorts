import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/progressionModel.dart';
import 'models/song.dart';
import 'models/strummingPatternModel.dart';
import 'models/strumsEnum.dart';
import 'songDetails.dart';
import 'package:path_provider/path_provider.dart' as pathP;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await pathP.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(SongAdapter());
  Hive.registerAdapter(ProgressionModelAdapter());
  Hive.registerAdapter(StrumAdapter());
  Hive.registerAdapter(StrummingPatternModelAdapter());
  Hive.openBox("songs");
  runApp(MyApp());
} 



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choorts',
      home: SongList(), 
    );
  }
}


class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {

  Song song1 = Song('Love Again', 'Dua Lipa');
  Song song2 = Song('Say something', 'Timberlake');


  List<Song> songs = [];
  final String title = "Choorts";
  final _biggerFont = const TextStyle(
    fontSize: 18.0,
    color: Colors.white);


  @override
  void initState(){
    super.initState();

    songs.add(song1);
    songs.add(song2);
  }

  @override
  void dispose(){
    Hive.close();
    super.dispose();
  }

  addSong(BuildContext context){

    TextEditingController songNameController  =  new TextEditingController();
    TextEditingController songAutorController  =  new TextEditingController();
    

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Song name:"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "song name"),
              controller: songNameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "song autor"),
              controller: songAutorController,
            ),
          ],
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: Text("Add", style: TextStyle(color: Colors.blue, fontSize: 20),),
              onPressed: (){
                Song songToAdd = Song(songNameController.text.toString(), songAutorController.text.toString());

                setState(() {
                  //songs.add(songToAdd);
                  Hive.box("songs").add(songToAdd);
                });
                Navigator.of(context).pop(songNameController.text.toString());
              }
              ,),
          )
        ],
      );
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
            // child: ListView.builder(
            //   padding: const EdgeInsets.all(10.0),
            //   itemCount: songs.length,
            //   itemBuilder: (BuildContext context, int index){
            //     return _buildRow(songs[index]);
            // }),
            child: FutureBuilder(
              future: Hive.openBox("songs"),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: Hive.box("songs").length,
                      itemBuilder: (BuildContext context, int index){
                        return _buildRow(Hive.box("songs").getAt(index), index);
                    });
                }
                else{
                  return CircularProgressIndicator();
                }
              },),
          ),

          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                addSong(context);
              },
              child: Icon(Icons.add),
            ),
          )

          ],
      ),
      
        );  
  }

  Widget _buildRow(Song song, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      
      child: ListTile(
      title: new Text("${song.name} - ${song.autor}", style: _biggerFont),
      trailing: Container(
        child: IconButton(
          color: Colors.red,
          icon: Icon(Icons.delete),
          onPressed: () {
          setState(() {
            //songs.remove(song);
            Hive.box("songs").deleteAt(index);
          });
          },
        ),
      ), 
     onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongDetails(songsBox: Hive.box("songs"), songIndex: index,),
          )
        );
     }, 
    ),
    );
  }

}

