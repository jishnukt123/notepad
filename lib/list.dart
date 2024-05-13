import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_form/hive.dart';
import 'package:hive_form/model/model.dart';

class list extends StatefulWidget {
  const list({Key? key}) : super(key: key);

  @override
  State<list> createState() => _listState();
}
TextEditingController title=TextEditingController();
TextEditingController description=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();

class _listState extends State<list> {
  late final box=Hive.box('hive_box');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(child: Icon(Icons.save,size: 30,),
            onTap: (){
              if(formkey.currentState!.validate())
                {
                  setState(() {
                    add();
                    Fluttertoast.showToast(msg: "Data added successfully");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>hive()));
                  });
                }

            },),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: title,
                          decoration: InputDecoration(
                            hintText: "title",
                          ),
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "Empty";
                            }
                          }),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: description,
                          decoration: InputDecoration(
                            hintText: "description",
                          ),
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "Empty";
                            }
                          }),
                        ),
                        SizedBox(width: 250,height: 90,),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            title.clear();
                            description.clear();
                          });
                        },
                            child: Text("clear")),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> add() async {

    DataModel dataModel=DataModel(
      title: title.text,
      description: description.text,
    );
    box.add(dataModel);
  }
}
