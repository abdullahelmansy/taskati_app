import 'package:flutter/material.dart';

push(context, Widget view) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => view,
    ),
  );
}

pushAndRemoveUntil(context, Widget view) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => view,
      ),
      (route) => false);
}

pushReplacement(context, Widget view) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => view,
    ),
  );
}
