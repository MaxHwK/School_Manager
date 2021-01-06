CREATE VIEW vue_inscrit
AS(
    SELECT id, civ, nom, prenom, adresse, cp, ville, telephone, portable, mel
    FROM etudiant
);