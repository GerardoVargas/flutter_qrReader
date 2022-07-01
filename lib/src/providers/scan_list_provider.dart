import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';


class ScanListProvider extends ChangeNotifier {
  List<ScanModel?> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan(String valor) async {
    final newScan = new ScanModel( valor: valor );
    final id = await DBProvider.db.nuevoScan(newScan);
    //Asignar el id de la BD al modelo
    newScan.id = id;
  
    if(selectedType == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  chargeScans() async{
    final scans = await DBProvider.db.getAllScans();
    //asignarlos al listado scans
    this.scans = [...scans];
    notifyListeners();
  }

  chargeScansByType( String tipo) async{
    final scans = await DBProvider.db.getScansByType(tipo);
    //asignarlos al listado scans
    this.scans = [...scans];
    this.selectedType = tipo;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async{
    scans.removeWhere((scan) => scan!.id == id);
    await DBProvider.db.deleteScan(id);
    //chargeScansByType(this.selectedType);
  }

}