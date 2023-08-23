part of 'present_widget.dart';

class PresentController extends ChangeNotifier {
  bool _isShowingPresent = false;
  DrawerStatus _drawerStatus = DrawerStatus.hide;
  Widget? _content;
  Function()? _onDismissPreventedCallback;
  late bool _dismissible;

  PresentController({bool dismissible = true}) {
    _dismissible = dismissible;
  }

  set isShowingPresent(bool newValue) {
    _isShowingPresent = newValue;
    notifyListeners();
  }

  bool get isShowingPresent => _isShowingPresent;

  set dismissible(bool newValue) {
    _dismissible = newValue;
    notifyListeners();
  }

  bool get dismissible => _dismissible;

  set drawerStatus(DrawerStatus newValue) {
    _drawerStatus = newValue;
    notifyListeners();
  }

  DrawerStatus get drawerStatus => _drawerStatus;

  void showPresent({required Widget content}) {
    _content = content;
    //if (_content == null) return;
    isShowingPresent = true;
  }

  void hidePresent() {
    _content = null;
    isShowingPresent = false;
  }

  void showLeftDrawer() {
    drawerStatus = DrawerStatus.left;
  }

  void showRightDrawer() {
    drawerStatus = DrawerStatus.right;
  }

  void hideDrawer() {
    drawerStatus = DrawerStatus.hide;
  }

  void onDismissPrevented(Function() callback) {
    _onDismissPreventedCallback = callback;
  }
}
