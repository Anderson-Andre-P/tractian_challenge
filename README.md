<h1 align="center">Tractian Challenge</h1>

<p align="center">
  <a href="https://github.com/Anderson-Andre-P/tractian_challenge">
    <img alt="Made by Anderson André" src="https://img.shields.io/badge/-Github-3D7BF7?style=for-the-badge&logo=Github&logoColor=white&link=https://github.com/Anderson-Andre-P" />
  </a>
  <a href="https://www.linkedin.com/in/anderson-andre-pereira/">
      <img alt="Anderson André" src="https://img.shields.io/badge/-Anderson%20André-3D7BF7?style=for-the-badge&logo=Linkedin&logoColor=white" />
   </a>
  <img alt="Repository size" src="https://img.shields.io/github/repo-size/Anderson-Andre-P/tractian_challenge?style=for-the-badge&label=Repo%20Size:&labelColor=3D7BF7&color=3D7BF7">
  </p>

  <p align="center">
    <img src="https://img.shields.io/badge/tractian_challenge-21.05.2024-3D7BF7?style=for-the-badge&labelColor=3D7BF7">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/Anderson-Andre-P/tractian_challenge?style=for-the-badge&label=last%20commit:&labelColor=3D7BF7&color=3D7BF7">
    <img alt="License" src="https://img.shields.io/badge/license-NONE-3D7BF7?style=for-the-badge&labelColor=3D7BF7&color=3D7BF7">
</p>

<p align="center">
  <a href="https://www.figma.com/file/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?type=design&node-id=0%3A1&mode=design&t=puUgGuBG9v8leaSQ-1">
    <img alt="Figma" src="https://img.shields.io/badge/-Design_no_Figma-3D7BF7?style=for-the-badge&logo=figma&logoColor=white&link=https://www.figma.com/file/ASMDdAUXSnRKAo3ch6vPAQ/VibraGuard?type=design&node-id=1%3A2&mode=design&t=18IICEUM5IEuoqDM-1" />
  </a>
</p>

Este projeto foi desenvolvido como parte do desafio para a vaga na Tractian. Ele consiste em um aplicativo Flutter que gerencia ativos e localizações, permitindo a pesquisa e aplicação de filtros específicos para exibir informações relevantes.

## :link: Demo

<details>

<summary>Clique em mim para ver uma imagem de demonstração do aplicativo</summary>

|           Splash            |          Home           |            Settings             |
| :-------------------------: | :---------------------: | :-----------------------------: |
| ![Splash](/demo/splash.png) | ![Home](/demo/home.png) | ![Settings](/demo/settings.png) |

|             All Assets              |             Assets Filter 01              |             Assets Filter 02              |
| :---------------------------------: | :---------------------------------------: | :---------------------------------------: |
| ![All Assets](/demo/assets-001.png) | ![Assets Filter 01](/demo/assets-002.png) | ![Assets Filter 02](/demo/assets-003.png) |

</details>

## Funcionalidades

- Listagem de Ativos e Localizações.
- Pesquisa por nome de Ativo ou Localização.
- Filtros:
  - Status Crítico
  - Tipo de Sensor de Energia
- Adições extras: opção de light e dark theme e a opção de mudar a língua do app.

## Tecnologias Utilizadas

- Flutter
- Get para gerenciamento de estado.
- DIO e HTTP para requisições de API.
- Shared Preferences para salvar as preferências do usuário

## Desafios e Soluções

### Filtros e Pesquisa

Um dos desafios foi garantir que a pesquisa e os filtros funcionassem corretamente em conjunto. A solução foi criar um método updateChips que atualiza os filtros sempre que há uma mudança no estado.

### Hierarquia de Assets e Locations

Outro desafio foi gerenciar a hierarquia de localizações, garantindo que sublocalizações sejam filtradas corretamente e adicionadas em uma tree. A função \_locationMatches foi ajustada para lidar com essa lógica.

### Considerações Finais

Este projeto foi uma excelente oportunidade para aplicar conhecimentos de Flutter e gerenciamento de estado com GetX. Agradeço pela oportunidade e estou à disposição para quaisquer dúvidas ou esclarecimentos.

## Contato

Se você tiver alguma dúvida ou sugestão sobre o projeto, não hesite em nos contatar. Você pode nos encontrar em [fornecer informações de contato, como endereço de e-mail ou link para um canal de comunicação]. Obrigado pelo seu interesse e apoio ao projeto!

- Contate-me através do meu perfil pessoal no LinkedIn.

  <a href="https://www.linkedin.com/in/anderson-andre-pereira/">
  <img alt="Anderson André" src="https://img.shields.io/badge/-Anderson%20André-3D7BF7?style=for-the-badge&logo=Linkedin&logoColor=white" />
  </a>

<a href="#top">Voltar ao topo</a>
