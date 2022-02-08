def BFS(G, edge, visitedlist, dado):
    row = []

    visitedlist.append(edge)
    row.append(edge)

    check = 0

    dados = str(dado)

    while row:
        no = row.pop(0)
        print(edge)

        for vizinho in G[edge]:
            if vizinho not in visitedlist:
                if dados in vizinho:
                    check = 1
                    break
                visitedlist.append(vizinho)
                row.append(vizinho)
    return check