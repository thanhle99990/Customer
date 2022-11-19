import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';

class Star extends StatelessWidget {
  final double rating;

  const Star({Key key, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
          width: 60,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(rating == null ? '' : rating.toStringAsFixed(1),
                    style: TextStyle(fontSize: 14)),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                )
              ],
            ),
          )),
    );
  }
}
