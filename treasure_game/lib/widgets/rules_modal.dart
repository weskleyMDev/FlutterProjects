import 'package:flutter/material.dart';

class RulesModal extends StatelessWidget {
  const RulesModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 15.0,
        right: 15.0,
        bottom: 5.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: const SingleChildScrollView(
        child: Text(
          '''1. Cada jogador rola os dados para saber qual posição irá ocupar. A soma dos 2 dados corresponde a coluna e a letra corresponde a linha do tabuleiro. Só é permitido rolar mais de 1 vez no seu turno caso repita os valores.
          \n2. Leia o QR-Code correspondente ao local que você ocupou para revelar seu conteúdo.
          \n3. Caso ocupe o mesmo local já ocupado por outro jogador, você irá clicar no botão de combate e deverá rolar os dados, se você for o vencedor receberá 1 ponto, se for o perdedor, perderá 1 ponto, caso não tenha pontos irá perder 1 ponto de vida, se empatar nada acontece.
          \n4. Vence a partida quem for o primeiro a conquistar 10 pontos no total.
          \n5. O primeiro a perder todos os pontos de vida será derrotado e a partida é encerrada.
          \n6. Cartas:          
          \nBaú Grande = Ganha 2 pontos.\nBaú Pequeno = Ganha 1 ponto.\nBônus = Ganha 1 ponto de vida(limite máximo de 6 pontos. Caso receba uma carta bônus com o limite atingido, não será adicionado o ponto de vida).\nMina Naval = Perde 1 ponto de vida.\nÁgua = nada acontece.
          ''',
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
