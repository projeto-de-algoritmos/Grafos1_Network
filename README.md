# Network

**Número da Lista**: 1<br>
**Conteúdo da Disciplina**: Grafos 1<br>

## Alunos
|Matrícula | Aluno |
| -- | -- |
| 19/0045485  |  Eduardo Gurgel Pereira de Carvalho |
| 20/0043111 |  Ricardo de Castro Loureiro |





## Sobre 
O network é uma aplicação que mostra as conexões em forma de grafo a partir de um arquivo csv, baseado em dados reais, podendo ser utilizado para encontrar influência entre pessoas, e também encontrar padrôes, no nosso projeto usamos dois casos, um é da série Grey's Anatomy e outro nas eleições presidenciais dos Estados Unidos

## Screenshots

![Arquivo .csv](https://user-images.githubusercontent.com/83254747/152902785-9e026555-2df0-447f-8e1f-4ac50d1180c6.png)
![Grafo](/grafos1/assets/screen2.png)


## Instalação 
**Linguagem**: Python<br>
**Biblioteca**: tkinter, networkx<br> 

* Pré-requisitos:
  * [Git](https://git-scm.com/)
  * [Python3](https://www.python.org/)
  * [tkinter](https://docs.python.org/3/library/tkinter.html)
  * [networx](https://networkx.org)
 
 * Clonar o repositório
  ```
  https://github.com/projeto-de-algoritmos/Grafos1_Network.git
  ```
  
  * Mudar para a pasta do repositório
  ```
  cd Grafos1_Network/grafos1
  ```
  
 * Executar o projeto
  ```
  python projeto.py
  ```
 
  ## Uso
  Ao rodar o projeto clique no botão plotar, que irá gerar um grafo aleatório baseado no arquivo csv, para mudar o arquivo, basta alterar o paramêtro df para "network_grey.csv" ou "network_eleicao.csv"

