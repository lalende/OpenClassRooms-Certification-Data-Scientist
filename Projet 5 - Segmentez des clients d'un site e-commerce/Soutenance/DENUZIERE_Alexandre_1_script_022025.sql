/*
Date la plus récente de la table orders pour effectuer les tests des requêtes
2018-10-17 17:30:18
*/
SELECT MAX(order_purchase_timestamp)
FROM orders

/*
Date la plus récente de la table order_reviews pour effectuer les tests des requêtes
2018-08-31 00:00:00
*/
SELECT MAX(review_creation_date)
FROM order_reviews

/*
En excluant les commandes annulées, quelles sont les commandes
récentes de moins de 3 mois que les clients ont reçues avec au moins 3
jours de retard ?
*/
SELECT 
    order_id,
    customer_id,
    JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date) AS retard_livraison 
FROM
    orders
WHERE 
    order_status != "canceled"  
AND 
    order_purchase_timestamp >= DATE('2018-10-17 17:30:18', '-3 months')
AND 
    retard_livraison > 3
ORDER BY 
    retard_livraison DESC

/*
Qui sont les vendeurs ayant généré un chiffre d'affaires de plus de 100 000 
Real sur des commandes livrées via Olist ?
*/
SELECT 
    seller_id, 
    SUM(price) AS chiffre_affaire
FROM 
    order_items
GROUP BY 
    seller_id
HAVING 
    chiffre_affaire > 100000
ORDER BY 
    chiffre_affaire DESC

/*
Qui sont les nouveaux vendeurs (moins de 3 mois d'ancienneté) qui
sont déjà très engagés avec la plateforme (ayant déjà vendu plus de 30
produits) ?
*/
SELECT 
    order_items.seller_id, 
    MIN(orders.order_purchase_timestamp) AS premiere_vente,
    count(order_items.product_id) AS nombre_produits_vendus
FROM 
    order_items, 
    orders
WHERE 
    order_items.order_id = orders.order_id
GROUP BY 
    order_items.seller_id
HAVING 
    premiere_vente >= DATE('2018-10-17 17:30:18', '-3 months')
AND 
    nombre_produits_vendus > 30

/*
Quels sont les 5 codes postaux, enregistrant plus de 30
reviews, avec le pire review score moyen sur les 12 derniers mois ?
*/
SELECT 
    AVG(order_reviews.review_score) AS score_moyen,
    COUNT(order_reviews.review_creation_date) AS nombre_commentaire,
    customers.customer_zip_code_prefix AS code_postal
FROM 
    customers,
    order_reviews,
    orders
WHERE 
    order_reviews.order_id = orders.order_id
AND
    orders.customer_id = customers.customer_id
AND 
    order_reviews.review_creation_date >= DATE('2018-08-31 00:00:00', '-12 months')
GROUP BY code_postal
HAVING nombre_commentaire > 30
ORDER BY score_moyen ASC
LIMIT 5
