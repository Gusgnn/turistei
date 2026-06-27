function toNotificationResponse(notification) {
  return {
    id: notification.id,
    usuarioId: notification.usuario_id,
    titulo: notification.titulo,
    mensagem: notification.mensagem,
    lida: notification.lida,
    criadoEm: notification.criado_em,
  };
}

function toNotificationListResponse(notifications) {
  return notifications.map(toNotificationResponse);
}

module.exports = {
  toNotificationResponse,
  toNotificationListResponse,
};