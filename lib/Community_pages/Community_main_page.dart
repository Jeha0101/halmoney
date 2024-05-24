import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/Community_pages/Community_widgets.dart';
import 'package:halmoney/Community_pages/Community_write_page.dart';
class Communitypage extends StatelessWidget{
  const Communitypage({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansKrTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      home : SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title : const Text('커뮤니티'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Community_widget(),
                ],
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Community_Write()),
                    );
                  },
                  backgroundColor: Color.fromARGB(250, 51, 51, 255),
                  foregroundColor: Colors.white,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
