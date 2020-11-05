import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTransferencias(),
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blue[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}

class _FormularioTransferencia extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: widget._controllerNumeroConta,
              label: 'Número da Conta',
              hint: '0000',
            ),
            Editor(
              controller: widget._controllerValor,
              label: 'Valor',
              hint: '0.00',
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              onPressed: () => widget._doTransfer(context),
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Criando transferência"),
      ),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  _FormularioTransferencia createState() => _FormularioTransferencia();

  void _doTransfer(BuildContext context) {
    final int numeroConta = int.tryParse(_controllerNumeroConta.text);
    final double valor = double.tryParse(_controllerValor.text);

    if (numeroConta != null && valor != null) {
      final transferencia = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferencia);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  Editor({this.controller, this.label, this.hint, this.icon});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transfers = List();

  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          return ItemTransferencia(widget._transfers[index]);
        },
      ),
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioTransferencia()),
          );

          future.then((transfer) {
            if (transfer != null) {
              setState(() {
                widget._transfers.add(transfer);
              });
            }
          });
        },
      ),
    );
  }
}

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

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
