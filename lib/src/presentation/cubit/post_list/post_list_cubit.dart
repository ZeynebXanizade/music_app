import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  final Dio _dio;

  PostListCubit(this._dio) : super(PostListInitial());

  Future<void> fetchSongsByCategory(String category) async {
    emit(PostListLoading());
    try {
      final response = await _dio.get('https://api.deezer.com/genre');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> genres = response.data['data'] ?? [];

        final genre = genres.firstWhere(
          (g) => g['name'].toString().toLowerCase() == category.toLowerCase(),
          orElse: () => null,
        );

        if (genre != null) {
          final genreId = genre['id'];

          final artistsResponse = await _dio.get(
            'https://api.deezer.com/genre/$genreId/artists',
          );

          if (artistsResponse.statusCode == 200 &&
              artistsResponse.data != null) {
            final List<dynamic> artists = artistsResponse.data['data'] ?? [];

            if (artists.isNotEmpty) {
              List<dynamic> allTracks = [];

              for (var artist in artists) {
                final artistId = artist['id'];

                final tracksResponse = await _dio.get(
                  'https://api.deezer.com/artist/$artistId/top?limit=5',
                );

                if (tracksResponse.statusCode == 200 &&
                    tracksResponse.data != null) {
                  final List<dynamic> tracks =
                      tracksResponse.data['data'] ?? [];

                  allTracks.addAll(tracks);
                }
              }

              if (allTracks.isEmpty) {
                emit(
                  PostListError(errorMessage: "Bu janra aid mahnı tapılmadı."),
                );
              } else {
                emit(
                  PostListLoaded(
                    isLoading: false,
                    albumData: {'tracks': allTracks},
                    isPlaying: false,
                    currentTrack: '',
                    errorMessage: '',
                    searchResults: [],
                  ),
                );
              }
            } else {
              emit(
                PostListError(errorMessage: "Bu janra aid artist tapılmadı."),
              );
            }
          } else {
            emit(PostListError(errorMessage: "Artistlər tapılmadı."));
          }
        } else {
          emit(PostListError(errorMessage: "Kateqoriya tapılmadı."));
        }
      } else {
        emit(PostListError(errorMessage: "Kateqoriyalar yüklənmədi."));
      }
    } catch (e) {
      emit(PostListError(errorMessage: "Xəta baş verdi: $e"));
    }
  }

  void fetchSongsBySearch(String query) async {
    try {
      emit(PostListLoading());

      final response = await _dio.get('https://api.deezer.com/search?q=$query');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> tracks = response.data['data'] ?? [];

        if (tracks.isNotEmpty) {
          emit(
            PostListLoaded(
              isLoading: false,
              albumData: {},
              isPlaying: false,
              currentTrack: '',
              errorMessage: '',
              searchResults: tracks,
            ),
          );
        } else {
          emit(PostListError(errorMessage: "Axtarış nəticəsi tapılmadı"));
        }
      } else {
        emit(PostListError(errorMessage: "Axtarış zamanı xəta baş verdi"));
      }
    } catch (e) {
      emit(PostListError(errorMessage: "Xəta baş verdi: ${e.toString()}"));
    }
  }
}
