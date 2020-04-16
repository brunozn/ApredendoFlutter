import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informa seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;

      double imc = weight/(height * height);
      print(imc);
      if(imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4) })";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4) })";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Acima do peso (${imc.toStringAsPrecision(4) })";
      }else if(imc>=29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4) })";
      }else if(imc >= 34.9 && imc <39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4) })";
      }else if(imc >= 40){
        _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(4) })";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), 
          onPressed: _resetFields,
        )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, size: 120.0, color: Colors.blue[900]),
          TextFormField(keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Peso em (Kg)",
              labelStyle: TextStyle(color: Colors.blue[900])
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue[900], fontSize: 25.0),
            controller: weightController,
            validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
            },
          ),
          TextFormField(keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Altura em (cm)",
              labelStyle: TextStyle(color: Colors.blue[900])
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue[900], fontSize: 25.0),
            controller: heightController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top:10.0, bottom: 10.0),
            child: Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    _calculate();
                  }
                },
                child: Text("Calcular", 
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                color: Colors.blue[900],
              ) ,
            ),
          ),
          Text(_infoText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue[900],
          fontSize: 25.0),
          )
        ]
      ),
        ),
      )
    );
  }
}