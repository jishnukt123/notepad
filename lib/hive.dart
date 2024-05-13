import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_form/view.dart';

import 'list.dart';

class hive extends StatefulWidget {
  const hive({Key? key}) : super(key: key);

  @override
  State<hive> createState() => _hiveState();
}

class _hiveState extends State<hive> {
  late final dataBox=Hive.box('hive_box');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        leading: Icon(Icons.notes),
      ),
      floatingActionButton:FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>list()));
        title.clear();
        description.clear();
      },
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: dataBox.listenable(),
        builder: (context, value, child) {
          if(value.isEmpty)
            {
              return const Center(
                child: Text("empty"),
              );
            }
          else{
            return ListView.builder(
                itemCount: dataBox.length,
                itemBuilder: (context, index) {
                  var box=value;
                  var getData=box.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(10,),
                    child: ListTile(
                      trailing: InkWell(child: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>view(title: getData.title,description: getData.description,index: index,)));
                      }),
                      title: Text(getData.title),
                      tileColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(width: 0)
                      ),

                    ),
                  );
                });
          }

        }),


    );
  }

}

