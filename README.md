# Painel Interativo da Bolsa de Valores
Este é um projeto desenvolvido em R utilizando o framework Shiny para criar uma aplicação web interativa para análise de dados de bolsa de valores. A aplicação permite visualizar os preços das ações ao longo do tempo, o volume de negociação diário, a correlação entre as ações e a volatilidade histórica das ações.

![image](https://github.com/LeviLucena/Bolsa_de_Valores/assets/34045910/eb85bf90-f647-4c14-926e-caebb5dd5cd9)

# Funcionalidades
- Preços das Ações: Visualização dos preços das ações selecionadas ao longo do tempo em um gráfico de linhas interativo.
- Volume de Negociação: Visualização do volume de negociação diário das ações selecionadas em um gráfico de barras interativo.
- Correlação entre as Ações: Visualização da matriz de correlação entre as ações selecionadas em um mapa de calor interativo.
- Volatilidade das Ações: Visualização da volatilidade histórica das ações selecionadas em um gráfico de linhas interativo.
- Relatório: Uma aba adicional que contém todos os gráficos das outras abas, permitindo uma visualização integrada dos dados, permitindo exportar e imprimir.

## Como Executar
Certifique-se de ter o ambiente do R instalado em seu sistema.

1. Instale as bibliotecas necessárias executando ```install.packages(c("shiny", "plotly", "dplyr"))``` no console do R.
2. Faça o download ou clone este repositório.
3. Navegue até o diretório do projeto.
4. Execute o arquivo ```app.R``` com o RStudio ou execute ```runApp("app.R")``` no console do R.

## Desenvolvimento
Este projeto foi desenvolvido utilizando o R com o framework Shiny para criar a interface web interativa. Os gráficos foram gerados utilizando a biblioteca Plotly, que permite a criação de gráficos interativos. Os dados de preços das ações e volume de negociação foram gerados aleatoriamente para fins de demonstração.

## Galeria

![image](https://github.com/LeviLucena/Bolsa_de_Valores/assets/34045910/da250b4a-fe8e-4fd2-a8f7-73e5573a70e1)
![image](https://github.com/LeviLucena/Bolsa_de_Valores/assets/34045910/e75dfdc1-df6e-4d95-a15d-7c2b7c8ee751)
![image](https://github.com/LeviLucena/Bolsa_de_Valores/assets/34045910/06f71af7-1239-4a83-a8d3-cc80aae399a5)
![image](https://github.com/LeviLucena/Bolsa_de_Valores/assets/34045910/dc7ff6fc-7828-4374-bee4-8898e4fd3d8f)
![image](https://github.com/LeviLucena/Bolsa_de_Valores/assets/34045910/1170cddf-b405-4dcd-ba39-63bddfc63ad6)

## Contribuição
Contribuições são bem-vindas! Sinta-se à vontade para abrir problemas (issues) para relatar bugs, sugerir melhorias ou adicionar novos recursos. Se você deseja contribuir com código, por favor, abra um pull request explicando claramente as alterações propostas.

## Licença
Este projeto está licenciado sob a Licença MIT.
