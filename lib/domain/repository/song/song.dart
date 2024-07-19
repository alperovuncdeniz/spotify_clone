import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songsId);
  Future<bool> isFavoriteSong(String songsId);
  Future<Either> getUserFavoriteSongs();
}
