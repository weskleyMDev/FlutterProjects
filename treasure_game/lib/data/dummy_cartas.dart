import '../models/cartas.dart';

final dummyCartas = [
  Cartas(
    id: 1,
    titulo: 'BÁU GRANDE',
    descricao: 'VOCÊ ENCONTROU UM BAÚ GRANDE E GANHOU 2 PONTOS!',
    pontos: 2,
    image: 'assets/images/big_chest.png',
  ),
  Cartas(
    id: 2,
    titulo: 'BÁU PEQUENO',
    descricao: 'VOCÊ ENCONTROU UM BAÚ PEQUENO E GANHOU 1 PONTO!',
    pontos: 1,
    image: 'assets/images/small_chest.png',
  ),
  Cartas(
    id: 3,
    titulo: 'BÔNUS',
    descricao: 'VOCÊ GANHOU 1 PONTO DE VIDA!',
    pontos: 1,
    image: 'assets/images/bonus.png',
  ),
  Cartas(
    id: 4,
    titulo: 'MINA NAVAL',
    descricao: 'VOCÊ ESBARROU EM UMA MINA E PERDEU 1 PONTO DE VIDA!',
    pontos: 1,
    image: 'assets/images/sea_mine.png',
  ),
  Cartas(
    id: 5,
    titulo: 'ÁGUA',
    descricao: 'OPS! NÃO HÁ NADA AQUI!',
    pontos: 0,
    image: 'assets/images/sea_water.png',
  ),
];
