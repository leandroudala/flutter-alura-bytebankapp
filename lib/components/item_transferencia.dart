import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  final Icon _moneyIcon = Icon(
    Icons.monetization_on,
    color: Colors.green[900],
  );
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _moneyIcon,
        title: Text('R\$ ${_transferencia.valor.toString()}'),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}
