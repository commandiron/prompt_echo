import "package:universal_html/html.dart" as html;

class HtmlHelper {
  static html.WindowBase? openURL(String url, {bool openInSameTab = false}) {return html.window.open(url, openInSameTab ? "_self" : "_blank");}
}
