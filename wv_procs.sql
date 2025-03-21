
CREATE PROCEDURE SEED_DATA(@NB_PLAYERS INT, @PARTY_ID INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @NB_PLAYERS
    BEGIN
        INSERT INTO player_actions(id_turn, id_player) VALUES (@PARTY_ID, @i);
        SET @i = @i + 1;
    END
END;

CREATE PROCEDURE COMPLETE_TOUR(@TOUR_ID INT, @PARTY_ID INT)
AS
BEGIN
    -- Appliquer les déplacements des joueurs ici
    -- Par exemple, résoudre les conflits d'emplacement ou les éliminations
END;

CREATE PROCEDURE USERNAME_TO_LOWER()
AS
BEGIN
    UPDATE players SET pseudo = LOWER(pseudo);
END;
