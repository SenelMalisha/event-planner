import 'package:event_planner/models/song_model.dart';
import 'package:flutter/material.dart';

/** created by Himashi Bogahawaththa **/
/** Eyepax IT Consulting (Pvt) Ltd **/
/** created on 1/17/2023 at 1:36 AM **/

class Playlist{
  final String title;
  final List<Song> songs;
  final String imageUrl;

  Playlist({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<Playlist> playlists = [
    Playlist(
        title: "Despacito",
        songs: Song.songs,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/en/c/c8/Luis_Fonsi_Feat._Daddy_Yankee_-_Despacito_%28Official_Single_Cover%29.png'
    ),
    Playlist(
        title: "Despacito",
        songs: Song.songs,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/en/c/c8/Luis_Fonsi_Feat._Daddy_Yankee_-_Despacito_%28Official_Single_Cover%29.png'
    ),
    Playlist(
        title: "Despacito",
        songs: Song.songs,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/en/c/c8/Luis_Fonsi_Feat._Daddy_Yankee_-_Despacito_%28Official_Single_Cover%29.png'
    ),
  ];
}