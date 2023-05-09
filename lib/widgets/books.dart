import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../connections/mongoconn.dart';
import '../global/globals.dart';

class BookLoan extends StatefulWidget {
  const BookLoan({Key? key, required this.detailsList}) : super(key: key);

  final List<Map<String, dynamic>> detailsList;

  @override
  _BookLoanState createState() => _BookLoanState();
}

class _BookLoanState extends State<BookLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Taken"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 86, 126, 0.545),
        //leading: Icon(Icons.qr_code),
        actions: [
       IconButton(
  icon: Icon(Icons.qr_code_2),
  onPressed: () async {
      final qrCodesCollection = MongoUtils.db.collection('student');
    var qrCode = await qrCodesCollection.findOne({'register_number': registerNumber});

    if (qrCode != null) {
      final qrCodeBytes = Uint8List.fromList(qrCode['qr_code'].byteList);
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
      body: ListView.builder(
        itemCount: widget.detailsList.length,
        itemBuilder: (BuildContext context, int index) {
          var title = widget.detailsList[index]['title'];
          var returnDate = widget.detailsList[index]['return_date'].toString();

          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text('Return Date: $returnDate'),
            ),
          );
        },
      ),
    );
  }
}
