import 'package:cloud_firestore/cloud_firestore.dart';




class Pessoa{
  String id;
  String nome;
  String email;
  String telefone;
  String celular;
  String cep;
  String rua;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  String pais;

  Pessoa({this.nome,this.email,this.telefone,this.celular,this.cep,this.rua,this.numero,this.complemento,this.bairro,this.cidade,this.estado,this.pais});

   gravar()async{

     Firestore.instance.collection("client").document(this.id).setData( {

       "id" : this.id,
       "nome" : this.nome,
       "email": this.email,
       "telefone" : this.telefone,
       "celular" : this.celular,
       "cep" : this.celular,
       "rua" : this.rua,
       "numero" : this.numero,
       "bairro": this.bairro,
       "cidade" : this.cidade,
       "estado" : this.estado,
       "pais" : this.pais


     });



  }

  deletarCliente(id){
      Firestore.instance.collection("client").document(id).delete();
  }

  editarCliente(id){
      Firestore.instance.collection("client").document(id).updateData(
       {
         "nome" : this.nome,
         "email": this.email,
         "telefone" : this.telefone,
         "celular" : this.celular,
         "cep" : this.cep,
         "rua" : this.rua,
         "numero" : this.numero,
         "bairro" : this.bairro,
         "cidade" : this.cidade,
         "estado" : this.estado ,
         "pais" : this.pais

       }
     );
  }

}
