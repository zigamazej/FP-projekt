︠1646d56a-16aa-41c2-afcf-3c646f37845f︠
import random
from random import randint
import numpy as np
from sage.graphs.generators.random import RandomBipartite as BP

# Formula za izračun sigma totalne iregularnosti dvodelnega grafa
def sigma_tot_bp(graf):
    sigma_tot = 0
    stopnje = graf.degree_sequence()
    for vozlisce in range(len(stopnje)):
        for nadaljne in range(vozlisce + 1, len(stopnje)):
            sigma_tot += (stopnje[vozlisce] - stopnje[nadaljne]) ** 2
    return sigma_tot

# Funkcija za simulated annealing
def SA_dvodelni(st_vozlisc, T, ponovitve = 1000):
    scale = np.sqrt(T)
    faktor = random.uniform(0, 1)
    n1 = randint(1, st_vozlisc - 1)
    n2 = st_vozlisc - n1
    start = BP(n1, n2, faktor)
    x = [n1, faktor]
    y = start
    cur = sigma_tot_bp(start)
    for i in range(ponovitve):
        prop = [int(max(min(floor(x[0] + np.random.uniform(-1, 1, size = 1)*
                             scale), st_vozlisc - 1), 1)), float(max(min(x[1] + np.random.uniform(-1, 1, size = 1)*scale, 0.999999), 0.0000001))]
        prop_graf = BP(prop[0], st_vozlisc - prop[0], prop[1])
        if np.log(np.random.rand()) * T > (sigma_tot_bp(prop_graf) - cur):
            prop = x
            prop_graf = y
        x = prop
        y = prop_graf
        cur = sigma_tot_bp(prop_graf)
        T = 0.9 * T
	#history.append((x,y, sigma_tot(y)))
    return [x[0], (st_vozlisc - x[0])], (min(x[0], st_vozlisc - x[0])/st_vozlisc), cur #y.is_bipartite()


# Vrne rešitve za vse grafe redov <= max_vozlišč
def test_dvodelni_SA (max_vozlisc, T, ponovitve = 1000):
    seznam = dict()
    for i in range(2, max_vozlisc + 1):
        sig = SA_dvodelni(i, T, ponovitve)
        seznam[i] = sig
    return seznam
︡5ac65581-f464-4d1e-b2e6-68921fe569a5︡{"done":true}
︠76553587-ddcb-499d-9bc0-1a5f1802f4c9︠
# Bolj natančna funkcija, ohranja le najboljšo rešitev do trenutnega koraka
def test_dvodelni_SA_natancen(st_vozlisc, T, ponovitve=1000, st_poskusov=10):
    najboljsa_resitev = None
    najboljsa_STI = -float('inf')

    for _ in range(st_poskusov):
        resitev = SA_dvodelni(st_vozlisc, T, ponovitve)
        if resitev[2] > najboljsa_STI:  # Primerjava STI
            najboljsa_resitev = resitev
            najboljsa_STI = resitev[2]

    return najboljsa_resitev



st_vozlisc = 20
T = 0.9
ponovitve = 1000
st_poskusov = 10

rezultat = test_dvodelni_SA_natancen(st_vozlisc, T, ponovitve, st_poskusov)
print("Particija vozlišč:", rezultat[0])
print("Razmerje manjšega nabora, glede na število vozlišč:", rezultat[1])
print("STI:", rezultat[2])


︡20e5191e-089a-4a0a-8f67-0def38ec5f42︡{"stderr":":11: DeprecationWarning: Conversion of an array with ndim > 0 to a scalar is deprecated, and will error in future. Ensure you extract a single element from your array before performing this operation. (Deprecated NumPy 1.25.)\n:12: DeprecationWarning: Conversion of an array with ndim > 0 to a scalar is deprecated, and will error in future. Ensure you extract a single element from your array before performing this operation. (Deprecated NumPy 1.25.)\n"}︡{"stdout":"Particija vozlišč: [3, 17]\n"}︡{"stdout":"Razmerje manjšega nabora, glede na število vozlišč: 3/20\n"}︡{"stdout":"STI: 9996\n"}︡{"done":true}









