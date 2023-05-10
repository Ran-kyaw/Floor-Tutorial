import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercrud/database/note_dao.dart';
import 'package:fluttercrud/database/note_table.dart';
import 'package:get/get.dart';

class UpdateScreen extends StatelessWidget {

  bool _validateTitle = false;
  bool _validateMessage = false;
var _titleTextController = TextEditingController();
var _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final NoteDao noteDao = Get.find();
    Note note = Get.arguments;
    _titleTextController.text = note.title;
    _messageTextController.text = note.message;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Update Note')),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                  controller: _titleTextController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder()
                  ),
              ),
      
              SizedBox(height: 10,),
              
              TextField(
                  controller: _messageTextController,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    border: OutlineInputBorder()
      
                  ),
              ),
      
              ElevatedButton(
                onPressed: (){
                  noteDao.updateNote(
                    Note(_titleTextController.text, _messageTextController.text,id: note.id)
                  );
                  Get.back();
                },
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                 ),
                 child: Text('Update Note'),)
            ],
          ),
        ),
      ),
    );
  }
}