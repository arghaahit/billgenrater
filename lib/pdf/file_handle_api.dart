import 'dart:html' as webFile;
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';


class FileHandleApi {
  // save pdf file function
  static downloadFile(File url) {
   webFile.AnchorElement anchorElement =   webFile.AnchorElement(href: url.path);
   anchorElement.download = url.path;
   anchorElement.click();
}
  static  saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    webFile.File bytes = (await pdf.save()) as webFile.File;
    final reader = webFile.FileReader();
    reader.readAsText(bytes);
    
  
  }

  // open pdf file function
  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
  static late final pw.Document pdf;
}