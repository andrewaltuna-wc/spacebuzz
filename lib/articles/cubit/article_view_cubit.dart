import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'article_view_state.dart';

class ArticleViewCubit extends Cubit<ArticleViewState> {
  ArticleViewCubit() : super(const ArticleViewState());

  void toggleView(bool doGrid) {
    emit(state.copyWith(doGrid: doGrid));
  }

  void toggleVisibility() {
    emit(state.copyWith(isVisible: !state.isVisible));
  }
}
