import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LISTA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingListScreen(),
    );
  }
}

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<ShoppingItem> _items = [];

  Future<void> _addItem(String newItemName) async {
    setState(() {
      _items.add(ShoppingItem(itemName: newItemName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            title: Text(item.itemName),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      item.decrementCount();
                    });
                  },
                ),
                Text('${item.count}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      item.incrementCount();
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? newItemName = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add a new item'),
                content: TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Enter item name'),
                  onChanged: (value) => newItemName = value,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, newItemName),
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );

          if (newItemName != null) {
            _addItem(newItemName!);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ShoppingItem {
  final String itemName;
  int _count;

  ShoppingItem({required this.itemName, int count = 0}) : _count = count;

  int get count => _count;

  void incrementCount() {
    _count++;
  }

  void decrementCount() {
    if (_count > 0) _count--;
  }
}