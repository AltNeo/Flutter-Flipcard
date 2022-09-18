import 'package:flash_card/constants.dart';
import 'package:flash_card/custom_widget/bottom_bar.dart';
import 'package:flash_card/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Fcards extends StatefulWidget {
  const Fcards({Key? key}) : super(key: key);
  @override
  State<Fcards> createState() => _FcardsState();
}

class _FcardsState extends State<Fcards> {
  final myController = TextEditingController();
  final textController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseHelper.instance.add(
            Grocery(name: textController.text),
          );
          setState(() {
            textController.clear();
          });
        },
        child: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: const [
                    Icon(
                      Icons.favorite,
                      color: Color(0xFF000000),
                    ),
                    SizedBox(width: 7),
                    Text("Favourite"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: const [
                    Icon(
                      Icons.delete,
                      color: Color(0xFF000000),
                    ),
                    SizedBox(width: 7),
                    Text("Delete")
                  ],
                ),
              ),
            ],
            onSelected: (item) => SelectedItem(context, item),
          ),
        ],
        title: Row(
          children: [
            TextField(
              controller: textController,
            ),
            SizedBox(
              width: 173.7,
            ),
            Icon(Icons.ios_share)
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: FutureBuilder<List<Grocery>>(
                future: DatabaseHelper.instance.getGroceries(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Grocery>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Loading...'));
                  }
                  return snapshot.data!.isEmpty
                      ? Center(child: Text('No Text Given'))
                      : ListView(
                          children: snapshot.data!.map((grocery) {
                            return Center(
                              child: ListTile(
                                title: Text(grocery.name),
                              ),
                            );
                          }).toList(),
                        );
                }),
          ),
        ],
      ),
    );
  }
}

void SelectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      break;
    case 1:
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
      break;
  }
}

class Grocery {
  final int? id;
  final String name;

  Grocery({this.id, required this.name});

  factory Grocery.fromMap(Map<String, dynamic> json) => new Grocery(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'groceries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE groceries(
          id INTEGER PRIMARY KEY,
          name TEXT
      )
      ''');
  }

  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => Grocery.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert('groceries', grocery.toMap());
  }
}
