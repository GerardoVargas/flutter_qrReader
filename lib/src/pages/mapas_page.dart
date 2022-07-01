import 'package:flutter/material.dart';
import 'package:qr_reader/src/widgets/scan_tiles.dart';


class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'geo');  
  }
}