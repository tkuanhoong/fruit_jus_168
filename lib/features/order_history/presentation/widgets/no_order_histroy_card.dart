import 'package:flutter/material.dart';

class NoOrderHistoryCard extends StatelessWidget {
  const NoOrderHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 15),
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 5,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: InkWell(
            onTap: () {},
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      height: 50,
                      color: const Color.fromARGB(80, 158, 158, 158),
                      child: const Center(
                          child: Text("No Order History Found :(")),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Opacity(
                        opacity: 0.2,
                        child: Image(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          image: AssetImage('assets/images/empty-box.png'),
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "You haven't made any order yet.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
