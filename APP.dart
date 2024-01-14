import 'package:flutter/material.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
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
 List<String> _items = [];

 void _addItem(String item) {
    setState(() {
      _items.add(item);
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
          return ListTile(
            title: Text(_items[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen(onAdd: _addItem)),
          );
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
 }
}

class AddItemScreen extends StatefulWidget {
 final Function(String) onAdd;

 AddItemScreen({required this.onAdd});

 @override
 _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
 final TextEditingController _textController = TextEditingController();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: 'Enter item name',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onAdd(_textController.text);
          Navigator.pop(context);
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
 }
}