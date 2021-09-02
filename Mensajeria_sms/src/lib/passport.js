const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('./helpers');


passport.use('local.add', new LocalStrategy({
    usernameField: 'NombreUsuario',
    passwordField: 'Password',
    passReqToCallback: true
  }, async (req, NombreUsuario, Password, done) => {
  
    const {NombreCliente} = req.body;
    const {Tipo} = req.body;
    const {Direccion} = req.body;
    const {NumeroTelefono} = req.body;
    const {Ruc} = req.body;
    const {Correo} = req.body;
    const {FechaNacimiento} = req.body;

    let newUser = {
      NombreCliente,
      Tipo,
      Direccion,
      NumeroTelefono,
      Ruc,
      Correo,
      FechaNacimiento,
      NombreUsuario,
      Password
    };
    console.log(req.body);
    newUser.Password = await helpers.encryptPassword(Password);
      // Saving in the Database
      const result = await pool.query('INSERT INTO usuarios SET ? ', newUser);
      newUser.idUsuarios = result.insertId;
      return done(null, newUser);
    }));

passport.use('local.signin', new LocalStrategy({
  usernameField: 'NombreUsuario',
  passwordField: 'Password',
  passReqToCallback: true
}, async (req, NombreUsuario, Password, done) => {
  const rows = await pool.query('SELECT * FROM usuarios WHERE NombreUsuario = ?', [NombreUsuario]);
  if (rows.length > 0) {
    const user = rows[0];
    const validPassword = await helpers.matchPassword(Password, user.Password)
    if (validPassword) {
      done(null, user, req.flash('success', 'Welcome ' + user.NombreUsuario));
    } else {
      done(null, false, req.flash('message', 'Incorrect Password'));
    }
  } else {
    return done(null, false, req.flash('message', 'El usuario no existe.'));
  }
}));

passport.use('local.Cliadd', new LocalStrategy({
  usernameField: 'NombreUsuario',
  passwordField: 'Password',
  passReqToCallback: true
}, async (req, NombreUsuario, Password, done) => {

  const {NombreCliente} = req.body;
  const {Tipo} = req.body;
  const {Direccion} = req.body;
  const {NumeroTelefono} = req.body;
  const {Ruc} = req.body;
  const {Correo} = req.body;
  const {FechaNacimiento} = req.body;

  let newUser = {
    NombreCliente,
    Tipo,
    Direccion,
    NumeroTelefono,
    Ruc,
    Correo,
    FechaNacimiento,
    NombreUsuario,
    Password
  };
  console.log(req.body);
  newUser.Password = await helpers.encryptPassword(Password);
    // Saving in the Database
    const result = await pool.query('INSERT INTO clientes SET ? ', newUser);
    newUser.idClientes = result.insertId;
    return done(null, newUser);
  }));

passport.serializeUser((user, done) => {
  done(null, user.idUsuarios);
});

passport.serializeUser((user, done) => {
  done(null, user.idClientes);
});

// passport.deserializeUser(async(idUsuarios, done)=> {
//   await pool.query("SELECT * FROM database_sms.usuarios WHERE idUsuarios ='"+[idUsuarios]+"';",(err,rows,filds)=>{
//     if(!err){
//       console.log(rows[0])
//       done(null,rows[0])
//     }else{
//       console.log("Error en deserealizador consulta" +err)
//     }
//   })
// done(null,idUsuarios)
// });

passport.deserializeUser(async (idUsuarios, done) => {
  const rows = await pool.query('SELECT * FROM database_sms.usuarios WHERE idUsuarios = ?', [idUsuarios]);
  done(null, rows[0]);
});

passport.deserializeUser(async (idClientes, done) => {
  const rows = await pool.query('SELECT * FROM database_sms.clientes WHERE idClientes = ?', [idClientes]);
  done(null, rows[0]);
});

