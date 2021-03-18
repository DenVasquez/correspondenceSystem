const { Pool } = require('pg');

 const pool = new Pool ({
     host:'localhost',
     user: 'postgres',
     password:'Denvas92',
     database:'correspondenceSystem',
     port:''
 });

const getUsers= async (req, res) => {
    const response = await pool.query('select * from usuarios');
    console.log(response.rows);
    res.status(200).json(response.rows);
}
const getUserById = async(req, res) =>{
    const id = req.params.id;
    const response = await pool.query('select * from usuarios where idcarnet = $1' , [id]);
    res.json(response.rows);
}
const createUser = async (req, res)=>{
    const {idcarnet, expedido, nombres, appaterno, apmaterno, usuario, clave, id_dependencia, id_rol } = req.body;
    const response = await pool.query('INSERT INTO usuarios (idcarnet, expedido, nombres, appaterno, apmaterno, usuario, clave, id_dependencia, id_rol ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)', [idcarnet,expedido,nombres,appaterno,apmaterno,usuario,clave,id_dependencia, id_rol ]);
    console.log(response);
    res.json({
        message:'Usuario creado exitosamente',
        body: {
            usuario:{idcarnet, expedido, nombres, appaterno, apmaterno, usuario, clave, id_dependencia, id_rol}
        }
    }
   );

}

const deleteUser = async(req, res) =>{
    const id = req.params.id;
    const response = await pool.query('delete from usuarios where idcarnet = $1' , [id]);
    res.json(`Usuario ${id} eliminado Satisfactoriamente`);
}

const updateUser = async (req, res) =>{
    const id = req.params.id;
    const {idcarnet, expedido, nombres, appaterno, apmaterno, usuario, clave, id_dependencia, id_rol } = req.body;
    const response = await pool.query('UPDATE usuarios SET idcarnet = $1, expedido = $2, nombres =  $3, appaterno = $4, apmaterno = $5, usuario = $6, clave = $7, id_dependencia = $8, id_rol = $9 WHERE idcarnet = $1' , 
    [
        idcarnet,
        expedido,
        nombres,
        appaterno,
        apmaterno,
        usuario,
        clave,
        id_dependencia,
        id_rol
]);
    console.log(response);
    res.json(`Usuario actualizado Satisfactoriamente`);
}

module.exports = {
       getUsers,
       getUserById,
       createUser,
       deleteUser,
       updateUser
}