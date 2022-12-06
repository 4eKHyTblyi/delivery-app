import 'package:flutter/material.dart';

import 'appbar.dart';
import 'drawer.dart';

class Catalog extends StatelessWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Center(
        child: Text('data'),
      ),
      backgroundColor: Colors.white24,
    );
  }
}

