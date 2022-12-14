import 'package:flutter/material.dart';
import 'package:refeicoes_app/models/category.dart';

import '../models/meal.dart';

const dummyCategories = [
  Category(
    id: 'c1',
    title: 'Italiano',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Rápido & Fácil',
    color: Colors.purpleAccent,
  ),
  Category(
    id: 'c3',
    title: 'Hamburgers',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'Alemã',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Leve & Saudável',
    color: Colors.green,
  ),
  Category(
    id: 'c6',
    title: 'Exótica',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c7',
    title: 'Café da Manhã',
    color: Colors.teal,
  ),
  Category(
    id: 'c8',
    title: 'Asiática',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c9',
    title: 'Francesa',
    color: Colors.red,
  ),
  Category(
    id: 'c10',
    title: 'Verão',
    color: Colors.pink,
  )
];

const dummyMeals = [
  Meal(
    id: 'm1',
    categories: ['c1', 'c2'],
    title: 'Espaguete com molho de tomate',
    cost: Cost.cheap,
    complexity: Complexity.simple,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 20,
    ingredients: [
      '4 Tomates',
      '1 Colher de sopa de azeite',
      '1 Cebola',
      '250g Espaguete',
      'Especiarias',
      'Queijo (opcional)'
    ],
    steps: [
      'Corte os tomates e a cebola em pequenos pedaços.',
      'Ferva um pouco de água - adicione sal quando ele ferver.',
      'Coloque o espaguete na água fervente - eles devem ser feitos em cerca de 10 a 12 minutos.',
      'Enquanto isso, aqueça um pouco de azeite e adicione a cebola cortada.',
      'Após 2 minutos, adicione os pedaços de tomate, sal, pimenta e suas outras especiarias.',
      'O molho será feito assim que o espaguete for.',
      'Sinta -se à vontade para adicionar um pouco de queijo em cima do prato acabado.'
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm2',
    categories: ['c2'],
    title: 'Brinde ao Havaí',
    cost: Cost.cheap,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    duration: 10,
    ingredients: [
      '1 fatia pão branco',
      '1 Fatia presunto',
      '1 Corte o abacaxi',
      '1-2 fatias de queijo',
      'Manteiga'
    ],
    steps: [
      'Manteiga um lado do pão branco',
      'Camada presunto, o abacaxi e o queijo no pão branco',
      'Asse a torrada por cerca de 10 minutos no forno a 200 ° C'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm3',
    categories: ['c2', 'c3'],
    title: 'Hamburger clássico',
    cost: Cost.fair,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    ingredients: [
      '300g carne de gado',
      '1 tomate',
      '1 pepino',
      '1 cebola',
      'Ketchup',
      '2 pães de hambúrguer'
    ],
    steps: [
      'Formulário 2 hambúrgueres',
      'Frite os hambúrgueres para c.4 minutos de cada lado ',
      'Frite rapidamente os pães para c.1 minuto de cada lado ',
      'Bruch Buns with ketchup',
      'Sirva hambúrguer com tomate, pepino e cebola'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm4',
    categories: ['c4'],
    title: 'Wiener Schnitzel',
    cost: Cost.expensive,
    complexity: Complexity.medium,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    duration: 60,
    ingredients: [
      '8 corte de vitela',
      '4 ovos',
      'Migalhas de pão 200g',
      '100g de farinha',
      'Manteiga de 300 ml',
      '100g de óleo vegetal',
      'Sal',
      'Fatias de limão'
    ],
    steps: [
      'Tenha a vitela para cerca de 2 a 4 mm e sal de ambos os lados.',
      'Em um prato plano, mexa os ovos brevemente com um garfo.',
      'Cubra levemente as costeletas em farinha e mergulhe no ovo e, finalmente, cubra em farinha de rosca.',
      'Aqueça a manteiga e o óleo em uma panela grande (deixe a gordura ficar muito quente) e frite os schnitzels até dourar em ambos os lados.',
      'Certifique -se de jogar a panela regularmente para que os schnitzels estejam cercados por óleo e o tiro ‘fofa’.',
      'Remova e escorra no papel da cozinha.Frite a salsa no óleo restante e escorra.',
      'Coloque os schnitzels em prato inativo e sirva decorada com salsa e fatias de limão.'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm5',
    categories: ['c2', 'c5', 'c10'],
    title: 'Salada com salmão defumado',
    cost: Cost.expensive,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    duration: 15,
    ingredients: [
      'Rúcula',
      'Alface-de-cordeiro',
      'Salsinha',
      'funcho',
      'Salmão fumado 200g',
      'Mostarda',
      'Vinagre balsâmico',
      'Azeite',
      'Sal e pimenta'
    ],
    steps: [
      'Lavar e cortar salada e ervas',
      'Dice the Salmon',
      'Processar mostarda, vinagre e azeite em um dessário',
      'Prepare a salada',
      'Adicione cubos de salmão e molho'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm6',
    categories: ['c6', 'c10'],
    title: 'Deliciosa mousse de laranja',
    cost: Cost.cheap,
    complexity: Complexity.difficult,
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 240,
    ingredients: [
      '4 folhas de gelatina',
      '150 ml de suco de laranja',
      '80g açúcar',
      '300g iogurte',
      '200g creme',
      'Casca de laranja',
    ],
    steps: [
      'Dissolver gelatina em maconha',
      'Adicione suco de laranja e açúcar',
      'Retire a panela do fogão',
      'Adicione 2 colheres de sopa de iogurte ',
      'Mexa gelatina sob o iogurte restante',
      'Esfriar tudo na geladeira',
      'Chicote o creme e levante -o sob a massa laranja da matriz',
      'Esfrie novamente por pelo menos 4 horas',
      'Sirva com casca de laranja',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm7',
    categories: ['c7'],
    title: 'Panquecas',
    cost: Cost.cheap,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    duration: 20,
    ingredients: [
      '1 1/2 xícaras de farinha para todos os fins',
      '3 1/2 colheres de chá de fermento em pó',
      '1 colher de chá de sal',
      '1 colher de sopa de açúcar branco',
      '1 1/4 xícaras de leite',
      '1 ovo',
      '3 colheres de sopa de manteiga, derretido',
    ],
    steps: [
      'Em uma tigela grande, peneire a farinha, o fermento, o sal e o açúcar.',
      'Faça um poço no centro e despeje o leite, o ovo e a manteiga derretida;Misture até ficar homogêneo. ',
      'Aqueça uma chapa levemente oleada ou frigideira em fogo médio alto.',
      'Despeje ou coloque a massa na chapa, usando aproximadamente 1/4 de xícara para cada panqueca.Marrom em ambos os lados e servir quente.'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm8',
    categories: ['c8'],
    title: 'Curry de frango indiano cremoso',
    cost: Cost.fair,
    complexity: Complexity.medium,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    duration: 35,
    ingredients: [
      '4 peitos de frango',
      '1 cebola',
      '2 dentes de alho',
      '1 pedaço de gengibre',
      '4 colheres de sopa de amêndoas',
      '1 colher de chá de pimenta caiena',
      '500ml de leite de coco',
    ],
    steps: [
      'Flice e frite o peito de frango',
      'Processe cebola, alho e gengibre em pasta e refogue tudo',
      'Adicione especiarias e frite',
      'Adicione o peito de frango + 250 ml de água e cozinhe tudo por 10 minutos',
      'Adicionar leite de coco',
      'Sirva com arroz'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm9',
    categories: ['c9'],
    title: 'Suflê de chocolate',
    cost: Cost.cheap,
    complexity: Complexity.difficult,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    duration: 45,
    ingredients: [
      '1 colher de chá de manteiga derretida',
      '2 colheres de sopa de açúcar branco',
      '2 onças 70% de chocolate escuro, quebrado em pedaços',
      '1 colher de sopa de manteiga',
      '1 colher de sopa de farinha para todos os fins',
      '4 1/3 colheres de sopa de leite frio',
      '1 sal de sal',
      '1 pitada pimenta caianne',
      '1 gema de ovo grande',
      '2 grandes claras de ovos',
      '1 creme de tártaro',
      '1 colher de sopa de açúcar branco',
    ],
    steps: [
      'Pré -aqueça o forno a 190 ° C. Faça uma assadeira com aros com papel manteiga. ',
      'Pincele o fundo e os lados de 2 ramekins levemente com 1 colher de chá de manteiga derretida; tampe o fundo e as laterais até a borda. ',
      'Adicione 1 colher de sopa de açúcar branco ao Ramekins. Gire o ramekins até o açúcar revestir todas as superfícies. ',
      'Coloque pedaços de chocolate em uma tigela de metal.',
      'Coloque a tigela sobre uma panela de cerca de 3 xícaras de água quente em fogo baixo.',
      'Derreta 1 colher de sopa de manteiga em uma frigideira em fogo médio. Polvilhe em farinha. Bata até que a farinha seja incorporada à manteiga e misture espessura. ',
      'Bata o leite frio até que a mistura fique lisa e espessa. Transfira a mistura para a tigela com chocolate derretido. ',
      'Adicione sal e pimenta de pimenta de Caiena. Misture bem. Adicione a gema de ovo e misture para combinar. ',
      'Deixe a tigela acima da água quente (não fervendo) para manter o chocolate quente enquanto você chicoteia as claras.',
      'Coloque 2 claras de ovos em uma tigela; Adicione creme de tártaro. Bata até que a mistura comece a engrossar e uma garoa do batedor permaneça na superfície cerca de 1 segundo antes de desaparecer na mistura. ',
      'Adicione 1/3 de açúcar e bata. Bata um pouco mais de açúcar cerca de 15 segundos.',
      'Misture o resto do açúcar. Continue mexendo até a mistura ficar tão espessa quanto o creme de barbear e segura picos suaves, 3 a 5 minutos. ',
      'Transfira um pouco menos da metade das claras de ovo para o chocolate.',
      'Misture até que as claras sejam completamente incorporadas ao chocolate.',
      'Adicione o resto das claras; Dobre delicadamente o chocolate com uma espátula, levantando do fundo e dobrando -se. ',
      'Pare de misturar depois que o ovo de branco desaparecer. Divida a mistura entre 2 ramekins preparados. Coloque Ramekins na assadeira preparada. ',
      'Asse no forno pré -aquecido até que as brigas sejam inchadas e subiram acima do topo das jantes, 12 a 15 minutos.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm10',
    categories: ['c2', 'c5', 'c10'],
    title: 'Salada de aspargos com tomate cereja',
    cost: Cost.expensive,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
    duration: 30,
    ingredients: [
      'Aspargos brancos e verdes',
      '30g Pinhões',
      '300g tomates cereja',
      'Salada',
      'Sal, pimenta e azeite'
    ],
    steps: [
      'Lave, descasque e corte os aspargos',
      'Cozinhe em água salgada',
      'Sal e pimenta o aspargo',
      'Assar os pinhões',
      'Metade os tomates',
      'Misture com aspargos, salada e molho',
      'Sirva com baguete'
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
];
