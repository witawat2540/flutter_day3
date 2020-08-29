import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mydrawer extends StatelessWidget {
  final String name;
  final String email;
  const mydrawer({
    this.name = '',
    this.email = '',
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: name == ''?Text("Null"):Text(name),
            accountEmail:email == ''?Text("Null"):Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.pinkAccent,
            ),
            otherAccountsPictures: [
              IconButton(
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
          ListTile(
            title: Text("Item 1"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Item 2"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Item 3"),
            onTap: () {},
          )
        ],
      ),
      elevation: 20,
    );
  }
}