
CREATE VIEW ALL_PLAYERS AS
SELECT 
    p.pseudo AS nom_joueur,
    COUNT(DISTINCT pp.id_party) AS nombre_de_parties,
    COUNT(pa.id_turn) AS nombre_de_tours,
    MIN(pp.date_de_participation) AS premiere_participation,
    MAX(pa.end_time) AS derniere_action
FROM players p
JOIN party_players pp ON p.id_player = pp.id_player
JOIN player_actions pa ON pp.id_party = pa.id_turn AND pp.id_player = pa.id_player
GROUP BY p.pseudo
ORDER BY nombre_de_parties DESC, premiere_participation;

CREATE VIEW ALL_PLAYERS_ELAPSED_GAME AS
SELECT 
    p.pseudo AS nom_joueur,
    pt.title_party AS nom_partie,
    COUNT(pp.id_player) AS nombre_de_participants,
    MIN(pa.start_time) AS premiere_action,
    MAX(pa.end_time) AS derniere_action,
    DATEDIFF(SECOND, MIN(pa.start_time), MAX(pa.end_time)) AS nb_secondes_passées
FROM players p
JOIN party_players pp ON p.id_player = pp.id_player
JOIN parties pt ON pp.id_party = pt.id_party
JOIN player_actions pa ON pp.id_party = pa.id_turn AND pp.id_player = pa.id_player
GROUP BY p.pseudo, pt.title_party;

CREATE VIEW ALL_PLAYERS_ELAPSED_TOUR AS
SELECT 
    p.pseudo AS nom_joueur,
    pt.title_party AS nom_partie,
    t.id_turn AS numero_du_tour,
    t.start_time AS debut_du_tour,
    pa.end_time AS prise_de_decision,
    DATEDIFF(SECOND, t.start_time, pa.end_time) AS nb_secondes_passées
FROM players p
JOIN party_players pp ON p.id_player = pp.id_player
JOIN turns t ON pp.id_party = t.id_party
JOIN player_actions pa ON pp.id_party = pa.id_turn AND pp.id_player = pa.id_player
ORDER BY p.pseudo, pt.title_party, t.id_turn;

CREATE VIEW ALL_PLAYERS_STATS AS
SELECT 
    p.pseudo AS nom_joueur,
    CASE 
        WHEN pp.id_role = 1 THEN 'Loup'
        ELSE 'Villageois' 
    END AS role_joueur,
    pt.title_party AS nom_partie,
    COUNT(pa.id_turn) AS nb_tours_joués,
    COUNT(t.id_turn) AS nb_tours_total,
    CASE 
        WHEN pp.id_role = 1 THEN 'Loup'
        ELSE 'Villageois'
    END AS vainqueur_role,
    AVG(DATEDIFF(SECOND, t.start_time, pa.end_time)) AS temps_moyen_prise_decision
FROM players p
JOIN party_players pp ON p.id_player = pp.id_player
JOIN player_actions pa ON pp.id_party = pa.id_turn AND pp.id_player = pa.id_player
JOIN turns t ON pa.id_turn = t.id_turn
JOIN parties pt ON pp.id_party = pt.id_party
GROUP BY p.pseudo, pp.id_role, pt.title_party;
