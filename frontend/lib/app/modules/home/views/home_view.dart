import 'package:book_store_app/app/modules/auth/views/auth_view.dart';
import 'package:book_store_app/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';
import '../../books/views/books_view.dart';
import '../../wishlist/views/wishlist_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  static List<Widget> screens = <Widget>[
    BooksView(),
    WishlistView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        elevation: 0,
        selectedLabelStyle: TextStyle(
            color: Colors.grey.shade200,
            fontSize: 14,
            fontFamily: GoogleFonts.titilliumWeb().fontFamily),
        unselectedLabelStyle: TextStyle(
            color: Colors.grey.shade200,
            fontSize: 14,
            fontFamily: GoogleFonts.titilliumWeb().fontFamily),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
            ),
            backgroundColor: Colors.black,
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            backgroundColor: Colors.black,
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            backgroundColor: Colors.black,
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey.shade400,
        onTap: _onItemTapped,
      ),
    );
  }
}
