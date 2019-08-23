import 'dart:convert';

import 'package:cliente_cadastro/produtos.dart';
import 'package:cliente_cadastro/vendas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:http/http.dart' as http;
import 'src/class_cliente.dart';
import 'cliente.dart';

Pessoa usuario = Pessoa();

void main() async {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  bool edit = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController paisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Expanded(
            child: IconButton(
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClientePage()));
                }),
          ),
          Expanded(
            child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProdutosPage()));
                }),
          ),
          Expanded(
            child: IconButton(
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VendasPage()));
                }),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 3),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nome:",
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,

                        ),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite seu nome';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "E-mail:",
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,

                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite seu E-mail';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: MaskedTextField(
                            escapeCharacter: "x",
                            maxLength: 13,
                            maskedTextFieldController: telefoneController,
                            mask: "(xx)xxxx-xxxx",
                            inputDecoration: InputDecoration(
                              labelText: "Telefone",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: MaskedTextField(
                            escapeCharacter: "x",
                            maxLength: 14,
                            maskedTextFieldController: celularController,
                            mask: "(xx)xxxxx-xxxx",
                            inputDecoration: InputDecoration(
                              labelText: "Celular",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: MaskedTextField(
                          escapeCharacter: "x",
                          maxLength: 9,
                          maskedTextFieldController: cepController,
                          mask: "xxxxx-xxx",
                          inputDecoration: InputDecoration(
                            labelText: "CEP",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,

                            ),
                          ),
                        )),
                        IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              setState(() {
                                buscaCep();
                              });
                            })
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Endereço:",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                            controller: ruaController,
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Nº:",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                            controller: numeroController,
                          ),
                        )
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Complemento",
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,

                        ),
                      ),
                      controller: complementoController,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Bairro:",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                            controller: bairroController,
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Cidade:",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                            controller: cidadeController,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Estado:",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                            controller: estadoController,
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Pais:",
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,

                              ),
                            ),
                            controller: paisController,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: FloatingActionButton(
                        onPressed: () {
                          gravarDados();
                          showAlertDialog1(context);
                          clearFields();
                        },
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

// FUNÇÃO DE BUSCA DE CEP
  void buscaCep() async {
    var resquest =
        "https://api.postmon.com.br/v1/cep/${cepController.text.replaceAll("-", "")}";
    http.Response response = await http.get(resquest);
    ruaController.text = json.decode(response.body)['logradouro'];
    bairroController.text = json.decode(response.body)['bairro'];
    cidadeController.text = json.decode(response.body)['cidade'];
    estadoController.text = json.decode(response.body)['estado'];
    paisController.text = "BR";
  }

// GRVANDO DADOS DO USUARIO
  gravarDados() {
    usuario.id = Firestore.instance.collection("client").document().documentID;
    usuario.nome = nameController.text;
    usuario.email = emailController.text;
    usuario.telefone = telefoneController.text;
    usuario.celular = celularController.text;
    usuario.cep = cepController.text;
    usuario.rua = ruaController.text;
    usuario.numero = numeroController.text;
    usuario.bairro = bairroController.text;
    usuario.cidade = cidadeController.text;
    usuario.estado = estadoController.text;
    usuario.pais = paisController.text;

    usuario.gravar();
  }

//  LIMPANDO TODOS OS CAMPOS
  void clearFields() {
    setState(() {
      nameController.clear();
      emailController.clear();
      telefoneController.clear();
      celularController.clear();
      celularController.clear();
      cepController.clear();
      ruaController.clear();
      numeroController.clear();
      complementoController.clear();
      bairroController.clear();
      cidadeController.clear();
      estadoController.clear();
      paisController.clear();
    });
  }
}

showAlertDialog1(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Cadastrado com sucesso"),
    content: Icon(
      Icons.check,
      color: Colors.green,
      size: 30.0,
    ),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
