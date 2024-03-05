# Carregar bibliotecas necessárias
library(shiny)
library(plotly)
library(dplyr)

# Definir número de dias de simulação
num_dias <- 100

# Gerar datas
datas <- seq(as.Date('2023-01-01'), by = 'day', length.out = num_dias)

# Gerar preços fictícios para ações e volume de negociação
set.seed(123) # Define uma semente para reprodutibilidade
precos <- data.frame(
  Data = datas,
  Google = cumsum(rnorm(num_dias)),
  Apple = cumsum(rnorm(num_dias)),
  Amazon = cumsum(rnorm(num_dias))
)

# Gerar volume de negociação diário
volume_negociacao <- data.frame(
  Data = datas,
  Volume_Google = abs(rnorm(num_dias, mean = 100000, sd = 50000)),
  Volume_Apple = abs(rnorm(num_dias, mean = 80000, sd = 40000)),
  Volume_Amazon = abs(rnorm(num_dias, mean = 120000, sd = 60000))
)

# Definir correlação entre as ações
correlacao <- cor(precos[, -1])

# Calcular volatilidade histórica das ações
volatilidade <- apply(precos[, -1], 2, function(x) sd(diff(x)))

# Definir UI
ui <- fluidPage(
  titlePanel("Análise de Bolsa de Valores"),
  tabsetPanel(
    tabPanel("Preços das Ações", 
             dateRangeInput("periodo_precos", "Período:", 
                            start = min(datas), end = max(datas),
                            min = min(datas), max = max(datas)),
             plotlyOutput("grafico_precos")),
    tabPanel("Volume de Negociação", 
             dateRangeInput("periodo_volume", "Período:", 
                            start = min(datas), end = max(datas),
                            min = min(datas), max = max(datas)),
             plotlyOutput("grafico_volume")),
    tabPanel("Correlação entre as Ações", 
             dateRangeInput("periodo_correlacao", "Período:", 
                            start = min(datas), end = max(datas),
                            min = min(datas), max = max(datas)),
             plotlyOutput("grafico_correlacao")),
    tabPanel("Volatilidade das Ações", 
             dateRangeInput("periodo_volatilidade", "Período:", 
                            start = min(datas), end = max(datas),
                            min = min(datas), max = max(datas)),
             plotlyOutput("grafico_volatilidade")),
    tabPanel("Relatório",
             fluidRow(
               column(6, plotlyOutput("grafico_relatorio1")),
               column(6, plotlyOutput("grafico_relatorio2"))
             ),
             fluidRow(
               column(6, plotlyOutput("grafico_relatorio3")),
               column(6, plotlyOutput("grafico_relatorio4"))
             ),
             fluidRow(
               column(12,
                      actionButton("exportar", "Exportar"),
                      actionButton("imprimir", "Imprimir")
               )
             )
    )
  )
)

# Definir server
server <- function(input, output) {
  
  # Subset dos dados de acordo com o período selecionado
  dados_filtrados_precos <- reactive({
    subset(precos, Data >= input$periodo_precos[1] & Data <= input$periodo_precos[2])
  })
  
  dados_filtrados_volume <- reactive({
    subset(volume_negociacao, Data >= input$periodo_volume[1] & Data <= input$periodo_volume[2])
  })
  
  # Gráfico de preços das ações
  output$grafico_precos <- renderPlotly({
    plot_ly(reshape2::melt(dados_filtrados_precos(), id.vars = "Data"), x = ~Data, y = ~value, color = ~variable, type = 'scatter', mode = 'lines') %>%
      layout(title = "Preços das Ações ao Longo do Tempo",
             xaxis = list(title = "Data"),
             yaxis = list(title = "Preço"),
             legend = list(title = "Ação"))
  })
  
  # Gráfico de volume de negociação
  output$grafico_volume <- renderPlotly({
    plot_ly(reshape2::melt(dados_filtrados_volume(), id.vars = "Data"), x = ~Data, y = ~value, color = ~variable, type = 'bar') %>%
      layout(title = "Volume de Negociação Diário",
             xaxis = list(title = "Data"),
             yaxis = list(title = "Volume"),
             legend = list(title = "Ação"))
  })
  
  # Gráfico de correlação entre as ações
  output$grafico_correlacao <- renderPlotly({
    plot_ly(z = ~correlacao, x = colnames(correlacao), y = colnames(correlacao), type = "heatmap", colorscale = "Viridis") %>%
      layout(title = "Correlação entre as Ações",
             xaxis = list(title = ""),
             yaxis = list(title = ""))
  })
  
  # Gráfico de volatilidade das ações
  output$grafico_volatilidade <- renderPlotly({
    plot_ly(x = colnames(precos[, -1]), y = volatilidade, type = "scatter", mode = "lines+markers") %>%
      layout(title = "Volatilidade das Ações",
             xaxis = list(title = "Ação"),
             yaxis = list(title = "Volatilidade"))
  })
  
  # Gráfico de preços das ações para o relatório
  output$grafico_relatorio1 <- renderPlotly({
    plot_ly(reshape2::melt(dados_filtrados_precos(), id.vars = "Data"), x = ~Data, y = ~value, color = ~variable, type = 'scatter', mode = 'lines') %>%
      layout(title = "Preços das Ações ao Longo do Tempo",
             xaxis = list(title = "Data"),
             yaxis = list(title = "Preço"),
             legend = list(title = "Ação"))
  })
  
  # Gráfico de volume de negociação para o relatório
  output$grafico_relatorio2 <- renderPlotly({
    plot_ly(reshape2::melt(dados_filtrados_volume(), id.vars = "Data"), x = ~Data, y = ~value, color = ~variable, type = 'bar') %>%
      layout(title = "Volume de Negociação Diário",
             xaxis = list(title = "Data"),
             yaxis = list(title = "Volume"),
             legend = list(title = "Ação"))
  })
  
  # Gráfico de correlação entre as ações para o relatório
  output$grafico_relatorio3 <- renderPlotly({
    plot_ly(z = ~correlacao, x = colnames(correlacao), y = colnames(correlacao), type = "heatmap", colorscale = "Viridis") %>%
      layout(title = "Correlação entre as Ações",
             xaxis = list(title = ""),
             yaxis = list(title = ""))
  })
  
  # Gráfico de volatilidade das ações para o relatório
  output$grafico_relatorio4 <- renderPlotly({
    plot_ly(x = colnames(precos[, -1]), y = volatilidade, type = "scatter", mode = "lines+markers") %>%
      layout(title = "Volatilidade das Ações",
             xaxis = list(title = "Ação"),
             yaxis = list(title = "Volatilidade"))
  })
  
  # Exportar gráficos
  observeEvent(input$exportar, {
    export(plotly::toJSON(output$grafico_relatorio1), file = "grafico_relatorio1.html")
    export(plotly::toJSON(output$grafico_relatorio2), file = "grafico_relatorio2.html")
    export(plotly::toJSON(output$grafico_relatorio3), file = "grafico_relatorio3.html")
    export(plotly::toJSON(output$grafico_relatorio4), file = "grafico_relatorio4.html")
  })
  
  # Imprimir gráficos
  observeEvent(input$imprimir, {
    print(output$grafico_relatorio1)
    print(output$grafico_relatorio2)
    print(output$grafico_relatorio3)
    print(output$grafico_relatorio4)
  })
}

# Rodar a aplicação
shinyApp(ui = ui, server = server)
