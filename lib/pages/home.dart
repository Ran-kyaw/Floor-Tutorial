import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercrud/database/note_dao.dart';
import 'package:fluttercrud/database/note_table.dart';
import 'package:fluttercrud/pages/add_screen.dart';
import 'package:fluttercrud/pages/update_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final NoteDao noteDao = Get.find();
  List<Note> notes = [];
  Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Floor Database")),
      ),
      ////////body  
      body: noteList(),
      
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            child: Icon(Icons.add),
            onPressed: (){
              Get.to(AddScreen());
            }),
            
           //////sizebox
           SizedBox(width: 5,),

            FloatingActionButton(
              heroTag: 'delete',
            child: Icon(Icons.delete),
            onPressed: (){
              noteDao.deleteAllNotes(notes);
            })
        ],
      ),
    );
  }

  Widget noteList(){
    return StreamBuilder<List<Note>>(
      stream: noteDao.getAllNotes(),
      builder: (_, data) {
        if(data.hasData){
      notes = data.data!;

          return ListView.builder(
            itemCount: data.data!.length,
            itemBuilder: (_,postion){
             return Card(
               child: ListTile(
                title: Text(data.data![postion].title),
                subtitle: Text(data.data![postion].message),
                trailing: IconButton(
                  onPressed: (){
                    noteDao.deleteNote(data.data![postion]);
                  },
                   icon: Icon(Icons.delete)),
                leading: IconButton(
                  onPressed: (){
                    Get.to(UpdateScreen(),arguments: data.data![postion]);
                  },
                   icon: Icon(Icons.edit)),
               ),
             );
            },
            );
        }
        else if(data.hasError){
          return Text('Error');
        }
        else return Text('Loading');
      }
      );
  }
}