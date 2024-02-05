// constants
const {
  express,
  app,
  port,
  server,
  cors,
  database,
} = require("./Constants/Imports");

// constants
app.use(express.json());
app.use(cors());
app.use(express.static("public"));

// routes
app.use("/user/api/", require("./Routes/UserRoutes"));

// database connection
database();

// server listen
server.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
