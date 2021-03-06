import 'package:flutter/material.dart';

import 'package:qr_reader/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL( BuildContext context, ScanModel scan ) async {
    final  url = scan.valor;

    if( scan.tipo == 'http') {
      //abrir el url del sitio
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    } else {
      Navigator.pushNamed(context, 'map', arguments: scan);
    }

}