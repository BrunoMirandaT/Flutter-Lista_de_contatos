import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/contact_generator.dart';
import 'package:myapp/database.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class menu extends ConsumerWidget {
  const menu({super.key});

  void deleteContato(id) {
    FirebaseFirestore.instance.collection('contato').doc(id).delete();
  }

  @override
  Widget build(BuildContext context, ref) {
    //List<String> nome_pasta = ref.watch(strNotifierProviderFolder);
    //final nome = "teste";
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Container(
                child: Text(
              'Contatos',
              style: TextStyle(color: Color(0XFFf0f3f5), fontSize: 28),
            ))),
        body: Center(
          child: Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('contato')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Column> clientWidgets = [];
                  if (snapshot.hasData) {
                    final contatos = snapshot.data?.docs.reversed.toList();
                    for (var contato in contatos!) {
                      final clientWidget = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: [
                              SizedBox(width: 20),
                              SizedBox(
                                width: 320,
                                height: 70,
                                child: Card(
                                  color: Color(0XFF666A86),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Row(children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        editContato(
                                                            id: contato.id)),
                                              );
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.person,
                                            color: Color(0XFF101419),
                                            size: 40,
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                contato['nome'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 24,
                                                    color: Color(0XFFf0f3f5)),
                                              ),
                                              Text(
                                                contato['numero'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                    color: Color(0XFFf0f3f5)),
                                              )
                                            ],
                                          ),
                                        ]),
                                      ]),
                                ),
                              ),
                              SizedBox(height: 75),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          deleteContato(contato.id);
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.white, size: 30)),
                                  ])
                            ])
                          ]);
                      clientWidgets.add(clientWidget);
                    }
                  }
                  return Expanded(
                      child: ListView(
                    children: clientWidgets,
                  ));
                })
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          highlightElevation: BorderSide.strokeAlignCenter,
          backgroundColor: Color(0XFF0D0628),
          tooltip: 'New',
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0XFFDDD92A)),
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const novoContato()),
            );
          },
          child: const Icon(Icons.add, color: Color(0XFFDDD92A), size: 42),
        ));
  }
}

class novoContato extends StatefulWidget {
  const novoContato({super.key});

  @override
  State<novoContato> createState() => _addState();
}

class _addState extends State<novoContato> {
  uploadInfo() async {
    try {
      Map<String, dynamic> uploadInfo = {
        "nome": contactnamecontroller.text,
        "numero": contactnumbercontroller.text,
      };
      await DatabaseMethods().addContactInfo(uploadInfo);
      Navigator.pop(context);
    } catch (error) {
      print('Error uploading info: $error');
    }
  }

  TextEditingController contactnamecontroller = TextEditingController();
  TextEditingController contactnumbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                Text("Novo contato",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 240, 243, 245))),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 42, vertical: 40),
                    child: Column(children: [
                      TextField(
                          controller: contactnamecontroller,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFF666A86))),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFFF0F3F5)),
                              ),
                              hintText: 'Nome'),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 240, 243, 245))),
                      const SizedBox(height: 40),
                      TextField(
                          controller: contactnumbercontroller,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFF666A86))),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFFF0F3F5)),
                              ),
                              hintText: 'Numero'),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 240, 243, 245))),
                      SizedBox(height: 40),
                      Container(
                          width: 200,
                          height: 40,
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: Color(0XFF0D0628),
                                  elevation: 2),
                              onPressed: () => uploadInfo(),
                              child: Text(
                                "Criar",
                                style: TextStyle(
                                  color: Color(0XFFDDD92A),
                                ),
                              )))
                    ]))
              ],
            ),
          ),
        ));
  }
}

class editContato extends StatefulWidget {
  final String id;

  const editContato(String contactId, {super.key, required this.id});

  @override
  State<editContato> createState() => _editState();
}

class _editState extends State<editContato> {
  editarContato(id) async {
    Map<String, dynamic> updateInfo = {
      "nome": contactnamecontroller.text,
      "numero": contactnumbercontroller.text,
    };
    await DatabaseMethods().editContactInfo(updateInfo, id);
    Navigator.pop(context);
  }

  TextEditingController contactnamecontroller = TextEditingController();
  TextEditingController contactnumbercontroller = TextEditingController();

  get id => widget.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                Text("Novo contato",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 240, 243, 245))),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 42, vertical: 40),
                    child: Column(children: [
                      TextField(
                          controller: contactnamecontroller,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFF666A86))),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFFF0F3F5)),
                              ),
                              hintText: 'Nome'),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 240, 243, 245))),
                      const SizedBox(height: 40),
                      TextField(
                          controller: contactnumbercontroller,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFF666A86))),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFFF0F3F5)),
                              ),
                              hintText: 'Numero'),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 240, 243, 245))),
                      SizedBox(height: 40),
                      Container(
                          width: 200,
                          height: 40,
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: Color(0XFF0D0628),
                                  elevation: 2),
                              onPressed: () => editarContato(id),
                              child: Text(
                                "Editar",
                                style: TextStyle(
                                  color: Color(0XFFDDD92A),
                                ),
                              )))
                    ]))
              ],
            ),
          ),
        ));
  }
}
