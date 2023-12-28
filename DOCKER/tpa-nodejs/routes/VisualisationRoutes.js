import express from 'express'
import {
    getAllMarqueAndNbVehicle,
    getCouleursParMarque, getPrixParMarque, getPuissanceParMarque,
    getVentesParMarque
} from "../controller/VisualisationController.js";

const router = express.Router()
const defaultRoute = '/api'

router.get(`${defaultRoute}/getAllMarque`, getAllMarqueAndNbVehicle)

router.get(`${defaultRoute}/ventes-par-marque/:marque`, getVentesParMarque)
router.get(`${defaultRoute}/prix-par-marque/:marque`, getPrixParMarque)
router.get(`${defaultRoute}/couleurs-par-marque/:marque`, getCouleursParMarque)
router.get(`${defaultRoute}/puissance-par-marque/:marque`, getPuissanceParMarque)

export default router