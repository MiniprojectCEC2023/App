import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../connections/mongoconn.dart';
import 'Office.dart';
import 'library.dart';
import '../global/globals.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 86, 126, 0.545),
        //leading: Icon(Icons.qr_code),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_2),
            onPressed: () async {
              final qrCodesCollection = MongoUtils.db.collection('student');
              var qrCode = await qrCodesCollection
                  .findOne({'register_number': registerNumber});

              if (qrCode != null) {
                final qrCodeBytes =
                    Uint8List.fromList(qrCode['qr_code'].byteList);
                // assuming the image data is stored as a binary in the 'imageData' field
                var qrCodeImage = Image.memory(qrCodeBytes);

                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: qrCodeImage,
                  ),
                );
              }
            },
          ),
        ],

        elevation: 20,
      ),
      body: Center(
      
         
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
           Container(
  height: 100,
  child: Align(
    alignment: Alignment.topCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Welcome $name!',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  ),
),

            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: Text("Library"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(12, 86, 126, 0.545),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(90, 45)),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () async {
                  var libraryCollection = MongoUtils.db.collection('library');
                  var libraryDetails = await libraryCollection
                      .findOne({'register_number': registerNumber});

                  if (libraryDetails != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Library(details: libraryDetails)),
                    );
                  } else {
                    print(
                        'No details found in the library for the given register number.');
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: Text("College Bus"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(12, 86, 126, 0.545),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(90, 45)),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () async {
                  var busCollection = MongoUtils.db.collection('bus');
                  var busDetails = await busCollection
                      .findOne({'register_number': registerNumber});

                  if (busDetails != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Office(details: busDetails)),
                    );
                  } else {
                    print(
                        'No details found in the library for the given register number.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
