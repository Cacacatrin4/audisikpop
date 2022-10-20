import 'package:flutter/material.dart';
    import 'database/db_helper.dart';
    import 'form_audisi.dart';
    import 'list_kontak.dart';
    import 'model/audisi.dart';
    
    void main() {
        runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
    
        @override
        Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter CRUD Demo',
            home: ListAudisiPage(),
        );
        }
    }