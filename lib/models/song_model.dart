/** created by Himashi Bogahawaththa **/
/** Eyepax IT Consulting (Pvt) Ltd **/
/** created on 1/17/2023 at 12:23 AM **/

class Song{
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
});

  static List<Song> songs = [
    Song(
        title: "Despacito",
        description: "Despacito",
        url: 'assets/audio/Despacito.mp3',
        coverUrl: 'assets/images/despacitoCover.jpg'
    ),
    Song(
        title: "Despacito",
        description: "Despacito",
        url: 'assets/audio/Despacito.mp3',
        coverUrl: 'assets/images/despacitoCover.jpg'
    ),
    Song(
        title: "Despacito",
        description: "Despacito",
        url: 'assets/audio/Despacito.mp3',
        coverUrl: 'assets/images/despacitoCover.jpg'
    ),
  ];
}