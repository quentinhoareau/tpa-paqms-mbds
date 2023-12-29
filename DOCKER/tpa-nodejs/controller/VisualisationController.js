import {PrismaClient} from '@prisma/client'

const prisma = new PrismaClient()

/**
 * Fonction qui permet de récupérer le nombre de véhicule par marque
 * Sous la forme :
 * [
 * {
 * "marque": "Audi",
 * "_count": {
 * "marque": 1
 * }
 * },
 * {
 * "marque": "BMW",
 * "_count": {
 * "marque": 1
 * }
 * ]
 */
export const getAllMarqueAndNbVehicle = async (req, res) => {
    try {
        const nbVehicleByMarque = await prisma.catalogue.groupBy({
            by: ['marque'],
            _count: {
                marque: true
            }
        })
        const marques = nbVehicleByMarque.map((marque) => marque.marque);
        const nbVehicles = nbVehicleByMarque.map((marque) => marque._count.marque);

        const associatedMarque = marques.map((marque, index) => {
            return {
                nom: marque,
                nbVehicles: nbVehicles[index]
            }
        })

        res.json(associatedMarque)
    } catch (error) {
        res.json({ error: error.message })
    }
}

export const getVentesParMarque = async (req, res) => {
    try {
        const { marque } = req.params;

        const models = await prisma.catalogue.findMany({
            where: {
                marque: marque
            },
            distinct: ['nom'],
            select: {
                nom: true,
            }
        });

        const nbVentesByModel = await Promise.all(models.map(async (model) => {
            const value = await prisma.immatriculations.count({
                where: {
                    marque: marque,
                    nom: model.nom
                }
            });
            return { nom: model.nom, nbVentes: value };
        }));

        res.json(nbVentesByModel);
    } catch (error) {
        res.json({ error: error.message });
    }
};

export const getPrixParMarque = async (req, res) => {
    try {
        const { marque } = req.params
        const prixParMarque = await prisma.catalogue.findMany({
            where: {
                marque: marque
            },
            distinct: ['nom'],
            select: {
                nom: true,
                prix: true
            }
        })
        const models = prixParMarque.map((prix) => prix.nom);
        const prices = prixParMarque.map((prix) => prix.prix);

        const associateModeleAndPrice = models.map((modele, index) => {
            return {
                nom: modele,
                prix: prices[index]
            }
        });

        res.json(associateModeleAndPrice)
    } catch (error) {
        res.json({ error: error.message })
    }
}

export const getCouleursParMarque = async (req, res) => {
    try {
        const { marque } = req.params
        const couleursParMarque = await prisma.catalogue.findMany({
            where: {
                marque: marque
            }
        })
        const allColorsUnique = [...new Set(couleursParMarque.map((couleur) => couleur.couleur))];
        let nbPersonByColors = [];

        for (let couleur of allColorsUnique) {
            const nbPerson = await prisma.immatriculations.count({
                where: {
                    marque: marque,
                    couleur: couleur
                }
            });
            nbPersonByColors.push({couleur: couleur, nbPerson: nbPerson});
        }

        res.json(nbPersonByColors)
    } catch (error) {
        res.json({ error: error.message })
    }
}

export const getPuissanceParMarque = async (req, res) => {
    try {
        const { marque } = req.params
        const puissanceParMarque = await prisma.catalogue.findMany({
            where: {
                marque: marque
            },
            distinct: ['nom'],
            select: {
                nom: true,
                puissance: true
            }
        })
        const models = puissanceParMarque.map((puissance) => puissance.nom);
        const powers = puissanceParMarque.map((puissance) => puissance.puissance);

        const associateModeleAndPower = models.map((modele, index) => {
            return {
                nom: modele,
                horsePower: powers[index]
            }
        });

        res.json(associateModeleAndPower)
    } catch (error) {
        res.json({ error: error.message })
    }
}
