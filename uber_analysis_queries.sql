CREATE DATABASE	Uber;
USE Uber;

SELECT *	
FROM clients_uber;

SELECT *
FROM chauffeurs_uber;

SELECT *
FROM trajets_uber;

-- Identifying high-value "Eco" customers with low satisfaction scores
-- Goal: Target for quality improvement surveys.

SELECT *
FROM
	clients_uber
WHERE 
	depense_totale > 3000
    AND preferences = 'Eco'
    AND Evaluations_Chauffeurs < 3;
    
    
-- Screening English-speaking drivers for morning high-priority shifts
-- Target: International airport transfers.

SELECT *
FROM
	chauffeurs_uber
WHERE
	langues_parlees = 'Anglais'
    AND disponibilite = 'matin'
    AND evaluation > 4;
    
    
-- Analyzing difficult trips (long distance + high traffic + poor notes)
-- Goal: Root cause analysis of negative reviews.

SELECT *
FROM
	trajets_uber
WHERE
	distance > 20
    AND conditions_traffic = 'eleve'
    AND notes_client = 'mauvais';
    
    
-- Analyzing musical preferences specifically for UberBlack premium trips
-- Goal: Personalization of high-end services.

SELECT
	clients_uber.ID_client,
	preferences_musique
FROM
	clients_uber
    LEFT JOIN trajets_uber
    ON clients_uber.ID_Client = trajets_uber.ID_Client
WHERE
	type_trajet = 'uberblack';
    
    
-- Assessing driver ratings specifically during high traffic conditions
-- Goal: Reward drivers who maintain quality under stress.

SELECT
	C.ID_Chauffeur,
    Evaluation AS performance
FROM 
	chauffeurs_uber AS C
    LEFT JOIN trajets_uber AS T
    ON C.ID_chauffeur = T.ID_chauffeur
WHERE 
	conditions_traffic = 'eleve';
    
    
-- Trip distance comparison: Weekends vs Weekdays
-- Goal: Dynamic supply adjustment based on day-of-week demand.

SELECT
	CASE 
		WHEN DATE_FORMAT(Date_Heure,"%W") 
			IN ('saturday','sunday') 
			THEN 'Week-end'
			ELSE 'Semaine'
	END AS Type_jour,
	ROUND(AVG(distance),2) AS Distance_moy
FROM
	trajets_uber
GROUP BY
	Type_jour;
    
    
-- Average trip price correlated with Driver language skills
-- Goal: Determine if multilingual drivers generate higher revenue.

SELECT
	C.Langues_parlees,
    ROUND(AVG(T.Prix),2) AS Prix_moyen_trajets
FROM 
	chauffeurs_uber AS C
	LEFT JOIN trajets_uber AS T
    ON C.id_chauffeur = T.id_chauffeur
GROUP BY
	C.Langues_parlees
ORDER BY
	Prix_moyen_trajets DESC;
    
    
-- Segmenting customer base by loyalty level (Fidèles vs Occasionnels)
-- Strategy: Define retention rewards based on trip volume.

SELECT
	CASE 
		WHEN Nombre_trajets > 30
			 THEN 'Clients_fidèles'
			 ELSE 'Clients_occasionnels'
    END AS Catégorie_client,
    COUNT(*) AS NB_clients
FROM
	clients_uber
GROUP BY
	Catégorie_client;
    
    
-- Trip categorization by Price brackets
-- Distribution analysis: Low, Medium, and High fare volume.

SELECT
	CASE
		WHEN prix > 30 
        THEN 'eleve'
        WHEN prix BETWEEN 10 AND 30 THEN 'moyen'
        ELSE 'bas'
	END AS Categories_prix,
    COUNT(*) AS NB_de_trajets
FROM
	trajets_uber
GROUP BY
	Categories_prix
ORDER BY
	NB_de_trajets DESC;
    
    
-- Driver classification by experience (Beginner to Veteran)
-- Goal: Career path monitoring.

SELECT
	CASE
		WHEN Nombre_trajets > 150 
        THEN 'Vétéran'
        WHEN Nombre_trajets BETWEEN 50 AND 150 THEN 'Expérimenté'
        ELSE 'Débutant'
	END AS Categories_chauffeurs,
    ROUND(AVG(Evaluation),2) AS Evaluation_moyenne
FROM
	chauffeurs_uber
GROUP BY
	Categories_chauffeurs
ORDER BY
	Evaluation_moyenne DESC;
    
    
-- Payment method trends for active high-spending clients
-- Goal: Optimize payment processing and partnerships.

SELECT
	Moyen_paiement AS Mode_paiement_préféré,
    ROUND(AVG(Depense_totale),2) AS Montant_moy_dépensé
FROM
	clients_uber
WHERE
	Nombre_Trajets >= 10
    AND Depense_Totale > 500
GROUP BY
	Mode_paiement_préféré
ORDER BY
	Montant_moy_dépensé DESC;
    
    
-- Impact of traffic density on average distance for premium trips (>20€)

