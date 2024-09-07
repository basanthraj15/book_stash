import 'package:book_stash/Services/database.dart';
import 'package:book_stash/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController authorcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "ADD A BOOK",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Title:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                SizedBox(height: 30),
                Center(
                    child: OutlinedButton(
                        onPressed: () async {
                          String Id = randomAlphaNumeric(10);
                          Map<String, dynamic> bookInfoMap = {
                            "Title": titlecontroller.text,
                            "Price": pricecontroller.text,
                            "Author": authorcontroller.text
                          };
                          await DatabaseHelper()
                              .addBookDetails(bookInfoMap, Id)
                              .then((value) {
                            ShowToast.toast(message: "Message has been added!");
                            // print("Success!!!!");
                            _showSnackBar(context);
                            Navigator.of(context).pop();
                          });
                          _print();
                        },
                        child: Text("Add")))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _print() {
    print("Title: ${titlecontroller.text}");
    print("Price: ${pricecontroller.text}");
    print("Author: ${authorcontroller.text}");
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Book Added Successfully"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();
    pricecontroller.dispose();
    authorcontroller.dispose();
  }
}
