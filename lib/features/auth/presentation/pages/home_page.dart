import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/enum/direction.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/utility/dialog_display.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/fulfillment_card.dart';
import 'package:fruit_jus_168/features/auth/presentation/widgets/home_card.dart';
import 'package:go_router/go_router.dart';

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
                "${getGreeting()}, ${context.watch<AuthBloc>().state.firebaseUser!.displayName!.split(' ')[0]}!",
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
                    onTap: () {
                      GoRouter.of(context).push('/referral-code');
                    },
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
              const SizedBox(height: 25),
              buildDeliveryPickupSection()
            ],
          ),
        ),
      ),
    );
  }

  Container buildDeliveryPickupSection() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: FullfillmentCard(
              direction: Direction.vertical,
              text: "DELIVERY",
              imagePath: 'assets/images/delivery.png',
              onTap: () =>
                  context.pushNamed(AppRouterConstants.addressRouteName),
            ),
          ),
          Expanded(
            child: FullfillmentCard(
              direction: Direction.vertical,
              text: "PICKUP",
              imagePath: 'assets/images/pickup.png',
              onTap: () {
                displayPickupLocationDialog(context);
              },
            ),
          ),
        ],
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
