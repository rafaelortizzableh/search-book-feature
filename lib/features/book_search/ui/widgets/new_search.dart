import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui_export.dart';

class NewSearch extends StatefulWidget {
  const NewSearch({Key? key}) : super(key: key);

  @override
  _NewSearchState createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  final _searchController = TextEditingController();
  static const _padding32 = 32.0;
  static const _padding16 = 16.0;
  static const _elevation5 = 5.0;
  static const _milliseconds100 = 100;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _translations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: AnimatedContainer(
        margin: const EdgeInsets.only(bottom: _padding32),
        duration: const Duration(milliseconds: _milliseconds100),
        padding: MediaQuery.of(context).viewInsets,
        child: Card(
          elevation: _elevation5,
          child: Container(
            padding: const EdgeInsets.all(_padding16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${_translations?.newSearch}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: '${_translations?.searchBook}'),
                  controller: _searchController,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (text) => text.trim().isNotEmpty
                      ? BookSearchUiFunctions.submitData(
                          _searchController,
                          context,
                        )
                      : null,
                  onChanged: (text) => setState(() {}),
                ),
                const SizedBox(height: _padding16),
                ElevatedButton(
                  child: Text('${_translations?.search}'),
                  onPressed: _searchController.text.trim().isEmpty
                      ? null
                      : () => BookSearchUiFunctions.submitData(
                            _searchController,
                            context,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
