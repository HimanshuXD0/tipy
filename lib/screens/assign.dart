import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TextFieldExample extends StatefulWidget {
  @override
  _TextFieldExampleState createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  final FocusNode _focusNode = FocusNode();
  var body="Hello! How can i help you ?";
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> Getdata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final result = json[0] as Map;
      String content = result['body'];
      setState(() {
        _focusNode.unfocus();
        body = content;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
       
        Center(
          child: Image.network(
            "https://cdn.staticneo.com/w/naruto/Nprofile2.jpg",
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height/1.25,
          ),
        ),
        
        Center(
          child: AnimatedBuilder(
            animation: _focusNode,
            builder: (context, child) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                top: _isFocused ? 70.0 : 310.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black, 
                  ),
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(253, 255, 253, 0.829),
                    hintText: 'Ask Naruto for advice!',
                    hintStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    suffixIcon: GestureDetector(
                      onTap: Getdata,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Visibility(
            visible: !_isFocused,
            child: Container(
              constraints: const BoxConstraints(
                // minWidth: 370,
                maxWidth: 330,
                maxHeight: 230,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(248, 248, 248, 0.845),
                shape: BoxShape.rectangle,
                border: Border.all(
                  width: 2,
                  color: Colors.orange,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              //constraints: BoxConstraints.expand();

              padding: EdgeInsets.all(25),
              child: Text(
                body,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
