import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionLabel extends StatefulWidget {
  const AppVersionLabel();

  @override
  State<AppVersionLabel> createState() => AppVersionLabelState();
}

class AppVersionLabelState extends State<AppVersionLabel> {
  String? _version;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = 'v${info.version}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Text(
      _version ?? '',
      style: GoogleFonts.jetBrainsMono(fontSize: 11, color: colors.onSurfaceVariant),
    );
  }
}
