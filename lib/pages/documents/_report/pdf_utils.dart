import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PdfUtils {
  static Future<File> savePdf({
    required String name,
    required pw.Document pdf,
  }) async {
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final filePath = '${directory?.path}/${name}_$timestamp.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static Future<void> openPdf(File file) async {
    await OpenFile.open(file.path);
  }

  static Future<void> uploadPdf(File file, BuildContext context) async {
    try {
      final bytes = await file.readAsBytes();
      final fileName = '${DateTime.now().toIso8601String()}.pdf';

      await supabase.storage.from('documents').uploadBinary(
            fileName,
            bytes,
            fileOptions: const FileOptions(contentType: 'application/pdf'),
          );

      final documentUrl = await supabase.storage
          .from('documents')
          .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10);

      if (documentUrl.isNotEmpty) {
        await supabase.from('profiles').update({
          'document_url': documentUrl,
        }).eq('id', supabase.auth.currentUser!.id);

        if (!context.mounted) return;
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
              message: 'PDF uploaded and profile updated successfully!'),
        );
      } else {
        if (!context.mounted) return;
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
              message: 'Failed to create signed URL for document'),
        );
      }
    } on StorageException catch (e) {
      if (!context.mounted) return;
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: e.message.toString()),
      );
    } catch (e) {
      if (!context.mounted) return;
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Unexpected error occurred'),
      );
    }
  }
}
