import 'package:flutter/material.dart';
import 'song.dart';
import 'songDetails.dart';

void main() async {
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
    fontSize: 18.0,);


  @override
  void initState(){
    super.initState();

    songs.add(song1);
    songs.add(song2);
  }


  addSong(BuildContext context){

    TextEditingController customController  =  new TextEditingController();
    

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Song name:"),
        content: TextField(
          decoration: InputDecoration(hintText: "song name"),
          controller: customController,
        ),
        actions: <Widget>[
          Center(
            child: MaterialButton(
              color: Colors.blue,
              elevation: 0.5,
              child: Text("Submit", style: TextStyle(color: Colors.white),),
              onPressed: (){
                Song songToAdd = Song(customController.text.toString(), "default");

                setState(() {
                  songs.add(songToAdd);
                });
                Navigator.of(context).pop(customController.text.toString());
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
            //   child: FutureBuilder<List>(
            // future: _query.getAllSongs(),
            // initialData: <Song>[],
            // builder: (context, snapshot) {
            //     return snapshot.hasData ?
            //     new ListView.builder(
            //       padding: const EdgeInsets.all(10.0),
            //       itemCount: snapshot.data!.length,
            //       itemBuilder: (context, i) {
            //         return _buildRow(snapshot.data![i]);
            //       },
            //     )
            //     : Center(
            //           child: CircularProgressIndicator(),
            //         );
            // },
            // )
            // 
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: songs.length,
              itemBuilder: (BuildContext context, int index){
                return _buildRow(songs[index]);
            }),
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

  Widget _buildRow(Song song) {
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
      title: new Text(song.name, style: _biggerFont),
      trailing: Container(
        child: IconButton(
          color: Colors.red,
          icon: Icon(Icons.delete),
          onPressed: () {
          setState(() {
            songs.remove(song);
          });
          },
        ),
      ), 
     onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongDetails(song: song,)
          )
        );
     }, 
    ),
    );
  }

}

