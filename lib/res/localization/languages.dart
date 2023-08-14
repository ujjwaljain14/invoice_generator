
import 'package:get/get.dart';

class Languages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US' : {
      'barcode_scan' : 'Scan The Barcode',
      'internet_exception' : 'No Internet Connection',
      'general_exception' : 'Something went wrong',
      'welcome' : 'Welcome',
      'home' :'Home',
      'customers' : "Customer's Data",
      'past_bills' : 'Past Bills',
      'gen_bill' : 'Generate Bill',
      'settings' : 'Settings',
      'language' : 'Language',
      'theme' : 'Theme',
      'scan' : 'Scan Items',
      'name' : 'Name',
      'p_num' : 'Phone Number',
      'email' : 'Email',
      'done' :'Done',
      'add' : 'Add More',
      'no_scanned' : 'No Item Scanned',
      'search' : 'Search',

    },
    'hi_IN':{
      'barcode_scan' : 'बारकोड को स्कैन करें',
      'internet_exception' : 'इंटरनेट कनेक्शन नहीं है',
      'general_exception' : 'कुछ गलत हो गया\nफिर से कोशिश करे',
      'welcome' : 'आपका स्वागत है',
      'home' : 'होम',
      'customers' : 'ग्राहक का डेटा',
      'past_bills' : 'पिछले बिल',
      'gen_bill' : 'नया बिल बनाओ',
      'settings' : 'समायोजन',
      'language' : 'भाषा',
      'theme' : 'प्रसंग रंग',
      'scan' : 'आइटम स्कैन करें',
      'name' : 'नाम',
      'p_num' : 'फ़ोन नंबर',
      'email' : 'ईमेल',
      'done' :'पूर्ण',
      'add' : 'और स्कैन करे',
      'no_scanned' : 'कोई आइटम स्कैन नहीं किया गया है',
      'search' : 'खोजे',
    }
  };

}