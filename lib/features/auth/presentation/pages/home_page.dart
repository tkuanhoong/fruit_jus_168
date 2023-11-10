import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> imageList = [
    {"id": "1", "image_path": "assets/images/slider_1.jpg"},
    {"id": "2", "image_path": "assets/images/slider_2.png"},
  ];

  String getGreeting() {
    var timeNow = DateTime.now().hour;

    if (timeNow >= 5 && timeNow < 12) {
      return 'Good Morning';
    } else if (timeNow >= 12 && timeNow < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
    // return '$greeting, $userName';
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      print(currentIndex);
                    },
                    child: ClipPath(
                      clipper: MyCustomClipper(),
                      child: CarouselSlider(
                        items: imageList
                            .map(
                              (Map<String, String> item) => ClipRRect(
                                child: Image.asset(
                                  item['image_path']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          height: 200,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 35,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Colors.white
                                  : Colors.teal,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Text(
                "${getGreeting()}, ${context.read<AuthBloc>().state.firebaseUser!.displayName!.split(' ')[0]}!",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: (1 / .6),
                children: <HomeCard>[
                  HomeCard(
                    heading: 'Invite',
                    subHeading: 'Friends',
                    icon: Icons.person_add,
                    onTap: () {},
                  ),
                  HomeCard(
                    heading: 'Stamps',
                    subHeading: '0/10',
                    icon: Icons.local_drink,
                    onTap: () {},
                  ),
                  HomeCard(
                    heading: 'Vouchers',
                    subHeading: '0',
                    icon: Icons.loyalty,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 400,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          12), // Optional: Rounded corners
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      color: Colors.grey,
                      elevation: 4,
                      child: Container(
                        width: 370,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Our Driver Will Deliver Your Order To',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Set Your Address',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                side: const BorderSide(
                                    color: Colors.green, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                fixedSize: const Size(300, 30),
                              ),
                              child: const Text('Order Now'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        backgroundColor: Colors.green[400],
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Delivery'),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your action here
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                      ),
                      child: const Text('Pickup'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
