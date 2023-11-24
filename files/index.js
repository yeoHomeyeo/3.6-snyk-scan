module.exports.handler = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify(
    {
        message: "Welcome to Group 1",
    },
    null,
    2
    ),
  };
};