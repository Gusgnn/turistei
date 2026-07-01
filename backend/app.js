const express = require('express');
const cors = require('cors');
const path = require('path');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./src/config/swagger');

const placeRoutes = require('./src/places/place.routes');
const categoryRoutes = require('./src/categories/category.routes');
const userRoutes = require('./src/users/user.routes');

const errorHandler = require('./src/common/middleware/errorHandler');
const authRoutes = require('./src/auth/auth.routes');
const favoriteRoutes = require('./src/favorites/favorite.routes');
const reviewRoutes = require('./src/reviews/review.routes');
const eventRoutes = require('./src/events/event.routes');
const notificationRoutes = require('./src/notifications/notification.routes');
const itineraryRoutes = require('./src/itineraries/itinerary.routes');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.use(
  '/api/docs',
  swaggerUi.serve,
  swaggerUi.setup(swaggerSpec)
);

app.get('/', (req, res) => {
  res.json({
    success: true,
    message: 'API Turistei funcionando!',
  });
});

app.use('/api/places', placeRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/users', userRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/favorites', favoriteRoutes);
app.use('/api/reviews', reviewRoutes);
app.use('/api/events', eventRoutes);
app.use('/api/notifications', notificationRoutes);
app.use('/api/itineraries', itineraryRoutes);

app.use(errorHandler);

module.exports = app;