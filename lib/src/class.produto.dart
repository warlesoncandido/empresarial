import 'package:cloud_firestore/cloud_firestore.dart';

class Produtos{
  String id;
  String codigoBarras;
  String nome;
  String quant;
  String preco;
  String url;
  
  
  insertProduct(){
    Firestore.instance.collection("produtos").document(this.id).setData({
      "id": this.id,
      "codigoBarras": this.codigoBarras,
      "nome": this.nome,
      "estoque" : this.quant,
      "preco": this.preco,
      "url" : this.url
    });
  }
  deletProduct(id){
    Firestore.instance.collection("produtos").document(id).delete();
  }

  editarProduto(id){
    Firestore.instance.collection("produtos").document(id).updateData(
        {
          "codigoBarras":this.codigoBarras,
          "nome": this.nome,
          "estoque" : this.quant,
          "preco": this.preco,
          "url" : this.url
    }
    );
  }
  listarProduto(){

  }
  
}