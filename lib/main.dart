import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //declaração dos controladores dos textFields
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  //declaração da chave global para validar os dados do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //declaração das váriaveis de controle dos textos de resultado e radiobutton
  String _infoTextIMC = "";
  String _infoTextBasal = "";
  String _selectSex = "m";
  //função responsável por "resetar" todos os dados do app via botão refresh
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    ageController.text = "";
    //reseta o estado dos textos de resultado, global key e radiobutton para
    setState(() {
      _infoTextIMC = "";
      _infoTextBasal = "";
      _formKey = GlobalKey<FormState>();
      _selectSex = "m";
    });
  }

  //função responsável pelo calculo do app
  void _calculate() {
    setState(() {
      //altera o estado dos objetos para que sejam mostrados na tela
      double weight = double.parse(weightController
          .text); //declaração variável que recebe o peso(convertendo para double)
      double height = double.parse(heightController
          .text); //declaração variável que recebe a altura(convertendo para double)
      double heightImc = height /
          100; //declaração variável que recebe o peso e divide por 100 para calculo do IMC
      int age = int.parse(ageController
          .text); //declaração variável que recebe a idade (convertendo para int)
      double imc = weight /
          (heightImc *
              heightImc); //declaração variável que recebe o calculo de IMC
      double basalM = 66 +
          (13.8 * weight) +
          (5 * height) -
          (6.8 *
              age); // declaração da váriavel que recebe o calculo da TMB de homens
      double basalF = 655 +
          (9.6 * weight) +
          (1.8 * height) -
          (4.7 *
              age); // declaração da váriavel que recebe o calculo da TMB de mulheres
      String sexo = _selectSex; //deckaração da variável que recebe o sexo

      //verifica em que faixa ficou o IMC e mostra o resultado na tela
      if (imc < 18.6) {
        _infoTextIMC = "IMC: Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoTextIMC = "IMC: Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoTextIMC = "IMC: Sobrepeso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoTextIMC = "IMC: Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoTextIMC = "IMC: Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoTextIMC =
            "IMC: Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }

      //Mostra o resultado da TBM de acordo com o sexo
      if (sexo == "m") {
        _infoTextBasal = "TMB: ${basalM.toStringAsPrecision(4)} Kcal";
      } else if (sexo == "f") {
        _infoTextBasal = "TMB: ${basalF.toStringAsPrecision(4)} Kcal";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //criação da appbar no topo
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xFF21BFBD),
        actions: <Widget>[
          //criação do botão de refresh para resetar os dados da tela
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Color(0xFF21BFBD),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Form(
          key: _formKey, //declaração da chave
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Calculadora",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "IMC / TMB",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.85,
                padding: EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //Criação dos campos do formulário
                    TextFormField(
                      keyboardType: TextInputType
                          .number, //seleciona o teclado numérico do dispositivo
                      decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: weightController, //define o controller
                      //coloca validação no campo para que a inserção de dados seja obrigatória
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu Peso";
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType
                          .number, //seleciona o teclado numérico do dispositivo
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: heightController, //define o controller
                      //coloca validação no campo para que a inserção de dados seja obrigatória
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua Altura";
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType
                          .number, //seleciona o teclado numérico do dispositivo
                      decoration: InputDecoration(
                        labelText: "Idade",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: ageController, //define o controller
                      //coloca validação no campo para que a inserção de dados seja obrigatória
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua Idade";
                        }
                      },
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //criação dos radio buttons para escolha do sexo
                          Radio(
                            value: "m", //seta o valor como "m"
                            groupValue: _selectSex,
                            onChanged: (String selected) {
                              setState(() {
                                _selectSex =
                                    selected; //passa o valor para variavel _selectSex
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text("Homem"),
                          Radio(
                            value: "f", //seta o valor como "f"
                            groupValue: _selectSex,
                            onChanged: (String selected) {
                              setState(() {
                                _selectSex =
                                    selected; //passa o valor para variavel _selectSex
                              });
                            },
                            activeColor: Colors.red,
                          ),
                          Text("Mulher"),
                        ]),
                    //Criação do botão de calculo que chama a função _calculate()
                    RaisedButton(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.pink[400],
                      padding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //valida os campos do formulário, se forem válidos chama a função _calculate
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //Criação de textos de instruções para o usuário
                    Text("IMC = Indíce de Massa Corporal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontFamily: "Montserrat",
                        )),
                    Text("TMB = Taxa Metabólica Basal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontFamily: "Montserrat",
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    ),
                    //Criação dos textos que recebem as variáveis com os resultados dos calculos
                    Text(_infoTextIMC,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.pink, 
                          fontSize: 22.0,
                          fontFamily: "Montserrat"
                        )
                    ),
                    Text(_infoTextBasal,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.pink, 
                          fontSize: 22.0,
                          fontFamily: "Montserrat"
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
