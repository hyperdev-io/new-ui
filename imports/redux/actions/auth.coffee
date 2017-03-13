module.exports =
  loginRequest: (username, password)->
    type: 'LoginRequest'
    username: username
    password: password
