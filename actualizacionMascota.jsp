<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>

<%/*
	@author EquipoFortuna
	@version 1.1.0
	Grupo: 1592
	Proyecto final: Aplicación web para Kindercan
	Fecha de entrega: 08 de enero del 2019

*/%>

<%
	Calendar calendario = Calendar.getInstance(java.util.Locale.getDefault());
	Date fecha = calendario.getTime();
	DateFormat formatoHora = DateFormat.getTimeInstance(DateFormat.SHORT);
	DateFormat formatoFecha = DateFormat.getDateInstance(java.text.DateFormat.FULL);

	String fechaActual = formatoFecha.format(fecha).toUpperCase() + ", " + formatoHora.format(fecha);
%>

<!DOCTYPE html>
<html lang="es-MX">
<head>
	<meta charset="UTF-8">
	<title>Kinder Can</title>
	<link rel="shortcut icon" href="img/perroIcono.png">
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
	<link type="text/css" rel="stylesheet" href="css/style.css">
</head>
<body>
	<nav class="navbar navbar-light bg-light sticky-top">
	  <a class="navbar-brand" href="index.jsp">
	    <img src="img/kindercanLogo.png" height="50" class="d-inline-block align-top" alt="Logo">
	  </a>
	  <h2>¡BIENVENIDO!</h2>
	  <p class="text-right font-weight-bold"><%out.println(fechaActual);%></p>
	</nav>

	<main>
		<!-- Inicia menú -->
		<div class="menuRegistrando border">
			<ul class="nav nav-pills flex-column">
			  <li class="nav-item">
			    <a class="nav-link sobre" href="index.jsp">Inicio</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link sobre" href="registrando.jsp">Registrar</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link sobre" href="consulta.jsp">Consultar mascota</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active" href="#">Actualizar datos</a>
			  </li>
			</ul>
			<img class="huellas" src="img/huellas.gif" height="350" alt="Huella">
		</div>
		<!-- Termina menú -->
<%

		//Se almacenan en variables los datos del perro ingresados en el formulario
		String idPerro = request.getParameter("idPerro");
		String nombrePerro = request.getParameter("nombrePerro");
		String raza = request.getParameter("raza");
		String sexo = request.getParameter("sexo");
		String fechaNacimiento = request.getParameter("fechaNacimiento");
		String enfermedad = request.getParameter("enfermedad");
		String celo = request.getParameter("celo");
		String tratamiento = request.getParameter("tratamiento");
		String descripcion = request.getParameter("descripcion");
		String idDueno = request.getParameter("idDueno");

		//Se realiza la insercion el la tabla "perro" de la BD
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
			// Se crea una instancia del tipo declaraciOn
			Statement stmt = con.createStatement();
	        stmt.executeQuery("use kindercan");
	        int res = stmt.executeUpdate("UPDATE perro SET nombre = '" + nombrePerro + "', raza = '" + raza + "', sexo = '" + sexo + "', fechaNacimiento = '" + fechaNacimiento + "', enfermedad = '" + enfermedad + "', celo = '" + celo + "', tratamiento = '" + tratamiento + "', descripcion = '" + descripcion + "', idDueno = " + idDueno + " WHERE idPerro = " + idPerro);
			if (res == 1){
				out.println("Mascota registrada");
			} else {
				out.println("Registro no insertado");
			}
		}catch (SQLException e){
			out.println("Error al realizar la inserciOn en mysql");
			if (e != null){
				out.println("<br>SQLState: " + e.getSQLState());
				out.println("<br>Mensaje: " + e.getMessage());
				out.println("<br>COdigo: " + e.getErrorCode());
				e.getNextException();
				out.println(" -------------------------------------- ");
			}
		}catch (Exception e){
			out.println("Error:\n" + e.getMessage());
			e.printStackTrace();
		}
%>


	</main>

	<footer>
		<div class="fixed-bottom pie">
			<p>© 2019 Kinder Can &nbsp|&nbsp Todos los derechos reservados.</p>
		</div>
	</footer>
	
</body>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
</html>