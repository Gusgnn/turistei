const notificationRepository = require('./notification.repository');

async function getNotificationsByUser(userId) {
  return await notificationRepository.findByUserId(userId);
}

async function createNotification(notification) {
  return await notificationRepository.create(notification);
}

async function markNotificationAsRead(id) {
  return await notificationRepository.markAsRead(id);
}

async function deleteNotification(id) {
  return await notificationRepository.remove(id);
}

module.exports = {
  getNotificationsByUser,
  createNotification,
  markNotificationAsRead,
  deleteNotification,
};