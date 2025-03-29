part of 'post_list_cubit.dart';

abstract class PostListState {}

class PostListInitial extends PostListState {}

class PostListLoading extends PostListState {}

class PostListLoaded extends PostListState {
  final bool isLoading;
  final Map<String, dynamic> albumData;
  final bool isPlaying;
  final String currentTrack;
  final String errorMessage;

  PostListLoaded({
    required this.isLoading,
    required this.albumData,
    required this.isPlaying,
    required this.currentTrack,
    required this.errorMessage,
  });
  PostListLoaded copyWith({
    bool? isLoading,
    Map<String, dynamic>? albumData,
    bool? isPlaying,
    String? currentTrack,
    String? errorMessage,
  }) {
    return PostListLoaded(
      isLoading: isLoading ?? this.isLoading,
      albumData: albumData ?? this.albumData,
      isPlaying: isPlaying ?? this.isPlaying,
      currentTrack: currentTrack ?? this.currentTrack,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PostListError extends PostListState {
  final String errorMessage;

  PostListError({required this.errorMessage});
}
