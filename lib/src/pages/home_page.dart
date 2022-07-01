import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/pages/direcciones_page.dart';
import 'package:qr_reader/src/pages/mapas_page.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_providers.dart';
import 'package:qr_reader/src/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).deleteAll();
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),

      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }

}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // TODO: Temp leer db
    final temScan = new ScanModel(valor: 'http//www.wikipedia.com');
    //DBProvider.db.nuevoScan(temScan);
    //DBProvider.db.getScanById(5).then((scan) => print(scan!.valor));
    //DBProvider.db.deleteAllScan().then(print);
    
    // Cambiar para mostrar la pagian respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // Usar el ScanListProvider 
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch(currentIndex) {
      case 0:
        scanListProvider.chargeScansByType('geo');
        return MapasPage();
      
      case 1:
        scanListProvider.chargeScansByType('http');
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}