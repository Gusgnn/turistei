function paginate(array, page = 1, limit = 10) {
  const start = (page - 1) * limit;
  const end = start + limit;

  return {
    page,
    limit,
    total: array.length,
    data: array.slice(start, end),
  };
}

module.exports = {
  paginate,
};