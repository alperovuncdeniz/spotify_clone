import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/song/song.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify_clone/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songsId);
  Future<bool> isFavoriteSong(String songsId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy("releaseDate", descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songsId = element.reference.id;
        songs.add(songModel.toEntitiy());
      }
      return Right(songs);
    } catch (e) {
      return const Left("An error accurred, Please try again.");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy("releaseDate", descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songsId = element.reference.id;
        songs.add(songModel.toEntitiy());
      }
      return Right(songs);
    } catch (e) {
      return const Left("An error accurred, Please try again.");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songsId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("Favorites")
          .where("songsId", isEqualTo: songsId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection("users")
            .doc(uid)
            .collection("Favorites")
            .add({
          "songsId": songsId,
          "addedDate": Timestamp.now(),
        });
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left("An error occured");
    }
  }

  @override
  Future<bool> isFavoriteSong(String songsId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("Favorites")
          .where("songsId", isEqualTo: songsId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs = [];
      String uid = user!.uid;

      QuerySnapshot favoritesSnapshot = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("Favorites")
          .get();

      for (var element in favoritesSnapshot.docs) {
        String songId = element["songsId"];
        var song =
            await firebaseFirestore.collection("songs").doc(songId).get();

        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songsId = songId;
        favoriteSongs.add(songModel.toEntitiy());
      }
      return Right(favoriteSongs);
    } catch (e) {
      return const Left("An error occured");
    }
  }
}
