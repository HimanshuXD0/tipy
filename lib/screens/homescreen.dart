import 'package:flutter/material.dart';

import 'package:tipy/widgets/widgets.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _formKey = GlobalKey<FormState>();
  var displytext = 0;
  var tip = 0;
  double _sliderValue = 0.0;
  TextEditingController principlecontroler = TextEditingController();
  TextEditingController displytextcnt = TextEditingController();

  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tipy'),
          titleTextStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                GetImage(),
                TextFormField(
                    controller: principlecontroler,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'pls enter valid amount';
                      }
                    },
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Bill Amount',
                      prefixIcon: Icon(
                        Icons.money,
                        color: Colors.green.shade400,
                      ),
                    )),
                const SizedBox(height: 10),
                Text(
                  'How much you wanna tip?  :  current: $tip %',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Slider(
                  value: _sliderValue, // initial value
                  min: 0,
                  max: 100,
                  divisions: null,  // number of intervals between min and max
                  label: tip
                      .toString(),  // optional label that appears when the slider is moved
                  onChanged: (double value) {
                    setState(() {
                      _sliderValue = value;
                      tip = value.toInt();
                      displytext = calculate();
                    });
                  },
                ),
                const SizedBox(height: 15),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text("Giving amount : ${displytext.toString()}₹",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.brown)),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget GetImage() {
    AssetImage assetImage =
        const AssetImage('assets/images/undraw_Success_factors_re_ce93.png');
    Image image = Image(
      image: assetImage,
      width: 350,
      height: 350,
    );
    return Container(
      child: image,
      padding: EdgeInsets.only(bottom: 10),
    );
  }

  int calculate() {
    int principle = int.parse(principlecontroler.text);
    return (principle * tip) ~/ 100;
  }}
