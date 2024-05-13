import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_form/editform.dart';
import 'package:hive_form/hive.dart';

import 'list.dart';

class view extends StatefulWidget {
 var title,description,index;
  view({this.title,this.description,this.index});
 //const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  late final dataBox=Hive.box('hive_box');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("note"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(child: Icon(Icons.edit,size: 30,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>editform(title:widget.title,description: widget.description,index: widget.index)));
              },),
          ),
          SizedBox(width: 10,),
          InkWell(child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Icon(Icons.delete,size: 30,),
              ],
            ),
          ),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Delete"),
                    content: Text("Delete?"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          child: Text("cancel")),
                      ElevatedButton(onPressed: (){
                        delete(widget.index);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>hive()));
                        Fluttertoast.showToast(msg: "deleted");
                      },
                          child: Text("ok")),
                    ],
                  );
                }
            );
          },)
        ],

      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    Text(widget.title,style: TextStyle(fontSize: 25),),
                    SizedBox(height: 30,),
                    Text(widget.description,style: TextStyle(fontSize: 15),),
                  ],

                ),
              )

            ],
          ),
        ),

      ),
    );
  }
  delete(index){
    dataBox.deleteAt(index);
  }
}
