import 'package:flutter/material.dart';
import 'package:flutter_bytebank/models/transferencia.dart';
import 'package:flutter_bytebank/screens/transferencia/formulario.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencias(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            atualiza(transferenciaRecebida, setState, widget, context);
          });
        },
      ),
    );
  }
}

void atualiza(Transferencia? transferenciaRecebida, functionset, widget,
    BuildContext context) {
  if (transferenciaRecebida != null) {
    functionset(() {
      //para atualizar conteúdo, chamar o build
      widget._transferencias.add(transferenciaRecebida);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: const Text('Transferência feita'),
        duration: const Duration(milliseconds: 1500),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class ItemTransferencias extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencias(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.numeroConta.toString()),
        subtitle: Text(_transferencia.valor.toString()),
      ),
    );
  }
}
