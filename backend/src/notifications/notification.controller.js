const notificationService = require('./notification.service');
const notificationDTO = require('./dto/notification.dto');
const notificationMapper = require('./notification.mapper');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getNotificationsByUser = asyncHandler(async (req, res) => {
  const notifications = await notificationService.getNotificationsByUser(
    req.params.userId
  );

  return res.json(
    ApiResponse.success(
      notificationMapper.toNotificationListResponse(notifications)
    )
  );
});

const createNotification = asyncHandler(async (req, res) => {
  const dto = notificationDTO.toCreateDTO(req.body);

  const notification = await notificationService.createNotification(dto);

  return res.status(201).json(
    ApiResponse.success(
      notificationMapper.toNotificationResponse(notification),
      'Notificação criada com sucesso.'
    )
  );
});

const markNotificationAsRead = asyncHandler(async (req, res) => {
  const notification = await notificationService.markNotificationAsRead(
    req.params.id
  );

  if (!notification) {
    throw new NotFoundError('Notificação não encontrada.');
  }

  return res.json(
    ApiResponse.success(
      notificationMapper.toNotificationResponse(notification),
      'Notificação marcada como lida.'
    )
  );
});

const deleteNotification = asyncHandler(async (req, res) => {
  const notification = await notificationService.deleteNotification(
    req.params.id
  );

  if (!notification) {
    throw new NotFoundError('Notificação não encontrada.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Notificação removida com sucesso.'
    )
  );
});

module.exports = {
  getNotificationsByUser,
  createNotification,
  markNotificationAsRead,
  deleteNotification,
};