import "package:universal_html/html.dart" as html;

enum BrowserType {
  chrome,
  edge,
  firefox,
  safari,
  opera,
  internetExplorer,
  unknown,
}


class HtmlHelper {
  static html.WindowBase? openURL(String url, {bool openInSameTab = false}) {return html.window.open(url, openInSameTab ? "_self" : "_blank");}
  
  static BrowserType getBrowserType() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();

  if (userAgent.contains('edg/')) return BrowserType.edge;
  if (userAgent.contains('chrome/') && !userAgent.contains('edg/')) return BrowserType.chrome;
  if (userAgent.contains('safari/') && !userAgent.contains('chrome/')) return BrowserType.safari;
  if (userAgent.contains('firefox/')) return BrowserType.firefox;
  if (userAgent.contains('opr/') || userAgent.contains('opera/')) return BrowserType.opera;
  if (userAgent.contains('msie') || userAgent.contains('trident/')) return BrowserType.internetExplorer;

  return BrowserType.unknown;
}
}
