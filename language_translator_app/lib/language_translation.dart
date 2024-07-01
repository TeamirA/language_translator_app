import 'dart:async';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = [
    'Amharic'
        'Arabic',
    'Basque',
    'Bengali',
    'Bulgarian',
    'English (UK)',
    'English (US)',
    'Catalan',
    'Cherokee',
    'Chinese (PRC)',
    'Chinese (Taiwan)',
    'Croatian',
    'Czech',
    'Danish',
    'Dutch',
    'Estonian',
    'Filipino',
    'Finnish',
    'French',
    'German',
    'Greek',
    'Gujarati',
    'Hebrew',
    'Hindi',
    'Hungarian',
    'Icelandic',
    'Indonesian',
    'Italian',
    'Japanese',
    'Kannada',
    'Korean',
    'Latvian',
    'Lithuanian',
    'Malay',
    'Malayalam',
    'Marathi',
    'Norwegian',
    'Polish',
    'Portuguese (Brazil)',
    'Portuguese (Portugal)',
    'Romanian',
    'Russian',
    'Serbian',
    'Slovak',
    'Slovenian',
    'Spanish',
    'Swahili',
    'Swedish',
    'Tamil',
    'Telugu',
    'Thai',
    'Turkish',
    'Ukrainian',
    'Urdu',
    'Vietnamese',
    'Welsh',
  ];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';
  TextEditingController languageController = TextEditingController();

  Future<void> translateText(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    try {
      var translation = await translator.translate(input, from: src, to: dest);
      setState(() {
        output = translation.text.toString();
      });
    } catch (e) {
      //show error message in snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error translating text. Please try again.'),
        duration: Duration(seconds: 5),
      ));
      throw Exception('Failed to translate the text: $e');
    }
  }

  Future<void> autoDetectAndTranslate(String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input,
        from: 'auto', to: getLanguageCode(destinationLanguage));
    setState(() {
      originLanguage = getLanguageCode(translation.sourceLanguage.toString());
      output = translation.text.toString();
    });
  }

  String getLanguageCode(String language) {
    switch (language) {
      case 'Amharic':
        return 'am';
      case 'Arabic':
        return 'ar';
      case 'Basque':
        return 'eu';
      case 'Bengali':
        return 'bn';
      case 'Bulgarian':
        return 'bg';
      case 'English (UK)':
        return 'en-GB';
      case 'English (US)':
        return 'en';
      case 'Catalan':
        return 'ca';
      case 'Cherokee':
        return 'chr';
      case 'Chinese (PRC)':
        return 'zh-CN';
      case 'Chinese (Taiwan)':
        return 'zh-TW';
      case 'Croatian':
        return 'hr';
      case 'Czech':
        return 'cs';
      case 'Danish':
        return 'da';
      case 'Dutch':
        return 'nl';
      case 'Estonian':
        return 'et';
      case 'Filipino':
        return 'fil';
      case 'Finnish':
        return 'fi';
      case 'French':
        return 'fr';
      case 'German':
        return 'de';
      case 'Greek':
        return 'el';
      case 'Gujarati':
        return 'gu';
      case 'Hebrew':
        return 'he';
      case 'Hindi':
        return 'hi';
      case 'Hungarian':
        return 'hu';
      case 'Icelandic':
        return 'is';
      case 'Indonesian':
        return 'id';
      case 'Italian':
        return 'it';
      case 'Japanese':
        return 'ja';
      case 'Kannada':
        return 'kn';
      case 'Korean':
        return 'ko';
      case 'Latvian':
        return 'lv';
      case 'Lithuanian':
        return 'lt';
      case 'Malay':
        return 'ms';
      case 'Malayalam':
        return 'ml';
      case 'Marathi':
        return 'mr';
      case 'Norwegian':
        return 'no';
      case 'Polish':
        return 'pl';
      case 'Portuguese (Brazil)':
        return 'pt-BR';
      case 'Portuguese (Portugal)':
        return 'pt-PT';
      case 'Romanian':
        return 'ro';
      case 'Russian':
        return 'ru';
      case 'Serbian':
        return 'sr';
      case 'Slovak':
        return 'sk';
      case 'Slovenian':
        return 'sl';
      case 'Spanish':
        return 'es';
      case 'Swahili':
        return 'sw';
      case 'Swedish':
        return 'sv';
      case 'Tamil':
        return 'ta';
      case 'Telugu':
        return 'te';
      case 'Thai':
        return 'th';
      case 'Turkish':
        return 'tr';
      case 'Ukrainian':
        return 'uk';
      case 'Urdu':
        return 'ur';
      case 'Vietnamese':
        return 'vi';
      case 'Welsh':
        return 'cy';
      default:
        return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: const Text('Language Translator'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.deepPurpleAccent,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: const Color.fromARGB(255, 139, 94, 243),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    focusColor: Colors.deepPurpleAccent,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: const Color.fromARGB(255, 139, 94, 243),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    autofocus: false,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Enter text to translate',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: languageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text to translat e';
                      }
                      return null;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    translateText(
                        getLanguageCode(originLanguage),
                        getLanguageCode(destinationLanguage),
                        languageController.text.toString());
                  },
                  child: const Text(
                    'Translate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SelectableText(
                "\n$output\n",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
