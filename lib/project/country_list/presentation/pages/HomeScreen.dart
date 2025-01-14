// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:minimal_country_explorer/project/country_list/presentation/widgets/country_list_view.dart';
//
// import 'FavoritesView.dart';
//
// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   int _selectedIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _selectedIndex == 0
//             ? TextField(
//                 controller: _searchController,
//                 decoration: const InputDecoration(
//                   hintText: 'Search countries...',
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//               )
//             : const Text('Favorites'),
//       ),
//       body: _selectedIndex == 0
//           ? CountryListView(searchQuery: _searchController.text)
//           : const FavoritesView(),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.public),
//             label: 'Countries',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//         ],
//       ),
//     );
//   }
// }