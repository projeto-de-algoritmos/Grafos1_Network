def DFS(G, edge, visited, dado):
    dados = str(dado)

    check = 0
    
    if edge not in visited:
        visited.append(edge)
        for adj in G[edge]:
            if dados in adj:
                check = 1
                break
            DFS(G, edge, visited, dados)

    return check