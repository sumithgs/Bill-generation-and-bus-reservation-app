class CoreCalculation {
  double fixedcharges = 0.0;
  double energycharges = 0.0;

  coreCalcu(String m, String t, double s, double consump) {
    if (m == 'LOWT') {
      if (t == '1LT2A1') {
        if (s <= 1) {
          fixedcharges = 85;
        } else if (s > 1 && s <= 50) {
          fixedcharges = 85 + (s - 1) * 95;
        } else {
          fixedcharges = 85 + 50 * 95 + (s - 51) * 150;
        }
        if (consump <= 50) {
          energycharges = consump * 4.1;
        } else if (consump > 50 && consump <= 100) {
          energycharges = 50 * 4.1 + ((consump - 50) * 5.55);
        } else if (consump > 100 && consump <= 200) {
          energycharges = 50 * 4.1 + 50 * 5.55 + ((consump - 100) * 7.1);
        } else {
          energycharges =
              50 * 4.1 + 50 * 5.55 + 50 * 7.1 + ((consump - 150) * 8.15);
        }
      } else if (t == '1LT2A2') {
        if (s <= 1) {
          fixedcharges = 70;
        } else if (s > 1 && s <= 50) {
          fixedcharges = 70 + (s - 1) * 85;
        } else {
          fixedcharges = 70 + 50 * 85 + (s - 51) * 140;
        }
        if (consump <= 50) {
          energycharges = consump * 4.0;
        } else if (consump > 50 && consump <= 100) {
          energycharges = 50 * 4.0 + ((consump - 50) * 5.25);
        } else if (consump > 100 && consump <= 200) {
          energycharges = 50 * 4.0 + 50 * 5.25 + ((consump - 100) * 6.8);
        } else {
          energycharges =
              50 * 4.0 + 50 * 5.25 + 50 * 6.8 + ((consump - 150) * 7.65);
        }
      } else if (t == '1LT2B1') {
        if (s <= 50) {
          fixedcharges = 125 + 100 * s;
        } else {
          fixedcharges = 125 + 100 * 50 + (s - 51) * 155;
        }
        if (consump <= 200) {
          energycharges = consump * 7.3;
        } else {
          energycharges = 200 * 7.3 + ((consump - 200) * 8.55);
        }
      } else if (t == '1LT2B2') {
        if (s <= 50) {
          fixedcharges = 110 + 90 * s;
        } else {
          fixedcharges = 110 + 90 * 50 + (s - 51) * 145;
        }
        if (consump <= 200) {
          energycharges = consump * 6.75;
        } else {
          energycharges = 200 * 6.75 + ((consump - 200) * 8.0);
        }
      } else if (t == '1LT31') {
        if (s <= 50) {
          fixedcharges = 105 * s;
        } else {
          fixedcharges = 105 + (s - 50) * 205;
        }
        if (consump <= 50) {
          energycharges = consump * 8.35;
        } else {
          energycharges = 50 * 8.35 + ((consump - 200) * 9.35);
        }
      } else if (t == '1LT32') {
        if (s <= 50) {
          fixedcharges = 95 * s;
        } else {
          fixedcharges = 95 + (s - 50) * 195;
        }
        if (consump <= 50) {
          energycharges = consump * 7.85;
        } else {
          energycharges = 50 * 7.85 + ((consump - 200) * 8.85);
        }
      } else if (t == '1LT4B') {
        fixedcharges = 90 * s;
        energycharges = consump * 3.85;
      } else if (t == '1LT4C') {
        fixedcharges = 80 * s;
        energycharges = consump * 3.85;
      } else {
        return {
          'maincat': '_',
          'tariff': 'Please enter a valid Tariff code',
          'sancLoad': s,
          'consump': 0,
          'fixedcharges': 0,
          'energycharges': 0,
          'total': 0
        };
      }
      return {
        'maincat': m,
        'tariff': t,
        'sancLoad': s,
        'consump': consump.roundToDouble(),
        'fixedcharges': fixedcharges.roundToDouble(),
        'energycharges': energycharges.roundToDouble(),
        'total': (fixedcharges + energycharges + energycharges * 0.09)
            .roundToDouble(),
      };
    }
    return {
      'maincat': 'Please enter a Valid Main Category',
      'tariff': 'Please enter a Valid Tariff code',
      'sancLoad': 0,
      'consump': 0,
      'fixedcharges': 0,
      'energycharges': 0,
      'total': 0
    };
  }
}

class Calculation {
  final String _rrno;
  final double _consump;
  Calculation(this._rrno, this._consump);
  Map<String, Map<String, String>> map1 = {
    "EH67929": {
      'details': "Sumith G S 13,12th E Main Road Muthyalanagara, Bangalore-54",
      'tariff': '1LT2A1',
      'maincat': 'LOWT',
      'sancLoad': '4'
    },
    "EH67939": {
      'details':
          "Mary D'souza 22,14th E Main Road Muthyalanagara, Bangalore-54",
      'tariff': '1LT2B1',
      'maincat': 'LOWT',
      'sancLoad': '4'
    },
    "EH67959": {
      'details': "Mithun k 11,12th E Main Road Muthyalanagara, Bangalore-54",
      'tariff': '1LT31',
      'maincat': 'LOWT',
      'sancLoad': '4'
    },
  };
  double fixedcharges = 0.0;
  double energycharges = 0.0;
  String maincat = 'LOWT';
  String tariff = '1LT2A1';
  double sancLoad = 0.0;

  tryfind() {
    if (map1.containsKey(_rrno) == true) {
      maincat = map1[_rrno]['maincat'];
      tariff = map1[_rrno]['tariff'];
      sancLoad = double.parse(map1[_rrno]['sancLoad']);
    }
    var obj = CoreCalculation();
    var nums = obj.coreCalcu(maincat, tariff, sancLoad, _consump);
    if (map1.containsKey(_rrno) == true) {
      return {
        'rrno': _rrno,
        'consump': _consump,
        'details': map1[_rrno]['details'],
        'fixedcharges': nums['fixedcharges'],
        'energycharges': nums['energycharges'],
        'total': (nums['fixedcharges'] +
            nums['energycharges'] +
            nums['energycharges'] * 0.09),
        'tariff': nums['tariff'],
        'sancLoad': nums['sancLoad'],
      };
    } else {
      if (map1.containsKey(_rrno) == false) {
        return {
          'rrno': 'Entered RR No is not present in the data base',
          'consump': '_',
          'details': 'Could not find the details',
          'fixedcharges': 0,
          'energycharges': 0,
          'total': '0',
          'tariff': '_',
          'sancLoad': '_',
        };
      }
    }
  }
}
