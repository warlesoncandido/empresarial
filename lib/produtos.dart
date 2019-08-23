import 'dart:io';
import 'package:cliente_cadastro/src/class.produto.dart';
import 'package:cliente_cadastro/vendas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



TextEditingController codigoBarrasController = TextEditingController();
TextEditingController editedCodigoBarrasController = TextEditingController();
TextEditingController nomeController = TextEditingController();
TextEditingController unitController = TextEditingController();
TextEditingController valorController = TextEditingController();
TextEditingController editedIdController = TextEditingController();
TextEditingController editedNomeController = TextEditingController();
TextEditingController editedUnitController = TextEditingController();
TextEditingController editedValorController = TextEditingController();







Produtos produtos = Produtos();

class ProdutosPage extends StatefulWidget {
  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return gravarProduto(context: context);
                  },
                );
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance.collection("produtos").snapshots(),
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
                              return ProductCard(snapshot.data.documents[index].data);
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


 String url;

class ProductCard extends StatefulWidget {


 

  
  final Map<String,dynamic> data;
  ProductCard(this.data);



  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
 

 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(left: 5 ,right: 5,bottom: 10.0),
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.data['url']),
                    ),
                    ),
                    Expanded(
                     child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.data['nome'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Text("Codigo Produto : ${widget.data['codigoBarras']}",style: TextStyle(fontSize: 15.0),),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("Estoque : ${widget.data['estoque']}",
                              style:TextStyle(fontSize: 15.0) ,)
                        ),
                        Expanded(
                            child: Text("Valor: ${widget.data['preco']}",
                              style:TextStyle(fontSize: 15.0) ,
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: IconButton(
                                icon: Icon(Icons.edit,color: Colors.orange,),
                                onPressed: (){

                                  editedCodigoBarrasController.text = widget.data['codigoBarras'];
                                  editedNomeController.text = widget.data['nome'];
                                  editedUnitController.text = widget.data['estoque'];
                                  editedValorController.text = widget.data['preco'];

                                   return
                                     showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Editando'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: editedCodigoBarrasController,

                                                  decoration: InputDecoration(
                                                    labelText: "Codigo Produto",

                                                  ),
                                                  onChanged: (text){

                                                  },


                                                ),
                                                TextField(
                                                  controller: editedNomeController,
                                                  decoration: InputDecoration(
                                                    labelText: "Nome Produto",
                                                  ),
                                                  onChanged: (text){

                                                  },

                                                ),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  controller: editedUnitController,
                                                  decoration: InputDecoration(

                                                    labelText: "Quantidade em Estoque",
                                                  ),
                                                  onChanged: (text){

                                                  },

                                                ),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  controller: editedValorController,
                                                  decoration: InputDecoration(
                                                    labelText: "Preço Unitario",
                                                  ),
                                                  onChanged: (text){

                                                  },

                                                ),
                                                RaisedButton.icon(
                                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                                  icon: Icon(Icons.photo_camera,color: Colors.blue,),
                                                  label: Text("Inserir Imagem",
                                                  style:TextStyle(
                                                    color: Colors.black
                                                  )),
                                                  onPressed:()async{
                                                     File img;
                                                    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                                    setState(() {
                                                     img = image; 
                                                    });
                                                                StorageUploadTask task = await FirebaseStorage.instance.ref().child(img.toString()).putFile(img);
                                                                String imgUrl =await  (await task.onComplete).ref.getDownloadURL();
                                                                imgUrl.toString();
                                                                produtos.url = imgUrl.toString();
                                                                
                                                                
                                                                
                                                                
                                                                
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
                                                
                                                
                                                editandoProdutos(widget.data['id']);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });


                                }
                            )
                        ),
                        Flexible(
                            child: IconButton(
                                icon: Icon(Icons.delete,color: Colors.red,),
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
                                      produtos.deletProduct(widget.data['id']);
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
                                  });
                                }
                            )
                        ),
                      ],
                    ),

                  ],
                ),
                    )
                  ],
                )
            )
          ),
        )
      ),

    );
  }
}





gravarProduto({context}) {



  return AlertDialog(
    title: Text("Novo Produto",style: TextStyle(color: Colors.blue),
    textAlign: TextAlign.center,),
    backgroundColor: Colors.white,

    content: SingleChildScrollView(
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Codigo Produto",

            ),
            controller: codigoBarrasController,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nome Produto",
            ),
            controller: nomeController,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Quantidade em Estoque",
            ),
            controller: unitController,
          ),
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              labelText: "Preço Unitario",
            ),
            controller: valorController,
          ),
          Row(
           children: <Widget>[
             FlatButton(
                 onPressed: (){
                   Navigator.pop(context);
                   clearField();
                 },
                 child: Text("Sair")
             ),
             FlatButton(
                 onPressed: (){
                     gravandoProduto();
                     produtos.insertProduct();
                     clearField();


                 },
                 child: Text("Gravar")
             ),
           ],
          ),

        ],
      ),
    ),
  );
}

editandoProdutos(id){
  produtos.codigoBarras = editedCodigoBarrasController.text.toUpperCase();
  produtos.nome = editedNomeController.text.toUpperCase();
  produtos.quant = editedUnitController.text.toUpperCase();
  produtos.preco = editedValorController.text.toUpperCase();
  
  produtos.editarProduto(id);
}

gravandoProduto(){

  produtos.id =Firestore.instance.collection("produtos").document().documentID;
  produtos.codigoBarras = codigoBarrasController.text.toUpperCase();
  produtos.nome = nomeController.text.toUpperCase();
  produtos.quant = unitController.text.toUpperCase();
  produtos.preco =valorController.text.toUpperCase();
  produtos.url =  "https://firebasestorage.googleapis.com/v0/b/testando-641b0.appspot.com/o/File%3A%20'%2Fstorage%2Femulated%2F0%2FDownload%2Fimages%20(1).jpeg'?alt=media&token=0cc68ec3-891f-4d45-9cce-e3b8f39d14e3";

}

clearField(){
  codigoBarrasController.clear();
  nomeController.clear();
  unitController.clear();
  valorController.clear();
}

 // FUNÇÕES DE ENVIO DE IMAGENS

