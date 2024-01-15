import 'package:flutter/material.dart';
import 'package:fruit_jus_168/features/reward/data/datasources/get_stamp_count.dart';

class StampTab extends StatefulWidget {
  StampTab({super.key});

  @override
  _StampTabState createState() => _StampTabState();
}

class _StampTabState extends State<StampTab> {
  late Future<int> _stampFuture;

  @override
  void initState() {
    super.initState();

    _stampFuture = StampFirestoreService().getStamp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _stampFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          int? stamp = snapshot.data;
          return Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    "My Stamps"),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 5,
                color: Color(0XFF20941C),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.local_drink),
                        title: Text("Stamp : ${stamp} / 10"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
