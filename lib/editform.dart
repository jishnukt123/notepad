import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_form/model/model.dart';
import 'package:hive_form/view.dart';

import 'hive.dart';
import 'list.dart';

class editform extends StatefulWidget {
  var title,description,index;
  editform({this.title,this.description,this.index});
 // const editform({Key? key}) : super(key: key);

  @override
  State<editform> createState() => _editformState();
}
TextEditingController title=TextEditingController();
TextEditingController description=TextEditingController();
class _editformState extends State<editform> {
  @override
  late final box=Hive.box('hive_box');

  void initState() {
    title=TextEditingController(text: widget.title);
    description=TextEditingController(text: widget.description);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(child: Icon(Icons.save,size: 30,),
            onTap: (){
              update();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>hive()));
            },),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical:30),
          child: Column(
            children: [
              Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.green.shade100 ,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: title,
                        decoration: InputDecoration(
                          hintText: "title",
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: description,
                        decoration: InputDecoration(
                          hintText: "description",
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }
  update(){
    DataModel dataModel=DataModel(
      title: title.text,
      description: description.text,
    );
    int index=widget.index;
    box.putAt(index, dataModel);
  }
}
