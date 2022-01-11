class WaterBillCalculation {
  double watercharges;
  double sanitarycharges;
  double borecharges;
  double metercharges;
  corecalci(double consump, String maincat) {
    if (maincat == 'Domestic') {
      borecharges = 100;
      if (consump <= 8000) {
        watercharges = 7 * consump / 1000;
        sanitarycharges = -14 + (watercharges * 0.25);
      } else if (consump > 8000 && consump <= 25000) {
        watercharges = 7 * 8 + 11 * (consump - 8000) / 1000;
        sanitarycharges = (watercharges * 0.25);
      } else if (consump > 25000 && consump <= 50000) {
        watercharges = 7 * 8 + 11 * 25 + 26 * (consump - 33000) / 1000;
        sanitarycharges = (watercharges * 0.25);
      } else {
        watercharges =
            7 * 8 + 11 * 25 + 26 * 50 + 45 * (consump - 83000) / 1000;
        sanitarycharges = (consump * 0.25);
      }
    } else if (maincat == 'Domestic (Apartements)') {
      watercharges = 22 * consump / 1000;
      sanitarycharges = 100 + 0.25 * watercharges;
      borecharges = 100;
    } else if (maincat == 'Non-Domestic') {
      sanitarycharges = 0.25 * watercharges;
      borecharges = 500;
      if (consump <= 10000) {
        watercharges = 50 * consump / 1000;
      } else if (consump > 10000 && consump <= 25000) {
        watercharges = 50 * 10 + 57 * (consump - 10000) / 1000;
      } else if (consump > 25000 && consump <= 50000) {
        watercharges = 50 * 10 + 57 * 25 + 65 * (consump - 35000) / 1000;
      } else if (consump > 50000 && consump <= 75000) {
        watercharges =
            50 * 10 + 57 * 25 + 65 * 35 + 76 * (consump - 85000) / 1000;
      } else {
        watercharges =
            50 * 10 + 57 * 25 + 65 * 35 + 76 * 75 + 87 * (consump - 160) / 1000;
      }
    } else if (maincat == 'Industries') {
      watercharges = 90 * consump / 1000;
      sanitarycharges = 0.25 * watercharges;
      borecharges = 500;
    } else if (maincat == 'Swimming Pools') {
      watercharges = 90 * consump / 1000;
      sanitarycharges = 0.25 * watercharges;
      borecharges = 500;
    } else {
      return {
        'sanitarycharges': 0,
        'borecharges': 0,
        'watercharges': 0,
        'maincat': 'Please eneter a valid category',
        'consump': 0,
      };
    }
    return {
      'sanitarycharges': sanitarycharges.roundToDouble(),
      'borecharges': borecharges.roundToDouble(),
      'watercharges': watercharges.roundToDouble(),
      'maincat': maincat,
      'consump': consump.roundToDouble(),
      'total':
          (sanitarycharges + borecharges + watercharges + 50).roundToDouble(),
    };
  }
}
