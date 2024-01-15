
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

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
 // ignore: library_private_types_in_public_api
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
  String? newItemName;
  int? newQuantProd;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
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
           newItemName = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
      title: Text('Adicionar novo item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Nome do produto'),
            onChanged: (value) => newItemName = value,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Quantidade do produto'),
            onChanged: (value) => newQuantProd = int.tryParse(value),
          ),
        ],
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