︠c1ecac3a-cc13-4d97-9033-0dd73cb23dd6s︠
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

    # Dodaj vozlišča v graf z želenimi oznakami in atributom dvodelnosti
    for i in range(st_vozlisc):
        dvodelni_graf.add_node(f"vozlisce_{i}", dvodelnost=0 if i < st_centrov else 1)

    # Dodaj povezave v graf, ki povezujejo vsak center z vsemi ne-center vozlišči
    for center in range(st_centrov):
        for i in range(st_centrov, st_vozlisc):
            dvodelni_graf.add_edge(f"vozlisce_{center}", f"vozlisce_{i}")

    return dvodelni_graf

def sigma_skupna_iregularnost(graf):
    skupna_iregularnost = 0

    for u, v in graf.edges():
        razlika_stopnje = abs(graf.degree(u) - graf.degree(v))
        skupna_iregularnost += razlika_stopnje**2

    return skupna_iregularnost

def generiraj_dvodelni_rekurzivno(st_vozlisc, vsi_dvodelni_grafi):
    if st_vozlisc <= 0:
        return

    # Generiraj dvodelni graf z različnim številom centrov
    for st_centrov in range(1, min(st_vozlisc, 10) + 1):  # Omeji število centrov za vizualizacijo
        dvodelni_graf = generiraj_dvodelni_graf(st_vozlisc, st_centrov)
        if ima_povezave(dvodelni_graf) and not je_regularen(dvodelni_graf):
            # Preveri izomorfizem z obstoječimi grafi
            izomorfni = any(nx.is_isomorphic(graf, dvodelni_graf) for graf in vsi_dvodelni_grafi)
            if not izomorfni:
                vsi_dvodelni_grafi.append(dvodelni_graf)

    # Generiraj za naslednje število vozlišč
    generiraj_dvodelni_rekurzivno(st_vozlisc - 1, vsi_dvodelni_grafi)

# Nastavi maksimalno število vozlišč
max_vozlisc = 30

# Generiraj vse dvodelne grafe z določenim številom vozlišč
vsi_dvodelni_grafi = []
generiraj_dvodelni_rekurzivno(max_vozlisc, vsi_dvodelni_grafi)

# Izračunaj sigma skupno iregularnost za vsak graf
sigma_skupne_vrednosti = [sigma_skupna_iregularnost(graf) for graf in vsi_dvodelni_grafi]

# Poišči maksimalno sigma skupno iregularnost in pripadajoči graf
max_sigma_t = max(sigma_skupne_vrednosti)
indeks_max_sigma_t = sigma_skupne_vrednosti.index(max_sigma_t)
max_graf = vsi_dvodelni_grafi[indeks_max_sigma_t]

print(f"Maksimalna Sigma Skupna Iregularnost: {max_sigma_t}")
print(f"Pripadajoče Povezave Grafa: {max_graf.edges}")

# Vizualiziraj graf z maksimalno iregularnostjo
razporeditev = nx.spring_layout(max_graf)
nx.draw(max_graf, razporeditev, with_labels=True, font_weight='bold', node_color='skyblue', node_size=800)
plt.title(f"Graf z Maksimalno Sigma Skupno Iregularnostjo: {max_sigma_t}")
plt.show()





