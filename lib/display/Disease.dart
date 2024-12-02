// ignore_for_file: file_names

class Disease {
  final String name; // اسم المرض بالعربية
  final String englishName; // اسم المرض بالإنجليزية
  final String description; // وصف المرض
  final List<String> symptoms; // قائمة الأعراض المرتبطة بالمرض

  Disease({
    required this.name,
    required this.englishName,
    required this.description,
    required this.symptoms,
  });
}

final List<Disease> diseases = [
  Disease(
    name: "الميلانوما",
    englishName: "Melanoma",
    description:
        "الميلانوما هي نوع من سرطان الجلد يمكن أن ينتشر إلى أعضاء أخرى. يظهر عادةً كنمو جديد غير عادي أو كتغيير في شامة موجودة.",
    symptoms: [
      "تغيرات في الشامة الجلدية",
      "ألم في الجلد",
      "حكة في الجلد",
      "نزيف من الشامة",
      "تغير لون الشامة إلى اللون الداكن",
    ],
  ),
  Disease(
    name: "التقرن الحميد",
    englishName: "Benign Keratosis",
    description:
        "التقرن الحميد هو آفة جلدية غير سرطانية. يعتبر حالة غير ضارة بشكل عام ولكنه قد يسبب قلقًا تجميليًا.",
    symptoms: [
      "سماكة في الجلد",
      "نمو في الجلد",
      "حكة",
      "بقع قشرية",
    ],
  ),
  Disease(
    name: "سرطان الخلايا القاعدية",
    englishName: "Basal Cell Carcinoma",
    description:
        "سرطان الخلايا القاعدية هو نوع من سرطان الجلد يظهر عادة ككتلة شفافة قليلاً على الجلد، وينتج غالباً عن التعرض الطويل للأشعة فوق البنفسجية.",
    symptoms: [
      "منطقة مرتفعة وغير مؤلمة من الجلد",
      "أوعية دموية مرئية",
      "قرح لا تلتئم",
      "بقع متغيرة اللون على الجلد",
    ],
  ),
  Disease(
    name: "التقرن الشعاعي",
    englishName: "Actinic Keratosis",
    description:
        "التقرن الشعاعي هو رقعة خشنة ومتقشرة على الجلد تتطور من سنوات من التعرض للشمس، ويظهر غالبًا على الوجه، الشفاه، الأذنين، واليدين.",
    symptoms: [
      "بقعة خشنة أو جافة أو متقشرة على الجلد",
      "بقعة أو نتوء مسطح أو مرتفع قليلاً",
      "حكة أو حرقان في المنطقة المصابة",
    ],
  ),
  Disease(
    name: "الآفة الوعائية",
    englishName: "Vascular Lesion",
    description:
        "الآفات الوعائية هي اضطرابات جلدية شائعة غالبًا ما تُعرف بالوحمة، وقد تكون موجودة منذ الولادة.",
    symptoms: [
      "علامة حمراء أو وردية أو بنفسجية على الجلد",
      "تورم أو ملمس مرتفع",
      "أوعية دموية مرئية تحت الجلد",
    ],
  ),
  Disease(
    name: "الورم الليفي الجلدي",
    englishName: "Dermatofibroma",
    description:
        "الورم الليفي الجلدي هو عقدة ليفية حميدة تظهر غالبًا على جلد الساقين. يبدو وكأنه كتلة صلبة تحت الجلد.",
    symptoms: [
      "كتلة صلبة تحت الجلد",
      "لون بني محمر أو أرجواني",
      "ألم أو حكة",
      "ملمس صلب عند اللمس",
    ],
  ),
];