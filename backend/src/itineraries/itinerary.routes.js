/**
 * @swagger
 * tags:
 *   name: Itineraries
 *   description: Gerenciamento de roteiros
 */

const express = require('express');

const controller = require('./itinerary.controller');

const {
  validateId,
  validateUserId,
  validateCreate,
  validateAddPlace,
  validateRemovePlace,
  validateUpdatePlaceOrder,
} = require('./itinerary.validation');

const router = express.Router();

router.get('/user/:userId', validateUserId, controller.getByUser);

router.get('/:id/places', validateId, controller.getPlaces);

router.get('/:id', validateId, controller.getById);

router.post('/', validateCreate, controller.create);

router.post('/places', validateAddPlace, controller.addPlace);

router.patch(
  '/places/order',
  validateUpdatePlaceOrder,
  controller.updatePlaceOrder
);

router.put('/:id', validateId, controller.update);

router.delete('/:id', validateId, controller.remove);

router.delete(
  '/:roteiroId/places/:localId',
  validateRemovePlace,
  controller.removePlace
);

module.exports = router;