︠6108b6c8-4443-480c-bca8-6c0cc03176e8s︠
def ustvari_dvodelni_graf(število_vozlišč_nabora1, število_vozlišč_nabora2):
    """
    Ustvari popoln dvodelni graf z določenim številom vozlišč v vsakem naboru.

    Parametri:
    - število_vozlišč_nabora1: Število vozlišč v naboru 1
    - število_vozlišč_nabora2: Število vozlišč v naboru 2

    Vrne:
    - Popoln dvodelni graf
    """
    # Ustvari dva nabora vozlišč
    vozlišča_nabora1 = range(število_vozlišč_nabora1)
    vozlišča_nabora2 = range(število_vozlišč_nabora1, število_vozlišč_nabora1 + število_vozlišč_nabora2)

    # Ustvari popoln bipartitni graf
    G = Graph()

    # Dodaj vozlišča v graf
    G.add_vertices(vozlišča_nabora1)
    G.add_vertices(vozlišča_nabora2)

    # Dodaj povezave med vsemi vozlišči različnih naborov
    G.add_edges([(v1, v2) for v1 in vozlišča_nabora1 for v2 in vozlišča_nabora2])

    return G

def sigma_totalna_iregularnost(graf):
    totalna_iregularnost = 0

    for u, v, *_ in graf.edge_iterator():
        razlika_stopnje = abs(graf.degree(u) - graf.degree(v))
        totalna_iregularnost += razlika_stopnje ** 2

    return totalna_iregularnost

# Define the results list
results = []

# Definiraj obseg vrednosti za max_vozlišča
max_vozlišča_vrednosti = list(range(50, 301, 50))

for max_vozlišč in max_vozlišča_vrednosti:
    največja_sigma_totalna_iregularnost = 0
    najboljši_graf = None
    število_vozlišč_nabora1 = 1
    število_vozlišč_nabora2 = 1

    for i in range(2, max_vozlišč):
        graf_i1 = ustvari_dvodelni_graf(število_vozlišč_nabora1 + 1, število_vozlišč_nabora2)
        graf_i2 = ustvari_dvodelni_graf(število_vozlišč_nabora1, število_vozlišč_nabora2 + 1)
        največja_sigma_totalna_iregularnost_i1 = sigma_totalna_iregularnost(graf_i1)
        največja_sigma_totalna_iregularnost_i2 = sigma_totalna_iregularnost(graf_i2)

        if največja_sigma_totalna_iregularnost_i1 >= največja_sigma_totalna_iregularnost_i2:
            največja_sigma_totalna_iregularnost = največja_sigma_totalna_iregularnost_i1
            najboljši_graf = graf_i1
            število_vozlišč_nabora1 += 1
        else:
            največja_sigma_totalna_iregularnost = največja_sigma_totalna_iregularnost_i2
            najboljši_graf = graf_i2
            število_vozlišč_nabora2 += 1

    # Add results to the list
    results.append([max_vozlišč, največja_sigma_totalna_iregularnost, število_vozlišč_nabora1, število_vozlišč_nabora2])

# Print the results with adjusted formatting
print("Max Vozlišča | Max Sigma Totalna Iregularnost | Število Vozlišč Nabora 1 | Število Vozlišč Nabora 2")
for row in results:
    print(f"{row[0]:<12} | {row[1]:<30} | {row[2]:<23}  | {row[3]:<23}")



︡5c56e0c3-e661-4e07-ae9e-67d816708846︡{"stdout":"Max Vozlišča | Max Sigma Totalna Iregularnost | Število Vozlišč Nabora 1 | Število Vozlišč Nabora 2\n"}︡{"stdout":"50           | 390096                         | 43                       | 7                      \n100          | 6247500                        | 85                       | 15                     \n150          | 31640576                       | 128                      | 22                     \n200          | 99993276                       | 171                      | 29                     \n250          | 244121856                      | 213                      | 37                     \n300          | 506249216                      | 256                      | 44                     \n"}︡{"done":true}
︠ec01fc37-2b0b-4f68-9f79-04eff2591ca6︠
︡1703f227-bfbc-472c-93d1-7b24c16db01c︡{"done":true}









