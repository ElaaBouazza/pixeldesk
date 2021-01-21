import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter_auth/screens/home/functions/category.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/text.dart';

import '../calendar.dart';
import 'add_category.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Query _ref;
  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance
        .reference()
        .child('Categories')
        .orderByChild('name');
  }

  void removeNode(String name) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.pink[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: new Text(
              "Remove this Task",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this Task ?',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  "Close",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  FirebaseDatabase.instance
                      .reference()
                      .child('Categories')
                      .orderByChild('name')
                      .equalTo(name)
                      .once()
                      .then((DataSnapshot snapshot) {
                    Map<dynamic, dynamic> children = snapshot.value;
                    children.forEach((key, value) {
                      FirebaseDatabase.instance
                          .reference()
                          .child('Categories')
                          .child(key)
                          .remove();
                    });
                  });
                },
              ),
            ],
          );
        });
  }

  Widget _buildCategoryItem({Map category}) {
    Color typeColor = getTypeColor(category['type']);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.pink[50],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /*const*/ ListTile(
              leading: Icon(
                Icons.check,
                color: typeColor,
                size: 40,
              ),
              title: Text(
                category['name'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, //Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                category['description'],
                style: TextStyle(
                  fontSize: 16,
                  //color: Theme.of(context).accentColor,
                  //fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.date_range,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calendar()),
                    );
                  },
                ),
                FlatButton(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    removeNode(category['name']);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map category = snapshot.value;
            return _buildCategoryItem(category: category);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddCategory();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;
    if (type == 'Trivial') {
      color = Colors.yellow[600];
    }
    if (type == 'Easy') {
      color = Colors.lime[600];
    }
    if (type == 'Medium') {
      color = Colors.orange;
    }

    if (type == 'Hard') {
      color = Colors.red;
    }
    return color;
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
