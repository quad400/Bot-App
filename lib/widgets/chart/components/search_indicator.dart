import 'package:flutter/material.dart';
import 'package:frontend/data/chart_data.dart';


// 63342
class SearchIndicator extends StatefulWidget {
  SearchIndicator({Key? key}) : super(key: key);

  @override
  State<SearchIndicator> createState() => _SearchIndicatorState();
}

class _SearchIndicatorState extends State<SearchIndicator> {
  List<String> indicator = [];

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
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: SizedBox(
                height: 50,
                width: 400,
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _textFocusNode,
                  autofocus: true,
                  cursorColor: Colors.black,
                  onChanged: (query) {
                    setState(() {
                      // indicator = indicators.where((symbols) {
                      //   final result = symbols.toLowerCase();
                      //   final inputs = query.toLowerCase();
                      //   return result.contains(inputs);
                      // }).toList();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Indicator',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100.withAlpha(234),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                      gapPadding: 10,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      iconSize: 20,
                      onPressed: () {},
                      splashRadius: 14,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Colors.black12.withOpacity(0.1)),
                      gapPadding: 10,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              iconSize: 26,
              onPressed: () {},
              splashRadius: 17,
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        SingleChildScrollView(
          // child: _textEditingController.text.isNotEmpty && indicator.isEmpty
              child:  SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 50,
                        color:
                            Color.fromARGB(255, 147, 20, 11).withOpacity(0.8),
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
              // : ListView.builder(
              //     itemCount: _textEditingController.text.isNotEmpty
              //         ? indicator.length
              //         : indicators.length,
              //     itemBuilder: (context, index) {
              //       return (_textEditingController.text.isNotEmpty
              //           ? ListTile(title: Text(indicator[index]))
              //           : GestureDetector(
              //               onTap: () => setState(() {}),
              //               child: Text('${index}'),
              //             ));
                  // }),

          // : Column(
          //     children: indicators
          //         .map((e) => GestureDetector(
          //               onTap: () => setState(() {

          //                 e.isIndicator = true;
          //                 print('${e.indicatorName}' '${e.isIndicator}');
          //               }),
          //               child: Text(e.indicatorName),
          //             ))
          //         .toList()
        )
      ],
    );
  }

//   Widget listIndicatorButton(){
//     return ListTile()
//   }
}
