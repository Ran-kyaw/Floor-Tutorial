import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercrud/database/note_dao.dart';
import 'package:fluttercrud/database/note_table.dart';
import 'package:get/get.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  /////validator

  bool _validateTitle = false;
  bool _validateMessage = false;

  var _titleTextController = TextEditingController();
  var _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final NoteDao noteDao = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add Note')),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTextController,
                  decoration: InputDecoration(
                      hintText: 'Title',
                      errorText: _validateTitle ? "Title Can't Be Empty" : null,
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _messageTextController,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    errorText:
                        _validateMessage ? "Message Can't Be Empty" : null,
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _titleTextController.text.isEmpty
                          ? _validateTitle = true
                          : _validateTitle = false;

                      _messageTextController.text.isEmpty
                          ? _validateMessage = true
                          : _validateMessage = false;

                      if (_validateTitle == false &&
                          _validateMessage == false) {
                        noteDao.addNote(Note(_titleTextController.text,
                            _messageTextController.text));
                        Get.back();
                      }
                    });
                    // noteDao.addNote(Note(_titleTextController.text, _messageTextController.text));
                    // Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Add Note'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
