const express = require("express");
const app = express();

app.get("/:statusCode", (req, res) => {
  const statusCode = Number(req.params.statusCode) || 200;

  console.log("requested", { statusCode });

  res.status(statusCode).json({ status: statusCode });
});

const port = 443;

app.listen(port, () => {
  console.log(`running on port :${port}`);
});
