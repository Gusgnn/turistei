function toNumber(value) {
  if (
    value === undefined ||
    value === null ||
    value === ''
  ) {
    return undefined;
  }

  return Number(value);
}

module.exports = {
  toNumber,
};