var express = require('express');
var router = express.Router();

var User = require('../models/User');

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('get in users');
});

router.get('/getAllUsers', function(req, res, next){
  User.find({}, function(err, users){
    if(err){
      console.log(err);
      return res.status(400).send("err in get all users");
    } else{
      return res.status(200).json(users);
    }
  });
});

router.get('/user/:account/:password', function(req, res, next){
    var account = req.params.account;
    var password = req.params.password;

    console.log("account: "+account);
    console.log("password: "+password);

    User.find({account: account}, function(err, user){
      if(err){
        console.log(err);
        return res.status(400).json(err);
      } else {
        console.log(user[0]);
        if(user[0]){
          if(user[0].password == password){
            return res.status(200).json(user[0]);
          } else {
            return res.status(300).send("err in incorrect password")
          }
        } else {
          return res.status(250).send("err in inexistent account")
        }
      }
    });
});

router.post('/user/:account/:password', function(req, res, next){
  var account = req.params.account;
  var password = req.params.password;

  if(!account || !password){
    return res.status(300).send("err in post user");
  }

  console.log("account: "+account);
  console.log("password: "+password);
  User.create({account: account, password: password}, function(err, user){
    if(err){
      return res.status(400).json(err);
      //return res.status(400).send("err in post existent user");
    } else{
      return res.status(200).json(user);
    }
  });
});

router.put('/user/:account/:password', function(req, res, next){
  var account = req.params.account;
  var password = req.params.password;
  console.log("Modify password of "+account);
  User.findOneAndUpdate({account: account}, {'$set':{password: password}},
  function(err, docs){
    if(err){
      return res.status(400).send("err in modify password of user");
    } else if(docs){
      return res.status(200).json(docs);
    } else {
      return res.status(300).send("err in modify password of non-existent user")
    }
  });
});

router.put('/userRssSource/:account/:title/:urlString', function(req, res, next){
  var account = req.params.account;
  var title = req.params.title;
  var urlString = req.params.urlString;
  if(!account || !title || !urlString){
    return res.status(300).send("err in add rssSource");
  }

  User.findOneAndUpdate({account: account},
    {'$addToSet': {rssSources: {title: title, urlString: urlString}}},
  function(err, docs){
    if(err){
      return res.status(400).send("err in add rssSource to user");
    } else if(docs){
      return res.status(200).json("succeed in add RssSource "+ title+" to User: "+account);
    } else{
      return res.status(350).send("err in add rssSource to non-existent user");
    }
  });
});

router.delete('/userRssSource/:account/:title', function(req, res, next){
  var account = req.params.account;
  var title = req.params.title;
  if(!account || !title){
    return res.status(300).send("err in delete rssSource");
  }

  User.findOneAndUpdate({account: account},
    {'$pull': {rssSources: {title: title}}},
    function(err, docs){
    if(err){
      return res.status(400).send("err in delete rssSource of user");
    } else if(docs){
      return res.status(200).send("succeed in delete RssSource"+title+" to User"+account);
    } else{
      return res.status(350).send("err in delete rssSource to non-existent user");
    }
  });
});

router.delete('/deleteAllUsers', function(req, res, next){
  User.remove({}, function(err, result){
    if(err) {
      console.log(err);
      return res.status(400).send("err in delete all Users");
    } else{
      console.log("delete all Users");
      return res.status(200).send("succeed in delete all Users");
    }
  });
});

module.exports = router;
