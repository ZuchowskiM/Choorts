import 'package:flutter/material.dart';
import 'query.dart';
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

  final List<String> songs = <String>['Love Again', 'Say something'];
  final String title = "Choorts";
  QueryCtr _query = new  QueryCtr();
  final _biggerFont = const TextStyle(
    fontSize: 18.0,);


  addSong(BuildContext context){

    TextEditingController customController  =  new TextEditingController();
    

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Song name:"),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 0.5,
            child: Text("Submit"),
            onPressed: (){
              Song songToAdd = Song(customController.text.toString());

              setState(() {
                _query.insertSong(songToAdd);
              });
              Navigator.of(context).pop(customController.text.toString());
            }
            ,)
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
              child: FutureBuilder<List>(
            future: _query.getAllSongs(),
            initialData: <Song>[],
            builder: (context, snapshot) {
                return snapshot.hasData ?
                new ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return _buildRow(snapshot.data![i]);
                  },
                )
                : Center(
                      child: CircularProgressIndicator(),
                    );
            },
            )
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
          icon: Icon(Icons.delete),
          onPressed: () {
          setState(() {
            _query.deleteSong(song);
          });
          },
        ),
      ), 
     onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongDetails()
          )
        );
     }, 
    ),
    );
  }

}

