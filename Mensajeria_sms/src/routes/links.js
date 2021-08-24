const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', (req, res) => {
    res.render('Usuarios/add');
});

router.post('/add', async (req, res) => {
    const {  NombreCliente,NombreUsuario,Password,FechaNacimiento,Tipo,Direccion,NumeroTelefono,Ruc,Correo } = req.body;
    const newLink = {
        NombreCliente,
        NombreUsuario,
        Password,
        FechaNacimiento,
        Tipo,
        Direccion,
        NumeroTelefono,
        Ruc,
        Correo,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO usuarios set ?', [newLink]);
    req.flash('success', 'usuarios Saved Successfully');
    res.redirect('/Usuarios');
});

router.get('/', isLoggedIn, async (req, res) => {
    const Usuarios = await pool.query('SELECT * FROM usuarios WHERE idUsuarios = ?', [req.user.idUsuarios]);
    res.render('Usuarios/list', { Usuarios });
});

router.get('/delete/:idUsuarios', async (req, res) => {
    const { idUsuarios } = req.params;
    await pool.query('DELETE FROM usuarios WHERE idUsuarios = ?', [idUsuarios]);
    req.flash('success', 'User Removed Successfully');
    res.redirect('/Usuarios');
});

router.get('/edit/:idUsuarios', async (req, res) => {
    const { idUsuarios } = req.params;
    const Usuarios = await pool.query('SELECT * FROM usuarios WHERE idUsuarios = ?', [idUsuarios]);
    console.log(Usuarios);
    res.render('Usuarios/edit', {link: Usuarios[0]});
});

router.post('/edit/:idUsuarios', async (req, res) => {
    const { idUsuarios } = req.params;
    const { NombreCliente,NombreUsuario,Password,FechaNacimiento,Tipo,Direccion,NumeroTelefono,Ruc,Correo} = req.body; 
    const newLink = {
        NombreCliente,
        NombreUsuario,
        Password,
        FechaNacimiento,
        Tipo,
        Direccion,
        NumeroTelefono,
        Ruc,
        Correo
    };
    await pool.query('UPDATE ususariios set ? WHERE idUsuarios = ?', [newLink, idUsuarios]);
    req.flash('success', 'User Updated Successfully');
    res.redirect('/Usuarios');
});

module.exports = router;