import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'artc.dart';

class WebScraper {
  final String url =
      "https://www.moh.gov.sa/HealthAwareness/EducationalContent/Diseases/Dermatology/Pages/default.aspx";

  Future<List<Artc>> extractData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final html = parser.parse(response.body);
        final container =
            html.querySelector(".dfwp-column.dfwp-list")?.children;

        if (container == null) {
          throw Exception("العنصر المطلوب غير موجود في الصفحة.");
        }

        List<Artc> articles = [];

        for (var element in container) {
          final liElements = element.getElementsByTagName("li");

          for (var li in liElements) {
            final link = li.querySelector("a");
            if (link != null) {
              final linkText = link.text.trim();
              final linkHref = link.attributes['href'] ?? '';
              final fullLink = linkHref.startsWith('http')
                  ? linkHref
                  : "https://www.moh.gov.sa${linkHref.startsWith('/') ? linkHref : '/$linkHref'}";

              articles.add(Artc(disName: linkText, linkUrl: fullLink));
            }
          }
        }

        return articles;
      } else {
        throw Exception('فشل في جلب البيانات: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
