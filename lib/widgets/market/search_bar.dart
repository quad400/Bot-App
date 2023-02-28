import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  static String routeName = '/search';
  const MySearchBar({Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  List<String> symbols = ['EUR/USD', 'JPY/AUD', 'USD/AUD', 'CAD/JPY'];
  List<String>? symbolSearch;

  String query = '';
  final FocusNode _textFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            size: 19,
            color: Colors.black,
          ),
          splashRadius: 14,
        ),
        title: TextField(
          controller: _textEditingController,
          focusNode: _textFocusNode,
          autofocus: true,
          cursorColor: Colors.black,
          onChanged: (query) {
            setState(() {
              symbolSearch = symbols.where((symbols) {
                final result = symbols.toLowerCase();
                final inputs = query.toLowerCase();
                return result.contains(inputs);
              }).toList();
            });
          },
          decoration: InputDecoration(
            hintText: 'Search Symbol',
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
            filled: true,
            fillColor: Colors.grey.shade100.withAlpha(234),
            // suffixIcon: IconButton(
            //   onPressed: () {
            //     setState(() {
            //       if (query.isEmpty) {
            //         // Navigator.pop(context, null);
            //         print('happy');
            //       } else {
            //         query = '';
            //         print('sad');
            //       }
            //     });
            // //   },
            //   icon: const Icon(
            //     Icons.clear,
            //     size: 17,
            //     color: Colors.black45,
            //   ),
            //   splashRadius: 14,
            // ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black12.withOpacity(0.1)),
              gapPadding: 10,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 19,
              color: Colors.black,
            ),
            splashRadius: 17,
          ),
        ],
      ),
      body: _textEditingController.text.isNotEmpty && symbolSearch!.isEmpty
          ? SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 50,
                    color: Color.fromARGB(255, 147, 20, 11).withOpacity(0.8),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Oops! No result found\n Please try different keyword',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: _textEditingController.text.isNotEmpty
                  ? symbolSearch!.length
                  : symbols.length,
              itemBuilder: (context, index) {
                return (_textEditingController.text.isNotEmpty
                    ? ListTile(title: Text(symbolSearch![index]))
                    : ListTile(
                        title: Text(''),
                      ));
              }),
    );
  }
}
