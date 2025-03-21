
CREATE FUNCTION random_position(@lignes INT, @colonnes INT)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @ligne INT, @colonne INT;
    SET @ligne = FLOOR(RAND() * @lignes) + 1;
    SET @colonne = FLOOR(RAND() * @colonnes) + 1;
    RETURN CONCAT(@ligne, '-', @colonne);
END;

CREATE FUNCTION random_role()
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @role VARCHAR(10);
    IF (SELECT COUNT(*) FROM party_players WHERE id_role = 1) < 10
    BEGIN
        SET @role = 'Loup';
    END
    ELSE
    BEGIN
        SET @role = 'Villageois';
    END
    RETURN @role;
END;

CREATE FUNCTION get_the_winner(@partyid INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.pseudo AS nom_joueur,
        pp.id_role AS role,
        pt.title_party AS nom_partie,
        COUNT(pa.id_turn) AS nb_tours_joués,
        COUNT(t.id_turn) AS nb_tours_total,
        AVG(DATEDIFF(SECOND, t.start_time, pa.end_time)) AS temps_moyen_prise_decision
    FROM players p
    JOIN party_players pp ON p.id_player = pp.id_player
    JOIN player_actions pa ON pp.id_party = pa.id_turn AND pp.id_player = pa.id_player
    JOIN turns t ON pa.id_turn = t.id_turn
    JOIN parties pt ON pp.id_party = pt.id_party
    WHERE pt.id_party = @partyid
    GROUP BY p.pseudo, pp.id_role, pt.title_party
);
