import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../connections/mongoconn.dart';

class Office extends StatelessWidget {
  final Map<String, dynamic> details;
  
  const Office({Key? key, required this.details}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String name = details["name"];
    String registerNumber = details["register_number"];
    String semester = details["semester"];
    String branch = details["branch"];
    String route_name = details["route_name"];
    int  fee_per_semester = details["fee_per_semester"];
    String fee_paid = details["fee_paid"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Office"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 86, 126, 0.545),
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
  }
          ),
        ],
        elevation: 20,
      ),
   body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    "Name",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(name),
                ),
                ListTile(
                  title: Text(
                    "Register Number",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(registerNumber),
                ),
                ListTile(
                  title: Text(
                    "Semester",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(semester),
                ),
                ListTile(
                  title: Text(
                    "Branch",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(branch),
                ),
                ListTile(
                  title: Text(
                    "Route",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("$route_name"),
                ),
                  ListTile(
                  title: Text(
                    "Fee",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("$fee_per_semester"),
                ),
               ListTile(
  title: Text(
    "Fee Status",
    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  ),
  subtitle: Text(
    fee_paid == '1' ? "Fee Paid" : "Fee Not Paid",
    style: TextStyle(
      fontSize: 16.0,
      color: fee_paid == '1' ? Colors.green : Colors.red,
      fontWeight: FontWeight.bold,
    ),
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


