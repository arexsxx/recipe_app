class CardInfo {
  final String title;
  final String image;
  final String description;
  final String harga;
  final double rating;

  CardInfo({
    required this.title,
    required this.image,
    required this.description,
    required this.harga,
    required this.rating,
  });
}

List<CardInfo> cardData = [
  CardInfo(
    title: "Nasi goreng",
    image: "assets/images/nasi_goreng.jpeg",
    description: "Nasi goreng dengan ayam bakar lezat",
    harga: "Rp 12.000",
    rating: 4.9,
  ),
  CardInfo(
    title: "Geprek ndower",
    image: "assets/images/Ayam Geprek.jpeg",
    description: "ayam geprek dengan sambel matah",
    harga: "Rp 12.000",
    rating: 4.5,
  ),
  CardInfo(
    title: "Chiken wings",
    image: "assets/images/chiken_wings.jpeg",
    description: "koren chiken wings enak pokoknya",
    harga: "Rp 15.000",
    rating: 4.7,
  ),
  CardInfo(
    title: "Ayam suwir",
    image: "assets/images/ayam_suwir.jpeg",
    description: "ayam yang disuwir-suwir dan dikasih bumbu",
    harga: "RP 10.000",
    rating: 4.5,
  ),
  CardInfo(
    title: "Black noodle",
    image: "assets/images/mie_hitam.jpeg",
    description: "mie hitam yang dibuat dengan kringat sendiri",
    harga: "Rp. 17.000",
    rating: 4.5,
  ),
  CardInfo(
    title: "Bakso Solo",
    image: "assets/images/Bakso_solo.jpeg",
    description: "Bakso asli dari solo",
    harga: "Rp. 10.000",
    rating: 4.8,
  ),
];