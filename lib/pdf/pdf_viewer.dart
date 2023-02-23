import 'dart:io';

import 'package:billgenrater/pdf/file_handle_api.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class MyPdfViewr extends StatefulWidget {
  const MyPdfViewr({super.key});

  @override
  State<MyPdfViewr> createState() => _MyPdfViewrState();
}

class _MyPdfViewrState extends State<MyPdfViewr> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.file(FileHandleApi.pdf as File,
          controller: _pdfViewerController),
    );
  }
}
