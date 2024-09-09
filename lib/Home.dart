import 'package:book_stash/Services/database.dart';
import 'package:book_stash/books.dart';
import 'package:book_stash/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController authorcontroller = TextEditingController();
  Stream? bookStream;

  dynamic getInfoInit() async {
    bookStream = await DatabaseHelper().getAllBookInfo();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getInfoInit();
  }

  Widget allBooksInfo() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Material(
                        color: const Color.fromARGB(255, 6, 29, 70),
                        elevation: 1.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 24, 224, 251),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.book_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "BOOK DETAILS",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 6, 29, 70),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                titlecontroller.text =
                                                    documentSnapshot["Title"];
                                                pricecontroller.text =
                                                    documentSnapshot["Price"];
                                                authorcontroller.text =
                                                    documentSnapshot["Author"];
                                                editBook(
                                                    documentSnapshot["Id"]);
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                size: 25,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Title:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  241, 63, 51, 33)),
                                        ),
                                      ),
                                      Text("  ${documentSnapshot["Title"]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Price:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  241, 63, 51, 33)),
                                        ),
                                      ),
                                      Text(
                                        "   ${documentSnapshot["Price"]}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Author:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    241, 63, 51, 33)),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        " ${documentSnapshot["Author"]}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
      stream: bookStream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "BOOK STASH",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(child: allBooksInfo()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 6, 29, 70),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BookScreen()));
        },
        child: Tooltip(
          message: "Add",
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Future editBook(String id) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Center(
                          child: Text(
                            "Edit a Book",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Divider(height: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Title:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: titlecontroller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  /*      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                                            ), */
                                  hintText: 'Enter Book title',
                                  hintStyle: TextStyle(color: Colors.blueGrey)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Price:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: pricecontroller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Price of the book',
                                  hintStyle: TextStyle(color: Colors.blueGrey)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Author:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: authorcontroller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter name of the Author',
                                  hintStyle: TextStyle(color: Colors.blueGrey)),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                  onPressed: () async {
                                    Map<String, dynamic> updateDetails = {
                                      "Title": titlecontroller.text,
                                      "Price": pricecontroller.text,
                                      "Author": authorcontroller.text,
                                      "Id": id,
                                    };
                                    await DatabaseHelper()
                                        .updateBook(id, updateDetails)
                                        .then((value) {
                                      ShowToast.toast(message: "Book updated");
                                      // print("Success!!!!");
                                      _print();
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text("Update")),
                              OutlinedButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  _print() {
    print("Title: ${titlecontroller.text}");
    print("Price: ${pricecontroller.text}");
    print("Author: ${authorcontroller.text}");
  }
}
