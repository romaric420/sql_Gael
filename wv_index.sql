
CREATE INDEX idx_joueur_partie ON party_players(id_player, id_party);
CREATE INDEX idx_tours_partie_joueur ON player_actions(id_turn, id_player);
CREATE INDEX idx_parties_nom ON parties(title_party);
