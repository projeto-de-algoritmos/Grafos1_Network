import networkx as nx


#LENDO UM ARQUIVO
import pandas as pd
df = pd.read_csv("ga_edgelist.csv")

g = nx.Graph()
g.add_node("Obama")
g.add_node("Trump")
g.add_nodes_from(["Hillary","Michelle"])


#Criando relações
g.add_edge("Obama","Michelle")
g.add_edge("Hillary","Clinton")
g.add_edge("Trump","Ivanka")
g.add_edge("Trump","Clinton")# Presidential Election
g.add_edge("Obama","Mitt")# Presidential Election

#Múltiplas relações
g.add_edges_from([("Hillary","Clinton"),("Obama","Trump"),("Obama","Clinton"),("Michelle","Ivanka"),("Michelle","Hillary")])


print(g.nodes())
nx.info(g)



import matplotlib.pyplot as plt

#Ver Gráfico
plt.figure(figsize=(10,10))
nx.draw_networkx(g)
plt.show()

# Quantas pessoas conectadas a Obama?
print(nx.degree(g,"Obama"))
print(nx.degree_centrality(g))

# Mostra o menor caminho entre dois candidatos
nx.shortest_path(g,"Obama","Clinton")

# Qual o menor caminho enre Mitt e Ivanka
nx.shortest_path(g,"Mitt","Ivanka")

#Mostra qual o mais influente
nx.degree_centrality(g)

#Conexão mais importante
nx.eigenvector_centrality(g)

#Lendo a partir de um arquivo
nx.read_edgelist()

