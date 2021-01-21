import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_auth/Screens/home/functions/category.dart';
//import 'package:flutter/src/widgets/text.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _nameController, _descriptionController;
  String _typeSelected = '';

  //var for firebase
  DatabaseReference _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    //added for firebase
    _ref = FirebaseDatabase.instance.reference().child('Categories');
  }

//function to add the category type i didn't make it cos i dont know which type we'll be using
//what are the types that can be setted for a category
  Widget _buildCategoryType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.pink
              : Colors.pink[900], //Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Task Name',
                prefixIcon: Icon(
                  Icons.category,
                  color: Colors.pink[900],
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.pink[900],
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryType('Trivial'),
                  SizedBox(width: 20),
                  _buildCategoryType('Easy'),
                  SizedBox(width: 20),
                  _buildCategoryType('Medium'),
                  SizedBox(width: 20),
                  _buildCategoryType('Hard'),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                child: Text(
                  'Create Task',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  saveCategory();
                },
                color: Colors.pink[900], //Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveCategory() {
    String name = _nameController.text;
    String description = _descriptionController.text;

    Map<String, String> category = {
      'name': name,
      'description': description,
      'type': _typeSelected,
    };
    _ref.push().set(category).then((value) {
      //Navigator.push(
      //  context,
      //  MaterialPageRoute(builder: (context) => Categories()),
      //);

      Navigator.pop(context);
    });
  }
}
