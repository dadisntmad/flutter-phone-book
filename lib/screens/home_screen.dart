import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import 'package:phone_book/constants.dart';
import 'package:phone_book/resources/auth_methods.dart';
import 'package:phone_book/resources/firestore_methods.dart';
import 'package:phone_book/screens/add_employee_screen.dart';
import 'package:phone_book/screens/employee_detailed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;

  void logout() async {
    await AuthMethods().signOut();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddEmployeeScreen(
                    isEditMode: false,
                    employee: null,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add, color: Colors.blue),
          ),
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.exit_to_app, color: Colors.blue),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (String _) {
                setState(() {
                  _isSearching = true;
                });

                if (_searchController.text.isEmpty) {
                  _isSearching = false;
                }
              },
              autofocus: false,
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            _isSearching
                ? _SearchList(text: _searchController.text)
                : const _EmployeesList(),
          ],
        ),
      ),
    );
  }
}

class _EmployeesList extends StatelessWidget {
  const _EmployeesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db
          .collection('employees')
          .where('companyId', isEqualTo: auth.currentUser?.uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        return _List(snapshot: snapshot);
      },
    );
  }
}

class _SearchList extends StatelessWidget {
  final String text;
  const _SearchList({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db
          .collection('employees')
          .where('companyId', isEqualTo: auth.currentUser?.uid)
          .where('fullName', isGreaterThanOrEqualTo: text)
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        return _List(snapshot: snapshot);
      },
    );
  }
}

class _List extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  _List({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: snapshot.data!.docs.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final employee = snapshot.data!.docs[index];

          return SwipeActionCell(
            key: UniqueKey(),
            trailingActions: <SwipeAction>[
              SwipeAction(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onTap: (CompletionHandler handler) async {
                  await handler(true);
                  await FirestoreMethods().delete(
                    employee['docId'],
                  );
                },
                color: Colors.red,
              ),
              SwipeAction(
                icon: const Icon(Icons.edit, color: Colors.white),
                onTap: (CompletionHandler handler) async {
                  handler(false);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddEmployeeScreen(
                        isEditMode: true,
                        employee: employee,
                      ),
                    ),
                  );
                },
                color: Colors.grey,
              ),
            ],
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EmployeeDetailedScreen(
                      employee: employee,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  employee['fullName'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
