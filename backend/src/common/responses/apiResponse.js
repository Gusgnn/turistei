class ApiResponse {
  static success(data = null, message = null) {
    return {
      success: true,
      message,
      data,
    };
  }

  static error(message, errors = null) {
    return {
      success: false,
      message,
      errors,
    };
  }
}

module.exports = ApiResponse;