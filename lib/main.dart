import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.orange[400],

        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: Colors.orange[600]),
          headline2: TextStyle(fontSize: 20, color: Colors.black,),
          headline3: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        )
      ),
      home: SongList(), 
    );
  }
}


class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {

  final String title = "Choorts";
  final _biggerFont = const TextStyle(
    fontSize: 18.0,
    color: Colors.white);


  @override
  void initState(){
    super.initState();
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
        title: Text(title, style: GoogleFonts.pacifico(),),
        centerTitle: true,
        backwardsCompatibility: false,
        backgroundColor: Theme.of(context).primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.grey[900]),
      ),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
            child: FutureBuilder(
              future: Hive.openBox("songs"),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.done){

                  if(snapshot.hasError){
                    return Text(snapshot.error.toString());
                  }
                  else if(snapshot.hasData){
                    return ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: Hive.box("songs").length,
                      itemBuilder: (BuildContext context, int index){
                        return _buildRow(Hive.box("songs").getAt(index), index);
                    });
                  }
                  else {
                    return Center(child: CircularProgressIndicator());
                  }
                  
                }
                else{
                  return Center(child: CircularProgressIndicator());
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
        color: Theme.of(context).primaryColor,
        border: Border.all(
          //color: Colors.blue,
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

