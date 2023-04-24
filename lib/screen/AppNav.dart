import 'package:class_room_chin/screen/home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppNav extends StatefulWidget {
  const AppNav({Key? key}) : super(key: key);

  @override
  State<AppNav> createState() => _AppNavState();
}

class _AppNavState extends State<AppNav> {
  final List<Widget> _pages =  [HomeScreen(),HomeScreen()];
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0,keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          //physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context,isInner){
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 150,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hey ${FirebaseAuth.instance.currentUser?.displayName ?? ""},',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Which skill are you looking to \nacquire today?',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  collapseMode: CollapseMode.pin,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius:const BorderRadius.all(Radius.circular(15))
                    ),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type something',
                          prefixIcon: Icon(Icons.search)
                      ),
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: PageView(
            controller: _pageController,
            physics:const NeverScrollableScrollPhysics(),
            children: _pages,
          ),
        )
    );
  }

  void navTap(int index){
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    setState(() {
      _currentIndex = index;
    });
  }
}
