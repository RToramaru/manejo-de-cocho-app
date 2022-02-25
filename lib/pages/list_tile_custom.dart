import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 1, 51, 2),
            ),
            child: Center(
              child: Text(
                'Leitura de Cocho',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calculate_outlined),
            title: const Text('Calcular Quantidade de Ração'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/calculate');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Registros'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/history');
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Consulta'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/search');
            },
          ),
          ListTile(
            leading: const Icon(Icons.send),
            title: const Text('Salvar Dados'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_graph),
            title: const Text('Gráficos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/graph');
            },
          ),
        ],
      ),
    );
  }
}
