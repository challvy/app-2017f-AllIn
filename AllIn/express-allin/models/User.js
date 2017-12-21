var mongoose = require('mongoose');

var UserSchema = new mongoose.Schema({
  account: {
    type: String,
    unique: true
  },
  password: String,
  rssSources: [{
    title: String,
    urlString: String
  }]
});

module.exports = mongoose.model("User", UserSchema);
