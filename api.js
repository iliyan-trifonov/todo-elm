var jsonServer = require('json-server');
var server = jsonServer.create();
var router = jsonServer.router('db.json');

server.use(jsonServer.defaults());

server.use('/todos/completed', function (req, res, next) {
  if (req.method === 'DELETE') {
    var db = router.db;
    var todos = db
      .get('todos')
      .remove({ done: true })
      .value();
    return res.jsonp(todos);
  } else {
    next();
  }
});

server.use(router);

console.log('JSON server API listening at http://localhost:4000');
server.listen(4000);
