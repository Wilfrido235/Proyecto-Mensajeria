const express = require('express');
const router = express.Router();

const passport = require('passport');
const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

// add
router.get('/add', (req, res) => {
  res.render('Usuarios/add');
});
router.post('/add', passport.authenticate('local.add', {
  successRedirect: '/profile',
  failureRedirect: '/add',
  failureFlash: true
}));

// SINGIN
router.get('/signin', (req, res) => {
  res.render('auth/signin');
});

router.post('/signin', (req, res, next) => {
  req.check('NombreUsuario', 'Username is Required').notEmpty();
  req.check('Password', 'Password is Required').notEmpty();
  const errors = req.validationErrors();
  if (errors.length > 0) {
    req.flash('message', errors[0].msg);
    res.redirect('/signin');
  }
  passport.authenticate('local.signin', {
    successRedirect: '/profile',
    failureRedirect: '/signin',
    failureFlash: true
  })(req, res, next);
  
});

router.get('/logout', (req, res) => {
  req.logOut();
  res.redirect('/');
});

router.get('/profile', isLoggedIn, (req, res) => {
  res.render('profile');
});
// //guardar una imagen 
// router.post('profileimg',async(req,res)=>{
//   const{nimetype,filename,path}=req.file;
//   console.log("las"+nimetype,filename,path)
//   // limite1
//   await pool.query("SELECT idUusario FROM usuarios ORDER BY idUsuarios desc;",(err,rows,filds)=>{
//     if(!err){
//       let idUltimoUsr;
//       for(const[p,v]of Object.entries(rows[0])){
//         idUltimoUsr=v;
//       }
//       pool.query("INSERT INTO 'database_sms','FotosUsuario'('idUusuario','NombreFoto','Data','Type')VALUES('"+[idUltimoUsr]+"','
//         if(!err){
//           req.flash
//           res.send
//           console.log('Se guardo la image correctamente')
//         }else{
//           console.log("No se guardo la image correctamente"+err)
//         }
//     })
//   }else{
//     console.log("Error al obteber el ultimo usuario para asignarle la imagen"+err)
//   }
// });

module.exports = router;
