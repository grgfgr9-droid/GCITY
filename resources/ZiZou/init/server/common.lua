ESX = {}
ESX.RegistredPlayers = {}
ESX.Players = {}
ESX.UsableItemsCallbacks = {}
ESX.Items = {
    ["weed_pooch"] = { label = "Pochon de Weed", weight = 1, rare = 0, canRemove = 1 },
    ["papier_pooch"] = { label = "Faux Billet", weight = 1, rare = 0, canRemove = 1 },
    ["bandage"] = { label = "Bandage", weight = 1, rare = 0, canRemove = 1 },
    ["water"] = { label = "Eau", weight = 1, rare = 0, canRemove = 1 },
    ["burger"] = { label = "Chicken Zinger", weight = 1, rare = 0, canRemove = 1 },
    ["vodkardb"] = { label = "Vodka Redbull", weight = 1, rare = 0, canRemove = 1 },
    ["silencieux"] = { label = "Silencieux", weight = 1, rare = 0, canRemove = 1 },
    ["meth_pooch"] = { label = "Pochon de Meth", weight = 1, rare = 0, canRemove = 1 },
    ["medikit"] = { label = "Medikit", weight = 1, rare = 0, canRemove = 1 },
    ["bread"] = { label = "Pain", weight = 1, rare = 0, canRemove = 1 },
    ["vigne_pooch"] = { label = "Vin rouge", weight = 1, rare = 0, canRemove = 1 },
    ["phone"] = { label = "Téléphone", weight = 1, rare = 0, canRemove = 1 },
    ["roueticket"] = { label = "Ticket Roue", weight = 0, rare = 1, canRemove = 0 },
    ["clip"] = { label = "Chargeur", weight = 1, rare = 0, canRemove = 1 },
    ["papier"] = { label = "Papier", weight = 1, rare = 0, canRemove = 1 },
    ["tabac"] = { label = "Tabac", weight = 1, rare = 0, canRemove = 1 },
    ["opium_pooch"] = { label = "Pochon d'Opium", weight = 1, rare = 0, canRemove = 1 },
    ["chocolat"] = { label = "Chocolat", weight = 1, rare = 0, canRemove = 1 },
    ["coke_pooch"] = { label = "Pochon de Coke", weight = 1, rare = 0, canRemove = 1 },
    ["fanta"] = { label = "Fanta", weight = 1, rare = 0, canRemove = 1 },
    ["opium"] = { label = "Opium", weight = 1, rare = 0, canRemove = 1 },
    ["weed"] = { label = "Weed", weight = 1, rare = 0, canRemove = 1 },
    ["powerade"] = { label = "Powerade", weight = 1, rare = 0, canRemove = 1 },
    ["grip"] = { label = "Poignée", weight = 1, rare = 0, canRemove = 1 },
    ["whiskycoca"] = { label = "Whisky Coca", weight = 1, rare = 0, canRemove = 1 },
    ["flashlight"] = { label = "Lampe", weight = 1, rare = 0, canRemove = 1 },
    ["redbull"] = { label = "Redbull", weight = 1, rare = 0, canRemove = 1 },
    ["vigne"] = { label = "Vigne", weight = 1, rare = 0, canRemove = 1 },
    ["meth"] = { label = "Meth", weight = 1, rare = 0, canRemove = 1 },
    ["cola"] = { label = "Coca-Cola", weight = 1, rare = 0, canRemove = 1 },
    ["coke"] = { label = "Coke", weight = 1, rare = 0, canRemove = 1 },

    ["jeton"] = { label = "Jeton", weight = 0, rare = 0, canRemove = 1 },
    ["radio"] = { label = "Radio", weight = 1, rare = 0, canRemove = 1 },



    ["blue_case"] = { label = "Blue Caisse", weight = 1, rare = 0, canRemove = 1 },
    ["radiant_case"] = { label = "Radiant Caisse", weight = 1, rare = 0, canRemove = 1 },
    ["ultimate_case"] = { label = "Ultimate Caisse", weight = 1, rare = 0, canRemove = 1 },

    ["bronze_case"] = { label = "Bronze Caisse", weight = 1, rare = 0, canRemove = 1 },
    ["gold_case"] = { label = "Gold Caisse", weight = 1, rare = 0, canRemove = 1 },
    ["diamond_case"] = { label = "Diamond Caisse", weight = 1, rare = 0, canRemove = 1 },





    ["coffe"] = { label = "Café", weight = 1, rare = 0, canRemove = 1 },
    ["tabac_pooch"] = { label = "Cigarette", weight = 1, rare = 0, canRemove = 1 },
    ["hamburger"] = { label = "Burger", weight = 1, rare = 0, canRemove = 1 },
    ["sandwich"] = { label = "Sandwich", weight = 1, rare = 0, canRemove = 1 },
    ["yusuf"] = { label = "Skin de luxe", weight = 1, rare = 0, canRemove = 1 },
    ["joal"] = { label = "Bijoux", weight = 1, rare = 0, canRemove = 1 },




    
    ----- CRAFT
    ["feraille"] = { label = "Feraille", weight = 1, rare = 0, canRemove = 1 },
    ["titanium"] = { label = "Titanium", weight = 1, rare = 0, canRemove = 1 },
    ["plomb"] = { label = "Plomb", weight = 1, rare = 0, canRemove = 1 },





    --- YOUTOOL 
    ["parapluie"] = { label = "Parapluie", weight = 1, rare = 0, canRemove = 1 },
    ["marteaux"] = { label = "Marteaux", weight = 1, rare = 0, canRemove = 1 },
    ["piedbiche"] = { label = "Pied de Biche", weight = 1, rare = 0, canRemove = 1 },
    ["rateau"] = { label = "Rateau", weight = 1, rare = 0, canRemove = 1 },
    ["lampebureau"] = { label = "Lampe de Bureau", weight = 1, rare = 0, canRemove = 1 },
    ["grainefleur"] = { label = "Graine De Fleur", weight = 1, rare = 0, canRemove = 1 },
    ["potfleur"] = { label = "Pot de Fleur", weight = 1, rare = 0, canRemove = 1 },
    ["crochetage"] = { label = "Outils de Crochetage", weight = 1, rare = 0, canRemove = 1 },
    ["caisseoutil"] = { label = "Caisse Outils", weight = 1, rare = 0, canRemove = 1 },
    ["fil"] = { label = "Fil", weight = 1, rare = 0, canRemove = 1 },
    ["boulon"] = { label = "Boulon", weight = 1, rare = 0, canRemove = 1 },


}


ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.Jobs = {
    ["unicorn"] = { name = "unicorn", label = "Unicorn", grades = {
            ["0"] = { id = 102, job_name = "unicorn", name = "recrue", grade = 0, label = "Barman", salary = 400 },
            ["1"] = { id = 103, job_name = "unicorn", name = "gerant", grade = 1, label = "Gerant", salary = 400 },
            ["2"] = { id = 104, job_name = "unicorn", name = "boss", grade = 2, label = "Patron", salary = 400 },
        }
    },
    ["unemployed"] = { name = "unemployed", label = "Chomeur", grades = {
            ["0"] = { id = 1, job_name = "unemployed", name = "unemployed", grade = 0, label = "Chomeur", salary = 200 },
        }
    },
    ["realestateagent"] = { name = "realestateagent", label = "Agent immobilier", grades = {
            ["3"] = { id = 85, job_name = "realestateagent", name = "boss", grade = 3, label = "Patron", salary = 0 },
            ["0"] = { id = 82, job_name = "realestateagent", name = "location", grade = 0, label = "Location", salary = 10 },
            ["1"] = { id = 83, job_name = "realestateagent", name = "vendeur", grade = 1, label = "Vendeur", salary = 25 },
            ["2"] = { id = 84, job_name = "realestateagent", name = "gestion", grade = 2, label = "Gestion", salary = 40 },
        }
    },
    ["bennys"] = { name = "bennys", label = "Benny's", grades = {
            ["3"] = { id = 73, job_name = "bennys", name = "boss", grade = 3, label = "Patron", salary = 48 },
            ["0"] = { id = 70, job_name = "bennys", name = "recrue", grade = 0, label = "Recrue", salary = 12 },
            ["1"] = { id = 71, job_name = "bennys", name = "experimente", grade = 1, label = "Experimente", salary = 24 },
            ["2"] = { id = 72, job_name = "bennys", name = "chief", grade = 2, label = "Chef d'équipe", salary = 36 },
        }
    },
    ["taxi"] = { name = "taxi", label = "Taxi", grades = {
        ["3"] = { id = 73, job_name = "taxi", name = "boss", grade = 3, label = "Patron", salary = 48 },
        ["0"] = { id = 70, job_name = "taxi", name = "recrue", grade = 0, label = "Recrue", salary = 12 },
        ["1"] = { id = 71, job_name = "taxi", name = "experimente", grade = 1, label = "Experimente", salary = 24 },
        ["2"] = { id = 72, job_name = "taxi", name = "chief", grade = 2, label = "Chef d'équipe", salary = 36 },
    }
},
    ["mechanic"] = { name = "mechanic", label = "Mécano", grades = {
            ["3"] = { id = 77, job_name = "mechanic", name = "boss", grade = 3, label = "Patron", salary = 0 },
            ["0"] = { id = 74, job_name = "mechanic", name = "recrue", grade = 0, label = "Recrue", salary = 12 },
            ["1"] = { id = 75, job_name = "mechanic", name = "experimente", grade = 1, label = "Experimente", salary = 36 },
            ["2"] = { id = 76, job_name = "mechanic", name = "chief", grade = 2, label = "Chef d'équipe", salary = 48 },
        }
    },
    ["cardealer"] = { name = "cardealer", label = "Concessionnaire Voitures", grades = {
            ["3"] = { id = 81, job_name = "cardealer", name = "boss", grade = 3, label = "Patron", salary = 0 },
            ["0"] = { id = 78, job_name = "cardealer", name = "recruit", grade = 0, label = "Recrue", salary = 10 },
            ["1"] = { id = 79, job_name = "cardealer", name = "novice", grade = 1, label = "Novice", salary = 25 },
            ["2"] = { id = 80, job_name = "cardealer", name = "experienced", grade = 2, label = "Experimente", salary = 40 },
        }
    },
    ["planedealer"] = { name = "planedealer", label = "Concessionnaire Avions", grades = {
        ["3"] = { id = 81, job_name = "planedealer", name = "boss", grade = 3, label = "Patron", salary = 0 },
        ["0"] = { id = 78, job_name = "planedealer", name = "recruit", grade = 0, label = "Recrue", salary = 10 },
        ["1"] = { id = 79, job_name = "planedealer", name = "novice", grade = 1, label = "Novice", salary = 25 },
        ["2"] = { id = 80, job_name = "planedealer", name = "experienced", grade = 2, label = "Experimente", salary = 40 },
    }
},
    ["tabac"] = { name = "tabac", label = "Tabac", grades = {
            ["0"] = { id = 99, job_name = "tabac", name = "recrue", grade = 0, label = "Tabagiste Marlboro", salary = 400 },
            ["1"] = { id = 100, job_name = "tabac", name = "gerant", grade = 1, label = "Gérant Marlboro", salary = 650 },
            ["2"] = { id = 101, job_name = "tabac", name = "boss", grade = 2, label = "Patron Marlboro", salary = 800 },
        }
    },
    ["gouv"] = { name = "gouv", label = "Gouvernement", grades = {
            ["3"] = { id = 114, job_name = "gouv", name = "boss", grade = 3, label = "Président", salary = 400 },
            ["0"] = { id = 111, job_name = "gouv", name = "secretaire", grade = 0, label = "Secretaire", salary = 400 },
            ["1"] = { id = 112, job_name = "gouv", name = "bodyguard", grade = 1, label = "Garde-Corps", salary = 400 },
            ["2"] = { id = 113, job_name = "gouv", name = "prime", grade = 2, label = "Premier Ministre", salary = 400 },
        }
    },
    ["ambulance"] = { name = "ambulance", label = "Ambulance", grades = {
            ["3"] = { id = 69, job_name = "ambulance", name = "boss", grade = 3, label = "Chirurgien", salary = 80 },
            ["0"] = { id = 66, job_name = "ambulance", name = "ambulance", grade = 0, label = "Ambulancier", salary = 20 },
            ["1"] = { id = 67, job_name = "ambulance", name = "doctor", grade = 1, label = "Medecin", salary = 40 },
            ["2"] = { id = 68, job_name = "ambulance", name = "chief_doctor", grade = 2, label = "Medecin-chef", salary = 60 },
        }
    },
    ["boulangerie"] = { name = "boulangerie", label = "Boulangerie", grades = {
            ["0"] = { id = 108, job_name = "boulangerie", name = "recrue", grade = 0, label = "Recrue", salary = 400 },
            ["1"] = { id = 109, job_name = "boulangerie", name = "novice", grade = 1, label = "Expérimenté", salary = 400 },
            ["2"] = { id = 110, job_name = "boulangerie", name = "boss", grade = 2, label = "Boss", salary = 400 },
        }
    },
    ["unemployed2"] = { name = "unemployed2", label = "citoyen", grades = {
            ["0"] = { id = 2, job_name = "unemployed2", name = "unemployed2", grade = 0, label = "citoyen", salary = 200 },
        }
    },

    ["chantier"] = { name = "chantier", label = "Chantier", grades = {
        ["0"] = { id = 150, job_name = "chantier", name = "chantier", grade = 0, label = "recrue", salary = 200 },
        }
    },

    ["mineur"] = { name = "mineur", label = "Mineur", grades = {
        ["0"] = { id = 151, job_name = "mineur", name = "mineur", grade = 0, label = "recrue", salary = 200 },
        }
    },

    ["jardinier"] = { name = "jardinier", label = "Jardinier", grades = {
        ["0"] = { id = 152, job_name = "jardinier", name = "jardinier", grade = 0, label = "recrue", salary = 200 },
        }
    },



    
    ["vigneron"] = { name = "vigneron", label = "Vigneron", grades = {
            ["0"] = { id = 105, job_name = "vigneron", name = "recrue", grade = 0, label = "Recrue", salary = 400 },
            ["1"] = { id = 106, job_name = "vigneron", name = "novice", grade = 1, label = "Experimenté", salary = 400 },
            ["2"] = { id = 107, job_name = "vigneron", name = "boss", grade = 2, label = "Patron", salary = 400 },
        }
    },
    ["joal"] = { name = "joal", label = "Joalerie", grades = {
        ["0"] = { id = 105, job_name = "joal", name = "recrue", grade = 0, label = "Recrue", salary = 400 },
        ["1"] = { id = 106, job_name = "joal", name = "novice", grade = 1, label = "Experimenté", salary = 400 },
        ["2"] = { id = 107, job_name = "joal", name = "boss", grade = 2, label = "Patron", salary = 400 },
    }
},
    ["kintaki"] = { name = "kintaki", label = "Kintaki", grades = {
        ["0"] = { id = 105, job_name = "kintaki", name = "recrue", grade = 0, label = "Recrue", salary = 400 },
        ["1"] = { id = 106, job_name = "kintaki", name = "novice", grade = 1, label = "Experimenté", salary = 400 },
        ["2"] = { id = 107, job_name = "kintaki", name = "boss", grade = 2, label = "Patron", salary = 400 },
        }
    },
    ["police"] = { name = "police", label = "LSPD", grades = {
            ["0"] = { id = 59, job_name = "police", name = "recruit", grade = 0, label = "Cadet", salary = 20 },
            ["1"] = { id = 60, job_name = "police", name = "officer", grade = 1, label = "Officier", salary = 20 },
            ["2"] = { id = 61, job_name = "police", name = "sergeant", grade = 2, label = "Sergeant", salary = 20 },
            ["3"] = { id = 63, job_name = "police", name = "lieutenant", grade = 3, label = "Lieutenant", salary = 20 },
            ["4"] = { id = 65, job_name = "police", name = "boss", grade = 4, label = "Commandant", salary = 20 },
        }
    },

    ["sheriff"] = { name = "sheriff", label = "BSCO", grades = {
        ["0"] = { id = 59, job_name = "sheriff", name = "recruit", grade = 0, label = "Cadet", salary = 20 },
        ["1"] = { id = 60, job_name = "sheriff", name = "officer", grade = 1, label = "Officier", salary = 20 },
        ["2"] = { id = 61, job_name = "sheriff", name = "sergeant", grade = 2, label = "Sergeant", salary = 20 },
        ["3"] = { id = 63, job_name = "sheriff", name = "lieutenant", grade = 3, label = "Lieutenant", salary = 20 },
        ["4"] = { id = 65, job_name = "sheriff", name = "boss", grade = 4, label = "Commandant", salary = 20 },
    }
},






















    ["ballas"] = { name = "ballas", label = "Ballas", grades = {
            ["0"] = { id = 115, job_name = "ballas", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
            ["1"] = { id = 116, job_name = "ballas", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
            ["2"] = { id = 117, job_name = "ballas", name = "capo", grade = 2, label = "Gerant", salary = 60 },
            ["3"] = { id = 118, job_name = "ballas", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
            ["4"] = { id = 119, job_name = "ballas", name = "boss", grade = 4, label = "Patron", salary = 100 },
        }
    },    
    ["families"] = { name = "families", label = "Families", grades = {
            ["0"] = { id = 125, job_name = "families", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
            ["1"] = { id = 126, job_name = "families", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
            ["2"] = { id = 127, job_name = "families", name = "capo", grade = 2, label = "Gerant", salary = 60 },
            ["3"] = { id = 128, job_name = "families", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
            ["4"] = { id = 129, job_name = "families", name = "boss", grade = 4, label = "Patron", salary = 100 },
        }
    },
    ["vagos"] = { name = "vagos", label = "Vagos", grades = {
            ["0"] = { id = 120, job_name = "vagos", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
            ["1"] = { id = 121, job_name = "vagos", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
            ["2"] = { id = 122, job_name = "vagos", name = "capo", grade = 2, label = "Gerant", salary = 60 },
            ["3"] = { id = 123, job_name = "vagos", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
            ["4"] = { id = 124, job_name = "vagos", name = "boss", grade = 4, label = "Patron", salary = 100 },
        }
    },
    ["crips"] = { name = "crips", label = "Crips", grades = {
            ["0"] = { id = 120, job_name = "crips", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
            ["1"] = { id = 121, job_name = "crips", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
            ["2"] = { id = 122, job_name = "crips", name = "capo", grade = 2, label = "Gerant", salary = 60 },
            ["3"] = { id = 123, job_name = "crips", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
            ["4"] = { id = 124, job_name = "crips", name = "boss", grade = 4, label = "Patron", salary = 100 },
        }
    },
    ["bloods"] = { name = "bloods", label = "Bloods", grades = {
            ["0"] = { id = 120, job_name = "bloods", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
            ["1"] = { id = 121, job_name = "bloods", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
            ["2"] = { id = 122, job_name = "bloods", name = "capo", grade = 2, label = "Gerant", salary = 60 },
            ["3"] = { id = 123, job_name = "bloods", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
            ["4"] = { id = 124, job_name = "bloods", name = "boss", grade = 4, label = "Patron", salary = 100 },
        }
    },   
    ["marabunta"] = { name = "marabunta", label = "Marabunta", grades = {
            ["0"] = { id = 120, job_name = "marabunta", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
            ["1"] = { id = 121, job_name = "marabunta", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
            ["2"] = { id = 122, job_name = "marabunta", name = "capo", grade = 2, label = "Gerant", salary = 60 },
            ["3"] = { id = 123, job_name = "marabunta", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
            ["4"] = { id = 124, job_name = "marabunta", name = "boss", grade = 4, label = "Patron", salary = 100 },
        }
    },







    ["jalisco"] = { name = "jalisco", label = "Jalisco", grades = {
        ["0"] = { id = 167, job_name = "jalisco", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
        ["1"] = { id = 168, job_name = "jalisco", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
        ["2"] = { id = 169, job_name = "jalisco", name = "capo", grade = 2, label = "Gerant", salary = 60 },
        ["3"] = { id = 170, job_name = "jalisco", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
        ["4"] = { id = 171, job_name = "jalisco", name = "boss", grade = 4, label = "Patron", salary = 100 },
    }    
    },

    ["armenien"] = { name = "armenien", label = "Mafia Arméniennes", grades = {
        ["0"] = { id = 167, job_name = "armenien", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
        ["1"] = { id = 168, job_name = "armenien", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
        ["2"] = { id = 169, job_name = "armenien", name = "capo", grade = 2, label = "Gerant", salary = 60 },
        ["3"] = { id = 170, job_name = "armenien", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
        ["4"] = { id = 171, job_name = "armenien", name = "boss", grade = 4, label = "Patron", salary = 100 },
    }
    },

    ["madrazo"] = { name = "madrazo", label = "Cartel De Madrazo", grades = {
        ["0"] = { id = 167, job_name = "madrazo", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
        ["1"] = { id = 168, job_name = "madrazo", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
        ["2"] = { id = 169, job_name = "madrazo", name = "capo", grade = 2, label = "Gerant", salary = 60 },
        ["3"] = { id = 170, job_name = "madrazo", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
        ["4"] = { id = 171, job_name = "madrazo", name = "boss", grade = 4, label = "Patron", salary = 100 },
    }
    },

    ["mocro"] = { name = "mocro", label = "Mocro Mafia", grades = {
        ["0"] = { id = 167, job_name = "mocro", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
        ["1"] = { id = 168, job_name = "mocro", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
        ["2"] = { id = 169, job_name = "mocro", name = "capo", grade = 2, label = "Gerant", salary = 60 },
        ["3"] = { id = 170, job_name = "mocro", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
        ["4"] = { id = 171, job_name = "mocro", name = "boss", grade = 4, label = "Patron", salary = 100 },
    }
    },

    ["medellin"] = { name = "medellin", label = "Cartel Medellin", grades = {
        ["0"] = { id = 167, job_name = "medellin", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
        ["1"] = { id = 168, job_name = "medellin", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
        ["2"] = { id = 169, job_name = "medellin", name = "capo", grade = 2, label = "Gerant", salary = 60 },
        ["3"] = { id = 170, job_name = "medellin", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
        ["4"] = { id = 171, job_name = "medellin", name = "boss", grade = 4, label = "Patron", salary = 100 },
    }
    },

    ["tijuana"] = { name = "tijuana", label = "Cartel Tijuana", grades = {
        ["0"] = { id = 167, job_name = "tijuana", name = "petitefrappe", grade = 0, label = "Recrue", salary = 20 },
        ["1"] = { id = 168, job_name = "tijuana", name = "grandefrappe", grade = 1, label = "Soldat", salary = 40 },
        ["2"] = { id = 169, job_name = "tijuana", name = "capo", grade = 2, label = "Gerant", salary = 60 },
        ["3"] = { id = 170, job_name = "tijuana", name = "bras-droit", grade = 3, label = "Bras droit", salary = 100 },
        ["4"] = { id = 171, job_name = "tijuana", name = "boss", grade = 4, label = "Patron", salary = 100 },
    }
    },





}



ESX.RegisteredCommands = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

MySQL.ready(function()
	ESX.RegistredPlayers = {}    

    MySQL.Async.fetchAll('SELECT * FROM users', {}, function(result)
		for k, v in pairs(result) do 
            ESX.RegistredPlayers[v.uuid] = v
        end
	end)
    
    
end)


RegisterServerEvent('esx:clientLog')
AddEventHandler('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[framework] [^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	ESX.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('esx:serverCallback', playerId, requestId, ...)
	end, ...)
end)
