
CREATE TABLE parties (
    id_party INT PRIMARY KEY,
    title_party VARCHAR(255) NOT NULL
);

CREATE TABLE roles (
    id_role INT PRIMARY KEY,
    description_role VARCHAR(255) NOT NULL
);

CREATE TABLE players (
    id_player INT PRIMARY KEY,
    pseudo VARCHAR(255) NOT NULL
);

CREATE TABLE party_players (
    id_party INT,
    id_player INT,
    id_role INT,
    is_alive CHAR(1) NOT NULL CHECK (is_alive IN ('Y', 'N')),
    PRIMARY KEY (id_party, id_player),
    FOREIGN KEY (id_party) REFERENCES parties(id_party),
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

CREATE TABLE turns (
    id_turn INT PRIMARY KEY,
    id_party INT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (id_party) REFERENCES parties(id_party)
);

CREATE TABLE player_actions (
    id_player INT,
    id_turn INT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    action VARCHAR(10) NOT NULL,
    origin_position_col INT NOT NULL,
    origin_position_row INT NOT NULL,
    target_position_col INT NOT NULL,
    target_position_row INT NOT NULL,
    PRIMARY KEY (id_player, id_turn),
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_turn) REFERENCES turns(id_turn)
);
