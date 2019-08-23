import 'package:cliente_cadastro/src/class_cliente.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


TextEditingController nomeController = TextEditingController();
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

Pessoa pessoa = Pessoa();
class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(icon:Icon(Icons.search),
          onPressed:()async{

          }
           )
        ],
      ),
      body:Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance.collection("client").snapshots(),
                  builder: (context,snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context,index){
                              return CardClient(snapshot.data.documents[index].data);
                            }


                        );
                    }
                  }

              )
          ),
          Divider(
            height: 2.0,
          ),
        ],
      ),
    );
  }


}

class CardClient extends StatelessWidget {

  final Map<String,dynamic> data;
  CardClient(this.data);







  @override
  Widget build(BuildContext context) {
    return Container(
        
        child: GestureDetector(

          onTap: (){},
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(

          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data['nome'],
                  style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold)
              ),
              Text(data['email']),
              Row(

                children: <Widget>[

                  Expanded(
                      child:Text(data['telefone'])
                  ),
                  Flexible(
                      child:Text(data['celular'])
                  ),

                ],
              ),

              Text(data['cep']),
              Row(

                children: <Widget>[

                  Expanded(
                      child:Text(data['rua'])
                  ),
                  Flexible(
                      child:Text(data['numero'])
                  ),

                ],
              ),
              Row(

                children: <Widget>[

                  Expanded(
                      child:Text(data['bairro'])
                  ),
                  Flexible(
                      child:Text(data['cidade'])
                  ),

                ],
              ),
              Row(

                children: <Widget>[

                  Expanded(
                      child:Text(data['estado'])
                  ),
                  Flexible(
                      child:Text(data['pais'])
                  ),

                ],
              ),
              Row(

                children: <Widget>[
                  Expanded(
                      child: IconButton(
                          icon: Icon(Icons.edit,color: Colors.orange,size: 25.0,),
                          onPressed:(){

                              nomeController.text = data['nome'];
                              emailController.text = data['email'];
                              telefoneController.text = data['telefone'];
                              celularController.text = data['celular'];
                              cepController.text = data['cep'];
                              ruaController.text = data['rua'];
                              numeroController.text = data['numero'];
                              complementoController.text = data['complemento'];
                              bairroController.text = data['bairro'];
                              cidadeController.text = data['cidade'];
                              estadoController.text = data['estado'];
                              paisController.text = data['pais'];

                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Editando'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: nomeController,
                                                  decoration: InputDecoration(
                                                    labelText: "Nome"
                                                  ),
                                                  onChanged: (text){

                                                        },
                                                ),
                                                TextField(
                                                  controller: emailController,
                                                  decoration: InputDecoration(
                                                    labelText: "E-mail"
                                                  ),
                                                  onChanged: (text){

                                                    },
                                                ),
                                                TextField(
                                                  controller: telefoneController,
                                                  decoration: InputDecoration(
                                                    labelText: "Telefone"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: celularController,
                                                  decoration: InputDecoration(
                                                    labelText: "Celular"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: cepController,
                                                  decoration: InputDecoration(
                                                    labelText: "CEP"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: ruaController,
                                                  decoration: InputDecoration(
                                                    labelText: "Rua"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: numeroController,
                                                  decoration: InputDecoration(
                                                    labelText: "Nº"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: complementoController,
                                                  decoration: InputDecoration(
                                                    labelText: "Complemento"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: bairroController,
                                                  decoration: InputDecoration(
                                                    labelText: "Bairro"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: cidadeController,
                                                  decoration: InputDecoration(
                                                    labelText: "Cidade"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: estadoController,
                                                  decoration: InputDecoration(
                                                    labelText: "Estado"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                                TextField(
                                                  controller: paisController,
                                                  decoration: InputDecoration(
                                                    labelText: "Pais"
                                                  ),
                                                  onChanged: (text){


                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text('Cancelar'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: new Text('Editar'),
                                              onPressed: () {
                                                editandoCliente(data['id']);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                            },

                      )
                  ),
                  Flexible(
                      child: IconButton(
                          icon: Icon(Icons.delete,color: Color.fromRGBO(255, 0, 0, 1),size: 25.0,),
                          onPressed: (){
                            Widget cancelaButton = FlatButton(
                              child: Text("Cancelar"),
                              onPressed:  () {
                                Navigator.pop(context);
                              },
                            );
                            Widget continuaButton = FlatButton(
                              child: Text("Deletar"),
                              onPressed:  () {
                                pessoa.deletarCliente(data['id']);
                                Navigator.pop(context);
                              },
                            );
                            //configura o AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Deletar?",style: TextStyle(color: Color.fromRGBO(255, 0, 0, 1)),),
                              content: Text("Deseja mesmo deletar ?"),
                              actions: [
                                cancelaButton,
                                continuaButton,
                              ],
                            );
                            //exibe o diálogo
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                      )
                  ),
                ],
              )






            ],
          ),

        ),
          )
        ),



    );


  }


}
void editandoCliente(id){
  pessoa.nome = nomeController.text;
  pessoa.email= emailController.text;
  pessoa.telefone = telefoneController.text;
  pessoa.celular = celularController.text;
  pessoa.cep = cepController.text;
  pessoa.rua = ruaController.text;
  pessoa.numero = numeroController.text;
  pessoa.bairro = bairroController.text;
  pessoa.cidade = cidadeController.text;
  pessoa.estado = estadoController.text;
  pessoa.pais = paisController.text;

  pessoa.editarCliente(id);
}







