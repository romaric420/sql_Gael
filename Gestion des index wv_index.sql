
-- Création des index pour optimiser les requêtes sur les joueurs et les tours

-- Index sur le joueur pour améliorer les recherches de joueurs par partie
CREATE INDEX idx_joueur_partie ON parties_joueurs(joueur_id, partie_id);

-- Index sur les tours pour accélérer les recherches sur les tours
CREATE INDEX idx_tours_partie_joueur ON tours(partie_id, joueur_id);

-- Index sur les parties pour améliorer l'accès aux parties spécifiques
CREATE INDEX idx_parties_nom ON parties(nom);
