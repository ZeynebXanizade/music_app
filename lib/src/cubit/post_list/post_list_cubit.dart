import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  final Dio _dio;

  PostListCubit(this._dio) : super(PostListInitial());

  Future<void> fetchAlbumDetails() async {
    emit(PostListLoading());
    try {
      final albumResponse = await _dio.get('https://api.deezer.com/chart');

      if (albumResponse.statusCode == 200 && albumResponse.data != null) {
        final List<dynamic> albums = albumResponse.data['albums']['data'] ?? [];

        if (albums.isNotEmpty) {
          albums.shuffle();

          final String albumId = albums.first['id'].toString();

          await getPostList(albumId);
        } else {
          emit(PostListError(errorMessage: "No albums found."));
        }
      } else {
        emit(
          PostListError(
            errorMessage:
                "Failed to fetch albums. Status code: ${albumResponse.statusCode}",
          ),
        );
      }
    } catch (e) {
      emit(PostListError(errorMessage: "An error occurred: $e"));
    }
  }

  Future<void> getPostList(String albumId) async {
    try {
      final response = await _dio.get('https://api.deezer.com/album/$albumId');
      if (response.statusCode == 200 && response.data != null) {
        if (response.data.containsKey('error')) {
          emit(
            PostListError(
              errorMessage: "API Error: ${response.data['error']['message']}",
            ),
          );
          return;
        }

        final albumData = response.data;
        final List<dynamic> tracks = albumData['tracks']['data'] ?? [];

        if (tracks.isEmpty) {
          emit(PostListError(errorMessage: "No tracks found in this album."));
        } else {
          emit(
            PostListLoaded(
              isLoading: false,
              albumData: albumData,
              isPlaying: false,
              currentTrack: '',
              errorMessage: '',
            ),
          );
        }
      } else {
        emit(
          PostListError(
            errorMessage:
                "Failed to fetch album data. Status code: ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      emit(PostListError(errorMessage: "An error occurred: $e"));
    }
  }

  void playMusic(String url, String trackName) {
    final currentState = state;
    if (currentState is PostListLoaded) {
      emit(currentState.copyWith(isPlaying: true, currentTrack: trackName));
    }
  }
}
