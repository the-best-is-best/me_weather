import 'ar_lang.dart';
import 'package:mit_x/mit_x.dart';

import 'en_lang.dart';

class LangController implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': EnLang.init(),
        'ar': ArLang.init(),
      };
}
