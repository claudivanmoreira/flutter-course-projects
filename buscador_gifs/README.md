# Buscador de GIFs

Aplicação para estudo de Flutter

### Contexto

A aplicação deve consultar gifs para compartilhamento.

### Regras:

- A aplicação permite a listagem dos GIFs nos top trends ao iniciar
- A aplicação permite a consulta de GIFs por termo (Ex: dogs, gato, carro)
- A aplicação permite que na tela inicial ao segurar um GIF pressionado, seja exibido a opção de compartilhamento em outros Apps (Whatsapp, Instagram, Facebook, etc...)
- A aplicação permite abrir um GIF da listagem em uma nova tela com a opção de compartilhar

### Widgets Usados

- InheritedWidget (para configuração de variáveis de ambiente usadas pelo App)
- StatelessWidget
- StatefulWidget
- MaterialApp
- ThemeData
- Scaffold
- AppBar
- Image
- Column
- Padding
- TextField
- Expanded
- FutureBuilder
- Center
- CircularProgressIndicator
- Container
- Text
- GridView
- SliverGridDelegateWithFixedCrossAxisCount
- GestureDetector
- FadeInImage
- Icon
- Navigator
- MaterialPageRoute

### Plugins Usados

```
    share: ^0.6.5+4
    transparent_image: ^1.0.0
    http: ^0.12.2
```

# API

[Giphy API](https://developers.giphy.com)
Username: xacohew356@pashter.com
Pwd: xacohew356@pashter.com
Name: xacohew356

### Screenshot

![GIF Trends](https://github.com/claudivanmoreira/flutter-course-projects/blob/master/buscador_gifs/screenshot1.png?raw=true)
![Busca](https://github.com/claudivanmoreira/flutter-course-projects/blob/master/buscador_gifs/screenshot2.png?raw=true)
![Compartilhamento pela Home](https://github.com/claudivanmoreira/flutter-course-projects/blob/master/buscador_gifs/screenshot3.png?raw=true)
![Compartilhamento em nova Tela](https://github.com/claudivanmoreira/flutter-course-projects/blob/master/buscador_gifs/screenshot4.png?raw=true)