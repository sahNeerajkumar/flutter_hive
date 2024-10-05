import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hive/models/notes_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Boxes/box_page.dart';

class HiveDatabase extends StatefulWidget {
  const HiveDatabase({super.key});

  @override
  State<HiveDatabase> createState() => _HiveDatabaseState();
}

class _HiveDatabaseState extends State<HiveDatabase> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Hive Database',
          style: TextStyle(
              color: Colors.white, fontStyle: FontStyle.italic, fontSize: 25),
        )),
        backgroundColor: Colors.blue,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: BoxPage.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,

            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {

              if(index%2==0){
                return Card(
                  color: Colors.red,
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              data[index].title.toString(),
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              data[index].description.toString(),
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(onPressed: () {
                            update_showMyDialog(data[index], data[index].title.toString(), data[index].description.toString());
                          }, icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                delete(data[index]);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      )
                    ],
                  ),
                );
              } else if(index>=7){
                return Card(
                  color: Colors.blue,
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              data[index].title.toString(),
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              data[index].description.toString(),
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(onPressed: () {
                            update_showMyDialog(data[index], data[index].title.toString(), data[index].description.toString());
                          }, icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                delete(data[index]);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      )
                    ],
                  ),
                );
              }
              else{
                return Card(
                  color: Colors.green,
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              data[index].title.toString(),
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              data[index].description.toString(),
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(onPressed: () {
                            update_showMyDialog(data[index], data[index].title.toString(), data[index].description.toString());
                          }, icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                delete(data[index]);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      )
                    ],
                  ),
                );
              }

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          inser_showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

//insert Data use to hive
  Future<void> inser_showMyDialog() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var widthScreen = MediaQuery.of(context).size.width;
        return SizedBox(
          height: 250,
          width: 450,
          child: AlertDialog(
            // barrierDismissible: false,
            title: Center(child: const Text('Add Notes')),
            content: SingleChildScrollView(
              child: SizedBox(
                width: widthScreen,
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Description'),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',style: TextStyle(fontSize: 18),)),
              const SizedBox(width: 130,),
              TextButton(
                  onPressed: () {
                    final data = NotesModel(title: titleController.text, description: descriptionController.text);
                    if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                      final box = BoxPage.getData();
                      box.add(data);
                      Navigator.pop(context);
                    }else{
                      Fluttertoast.showToast(msg: 'please fill in the blanks',
                      toastLength:Toast.LENGTH_LONG,
                        backgroundColor: Colors.greenAccent,
                        fontSize: 18
                      );
                    }
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text('Add',style: TextStyle(fontSize: 18),),
                  )),
            ],
          ),
        );
      },
    );
  }

  //delete Data
  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }


  //Update Data
  Future<void> update_showMyDialog(NotesModel notesModel, String title, String description) async {
 titleController.text = title;
 descriptionController.text = description;
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          width: 450,
          child: AlertDialog(
            title: Center(child: const Text('Update Notes')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Title',
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Description'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 100,
              ),
              TextButton(
                  onPressed: () {
                    notesModel.title = titleController.text.toString();
                    notesModel.description =
                        descriptionController.text.toString();
                    notesModel.save();
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: const Text('Update', style: TextStyle(fontSize: 18))),
            ],
          ),
        );
      },
    );
  }
}