SELECT
	Conditions_traffic,
	ROUND(AVG(Distance),2) AS Distance_moyenne
FROM
	trajets_uber
WHERE 
	Prix > 20
GROUP BY
	Conditions_traffic
ORDER BY
	Distance_moyenne DESC;
    
    
-- Driver classification by experience 
-- Goal: Career path monitoring.

SELECT
	CASE
		WHEN Nombre_Trajets >= 100 
		THEN '100 trajets ou plus'
        ELSE 'moins de 100 trajets'
	END AS Catégories_chauffeurs,
    SUM(Nombre_trajets) AS Nb_total_trajets,
    ROUND(SUM(Distance_totale),2) AS Distance_totale,
    ROUND(AVG(Evaluation),2) AS Evaluation_moyenne
FROM
	chauffeurs_uber
GROUP BY
	Catégories_chauffeurs
ORDER BY
	Nb_total_trajets DESC;
    
    
-- Customer profiles based on total spending threshold (500€)
-- Goal: Understand average trip frequency per spending tier.

SELECT
	CASE
		WHEN
			Depense_Totale >= 500 
		THEN
			'500E_ou_plus_depensé'
		ELSE
			'Moins_de_500E_dépensé'
	END AS Catégories_client,
    ROUND(AVG(Nombre_trajets),2) AS Nb_moyen_de_trajets,
    ROUND(AVG(Depense_Totale),2) AS Dépense_moyenne
FROM
	clients_uber
GROUP BY
	Catégories_client
ORDER BY
	Nb_moyen_de_trajets DESC;
    
    
-- Analysing Driver Performance & Revenue Generation
-- Goal: Correlate driver ratings (High/Medium/Low) with their revenue impact.

SELECT
	CASE
		WHEN
			C.Evaluation > 4 
		THEN
			'Eleve'
		WHEN
			C.Evaluation BETWEEN 3 AND 4
		THEN
			'Moyenne'
		ELSE
			'Faible'
	END AS Catégories_performance,
    COUNT(*) AS Nb_par_categories,
    ROUND(AVG(T.prix),2) AS Revenu_moy_trajets,
    SUM(C.Nombre_Trajets) AS Nb_trajets,
    ROUND(SUM(Revenu_total),2) AS Revenu_total
FROM
	chauffeurs_uber AS C
    LEFT JOIN trajets_uber AS T
    ON C.ID_chauffeur = T.ID_chauffeur
WHERE
	C.Nombre_trajets > 50
GROUP BY
	Catégories_performance
HAVING
	Nb_par_categories > 10
ORDER BY
	Revenu_total DESC;
	
    
-- Analyzing the impact of Music Preferences on Driver Ratings
-- Goal: Enhance customer/driver matching algorithm.

SELECT
	C.preferences_musique AS Préférence_musique,
    ROUND(SUM(C.Nombre_trajets),2) AS Nb_de_trajets,
    ROUND(AVG(C.evaluations_chauffeurs),2) AS Evaluation_moyenne_chauffeurs,
    ROUND(AVG(T.prix),2) AS Revenu_moyen_par_trajet
FROM
	clients_uber AS C
    LEFT JOIN trajets_uber AS T
    ON C.ID_client = T.ID_client
GROUP BY
	Préférence_musique
ORDER BY
	Evaluation_moyenne_chauffeurs DESC;
    
    
-- Correlation between Security Training and driver ratings
-- Goal: Verify the ROI of safety certifications.

SELECT
	Formation_securite,
	CASE
		WHEN
			Evaluation > 4 
		THEN
			'Haute'
		WHEN
			Evaluation BETWEEN 3 AND 4
		THEN 
			'Moyenne'
		ELSE 'Faible'
	END AS Catégories_evaluation_moyenne,
    ROUND(AVG(Evaluation),2) AS Evaluation_moyenne,
    SUM(Nombre_trajets) AS Nb_Total_trajets
FROM
	chauffeurs_uber
GROUP BY
	formation_securite,
	Catégories_evaluation_moyenne
ORDER BY
	formation_securite ASC,
	Evaluation_moyenne;
    
    
-- Strategic Monthly Performance Report (Year 2023)
-- Metrics: Revenue, Distance, and Ratings per Trip Type.

SELECT
	DATE_FORMAT(T.Date_heure,"%b") AS Months,
	T.Type_trajet AS Type_trajet,
	COUNT(T.ID_trajet) AS Nb_Total_trajets,
    ROUND(SUM(T.prix),2) AS Revenu_total,
    ROUND(AVG(T.Distance),2) AS Distance_moyenne,
    ROUND(AVG(C.Evaluation),2) AS Evaluation_moyenne
FROM
	Trajets_Uber AS T
    LEFT JOIN Chauffeurs_uber AS C
    ON T.ID_chauffeur = C.ID_chauffeur
WHERE 
	YEAR(T.Date_Heure)='2023'
GROUP BY
	Months,
	Type_trajet
ORDER BY
	Months DESC;
	
     
    



  

	
	
    

    
    




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



