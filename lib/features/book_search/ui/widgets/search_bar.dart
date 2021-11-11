import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../theme/theme_export.dart';

class SearchBar extends StatelessWidget {
  static const _radius20 = 20.0;
  static const _padding8 = 8.0;
  static const _padding16 = 16.0;
  static const _elevation2 = 2.0;
  const SearchBar({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final _translations = AppLocalizations.of(context);
    return InkWell(
      borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(_radius20), right: Radius.circular(_radius20)),
      onTap: onPressed,
      child: ClipRRect(
        child: Card(
          elevation: _elevation2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(_radius20),
                right: Radius.circular(_radius20)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: _padding16, vertical: _padding8),
            child: Row(
              children: [
                Text('${_translations?.searchBook}',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade600
                            : Palette.white)),
                const Spacer(),
                Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade600
                      : Palette.white,
                ),
              ],
            ),
          ),
        ),
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(_radius20),
            right: Radius.circular(_radius20)),
      ),
    );
  }
}
