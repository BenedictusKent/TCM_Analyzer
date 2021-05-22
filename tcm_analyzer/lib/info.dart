import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  // pass in arguments
  final String data;
  InfoPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  // declarations and initializations
  bool stat;
  String text, folder;
  Map<String, String> map1 = {
    '黃苓': 'X1',
    'Baikal Skullcap Root': 'X1',
    '熟地黃': 'X2',
    'Radix Rehmanniae Preparata': 'X2',
    '黨參': 'X3',
    'Pilose Asiabell Root': 'X3',
    '甘草': 'X4',
    'Licorice': 'X4',
    '懷牛膝': 'X5',
    'Two-toothed Achyranthes': 'X5',
    '麥門冬': 'X6',
    'Dwarf Lilyturf Root Tuber': 'X6',
    '白术': 'X7',
    'Largehead Atractylodes Rhizome': 'X7',
    '野葛': 'X8',
    'Lobed Kudzuvine Root': 'X8',
    '桑白皮': 'X9',
    'White Mulberry Root-bark': 'X9',
    '桔梗': 'X10',
    'Balloonflower Root': 'X10',
    '山茱萸': 'X11',
    'Medical Dogwood': 'X11',
    '何首烏': 'X12',
    'Tuber Fleeceflower Root': 'X12',
    '赤芍': 'X13',
    'Red Paeoniae Trichocarpae': 'X13',
    '桂皮': 'X14',
    'Cassia Bark': 'X14',
    '岷當歸': 'X15',
    'Chinese Angelica': 'X15',
    '川芎': 'X16',
    'Szechwan Lovage Rhizome': 'X16',
    '川紅花': 'X17',
    'Safflower': 'X17',
    '枳實': 'X18',
    'Immature Bitter Orange': 'X18',
    '紅棗': 'X19',
    'Common Jujube': 'X19',
    '細辛根': 'X20',
    'Manchurian Wildginger Herb': 'X20',
    '連翹': 'X21',
    'Weeping Forsythia Fruit': 'X21',
    '懷山藥': 'X22',
    'Common Yam Rhizome': 'X22',
    '款冬花': 'X23',
    'Common Coltsfoot Flower': 'X23',
    '乾薑': 'X24',
    'Dried Ginger': 'X24',
    '袍附子': 'X25',
    'Prepared Common Monkshood Daughter Root': 'X25',
    '桃仁': 'X26',
    'Peach Seed': 'X26',
    '紫苑': 'X27',
    'Tatarian Aster Root': 'X27',
    '烏藥': 'X28',
    'Combined Spicebush Root': 'X28',
    '銅陵鳳丹皮': 'X29',
    'Tree Peony Bark': 'X29',
    '寧夏枸杞': 'X30',
    'Barbary Wolfberry': 'X30',
    '荳蔻': 'X31',
    'Nutmeg': 'X31',
    '茯苓': 'X32',
    'Indian Buead Tuckahoe': 'X32',
    '桂枝': 'X33',
    'Cassiabarktree Twig': 'X33',
    '懷菊花': 'X34',
    'Florists Dendranthema': 'X34',
    '白參': 'X35',
    'Ginseng Root': 'X35',
    '北黃耆': 'X36',
    'Mongolian Milkvetch Root': 'X36',
    '知母': 'X37',
    'Common Anemarrhena': 'X37',
    '生地黃': 'X38',
    'Radix Rehmanniae Recens': 'X38',
    '骨碎補': 'X39',
    'Fortune\'s Drynaria Rhizome': 'X39',
    '薏仁': 'X40',
    'Ma-yuen Jobstears Seed': 'X40',
    '桑寄生': 'X41',
    'Chinese Taxillus Herb': 'X41',
  };

  String convertToTitleCase(String text) {
    if (text == null) {
      return null;
    }
    if (text.length <= 1) {
      return text.toUpperCase();
    }
    final List<String> words = text.split(' ');
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);
        return '$firstLetter$remainingLetters';
      }
      return '';
    });
    return capitalizedWords.join(' ');
  }

  // function
  String whichfolder(String args) {
    // choose which folder in 'asset' to use
    String temp;
    if (map1.containsKey(args))
      temp = map1[args];
    else
      temp = "X";
    return temp;
  }

  String allinfo(String args, String folder) {
    // all info needed in this page
    String temp;
    // if key exists
    if (map1.containsKey(args)) {
      // English
      if (args.contains(RegExp(r'[A-Za-z]'))) {
        if (folder == 'X1') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X1', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦，寒。歸肺、胃、膽、大腸經。\n[功效]:\n清熱燥濕，瀉火解毒，涼血止血，除熱安胎。本品又分枯芩，即生長年久的宿根，善清肺火；條芩為生長年少的子根，善清大腸之火，瀉下焦濕熱。";
        } else if (folder == 'X2') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X2', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘，微溫，歸肝、腎經。\n[功效]:\n補血滋陰，益精填髓。";
        } else if (folder == 'X3') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X3', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n味甘，歸脾、肺經。\n[功效]:\n補中益氣，生津，健脾益肺。";
        } else if (folder == 'X4') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X4', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘，平。歸心、肺、脾、胃經。\n[功效]:\n益氣補中，清熱解毒，祛痰止咳，緩急止痛，調和藥性。";
        } else if (folder == 'X5') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X5', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦、甘、酸，平。歸肝、腎經。\n[功效]:\n活血通經，補肝腎，強筋骨，利水通淋，引火（血）下行。";
        } else if (folder == 'X6') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X6', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘、微苦，微寒。歸心、肺、胃經。\n[功效]:\n養陰潤肺、益胃生津、清心除煩。";
        } else if (folder == 'X7') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X7', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦、甘，溫。歸脾、胃經。\n[功效]:\n補氣健脾，燥濕利水，止汗，安胎。";
        } else if (folder == 'X8') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X8', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n味辛微苦，歸肝肺經。\n[功效]:\n清熱涼血，消腫利尿，有袪痰、止咳、活血通絡。";
        } else if (folder == 'X9') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X9', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘、寒。歸肺經。\n[功效]:\n瀉肺平喘，利水消腫。";
        } else if (folder == 'X10') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X10', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦、辛，平。歸肺經。\n[功效]:\n宣肺化痰，利咽，排膿。";
        } else if (folder == 'X11') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X11', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘、酸，微溫。歸肝、腎經。\n[功效]:\n補益肝腎，收斂固澀。";
        } else if (folder == 'X12') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X12', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n製首烏甘、澀，微溫；歸肝、腎經。\n[功效]:\n製首烏補益精血，固腎烏須；生首烏截瘧解毒，潤腸通便。";
        } else if (folder == 'X13') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X13', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦，微寒。歸肝經。\n[功效]:\n清熱涼血，散瘀止痛。";
        } else if (folder == 'X14') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X14', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛、甘，熱。歸脾、腎、心、肝經。\n[功效]:\n補火助陽，散寒止痛，溫經通脈。";
        } else if (folder == 'X15') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X15', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\nNo information.\n[功效]:\n補血和血，調經止痛，潤燥滑腸。治月經不調，經閉腹痛，症瘕結聚，崩漏；血虛頭痛，眩暈，痿痹；腸燥便難，赤痢後重；癰疽瘡竊，跌扑損傷。";
        } else if (folder == 'X16') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X16', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛，溫。歸肝、膽、心包經。\n[功效]:\n活血行氣，祛風止痛。";
        } else if (folder == 'X17') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X17', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛，溫。歸心、肝經。\n[功效]:\n活血通經，祛瘀止痛。";
        } else if (folder == 'X18') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X18', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛、苦、酸，微寒。入脾、胃經。\n[功效]:\n破氣消積，化痰散痞。";
        } else if (folder == 'X19') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X19', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘、溫，能健脾益胃。\n[功效]:\n可能具有治療阿茲海默症的潛力。";
        } else if (folder == 'X20') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X20', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛，溫。有小毒。歸肺、腎、心經。\n[功效]:\n祛風散寒，通竅，止痛，溫肺化飲。";
        } else if (folder == 'X21') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X21', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦，微寒。歸肺、心、膽經。\n[功效]:\n清熱解毒，消癰散結，疏散風熱。";
        } else if (folder == 'X22') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X22', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘，平。歸脾、肺、腎經。\n[功效]:\n益氣養陰，補脾肺腎，固精止帶。";
        } else if (folder == 'X23') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X23', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛、微苦，溫。歸肺經。\n[功效]:\n潤肺止咳化痰。";
        } else if (folder == 'X24') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X24', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦、澀，溫。歸脾、肝經。\n[功效]:\n溫經止血，溫中止痛。";
        } else if (folder == 'X25') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X25', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛、甘，熱。有毒。歸心、腎、脾經。\n[功效]:\n回陽救逆，助陽補火，散寒止痛。";
        } else if (folder == 'X26') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X26', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦、甘，平。有小毒。歸心、肝、大腸經。\n[功效]:\n活血祛瘀，潤腸通便。";
        } else if (folder == 'X27') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X27', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛、甘、苦，溫。歸肺經。\n[功效]:\n潤肺化痰止咳。";
        } else if (folder == 'X28') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X28', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛，溫。歸肺、脾、腎、膀胱經。\n[功效]:\n行氣止痛，溫腎散寒。";
        } else if (folder == 'X29') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X29', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\nNo information\n[功效]:\n清熱藥；涼血藥。";
        } else if (folder == 'X30') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X30', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\nNo information\n[功效]:\n提高机体免疫功能，增强机体适应调节能力。";
        } else if (folder == 'X31') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X31', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛，溫。歸脾、胃、大腸經。\n[功效]:\n澀腸止瀉，溫中行氣。";
        } else if (folder == 'X32') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X32', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘、淡，平。歸心、脾、腎經。\n[功效]:\n利水滲濕，健脾安神。";
        } else if (folder == 'X33') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X33', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n辛、甘，溫。歸心、肺、膀胱經。\n[功效]:\n發汗解肌，溫通經脈，助陽化氣。";
        } else if (folder == 'X34') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X34', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\nNo information\n[功效]:\n散風清熱、清肝明目、消炎解毒。";
        } else if (folder == 'X35') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X35', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\nNo information\n[功效]:\n補血、活血。";
        } else if (folder == 'X36') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X36', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘，微溫。歸脾、肺經。\n[功效]:\n補氣升陽，益衛固表，利水消腫，托瘡生肌。";
        } else if (folder == 'X37') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X37', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\苦、甘，寒。歸肺、胃、腎經。\n[功效]:\n清熱瀉火，滋陰潤燥。";
        } else if (folder == 'X38') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X38', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n甘、苦，寒。歸心、肝、肺經。\n[功效]:\n清熱涼血，養陰生津。";
        } else if (folder == 'X39') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X39', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦，溫。歸肝、腎經。\n[功效]:\n活血續傷，補腎強骨。";
        } else if (folder == 'X40') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X40', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\nNo information\n[功效]:\n減肥、消水腫。";
        } else if (folder == 'X41') {
          String key =
              map1.keys.firstWhere((k) => map1[k] == 'X41', orElse: () => null);
          temp =
              "[藥名]: $key\n[英文]: $args\n[性味歸經]:\n苦、甘，平。歸肝、腎經。\n[功效]:\n祛風濕，益肝腎，強筋骨，安胎。";
        }
      }
      // Chinese
      else {
        if (folder == 'X1') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X1', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦，寒。歸肺、胃、膽、大腸經。\n[功效]:\n清熱燥濕，瀉火解毒，涼血止血，除熱安胎。本品又分枯芩，即生長年久的宿根，善清肺火；條芩為生長年少的子根，善清大腸之火，瀉下焦濕熱。";
        } else if (folder == 'X2') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X2', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘，微溫，歸肝、腎經。\n[功效]:\n補血滋陰，益精填髓。";
        } else if (folder == 'X3') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X3', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n味甘，歸脾、肺經。\n[功效]:\n補中益氣，生津，健脾益肺。";
        } else if (folder == 'X4') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X4', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘，平。歸心、肺、脾、胃經。\n[功效]:\n益氣補中，清熱解毒，祛痰止咳，緩急止痛，調和藥性。";
        } else if (folder == 'X5') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X5', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦、甘、酸，平。歸肝、腎經。\n[功效]:\n活血通經，補肝腎，強筋骨，利水通淋，引火（血）下行。";
        } else if (folder == 'X6') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X6', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘、微苦，微寒。歸心、肺、胃經。\n[功效]:\n養陰潤肺、益胃生津、清心除煩。";
        } else if (folder == 'X7') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X7', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦、甘，溫。歸脾、胃經。\n[功效]:\n補氣健脾，燥濕利水，止汗，安胎。";
        } else if (folder == 'X8') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X8', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n味辛微苦，歸肝肺經。\n[功效]:\n清熱涼血，消腫利尿，有袪痰、止咳、活血通絡。";
        } else if (folder == 'X9') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X9', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘、寒。歸肺經。\n[功效]:\n瀉肺平喘，利水消腫。";
        } else if (folder == 'X10') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X10', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦、辛，平。歸肺經。\n[功效]:\n宣肺化痰，利咽，排膿。";
        } else if (folder == 'X11') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X11', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘、酸，微溫。歸肝、腎經。\n[功效]:\n補益肝腎，收斂固澀。";
        } else if (folder == 'X12') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X12', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n製首烏甘、澀，微溫；歸肝、腎經。\n[功效]:\n製首烏補益精血，固腎烏須；生首烏截瘧解毒，潤腸通便。";
        } else if (folder == 'X13') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X13', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦，微寒。歸肝經。\n[功效]:\n清熱涼血，散瘀止痛。";
        } else if (folder == 'X14') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X14', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛、甘，熱。歸脾、腎、心、肝經。\n[功效]:\n補火助陽，散寒止痛，溫經通脈。";
        } else if (folder == 'X15') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X15', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\nNo information.\n[功效]:\n補血和血，調經止痛，潤燥滑腸。治月經不調，經閉腹痛，症瘕結聚，崩漏；血虛頭痛，眩暈，痿痹；腸燥便難，赤痢後重；癰疽瘡竊，跌扑損傷。";
        } else if (folder == 'X16') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X16', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛，溫。歸肝、膽、心包經。\n[功效]:\n活血行氣，祛風止痛。";
        } else if (folder == 'X17') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X17', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛，溫。歸心、肝經。\n[功效]:\n活血通經，祛瘀止痛。";
        } else if (folder == 'X18') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X18', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛、苦、酸，微寒。入脾、胃經。\n[功效]:\n破氣消積，化痰散痞。";
        } else if (folder == 'X19') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X19', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘、溫，能健脾益胃。\n[功效]:\n可能具有治療阿茲海默症的潛力。";
        } else if (folder == 'X20') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X20', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛，溫。有小毒。歸肺、腎、心經。\n[功效]:\n祛風散寒，通竅，止痛，溫肺化飲。";
        } else if (folder == 'X21') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X21', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦，微寒。歸肺、心、膽經。\n[功效]:\n清熱解毒，消癰散結，疏散風熱。";
        } else if (folder == 'X22') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X22', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘，平。歸脾、肺、腎經。\n[功效]:\n益氣養陰，補脾肺腎，固精止帶。";
        } else if (folder == 'X23') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X23', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛、微苦，溫。歸肺經。\n[功效]:\n潤肺止咳化痰。";
        } else if (folder == 'X24') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X24', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦、澀，溫。歸脾、肝經。\n[功效]:\n溫經止血，溫中止痛。";
        } else if (folder == 'X25') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X25', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛、甘，熱。有毒。歸心、腎、脾經。\n[功效]:\n回陽救逆，助陽補火，散寒止痛。";
        } else if (folder == 'X26') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X26', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦、甘，平。有小毒。歸心、肝、大腸經。\n[功效]:\n活血祛瘀，潤腸通便。";
        } else if (folder == 'X27') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X27', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛、甘、苦，溫。歸肺經。\n[功效]:\n潤肺化痰止咳。";
        } else if (folder == 'X28') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X28', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛，溫。歸肺、脾、腎、膀胱經。\n[功效]:\n行氣止痛，溫腎散寒。";
        } else if (folder == 'X29') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X29', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\nNo information\n[功效]:\n清熱藥；涼血藥。";
        } else if (folder == 'X30') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X30', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\nNo information\n[功效]:\n提高机体免疫功能，增强机体适应调节能力。";
        } else if (folder == 'X31') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X31', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛，溫。歸脾、胃、大腸經。\n[功效]:\n澀腸止瀉，溫中行氣。";
        } else if (folder == 'X32') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X32', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘、淡，平。歸心、脾、腎經。\n[功效]:\n利水滲濕，健脾安神。";
        } else if (folder == 'X33') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X33', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n辛、甘，溫。歸心、肺、膀胱經。\n[功效]:\n發汗解肌，溫通經脈，助陽化氣。";
        } else if (folder == 'X34') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X34', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\nNo information\n[功效]:\n散風清熱、清肝明目、消炎解毒。";
        } else if (folder == 'X35') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X35', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\nNo information\n[功效]:\n補血、活血。";
        } else if (folder == 'X36') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X36', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘，微溫。歸脾、肺經。\n[功效]:\n補氣升陽，益衛固表，利水消腫，托瘡生肌。";
        } else if (folder == 'X37') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X37', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\苦、甘，寒。歸肺、胃、腎經。\n[功效]:\n清熱瀉火，滋陰潤燥。";
        } else if (folder == 'X38') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X38', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n甘、苦，寒。歸心、肝、肺經。\n[功效]:\n清熱涼血，養陰生津。";
        } else if (folder == 'X39') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X39', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦，溫。歸肝、腎經。\n[功效]:\n活血續傷，補腎強骨。";
        } else if (folder == 'X40') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X40', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\nNo information\n[功效]:\n減肥、消水腫。";
        } else if (folder == 'X41') {
          String key =
              map1.keys.lastWhere((k) => map1[k] == 'X41', orElse: () => null);
          temp =
              "[藥名]: $args\n[英文]: $key\n[性味歸經]:\n苦、甘，平。歸肝、腎經。\n[功效]:\n祛風濕，益肝腎，強筋骨，安胎。";
        }
      }
    } else
      temp = "No information";

    return temp;
  }

  // Widget to put image
  Widget pickImage(bool status, String path, String number) {
    if (status) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            height: 180.0,
            width: 180.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                    image: AssetImage("asset/$path/$number.jpg"),
                    fit: BoxFit.fill)),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            height: 180.0,
            width: 180.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                    image: AssetImage("asset/no-camera.png"),
                    fit: BoxFit.fill)),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var temp = convertToTitleCase(widget.data);
    folder = whichfolder(temp);
    text = allinfo(temp, folder);
    if (folder == 'X')
      stat = false;
    else
      stat = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          // app bar
          PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Color(0xFE2B3F87),
              title: Text(
                widget.data,
                style: TextStyle(fontFamily: "Abyssinica"),
              ),
              centerTitle: true,
              elevation: 0,
            ),
          ),

          // image
          Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // first box
                pickImage(stat, folder, '1'),
                // second box
                pickImage(stat, folder, '2'),
              ],
            ),
          ),

          // Info
          Container(
            height: MediaQuery.of(context).size.height - 70 - 200 - 20,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(20.0),
              height: (MediaQuery.of(context).size.height - 60 - 180 - 20) - 40,
              width: (MediaQuery.of(context).size.width) - 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Text(
                text,
                style: TextStyle(fontSize: 18.0, fontFamily: 'abyssinica'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
