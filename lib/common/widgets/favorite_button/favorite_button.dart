// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_clone/common/helper/is_dark_mode.dart';
import 'package:spotify_clone/core/config/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  const FavoriteButton({
    super.key,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                      songEntity.songsId,
                    );
              },
              icon: Icon(
                size: 25,
                songEntity.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                color: context.isDarkMode
                    ? AppColors.darkGrey
                    : const Color(0xffB4B4B4),
              ),
            );
          }
          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                      songEntity.songsId,
                    );
              },
              icon: Icon(
                size: 25,
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                color: context.isDarkMode
                    ? AppColors.darkGrey
                    : const Color(0xffB4B4B4),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
