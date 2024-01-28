︠9ec5fb1d-8b1d-4025-85e6-7b5b3ca58977︠
import networkx as nx
import itertools
import matplotlib.pyplot as plt

def ima_povezave(graf):
    return bool(graf.edges)

def je_regularen(graf):
    # Preveri, ali imajo vsa vozlišča enako stopnjo
    stopnje = set(graf.degree(vozlisce) for vozlisce in graf.nodes)
    return len(stopnje) == 1

def generiraj_dvodelni_graf(st_vozlisc, st_centrov):
    dvodelni_graf = nx.Graph()

    # Doda vozlišča v graf z želenimi oznakami in atributom dvodelnosti
    for i in range(st_vozlisc):
        dvodelni_graf.add_node(f"vozlisce_{i}", dvodelnost=0 if i < st_centrov else 1)

    # Doda povezave v graf, ki povezujejo vsak center z vsemi zunanjimi vozlišči
    for center in range(st_centrov):
        for i in range(st_centrov, st_vozlisc):
            dvodelni_graf.add_edge(f"vozlisce_{center}", f"vozlisce_{i}")

    return dvodelni_graf

# Formula za izračun sigma totalne iregularnosti dvodelnega grafa
def sigma_skupna_iregularnost(graf):
    skupna_iregularnost = 0

    for u, v in graf.edges():
        razlika_stopnje = abs(graf.degree(u) - graf.degree(v))
        skupna_iregularnost += razlika_stopnje**2

    return skupna_iregularnost

def generiraj_dvodelni_rekurzivno(st_vozlisc, vsi_dvodelni_grafi):
    if st_vozlisc <= 0:
        return

    # Generira dvodelni graf z različnim številom centrov
    for st_centrov in range(1, min(st_vozlisc, 15) + 1):  # Omeji število centrov za vizualizacijo
        dvodelni_graf = generiraj_dvodelni_graf(st_vozlisc, st_centrov)
        if ima_povezave(dvodelni_graf) and not je_regularen(dvodelni_graf):
            # Preveri izomorfizem z obstoječimi grafi
            izomorfni = any(nx.is_isomorphic(graf, dvodelni_graf) for graf in vsi_dvodelni_grafi)
            if not izomorfni:
                vsi_dvodelni_grafi.append(dvodelni_graf)

    # Generira za naslednje število vozlišč
    generiraj_dvodelni_rekurzivno(st_vozlisc - 1, vsi_dvodelni_grafi)

# Generira tabelo največjih sigma totalnih iregularnosti glede na število vozlišč
tabela_sigma_skupnih = []

for max_vozlisc in range(3, 101):
    if max_vozlisc <= 10 or (max_vozlisc - 10) % 10 == 0:
        vsi_dvodelni_grafi = []
        generiraj_dvodelni_rekurzivno(max_vozlisc, vsi_dvodelni_grafi)

        # Izračuna sigma totalno iregularnost za vsak graf
        sigma_skupne_vrednosti = [sigma_skupna_iregularnost(graf) for graf in vsi_dvodelni_grafi]

        # Poišče največjo sigma totalno iregularnost in pripadajoči graf
        maks_sigma_t = max(sigma_skupne_vrednosti)
        indeks_maks_sigma_t = sigma_skupne_vrednosti.index(maks_sigma_t)
        maks_graf = vsi_dvodelni_grafi[indeks_maks_sigma_t]

        tabela_sigma_skupnih.append((max_vozlisc, maks_sigma_t))

# Izpiše tabelo rezultatov
print("Število vozlišč | Največja Sigma Totalna Iregularnost")
print("-" * 50)
for max_vozlisc, maks_sigma_t in tabela_sigma_skupnih:
    print(f"{max_vozlisc:^15} | {maks_sigma_t:^33}")

# Vizualizira zadnji graf v tabeli z maksimalno iregularnostjo
razporeditev = nx.spring_layout(maks_graf)
nx.draw(maks_graf, razporeditev, with_labels=True, font_weight='bold', node_color='skyblue', node_size=800)
plt.title(f"Graf z Maksimalno Sigma Totalno Iregularnostjo: {maks_sigma_t}")
plt.show()


︡3dc39ca1-eae9-4d60-b755-8fa07c8ff0a0︡{"stdout":"Število vozlišč | Maksimalna Sigma Skupna Iregularnost\n"}︡{"stdout":"--------------------------------------------------"}︡{"stdout":"\n"}︡{"stdout":"       3        |                 2                \n       4        |                12                \n       5        |                36                \n       6        |                80                \n       7        |                150               \n       8        |                252               \n       9        |                392               \n      10        |                576               \n      20        |               9996               \n      30        |               50336              \n      40        |              159936              \n      50        |              390096              \n      60        |              809676              \n      70        |              1500000             \n      80        |              2558976             \n      90        |              4100096             \n      100       |              6247500             \n"}︡{"stdout":"Text(0.5, 1.0, 'Graf z Maksimalno Sigma Skupno Iregularnostjo: 6247500')\n"}︡{"file":{"filename":"3d8dc0bb-90fe-4e55-85a5-35693d07b1ea.svg","show":true,"text":null,"uuid":"99c78532-e6f8-4ccf-8f78-ef8237ac1bef"},"once":false}︡{"done":true}︡









