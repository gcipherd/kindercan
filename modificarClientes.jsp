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

				<!-- Inicia selección -->
		<div id="seleccionarDueno"><br>
			<center><h1>Datos del cliente a editar</h1></center>
			<br>
				<%
					String dueno = request.getParameter("dueno");
					int idDueno = Integer.parseInt(dueno);
					try {
					            Class.forName("com.mysql.jdbc.Driver");
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
								//System.out.println("ConexiOn con la BD establecida");
								// Se crea una instancia del tipo declaraciOn
								Statement stmt = con.createStatement();
								stmt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
					            ResultSet rs = stmt.executeQuery("SELECT * FROM dueno WHERE idDueno = " + idDueno + ";");
					            while(rs.next()) {
									out.println("Nombre: " + rs.getString("nombre") + "<br>");
									out.println("Apellido Paterno: " + rs.getString("apellidoPaterno") + "<br>");
									out.println("Apellido Materno: " + rs.getString("apellidoMaterno") + "<br>");
									out.println("Delegación: " + rs.getString("delegacion") + "<br>");
									out.println("Colonia: " + rs.getString("colonia") + "<br>");
									out.println("Código Postal: " + rs.getString("codigoPostal") + "<br>");
									out.println("Calle: " + rs.getString("calle") + "<br>");
									out.println("Número Interior: " + rs.getString("numInterior") + "<br>");
									out.println("Número Exterior: " + rs.getString("numExterior") + "<br>");
									out.println("Teléfono: " + rs.getString("telefono"));
								}
							}catch (SQLException e){
								System.out.println("Error al realizar la conexiOn con mysql");
							}catch (Exception e){
								System.out.println("Error:\n" + e.getMessage());
								e.printStackTrace();
							}
				%>

				<center><h1>Nuevos datos</h1></center>

		<!-- Inicia formulario -->
		<div><br>
			<form class="formulario container" action="actualizacionCliente.jsp" method="POST">
				<h2>Registro del dueño</h2>
				<div class="form-row">
					<div class="col-auto">
						<label for="idDueno">ID Dueño</label>
						<br>
						<% 
							out.println("<input type='text' name='idDueno' value='" + idDueno + "'>");
						%>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="nombreDueno">Nombre</label>
						<br>
						<input type="text" name="nombreDueno" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="apellidoPaterno">Apellido paterno</label>
						<br>
						<input type="text" name="apellidoPaterno" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="apellidoMaterno">Apellido materno</label>
						<br>
						<input type="text" name="apellidoMaterno" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="telefono">Teléfono</label>
						<br>
						<input type="telephone" name="telefono" minlength="8" maxlength="12" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="delegacion">Delegación</label>
						<br>
						<input type="text" name="delegacion" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="colonia">Colonia</label>
						<br>
						<input type="text" name="colonia" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="codigoPostal">Código postal</label>
						<br>
						<input type="text" name="codigoPostal" minlength="5" maxlength="5" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="calle">Calle</label>
						<br>
						<input type="text" name="calle" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="numeroExterior">Núm. Exterior</label>
						<br>
						<input type="number" name="numeroExterior" maxlength="10" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="numeroInterior">Núm. Interior</label>
						<br>
						<input type="number" name="numeroInterior" placeholder="Opcional" maxlength="10">
					</div>
					<br><br>
					<div class="col-12">
						<br>
						<input id="registrar" class="btn btn-outline-success" type="submit" value="¡Actualizar cliente!">
					</div>
				</div>
			</form>
		</div>
		<!-- Termina formulario -->

			<br>
			<div>
				
			</div>

		</div>
		<!-- Termina selección -->

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