︡fe4530e0-1d3f-4880-8152-66b35f93f2e1︡{"stdout":"Maksimalna Sigma Skupna Iregularnost: 50336\n"}︡{"stdout":"Pripadajoče Povezave Grafa: [('vozlisce_0', 'vozlisce_4'), ('vozlisce_0', 'vozlisce_5'), ('vozlisce_0', 'vozlisce_6'), ('vozlisce_0', 'vozlisce_7'), ('vozlisce_0', 'vozlisce_8'), ('vozlisce_0', 'vozlisce_9'), ('vozlisce_0', 'vozlisce_10'), ('vozlisce_0', 'vozlisce_11'), ('vozlisce_0', 'vozlisce_12'), ('vozlisce_0', 'vozlisce_13'), ('vozlisce_0', 'vozlisce_14'), ('vozlisce_0', 'vozlisce_15'), ('vozlisce_0', 'vozlisce_16'), ('vozlisce_0', 'vozlisce_17'), ('vozlisce_0', 'vozlisce_18'), ('vozlisce_0', 'vozlisce_19'), ('vozlisce_0', 'vozlisce_20'), ('vozlisce_0', 'vozlisce_21'), ('vozlisce_0', 'vozlisce_22'), ('vozlisce_0', 'vozlisce_23'), ('vozlisce_0', 'vozlisce_24'), ('vozlisce_0', 'vozlisce_25'), ('vozlisce_0', 'vozlisce_26'), ('vozlisce_0', 'vozlisce_27'), ('vozlisce_0', 'vozlisce_28'), ('vozlisce_0', 'vozlisce_29'), ('vozlisce_1', 'vozlisce_4'), ('vozlisce_1', 'vozlisce_5'), ('vozlisce_1', 'vozlisce_6'), ('vozlisce_1', 'vozlisce_7'), ('vozlisce_1', 'vozlisce_8'), ('vozlisce_1', 'vozlisce_9'), ('vozlisce_1', 'vozlisce_10'), ('vozlisce_1', 'vozlisce_11'), ('vozlisce_1', 'vozlisce_12'), ('vozlisce_1', 'vozlisce_13'), ('vozlisce_1', 'vozlisce_14'), ('vozlisce_1', 'vozlisce_15'), ('vozlisce_1', 'vozlisce_16'), ('vozlisce_1', 'vozlisce_17'), ('vozlisce_1', 'vozlisce_18'), ('vozlisce_1', 'vozlisce_19'), ('vozlisce_1', 'vozlisce_20'), ('vozlisce_1', 'vozlisce_21'), ('vozlisce_1', 'vozlisce_22'), ('vozlisce_1', 'vozlisce_23'), ('vozlisce_1', 'vozlisce_24'), ('vozlisce_1', 'vozlisce_25'), ('vozlisce_1', 'vozlisce_26'), ('vozlisce_1', 'vozlisce_27'), ('vozlisce_1', 'vozlisce_28'), ('vozlisce_1', 'vozlisce_29'), ('vozlisce_2', 'vozlisce_4'), ('vozlisce_2', 'vozlisce_5'), ('vozlisce_2', 'vozlisce_6'), ('vozlisce_2', 'vozlisce_7'), ('vozlisce_2', 'vozlisce_8'), ('vozlisce_2', 'vozlisce_9'), ('vozlisce_2', 'vozlisce_10'), ('vozlisce_2', 'vozlisce_11'), ('vozlisce_2', 'vozlisce_12'), ('vozlisce_2', 'vozlisce_13'), ('vozlisce_2', 'vozlisce_14'), ('vozlisce_2', 'vozlisce_15'), ('vozlisce_2', 'vozlisce_16'), ('vozlisce_2', 'vozlisce_17'), ('vozlisce_2', 'vozlisce_18'), ('vozlisce_2', 'vozlisce_19'), ('vozlisce_2', 'vozlisce_20'), ('vozlisce_2', 'vozlisce_21'), ('vozlisce_2', 'vozlisce_22'), ('vozlisce_2', 'vozlisce_23'), ('vozlisce_2', 'vozlisce_24'), ('vozlisce_2', 'vozlisce_25'), ('vozlisce_2', 'vozlisce_26'), ('vozlisce_2', 'vozlisce_27'), ('vozlisce_2', 'vozlisce_28'), ('vozlisce_2', 'vozlisce_29'), ('vozlisce_3', 'vozlisce_4'), ('vozlisce_3', 'vozlisce_5'), ('vozlisce_3', 'vozlisce_6'), ('vozlisce_3', 'vozlisce_7'), ('vozlisce_3', 'vozlisce_8'), ('vozlisce_3', 'vozlisce_9'), ('vozlisce_3', 'vozlisce_10'), ('vozlisce_3', 'vozlisce_11'), ('vozlisce_3', 'vozlisce_12'), ('vozlisce_3', 'vozlisce_13'), ('vozlisce_3', 'vozlisce_14'), ('vozlisce_3', 'vozlisce_15'), ('vozlisce_3', 'vozlisce_16'), ('vozlisce_3', 'vozlisce_17'), ('vozlisce_3', 'vozlisce_18'), ('vozlisce_3', 'vozlisce_19'), ('vozlisce_3', 'vozlisce_20'), ('vozlisce_3', 'vozlisce_21'), ('vozlisce_3', 'vozlisce_22'), ('vozlisce_3', 'vozlisce_23'), ('vozlisce_3', 'vozlisce_24'), ('vozlisce_3', 'vozlisce_25'), ('vozlisce_3', 'vozlisce_26'), ('vozlisce_3', 'vozlisce_27'), ('vozlisce_3', 'vozlisce_28'), ('vozlisce_3', 'vozlisce_29')]\n"}︡{"stdout":"Text(0.5, 1.0, 'Graf z Maksimalno Sigma Skupno Iregularnostjo: 50336')\n"}︡{"file":{"filename":"a294a8e8-f72c-47d6-8334-2a8a5507a0f5.svg","show":true,"text":null,"uuid":"cef53dc9-904a-4d98-ab72-c55e149b8906"},"once":false}︡{"done":true}
︠33701397-01ed-41b0-b478-68d33c659da0︠

︡a7f251a1-1233-4f5c-9bfc-8be9af376753︡
︠0b838da2-3b41-4d4b-818e-696b15d9cf5e︠

︡23faaac6-d290-4262-bad2-ee835463fd07︡
︠7544daf0-dba8-4176-a8c5-8f4aa43d21bf︠
︡4f11be24-25fb-4216-a837-64a75e30e8d8︡{"done":true}









