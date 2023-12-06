︠fbc6afc4-946a-4b54-b580-9307cb8a213a︠

︡5339a9ea-bf68-406f-8d0e-0400ff8f1459︡
︠e30e962a-7082-4ea1-89e9-80082e1d2016s︠
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

max_vozlišč = 500
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

print(f"Največja sigma totalna iregularnost: {največja_sigma_totalna_iregularnost}")
print(f"Število vozlišč v Naboru 1: {število_vozlišč_nabora1}, Število vozlišč v Naboru 2: {število_vozlišč_nabora2}")

# Prikaži najboljši graf
#najboljši_graf.plot()

# Pridobi dvodelna nabora
X, Y = najboljši_graf.bipartite_sets()

# Določi sredino za y-koordinate naborov
sredina_L = len(X) / 2.0
sredina_D = len(Y) / 2.0

# Ustvari slovar za pozicije za risanje grafa
pozicije = {}
for i, v in enumerate(X):
    pozicije[v] = (1, i - sredina_L + 0.5)
for i, v in enumerate(Y):
    pozicije[v] = (1 + (len(Y) + len(X)) / 2, i - sredina_D + 0.5)

# Nariši graf
najboljši_graf.plot(pos=pozicije)
︡858e3bc1-0257-4fdc-89db-2259639583f3︡{"stdout":"Največja sigma totalna iregularnost: 1599943356\n"}︡{"stdout":"Število vozlišč v Naboru 1: 341, Število vozlišč v Naboru 2: 59\n"}︡{"file":{"filename":"/tmp/tmprvm0j_li/tmp_pxpgz986.svg","show":true,"text":null,"uuid":"7baf617b-a259-4ac0-959b-9805fa6489d1"},"once":false}︡{"done":true}









